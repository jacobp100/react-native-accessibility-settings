import { useEffect, useState } from 'react';
import { NativeModules, NativeEventEmitter } from 'react-native';

type AccessibilitySettings = {
  shakeToUndo: boolean;
  closedCaptioning: boolean;
  boldText: boolean;
  darkerSystemColors: boolean;
  grayscale: boolean;
  guidedAccess: boolean;
  invertColors: boolean;
  monoAudio: boolean;
  reduceMotion: boolean;
  reduceTransparency: boolean;
  speakScreen: boolean;
  speakSelection: boolean;
  onOffSwitchLabels: boolean;
  videoAutoplay: boolean;
  buttonShapes: boolean;
  prefersCrossFadeTransitions: boolean;
  shouldDifferentiateWithoutColor: boolean;
};

const AccessibilitySettingsModule = NativeModules.AccessibilitySettings;

const events = new NativeEventEmitter(AccessibilitySettingsModule);

let currentValue: AccessibilitySettings = {
  shakeToUndo: AccessibilitySettingsModule.shakeToUndo,
  closedCaptioning: AccessibilitySettingsModule.closedCaptioning,
  boldText: AccessibilitySettingsModule.boldText,
  darkerSystemColors: AccessibilitySettingsModule.darkerSystemColors,
  grayscale: AccessibilitySettingsModule.grayscale,
  guidedAccess: AccessibilitySettingsModule.guidedAccess,
  invertColors: AccessibilitySettingsModule.invertColors,
  monoAudio: AccessibilitySettingsModule.monoAudio,
  reduceMotion: AccessibilitySettingsModule.reduceMotion,
  reduceTransparency: AccessibilitySettingsModule.reduceTransparency,
  speakScreen: AccessibilitySettingsModule.speakScreen,
  speakSelection: AccessibilitySettingsModule.speakSelection,
  onOffSwitchLabels: AccessibilitySettingsModule.onOffSwitchLabels,
  videoAutoplay: AccessibilitySettingsModule.videoAutoplay,
  buttonShapes: AccessibilitySettingsModule.buttonShapes,
  prefersCrossFadeTransitions:
    AccessibilitySettingsModule.prefersCrossFadeTransitions,
  shouldDifferentiateWithoutColor:
    AccessibilitySettingsModule.shouldDifferentiateWithoutColor,
};

const changeListeners = new Set<(value: AccessibilitySettings) => void>();

let combinedListener: { remove: () => void } | undefined;

const createCombinedListener = () => {
  combinedListener = events.addListener(
    'change',
    (newValue: AccessibilitySettings) => {
      currentValue = newValue;
      changeListeners.forEach((listener) => {
        listener(currentValue);
      });
    }
  );
};

const Module = {
  get() {
    return currentValue;
  },
  addListener(
    _event: 'change',
    listener: (value: AccessibilitySettings) => void
  ) {
    if (combinedListener == null) {
      createCombinedListener();
    }

    changeListeners.add(listener);

    return {
      remove() {
        changeListeners.delete(listener);

        if (changeListeners.size === 0) {
          combinedListener?.remove();
        }
      },
    };
  },
};

export default Module;

export const useAccessibilitySettings = () => {
  const [value, setValue] = useState(currentValue);

  useEffect(() => {
    setValue(currentValue);
    const { remove } = Module.addListener('change', setValue);
    return remove;
  }, []);

  return value;
};

export const useAccessibilitySetting = (key: keyof AccessibilitySettings) =>
  useAccessibilitySettings()[key];

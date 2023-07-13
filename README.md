# react-native-accessibility-settings

Accessibility settings (only iOS supported for now)

<a href="https://jacobdoescode.com/technicalc"><img alt="Part of the TechniCalc Project" src="https://github.com/jacobp100/technicalc-core/blob/master/banner.png" width="200" height="60"></a>

## Installation

```sh
npm install react-native-accessibility-settings
```

## Usage

```js
import AccessibilitySettings, {
  useAccessibilitySettings,
  useAccessibilitySetting,
} from 'react-native-accessibility-settings';

// Does NOT update when the users preferences change
const accessibilitySettings = AccessibilitySettings.get();

// DOES update when the users preferences change
const accessibilitySettings = useAccessibilitySettings();
const buttonShapes = useAccessibilitySetting('buttonShapes');
```

Settings supported:-

- `shakeToUndo`
- `closedCaptioning`
- `boldText`
- `darkerSystemColors`
- `grayscale`
- `guidedAccess`
- `invertColors`
- `monoAudio`
- `reduceMotion`
- `reduceTransparency`
- `speakScreen`
- `speakSelection`
- `onOffSwitchLabels`
- `videoAutoplay`
- `buttonShapes`
- `prefersCrossFadeTransitions`
- `shouldDifferentiateWithoutColor`

See [Apple's documentation](https://developer.apple.com/documentation/uikit/accessibility_for_uikit?language=objc) for more information

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)

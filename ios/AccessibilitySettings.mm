#import "AccessibilitySettings.h"

@implementation AccessibilitySettings

RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

- (NSDictionary *)constantsToExport
{
  return [self data];
}

- (NSArray<NSString *> *)supportedEvents
{
  return @[@"change"];
}

#define ADD_OBSERVER(notificationName) \
  [NSNotificationCenter.defaultCenter addObserver:self \
                                         selector:@selector(accessibilityDataDidChange) \
                                             name:@#notificationName \
                                           object:nil];

- (void)startObserving
{
  // No observers for onOffSwitchLabels, videoAutoplay, prefersCrossFadeTransitions and shouldDifferentiateWithoutColor
  ADD_OBSERVER(UIAccessibilityShakeToUndoDidChangeNotification)
  ADD_OBSERVER(UIAccessibilityClosedCaptioningStatusDidChangeNotification)
  ADD_OBSERVER(UIAccessibilityBoldTextStatusDidChangeNotification)
  ADD_OBSERVER(UIAccessibilityDarkerSystemColorsStatusDidChangeNotification)
  ADD_OBSERVER(UIAccessibilityGrayscaleStatusDidChangeNotification)
  ADD_OBSERVER(UIAccessibilityGuidedAccessStatusDidChangeNotification)
  ADD_OBSERVER(UIAccessibilityInvertColorsStatusDidChangeNotification)
  ADD_OBSERVER(UIAccessibilityMonoAudioStatusDidChangeNotification)
  ADD_OBSERVER(UIAccessibilityReduceMotionStatusDidChangeNotification)
  ADD_OBSERVER(UIAccessibilityReduceTransparencyStatusDidChangeNotification)
  ADD_OBSERVER(UIAccessibilitySpeakScreenStatusDidChangeNotification)
  ADD_OBSERVER(UIAccessibilitySpeakSelectionStatusDidChangeNotification)
  if (@available(iOS 14.0, *)) {
    ADD_OBSERVER(UIAccessibilityButtonShapesEnabledStatusDidChangeNotification)
  }
}

- (void)stopObserving
{
  [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)accessibilityDataDidChange
{
  __weak __typeof(self) weakSelf = self;
  dispatch_async(dispatch_get_main_queue(), ^{
    __strong __typeof(self) strongSelf = weakSelf;
    if (strongSelf == nil) {
      return;
    }

    [strongSelf sendEventWithName:@"change"
                             body:[strongSelf data]];
  });
}

- (NSDictionary *)data
{
  BOOL onOffSwitchLabels = NO;
  BOOL videoAutoplay = NO;
  if (@available(iOS 13.0, *)) {
    onOffSwitchLabels = UIAccessibilityIsOnOffSwitchLabelsEnabled();
    videoAutoplay = UIAccessibilityIsVideoAutoplayEnabled();
  }

  BOOL buttonShapes = NO;
  BOOL prefersCrossFadeTransitions = NO;
  BOOL shouldDifferentiateWithoutColor = NO;
  if (@available(iOS 14.0, *)) {
    buttonShapes = UIAccessibilityButtonShapesEnabled();
    prefersCrossFadeTransitions = UIAccessibilityPrefersCrossFadeTransitions();
    shouldDifferentiateWithoutColor = UIAccessibilityShouldDifferentiateWithoutColor();
  }

  return @{
    @"shakeToUndo": @(UIAccessibilityIsShakeToUndoEnabled()),
    @"closedCaptioning": @(UIAccessibilityIsClosedCaptioningEnabled()),
    @"boldText": @(UIAccessibilityIsBoldTextEnabled()),
    @"darkerSystemColors": @(UIAccessibilityDarkerSystemColorsEnabled()),
    @"grayscale": @(UIAccessibilityIsGrayscaleEnabled()),
    @"guidedAccess": @(UIAccessibilityIsGuidedAccessEnabled()),
    @"invertColors": @(UIAccessibilityIsInvertColorsEnabled()),
    @"monoAudio": @(UIAccessibilityIsMonoAudioEnabled()),
    @"reduceMotion": @(UIAccessibilityIsReduceMotionEnabled()),
    @"reduceTransparency": @(UIAccessibilityIsReduceTransparencyEnabled()),
    @"speakScreen": @(UIAccessibilityIsSpeakScreenEnabled()),
    @"speakSelection": @(UIAccessibilityIsSpeakSelectionEnabled()),
    @"onOffSwitchLabels": @(onOffSwitchLabels),
    @"videoAutoplay": @(videoAutoplay),
    @"buttonShapes": @(buttonShapes),
    @"prefersCrossFadeTransitions": @(prefersCrossFadeTransitions),
    @"shouldDifferentiateWithoutColor": @(shouldDifferentiateWithoutColor),
  };
}

@end

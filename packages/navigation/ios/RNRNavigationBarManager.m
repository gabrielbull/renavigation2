#import "React/RCTViewManager.h"

@interface RCT_EXTERN_MODULE(RNRNavigationBarManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(isTranslucent, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(prefersLargeTitles, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(customHidden, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(customTintColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(barTintColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(titleStyle, NSDictionary)
RCT_EXPORT_VIEW_PROPERTY(largeTitleStyle, NSDictionary)
RCT_EXPORT_VIEW_PROPERTY(defaultTitleVerticalPositionAdjustment, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(defaultPromptTitleVerticalPositionAdjustment, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(compactTitleVerticalPositionAdjustment, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(compactPromptTitleVerticalPositionAdjustment, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(backIndicatorImage, UIImage)
RCT_EXPORT_VIEW_PROPERTY(backIndicatorTransitionMaskImage, UIImage)
RCT_EXPORT_VIEW_PROPERTY(shadowImage, UIImage)
RCT_EXPORT_VIEW_PROPERTY(defaultBackgroundImage, UIImage)
RCT_EXPORT_VIEW_PROPERTY(defaultPromptBackgroundImage, UIImage)
RCT_EXPORT_VIEW_PROPERTY(compactBackgroundImage, UIImage)
RCT_EXPORT_VIEW_PROPERTY(compactPromptBackgroundImage, UIImage)
RCT_EXPORT_VIEW_PROPERTY(standardAppearance, NSDictionary)
RCT_EXPORT_VIEW_PROPERTY(compactAppearance, NSDictionary)
RCT_EXPORT_VIEW_PROPERTY(scrollEdgeAppearance, NSDictionary)

@end

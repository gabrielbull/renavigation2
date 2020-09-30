#import "React/RCTViewManager.h"

@interface RCT_EXTERN_MODULE(RNRNavigationSearchManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(isActive, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(dimsBackgroundDuringPresentation, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(obscuresBackgroundDuringPresentation, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(hidesNavigationBarDuringPresentation, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(automaticallyShowsCancelButton, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(barStyle, int)
RCT_EXPORT_VIEW_PROPERTY(text, NSString)
RCT_EXPORT_VIEW_PROPERTY(prompt, NSString)
RCT_EXPORT_VIEW_PROPERTY(placeholder, NSString)
RCT_EXPORT_VIEW_PROPERTY(showsBookmarkButton, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(showsCancelButton, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(showsSearchResultsButton, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(isSearchResultsButtonSelected, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(searchTintColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(barTintColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(searchBarStyle, int)
RCT_EXPORT_VIEW_PROPERTY(isTranslucent, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(scopeButtonTitles, NSArray)
RCT_EXPORT_VIEW_PROPERTY(selectedScopeButtonIndex, int)
RCT_EXPORT_VIEW_PROPERTY(showsScopeBar, NSNumber)

RCT_EXPORT_VIEW_PROPERTY(onWillPresentSearch, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onDidPresentSearch, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onWillDismissSearch, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onDidDismissSearch, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onSearchBarSearchButtonPress, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onSearchBarBookmarkButtonPress, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onSearchBarCancelButtonPress, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onSearchBarResultsListButtonPress, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onSearchBarChange, RCTDirectEventBlock)

@end

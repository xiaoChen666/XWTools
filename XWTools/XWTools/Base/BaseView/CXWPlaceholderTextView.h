
//

#import <UIKit/UIKit.h>

@interface CXWPlaceholderTextView : UITextView

/**placeholder占位文字*/
@property (nonatomic, copy) NSString *placehold;

/**placeholderColor占位文字颜色*/
@property (nonatomic, strong) UIColor *placeholdColor;

@property (nonatomic, strong) UIFont *placeFont;

@property (nonatomic, assign) CGPoint offsetPoint;
@end

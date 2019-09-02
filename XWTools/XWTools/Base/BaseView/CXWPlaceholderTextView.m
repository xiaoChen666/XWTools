
//

#import "CXWPlaceholderTextView.h"
#import "UIView+Extension.h"
@implementation CXWPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
         // 外界文字颜色不设置,默认为灰色
        self.placeholdColor = [UIColor colorWithHexString:CXWTestLowColorStr];
        self.offsetPoint = CGPointMake(8, 4);
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textChange {
    [self setNeedsDisplay];
}
// 调用drawRect时,会将之前的图像擦除掉,重新绘制

- (void)drawRect:(CGRect)rect {
    if ([self hasText]) return;
        rect.origin.y += self.offsetPoint.y;
        rect.origin.x += self.offsetPoint.x;
        rect.size.width -= 2 * rect.origin.x;
        UIFont  *placeFont = [UIFont CXWFontWithName:CXWPingFang_SC_Regular size:13];
        if (self.placeFont) {
            placeFont = self.placeFont;
        }
       NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
         attrs[NSForegroundColorAttributeName] = self.placeholdColor;
        attrs[NSFontAttributeName] = placeFont;
         [self.placehold drawInRect:rect withAttributes:attrs];
}

// 设计框架需注意,给外界提供了属性后,一定重写出行的setter,这样既可以时时监听使用者对属性的更改,还可以跟好的与外界代码进行交互
- (void)setPlacehold:(NSString *)placehold {
    _placehold = placehold;
    // 设置了站位文字后,需要重绘一遍
    [self setNeedsDisplay];
}

- (void)setPlaceholdColor:(UIColor *)placeholdColor {
    _placeholdColor = placeholdColor;
    [self setNeedsDisplay];
}

// 同时,也要考虑到
- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

 @end

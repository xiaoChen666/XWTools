//
//  XWInputTF.m
//  SuperBabyTest
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "XWInputTF.h"
#import "UITextField+CXWTF.h"
@implementation XWInputTF

- (instancetype)init {
    if (self = [super init]) {
        [self cxw_basesetting];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        [self cxw_basesetting];
    }
    return self;
}

- (void)cxw_basesetting {
//    self.textColor = [UIColor colorWithHexString:CXWTestHighColorStr];
//    self.font = [UIFont CXWFontWithName:CXWPingFang_SC_Regular size:16];
//    self.tintColor = [UIColor colorWithHexString:CXWThemeColorStr];
//    UIButton *clearBtn = [self CXWGetClearBtn];
//    [clearBtn setImage:[UIImage imageNamed:@"tf_clear"] forState:UIControlStateNormal];
//    [clearBtn setImage:[UIImage imageNamed:@"tf_clear"] forState:UIControlStateSelected];
//    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    

    
}


- (void)setXwPlaceholderColor:(UIColor *)xwPlaceholderColor {
    _xwPlaceholderColor = xwPlaceholderColor;
    [self CXWSetPlaceHolderColor:xwPlaceholderColor];
}

- (void)setXwPlaceholderFont:(UIFont *)xwPlaceholderFont {
    _xwPlaceholderFont = xwPlaceholderFont;
    [self CXWSetPlaceHolderFont:xwPlaceholderFont];
}

@end

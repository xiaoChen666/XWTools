//
//  XWTabbarCenterBtn.m
//  SuperBabyTest
//
//  Created by mac on 2019/5/14.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "XWTabbarCenterBtn.h"
#import "UIView+AZGradient.h"
@implementation XWTabbarCenterBtn

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self xw_set];
    }
    return self;
}

- (void)xw_set {

    [self setTitle:@"测评" forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont CXWFontWithName:CXWPingFang_SC_Regular size:15];
    self.layer.cornerRadius = 23.5;
    self.layer.masksToBounds = NO;
    
//    [self CXWSetPublicGradient];
//
//    self.layer.shadowColor   = [UIColor colorWithHexString:@"#6CC1FF"].CGColor;
//    self.layer.shadowOffset  = CGSizeMake(0, 0);
//    self.layer.shadowOpacity = 0.76;
//    self.layer.shadowRadius  = 8;
}

- (void)setIsSeleted:(BOOL)isSeleted {
    _isSeleted = isSeleted;
    if (isSeleted) {
        [self CXWSetPublicGradient];
        [self setTitleColor:[UIColor colorWithHexString:CXWWriteColorStr] forState:UIControlStateNormal];
        self.layer.shadowColor   = [UIColor colorWithHexString:@"#6CC1FF"].CGColor;
        self.layer.shadowOffset  = CGSizeMake(0, 0);
        self.layer.shadowOpacity = 0.76;
        self.layer.shadowRadius  = 8;
        
        self.layer.borderWidth = 0;
    } else {
        [self setTitleColor:[UIColor colorWithHexString:CXWTestMidColorStr] forState:UIControlStateNormal];
        
        NSArray *colors = @[[UIColor colorWithHexString:@"#EFEFEF"],[UIColor colorWithHexString:@"#EFEFEF"]];
        [self az_setGradientBackgroundWithColors:colors locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1.0, 0.5)];
        
        self.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
        self.layer.borderColor = [UIColor colorWithHexString:@"#BCBCBC"].CGColor;
        self.layer.borderWidth = 1;
        
        self.layer.shadowRadius = 0;
    }
}

@end

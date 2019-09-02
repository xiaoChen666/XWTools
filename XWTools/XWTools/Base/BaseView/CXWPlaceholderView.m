//
//  CXWPlaceholderView.m
//  CarRank
//
//  Created by 陈叙文 on 2017/10/28.
//  Copyright © 2017年 陈叙文. All rights reserved.
//

#import "CXWPlaceholderView.h"

#define IMagegWidth  56
#define LabelHeight  20

@interface CXWPlaceholderView ()
@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UILabel *label;
@end
@implementation CXWPlaceholderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //
         [self CXWAddSubViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init])
    {
        //
        self.backgroundColor = [UIColor whiteColor];
        [self CXWAddSubViews];
    }
    return self;
}

- (void)CXWAddSubViews
{
    self.imageV = [[UIImageView alloc] init];
    self.imageV.image = [UIImage imageNamed:@"no_data_icon"];

    self.label = [[UILabel alloc] init];
    self.label.numberOfLines = 0;
    self.label.font = [UIFont CXWFontWithName:CXWPingFang_SC_Regular size:16];
    self.label.textColor = [UIColor colorWithHexString:CXWTestHighColorStr];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.imageV];
    [self addSubview:self.label];
}

- (void)layoutSubviews
{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.imageV.frame = CGRectMake((width-IMagegWidth)*0.5, (height-IMagegWidth-LabelHeight)*0.5, IMagegWidth, IMagegWidth);

    self.label.frame = CGRectMake(0, CGRectGetMaxY(self.imageV.frame)+5, width, LabelHeight);


    if (height<IMagegWidth+LabelHeight)
    {
        self.imageV.hidden = YES;
        self.label.hidden = YES;
    }
    else
    {
        self.imageV.hidden = NO;
        self.label.hidden = NO;
    }
    
//    CGFloat labelHeight = [[CXWDataManager shareManager] getheightForString:self.label.text andWidth:250 andFont:self.label.font];
    
    
//    self.label.frame = CGRectMake(0, 0, 250, labelHeight);
//    self.label.center = CGPointMake(width*0.5, height*0.5);
//
//    CXWLog(@"---%@--label-%@",NSStringFromCGRect(self.frame),NSStringFromCGRect(self.label.frame));
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.label.text = placeholder;
}

@end

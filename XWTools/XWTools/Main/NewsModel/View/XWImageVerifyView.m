//
//  XWImageVerifyView.m
//  XWTools
//
//  Created by xuwen_chen on 2019/10/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "XWImageVerifyView.h"

@interface XWImageVerifyView ()
@property (nonatomic, strong) UIImageView *pictureImageV;
@property (nonatomic, assign) NSInteger maxCount;
@property (nonatomic, assign) NSInteger currentCount;

@property (nonatomic, strong) NSMutableArray *pointArr;
@end


@implementation XWImageVerifyView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self init_UI];
    }
    return self;
}

- (void)init_UI {
    
    self.maxCount = 4;
    self.currentCount = 1;
    
    self.pictureImageV = [[UIImageView alloc] init];
    self.pictureImageV.image = [UIImage imageNamed:@"test_home_icon"];
    [self addSubview:self.pictureImageV];
    
    [self.pictureImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"重置" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.right.equalTo(self).with.offset(-10);
        make.top.equalTo(self).with.offset(10);
    }];
    
}

- (void)btnClick:(UIButton *)sender {
    self.currentCount = 1;
    
    while (self.subviews.count>2) {
        [self.subviews.lastObject removeFromSuperview];
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   
    
    CGPoint point = [touches.anyObject locationInView:self];
    
    if (self.currentCount<=self.maxCount) {
        UIImageView *imageV = [[UIImageView alloc] init];
        [self addSubview:imageV];
        imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"num%ld",self.currentCount]];
        
//        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(point.y);
//            make.centerX.mas_equalTo(point.x);
//        }];
        
        imageV.frame = CGRectMake(point.x-15, point.y-30, 30, 30);
        
        
        [imageV layoutIfNeeded];
        
        NSLog(@"----%@",NSStringFromCGRect(imageV.frame));
        
        [self.pointArr addObject:NSStringFromCGPoint(point)];
        
        if (self.currentCount==self.maxCount) {
            if (self.pointArrBlock) {
                self.pointArrBlock([self.pointArr copy]);
            }
        }
        
        self.currentCount ++;
        
    }
    
    
}







- (UIImageView *)pictureImageV {
    if (!_pictureImageV) {
        _pictureImageV = [[UIImageView alloc] init];
    }
    return _pictureImageV;
}

- (NSMutableArray *)pointArr {
    if (!_pointArr) {
        _pointArr = [NSMutableArray array];
    }
    return _pointArr;
}


@end

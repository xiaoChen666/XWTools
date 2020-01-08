//
//  XMNotiView.m
//  XWTools
//
//  Created by xuwen_chen on 2019/11/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "XMNotiView.h"
#import "AppDelegate.h"

#define SelfHeight  (80)

#define containViewHeight  (60)
@interface XMNotiView ()
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIView *containView;///容器视图
@end

@implementation XMNotiView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self init_UI];
    }
    return self;
}

///初始化UI
- (void)init_UI {
//    self.backgroundColor = [UIColor yellowColor];
    self.clipsToBounds = YES;
    
    [self addSubview:self.containView];
    
    [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.right.equalTo(self).with.offset(-15);
        make.top.equalTo(self).with.offset(0);
        make.height.mas_equalTo(containViewHeight);
    }];
    

}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [touches.anyObject locationInView:self];
    CGFloat y = point.y;
    if (y<-containViewHeight||y>SelfHeight-containViewHeight-20) {
        return;
    }
    [self.containView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(point.y);
    }];
    [self.superview layoutIfNeeded];
    
}



- (void)show {
     UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(0, 0, KAPPWidth, KAppHeight);
    self.backBtn.backgroundColor = [UIColor clearColor];
    [self.backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [window addSubview:self.backBtn];
    [self.backBtn addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backBtn).with.offset(CURRENTSCREN_Status_HEIGHT + 10);
        make.left.right.equalTo(self.backBtn);
        make.bottom.equalTo(self.backBtn.mas_top);
        make.height.mas_equalTo(SelfHeight);
    }];
    
    [self.superview layoutIfNeeded];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.backBtn.mas_top).with.offset(SelfHeight);
        }];
        [self.superview layoutIfNeeded];
    }];
}





- (void)backBtnClick {
    [self remove_selfView];
}


- (void)remove_selfView {
    [UIView animateWithDuration:0.3 animations:^{
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backBtn).with.offset(CURRENTSCREN_Status_HEIGHT + 20);
        }];
        [self.superview layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.backBtn removeFromSuperview];
    }];
}


#pragma mark lazy
- (UIView *)containView {
    if (!_containView) {
        _containView = [[UIView alloc] init];
        _containView.backgroundColor = [UIColor redColor];
    }
    return _containView;
}


@end

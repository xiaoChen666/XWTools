//
//  XWTabbar.m
//  SuperBabyTest
//
//  Created by mac on 2019/5/14.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "XWTabbar.h"

OverrideImplementation(Class targetClass, SEL targetSelector, id (^implementationBlock)(Class originClass, SEL originCMD, IMP originIMP)) {
    Method originMethod = class_getInstanceMethod(targetClass, targetSelector);
    if (!originMethod) {
        return NO;
    }
    IMP originIMP = method_getImplementation(originMethod);
    method_setImplementation(originMethod, imp_implementationWithBlock(implementationBlock(targetClass, targetSelector, originIMP)));
    return YES;
}

@implementation XWTabbar

+ (void)load {
    /* 这个问题是 iOS 12.1 Beta 2 的问题，只要 UITabBar 是磨砂的，并且 push viewController 时 hidesBottomBarWhenPushed = YES 则手势返回的时候就会触发。
     
     出现这个现象的直接原因是 tabBar 内的按钮 UITabBarButton 被设置了错误的 frame，frame.size 变为 (0, 0) 导致的。如果12.1正式版Apple修复了这个bug可以移除调这段代码(来源于QMUIKit的处理方式)*/
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 12.1, *)) {
            OverrideImplementation(NSClassFromString(@"UITabBarButton"), @selector(setFrame:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP originIMP) {
                return ^(UIView *selfObject, CGRect firstArgv) {
                    
                    if ([selfObject isKindOfClass:originClass]) {
                        // 如果发现即将要设置一个 size 为空的 frame，则屏蔽掉本次设置
                        if (!CGRectIsEmpty(selfObject.frame) && CGRectIsEmpty(firstArgv)) {
                            return;
                        }
                    }
                    // call super
                    void (*originSelectorIMP)(id, SEL, CGRect);
                    originSelectorIMP = (void (*)(id, SEL, CGRect))originIMP;
                    originSelectorIMP(selfObject, originCMD, firstArgv);
                };
            });
        }
    });
}

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#FBFBFB"];
         self.centerBtn.frame = CGRectMake((KAPPWidth-47)*0.5, -7, 47, 47);
    }
    return self;
}



//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//
//
//    /**** 设置所有UITabBarButton的frame ****/
//    // 按钮的尺寸
//    //    CGFloat buttonW = self.frame.size.width / 3.0;
//    //    CGFloat buttonH = self.frame.size.height;
//    
//    
//    CGFloat buttonW = self.frame.size.width / 3.0;
//    CGFloat buttonH = self.frame.size.height-CURRENTSCREN_SafeArea_HEIGHT;
//    CGFloat buttonY = 0;
//    // 按钮索引
//    int buttonIndex = 0;
//    
//    for (UIView *subview in self.subviews) {
//        // 过滤掉非UITabBarButton
//        //   if (![@"UITabBarButton" isEqualToString:NSStringFromClass(subview.class)]) continue;
//        if (subview.class != NSClassFromString(@"UITabBarButton")) continue;
//        
//        // 设置frame
//        CGFloat buttonX = buttonIndex * buttonW;
//        // 把发布按钮的位置预留出来
//        subview.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
//        // 增加索引
//        buttonIndex++;
//    }
//    /**** 设置中间的发布按钮的frame ****/
//    self.centerBtn.frame = CGRectMake((KAPPWidth-47)*0.5, -7, 47, 47);
//    
//}

#pragma mark  ======Event======
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view==nil) {
        CGPoint tempPoint = [self.centerBtn convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.centerBtn.bounds, tempPoint)) {
            return self.centerBtn;
        }
    }
    return view;
}

#pragma mark  ======lazyLoad======
- (XWTabbarCenterBtn *)centerBtn {
    if (!_centerBtn) {
        _centerBtn = [[XWTabbarCenterBtn alloc] init];
        _centerBtn.isSeleted = NO;
        [self addSubview:_centerBtn];
    }
    return _centerBtn;

}

@end

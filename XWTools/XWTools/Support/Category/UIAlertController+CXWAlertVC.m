//
//  UIAlertController+CXWAlertVC.m
//  CarRank
//
//  Created by 陈叙文 on 2018/6/20.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import "UIAlertController+CXWAlertVC.h"

@implementation UIAlertController (CXWAlertVC)
+(UIAlertController*)CXWAlertWithTitle:(NSString*)title AndVCStyle:(UIAlertControllerStyle)VCStyle AndSuccessTitle:(NSString*)successTitle AndSuccesBlock:(void (^)())success {

    UIAlertController *alertVC = [self CXWAlertWithTitle:title AndVCStyle:VCStyle AndSuccessTitle:successTitle AndSuccesBlock:success AndCancelTitle:@"取消" AndCancleBlock:nil];
    return alertVC;
}

///两个弹框的
+(UIAlertController*)CXWAlertWithTitle:(NSString*)title AndVCStyle:(UIAlertControllerStyle)VCStyle AndSuccessTitle:(NSString*)successTitle AndSuccesBlock:(void (^)())successBlock AndCancelTitle:(NSString*)cancelTitle AndCancleBlock:(void (^)())cancleBlock{
    
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:VCStyle];
    
    UIAlertAction *sucessAction = [UIAlertAction actionWithTitle:successTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (successBlock) {
            successBlock();
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancleBlock) {
            cancleBlock();
        }
    }];
    
    [alertVC addAction:sucessAction];
    [alertVC addAction:cancelAction];
    return alertVC;
    
}

+(UIAlertController*)CXWAlertWithTitle:(NSString*)title AndVCStyle:(UIAlertControllerStyle)VCStyle AndFirstTitle:(NSString*)firstTitle AndFirstBlock:(void (^)())firstBlock AndSecondTitle:(NSString*)secondTitle AndSecondBlock:(void (^)())secondBlock {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:VCStyle];
    
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:firstTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (firstBlock) {
            firstBlock();
        }
    }];
    
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:secondTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (secondBlock) {
            secondBlock();
        }
    }];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //
    }];
    
    [alertVC addAction:firstAction];
    [alertVC addAction:secondAction];
    [alertVC addAction:cancleAction];
    
    return alertVC;
}


@end

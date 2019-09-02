//
//  UIAlertController+CXWAlertVC.h
//  CarRank
//
//  Created by 陈叙文 on 2018/6/20.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (CXWAlertVC)

///两个弹框的
+(UIAlertController*)CXWAlertWithTitle:(NSString*)title AndVCStyle:(UIAlertControllerStyle)VCStyle AndSuccessTitle:(NSString*)successTitle AndSuccesBlock:(void (^)())success;

///两个弹框的
+(UIAlertController*)CXWAlertWithTitle:(NSString*)title AndVCStyle:(UIAlertControllerStyle)VCStyle AndSuccessTitle:(NSString*)successTitle AndSuccesBlock:(void (^)())successBlock AndCancelTitle:(NSString*)cancelTitle AndCancleBlock:(void (^)())cancleBlock;


///三个弹框的
+(UIAlertController*)CXWAlertWithTitle:(NSString*)title AndVCStyle:(UIAlertControllerStyle)VCStyle AndFirstTitle:(NSString*)firstTitle AndFirstBlock:(void (^)())firstBlock AndSecondTitle:(NSString*)secondTitle AndSecondBlock:(void (^)())secondBlock;

@end

//
//  UIImage+CXWPlaceImage.m
//  CarRank
//
//  Created by 陈叙文 on 2018/5/2.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import "UIImage+CXWPlaceImage.h"

@implementation UIImage (CXWPlaceImage)

+ (UIImage *)placeholderImage{
    UIImage *img = [self placeholderImageWithSize:CGSizeMake(60, 60)];
    return img;
}

+ (UIImage *)placeholderImageWithSize:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor colorWithHexString:@"#eeeeee"] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


/**
 传入需要的占位图尺寸 获取占位图
 @param size 需要的站位图尺寸
 @return 占位图
 */
+ (UIImage *)placeholderImageWithImageAndSize:(CGSize)size {
        // 占位图的背景色
    UIColor *backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    // 中间LOGO图片
    UIImage *image = [UIImage imageNamed:KCXWPublicPic];
    // 根据占位图需要的尺寸 计算 中间LOGO的宽高
    CGFloat logoWH = (size.width > size.height ? size.height : size.width) * 0.5;
    CGSize logoSize = CGSizeMake(logoWH, logoWH);
    // 打开上下文
    UIGraphicsBeginImageContextWithOptions(size,0, [UIScreen mainScreen].scale);
    // 绘图
    [backgroundColor set];
    UIRectFill(CGRectMake(0,0, size.width, size.height));
    CGFloat imageX = (size.width / 2) - (logoSize.width / 2);
    CGFloat imageY = (size.height / 2) - (logoSize.height / 2);
    [image drawInRect:CGRectMake(imageX, imageY, logoSize.width, logoSize.height)];
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    return resImage;
}

@end

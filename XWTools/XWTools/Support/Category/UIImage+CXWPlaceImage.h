//
//  UIImage+CXWPlaceImage.h
//  CarRank
//
//  Created by 陈叙文 on 2018/5/2.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CXWPlaceImage)

+ (UIImage *)placeholderImage;

+ (UIImage *)placeholderImageWithSize:(CGSize)size;

+ (UIImage *)placeholderImageWithImageAndSize:(CGSize)size;
@end

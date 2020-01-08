//
//  XWImageVerifyView.h
//  XWTools
//
//  Created by xuwen_chen on 2019/10/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XWImageVerifyView : UIView


@property (nonatomic, copy) void (^pointArrBlock)(NSArray *pointArr);
@end

NS_ASSUME_NONNULL_END

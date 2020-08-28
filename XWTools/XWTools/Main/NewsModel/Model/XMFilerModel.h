//
//  XMFilerModel.h
//  XWTools
//
//  Created by xuwen_chen on 2020/8/11.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GPUImage.h>
NS_ASSUME_NONNULL_BEGIN

@interface XMFilerModel : NSObject
@property (nonatomic, copy) NSString *filerTitle;
@property (nonatomic, strong) GPUImageOutput *currentFiler;
@end

NS_ASSUME_NONNULL_END

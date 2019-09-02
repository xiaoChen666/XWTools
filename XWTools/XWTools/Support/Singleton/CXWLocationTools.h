//
//  CXWLocationTools.h
//  CarRank
//
//  Created by 陈叙文 on 2017/10/20.
//  Copyright © 2017年 陈叙文. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^LocationFinisnBlock)(id obj);
typedef void (^LocationFailBlock)();
@interface CXWLocationTools : NSObject
+(instancetype) defaultTool;//单例方法

@property (copy , nonatomic) LocationFinisnBlock locationFinisnBlock;
@property (copy, nonatomic) LocationFailBlock failBlock;
-(void)startLocationWithBlock:(LocationFinisnBlock)completion AndFailBlock:(LocationFailBlock)Fail;
@end

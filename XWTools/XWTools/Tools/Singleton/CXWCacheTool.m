//
//  CXWCacheTool.m
//  CarRank
//
//  Created by 陈叙文 on 2018/8/3.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import "CXWCacheTool.h"
#import "SDImageCache.h"
@implementation CXWCacheTool

#pragma mark --单例
static CXWCacheTool* _defaultTool = nil;
+(instancetype) defaultTool
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _defaultTool = [[super allocWithZone:NULL] init] ;
    }) ;
    
    return _defaultTool ;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [CXWCacheTool defaultTool] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [CXWCacheTool defaultTool] ;
}

#pragma mark  ======计算缓存=====

- (NSString*)CXWGetTotolSize
{
    float sdSize = [[SDImageCache sharedImageCache] getSize];
    
    CGFloat size = [self folderSizeAtPath:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject] + [self folderSizeAtPath:NSTemporaryDirectory()];
    
    float MBCache = sdSize/1024/1024;
    
    size = size + MBCache;
    
    NSString *message = size > 1 ? [NSString stringWithFormat:@"缓存%.2fM", size] : [NSString stringWithFormat:@"缓存%.2fK", size * 1024.0];
    return message;
}



// 计算目录大小
- (CGFloat)folderSizeAtPath:(NSString *)path{
    
    // 利用NSFileManager实现对文件的管理
    NSFileManager *manager = [NSFileManager defaultManager];
    CGFloat size = 0;
    if ([manager fileExistsAtPath:path]) {
        // 获取该目录下的文件，计算其大小
        NSArray *childrenFile = [manager subpathsAtPath:path];
        for (NSString *fileName in childrenFile) {
            if ([fileName isEqualToString:@"JKBD"]||[fileName isEqualToString:@"JKBD/jkdb.sqlite"]) {
                continue;
            }
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            size += [manager attributesOfItemAtPath:absolutePath error:nil].fileSize;
        }
        // 将大小转化为M
        return size / 1024.0 / 1024.0;
    }
    return 0;
}



// 根据路径删除文件
- (void)cleanCaches:(NSString *)path{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        // 获取该路径下面的文件名
        NSArray *childrenFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childrenFiles) {
            // 拼接路径
            if ([fileName isEqualToString:@"JKBD"]||[fileName isEqualToString:@"JKBD/jkdb.sqlite"]) {
                continue;
            }
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            // 将文件删除
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}

- (void)cxw_clearAllCache:(CXWPublicVoidBlock)block{
    
    [self cleanCaches:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject];
    [self cleanCaches:NSTemporaryDirectory()];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        if (block) {
            block();
        }
    }];
}
@end

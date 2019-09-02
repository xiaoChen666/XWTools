//
//  XWUserModel.m
//  SuperBabyTest
//
//  Created by mac on 2019/5/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import "XWUserModel.h"

@implementation XWUserModel

- (void)setSex:(NSString *)Sex {
    _Sex = Sex;
    if ([Sex isEqualToString:@"0"]) {
        _sexName = @"女";
    } else if ([Sex isEqualToString:@"1"]) {
        _sexName = @"男";
    }
}

@end

//
//  XWSendMsgBtn.m
//  SuperBabyTest
//
//  Created by mac on 2019/5/21.
//  Copyright © 2019 mac. All rights reserved.
//

#import "XWSendMsgBtn.h"

@implementation XWSendMsgBtn


- (CGSize)intrinsicContentSize {
  
    CGFloat width  = [[CXWDataManager shareManager] getWidthForString:self.currentTitle andHeight:16 andFont:self.titleLabel.font];
    
    return CGSizeMake(width+20, 16);
}

@end

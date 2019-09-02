//
//  CXWBaseTableViewCell.m
//  CarRank
//
//  Created by 陈叙文 on 2018/6/5.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import "CXWBaseTableViewCell.h"

@implementation CXWBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self cxw_baseSetting];
        [self CXWCellAddSubviews];
    }
    return self;
}

- (void)cxw_baseSetting {
    self.contentView.backgroundColor = [UIColor colorWithHexString:CXWWriteColorStr];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
- (void)CXWCellAddSubviews {
    
}


@end


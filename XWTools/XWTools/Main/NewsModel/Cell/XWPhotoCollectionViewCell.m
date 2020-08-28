//
//  XWPhotoCollectionViewCell.m
//  XWTools
//
//  Created by xuwen_chen on 2019/9/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "XWPhotoCollectionViewCell.h"

@interface XWPhotoCollectionViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation XWPhotoCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self init_UI];
    }
    return self;
}

- (void)init_UI {
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel = titleLabel;
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
}

- (void)setCurrentModel:(XMFilerModel *)currentModel {
    _currentModel = currentModel;
    self.titleLabel.text = currentModel.filerTitle;
}



@end

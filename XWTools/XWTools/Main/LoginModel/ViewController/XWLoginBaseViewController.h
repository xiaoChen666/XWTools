//
//  XWLoginBaseViewController.h
//  SuperBabyTest
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CXWBaseViewController.h"
#import "XWInputTF.h"

NS_ASSUME_NONNULL_BEGIN

@interface XWLoginBaseViewController : CXWBaseViewController


- (UILabel *)publicLabel;

- (XWInputTF *)publicInputTF;

- (CXWPublicSeparatorView *)publicLineView;

- (UIButton *)publicTopBtn;

- (UIButton *)publicSureBtn;
@end

NS_ASSUME_NONNULL_END

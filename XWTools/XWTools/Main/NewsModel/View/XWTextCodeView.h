//
//  XWTextCodeView.h
//  XWTools
//
//  Created by xuwen_chen on 2019/9/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SuccessBlock)(BOOL is);

@interface XWTextCodeView : UIView
// 需要生成的总文字数
@property (nonatomic, assign) NSInteger textTotal;

// 需要点击的文字个数
@property (nonatomic, assign) NSInteger textNum;

// 点击顺序字符串
@property (nonatomic, strong) NSString *textString;

// 成功或失败block
@property (nonatomic, copy) SuccessBlock successBlock;

// 刷新
- (void)change;
@end



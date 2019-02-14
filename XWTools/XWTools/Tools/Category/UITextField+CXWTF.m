//
//  UITextField+CXWTF.m
//  CarRank
//
//  Created by 陈叙文 on 2018/5/15.
//  Copyright © 2018年 陈叙文. All rights reserved.
//

#import "UITextField+CXWTF.h"

@implementation UITextField (CXWTF)

///设置占位文字的颜色
- (void)CXWSetPlaceHolderFont:(UIFont*)placeholderFont{
    [self setValue:placeholderFont forKeyPath:@"_placeholderLabel.font"];
}


- (NSRange)selectedRange{
    //开始位置
    UITextPosition* beginning = self.beginningOfDocument;
    //光标选择区域
    UITextRange* selectedRange = self.selectedTextRange;
    //选择的开始位置
    UITextPosition* selectionStart = selectedRange.start;
    //选择的结束位置
    UITextPosition* selectionEnd = selectedRange.end;
    //选择的实际位置
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    //选择的长度
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
}

- (void) setSelectedRange:(NSRange) range
{
    UITextPosition* beginning = self.beginningOfDocument;
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}


///设置占位文字的颜色
- (void)CXWSetPlaceHolderColor:(UIColor*)placeholderColor {
    
    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

///获取清空文字的按钮
- (UIButton*)CXWGetClearBtn {
    UIButton *ClearButton = [self valueForKey:@"_clearButton"];//key值是固定的
    return ClearButton;
}


- (void)CXWSetLeftMargin:(CGFloat)margin {
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, margin, 20)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
}


- (void)CXWSetSecureEntry:(BOOL)entry {
    NSString *tempPwdStr = self.text;
    self.text = @"";
    self.secureTextEntry = entry;
    self.text = tempPwdStr;
}
@end

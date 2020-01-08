//
//  XMLimitCharViewController.m
//  XWTools
//
//  Created by xuwen_chen on 2019/8/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "XMLimitCharViewController.h"
#import "NSString+CXWStr.h"

#import "CCPScrollView.h"
@interface XMLimitCharViewController ()<UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) CCPScrollView *textLabel;
@end

@implementation XMLimitCharViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField *myTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 200, 250, 40)];
    myTextField.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    myTextField.placeholder = @"哈哈";
    myTextField.returnKeyType = UIReturnKeySearch;
    myTextField.font = [UIFont systemFontOfSize:13];
    myTextField.delegate = self;
    
    
    [self.view addSubview:myTextField];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification" object:nil];
    
    
    
    
    
    UITextView *textVIew= [[UITextView alloc] initWithFrame:CGRectMake(0, 250, 350, 100)];
    textVIew.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    
    [self.view addSubview:textVIew];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewEditChanged:)
                                                name:UITextViewTextDidChangeNotification object:nil];
    
    textVIew.delegate = self;
    
    
    CCPScrollView *lable = [[CCPScrollView alloc] init];
    lable.titleColor = [UIColor redColor];
    self.textLabel = lable;
    lable.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:lable];
    
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view).with.offset(-50);
        make.top.equalTo(self.view).with.offset(100);
        make.height.mas_equalTo(50);
    }];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.textLabel.titleArray = @[@"1",@"2",@"3"];
    
    self.textLabel.titleColor = RandomColor;
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    

    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    text = [NSString CXWRemoveStartEndSpaceWithStr:text];

    NSInteger MAX_STARWORDS_LENGTH = 15;
    
    if (string.length<=0) {
        return YES;
    }
    if (text.length>MAX_STARWORDS_LENGTH) {
        
        return NO;
    }

    return YES;
}


-(void)textFieldEditChanged:(NSNotification *)obj
{
    
    NSInteger kMaxLength = 10;
    
//    UITextField *textField = (UITextField *)obj.object;
//    NSString *toBeString = textField.text;
//
//    //获取高亮部分
//    UITextRange *selectedRange = [textField markedTextRange];
//    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
//
//    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
//    if (!position)
//    {
//        if (toBeString.length > MAX_STARWORDS_LENGTH)
//        {
//            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
//            if (rangeIndex.length == 1)
//            {
//                textField.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
//            }
//            else
//            {
//                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
//                textField.text = [toBeString substringWithRange:rangeRange];
//            }
//        }
//    }
    
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > kMaxLength) {
            textField.text = [toBeString substringToIndex:kMaxLength];
        }
    }
    
}


-(void)textViewEditChanged:(NSNotification *)obj
{
    
    NSInteger MAX_STARWORDS_LENGTH = 10;
    
    UITextView *textField = (UITextView *)obj.object;
    NSString *toBeString = textField.text;
    
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position)
    {
        if (toBeString.length > MAX_STARWORDS_LENGTH)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

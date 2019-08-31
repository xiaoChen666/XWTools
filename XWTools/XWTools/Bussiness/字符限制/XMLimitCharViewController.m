//
//  XMLimitCharViewController.m
//  XWTools
//
//  Created by xuwen_chen on 2019/8/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "XMLimitCharViewController.h"

@interface XMLimitCharViewController ()<UITextViewDelegate>

@end

@implementation XMLimitCharViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField *myTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 200, 250, 40)];
    myTextField.placeholder = @"哈哈";
    myTextField.font = [UIFont systemFontOfSize:13];
    
    [self.view addSubview:myTextField];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification" object:nil];
    
    
    UITextView *textVIew= [[UITextView alloc] initWithFrame:CGRectMake(0, 250, 350, 100)];
    
    [self.view addSubview:textVIew];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewEditChanged:)
                                                name:UITextViewTextDidChangeNotification object:nil];
    
    textVIew.delegate = self;
    
    // Do any additional setup after loading the view.
}


-(void)textFieldEditChanged:(NSNotification *)obj
{
    
    NSInteger MAX_STARWORDS_LENGTH = 10;
    
    UITextField *textField = (UITextField *)obj.object;
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

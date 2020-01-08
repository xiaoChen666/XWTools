//
//  XWTextCodeVerifyViewController.m
//  XWTools
//
//  Created by xuwen_chen on 2019/9/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "XWTextCodeVerifyViewController.h"
#import "XWTextCodeView.h"
@interface XWTextCodeVerifyViewController ()
@property (nonatomic, strong) XWTextCodeView *textView;

@property (nonatomic, strong) UILabel *label;
@end

@implementation XWTextCodeVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"文字验证码";
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(30, 150, 200, 30)];
    
    [self.view addSubview:self.label];
    
    self.label.adjustsFontSizeToFitWidth = YES;
    
    
    
    
    
    CGRect one = CGRectMake(0, 0, 100, 100);
    CGRect two = CGRectMake(0, 101, 100, 100);
    BOOL contains = CGRectIntersectsRect(one, two);
    
    
    XWTextCodeView *textView = [[XWTextCodeView alloc] init];
    textView.backgroundColor = [UIColor redColor];
    textView.textTotal = 5;
    textView.textNum = 5;
    [textView change];
    [self.view addSubview:textView];
    
    self.textView = textView;
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200,200));
    }];
    
    
    XMWeakSelf
    textView.successBlock = ^(BOOL is) {
        NSLog(@"----%d",is);
        if (is) {
            weakSelf.label.text = @"成功";
        } else {
            weakSelf.label.text = @"失败";
        }
    };
    
    
    self.label.text = [NSString stringWithFormat:@"按 %@ 顺序点击",self.textView.textString];
    
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(30, 50, 100, 30)];
    
    [button setTitle:@"刷新" forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    
    button.backgroundColor = [UIColor darkGrayColor];
    
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Do any additional setup after loading the view.
}


- (void)buttonClick{
    
    [self.textView change];
    self.label.text = [NSString stringWithFormat:@"按 %@ 顺序点击",self.textView.textString];

    
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

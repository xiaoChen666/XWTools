//
//  XWSearchWordViewController.m
//  XWTools
//
//  Created by xuwen_chen on 2019/9/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "XWSearchWordViewController.h"
#import "NSString+CXWStr.h"
@interface XWSearchWordViewController ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation XWSearchWordViewController

- (instancetype)init {
    if (self = [super init]) {
        //
    }
    return self;
}

- (instancetype)initWithCustomTitle:(NSString *)customTitle {
    if (self = [super init]) {
        for (int i = 0; i<5; i++) {
            NSLog(@"sdkadkadhas");
            UIViewController *controller = [UIViewController new];
            [self addChildViewController:controller];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *sourStr = @"NBAnbaaaa你A";

    
    self.label = [[UILabel alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.label];
    [self setKeyWord:@"你a" andSourStr:sourStr];
    
    // Do any additional setup after loading the view.
}


- (void)setKeyWord:(NSString *)keyword andSourStr:(NSString *)customStr {
    
    if (kStringIsEmpty(keyword)) {
        self.label.text = customStr;
    } else {
        NSArray *ranges = [customStr getAllRangeOfString:keyword];
        if (kArrayIsEmpty(ranges)) {
            self.label.text = customStr;
        } else {
            NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:customStr];
            for (NSValue * v in ranges) {
                NSRange range = [v rangeValue];
                [att addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#3683FF"] range:range];
            }
            
            self.label.attributedText = [att copy];
        }
    }
    
}



- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:18];
        _label.textColor = [UIColor blackColor];
    }
    return _label;
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

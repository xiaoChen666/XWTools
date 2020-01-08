//
//  XWMeHomeViewController.m
//  SuperBabyTest
//
//  Created by mac on 2019/5/14.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "XWMeHomeViewController.h"
#import "UICountingLabel.h"
#import "DPScrollNumberLabel.h"
#import "AMAnimatedNumber.h"
#import "LNNumberScrollAnimatedView.h"
#import "JQScrollNumberLabel.h"
@interface XWMeHomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) CXWBaseTabView *tableView;
@property (nonatomic, strong) JQScrollNumberLabel *label;
@property (nonatomic, assign) NSInteger count;
@end

@implementation XWMeHomeViewController

- (instancetype)init {
    if (self = [super init]) {
        //
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];


    JQScrollNumberLabel *label = [[JQScrollNumberLabel alloc] initWithNumber:[NSNumber numberWithInt:0] font:[UIFont systemFontOfSize:16]];
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.view).with.offset(150);
        make.size.mas_equalTo(CGSizeMake(100, 18));
    }];
    
    self.label = label;
    
    self.count = 1;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.count= self.count+5;
    [self.label changeToNumber:[NSNumber numberWithInt:self.count] animated:YES];
    
}





@end

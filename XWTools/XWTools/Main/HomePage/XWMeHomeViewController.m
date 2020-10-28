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

    
    NSMutableDictionary *muDic = [NSMutableDictionary dictionary];
    [muDic setValue:nil forKey:@"aaa"];
//    [muDic setObject:nil forKey:@"aa"];
    
//    NSObject *obj = [[NSObject alloc] init];
//    [obj setValue:@"" forKey:@"isa"];
    
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}





@end

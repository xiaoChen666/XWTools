//
//  XWNewsHomeViewController.m
//  SuperBabyTest
//
//  Created by mac on 2019/5/14.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "XWNewsHomeViewController.h"

#import "XMLimitCharViewController.h"
#import "XWCameraViewController.h"
#import "XWSearchWordViewController.h"
#import "XWTextCodeVerifyViewController.h"
#import "XWOtherTextCodeVerifyViewController.h"
#import "XWShakeViewController.h"

#import "NSString+AES.h"
#import "XWUserModel.h"
#import "AESCrypt.h"
#import "XWPhotoViewController.h"
#import "CJSONSerializer.h"

#import "XMNotiView.h"
#import "XMPerson.h"
#import <objc/runtime.h>
#import "XMPerson.h"
#import "UIView+AZGradient.h"
#import <UIImageView+WebCache.h>
@interface XWNewsHomeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *sourArr;

@property (nonatomic, strong) XMPerson *person;
@property (nonatomic, strong) XMPerson *personTwo;
@end

@implementation XWNewsHomeViewController


- (void)printMethodNameofClass:(Class)class {

    
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self init_UI];
//
//
//    NSLog(@"----%p---%p---%p",@selector(test),@selector(test),sel_registerName(@"test"));
//
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
//    [self.view addSubview:label];
//
//    UIColor *startColor = [UIColor redColor];
//    UIColor *endColor = [UIColor blackColor];
//
//    [label az_setGradientBackgroundWithColors:@[startColor,endColor] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1.0, 0.5)];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [imageV sd_setImageWithURL:[NSURL URLWithString:@"https://isparta.github.io/compare-webp/image/gif_webp/webp/2.webp"]];
    [self.view addSubview:imageV];
    
}


- (void)test {
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


#pragma mark UITalbeViewDataSourceDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sourArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.sourArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
//            XMLimitCharViewController *VC = [[XMLimitCharViewController alloc] init];
//            [self.navigationController pushViewController:VC animated:YES];
            
            XMNotiView *notiView = [[XMNotiView alloc] init];
            [notiView show];
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            XWCameraViewController *VC = [[XWCameraViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 3:
        {
//            XWSearchWordViewController *VC = [[XWSearchWordViewController alloc] init];
            XWSearchWordViewController *VC = [[XWSearchWordViewController alloc] initWithCustomTitle:@"hehe"];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 4:
        {
            XWTextCodeVerifyViewController *VC = [[XWTextCodeVerifyViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 5:
        {
            XWOtherTextCodeVerifyViewController *VC = [[XWOtherTextCodeVerifyViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
            
        }
            break;
        case 6:
        {
            XWShakeViewController *VC = [[XWShakeViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 7:
        {
            XWPhotoViewController *VC = [[XWPhotoViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
            
        default:
            break;
    }
}






#pragma mark UI
- (void)init_UI {
    
    self.sourArr = @[@"字符限制",@"自定义下拉刷新",@"美颜相机",@"搜索关键字",@"图片验证码",@"后台图形验证码",@"抖动动画",@"调用相机"];
    
    
    [self.view addSubview:self.tableView];
    
    self.tableView.frame = self.view.bounds;
    
    [self.tableView reloadData];
}

#pragma mark lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

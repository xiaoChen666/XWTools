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
#import "Event.h"
#import "XWPhotoViewController.h"
#import "CJSONSerializer.h"

#import "XMNotiView.h"

@interface XWNewsHomeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *sourArr;
@end

@implementation XWNewsHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"main";
    [self init_UI];
    
    //    NSString *action;
    //    NSString *time;
    //    NSString *activity;
    //    NSString *page;
    //    int acc;
    //    NSString *version;
    //    NSString *jsonstr;
    //    NSString *lib_version;
    //    NSString *sessionID;
    //    NSString *country;
    //    NSString *region;
    //    NSString *city;
    //    NSString *pay;
    //    NSString *app_version;
    //    NSString *platform;
    //    NSString *os_version;
    //    NSString *resolution;
    //    NSString *deviceid;
    //    NSString *event_type;
    //    NSString *refer;
    //    NSString *event_value;
    //    NSString *channel;
    //    NSString *userid;
    //    NSString *algorithm;
    //    NSInteger duration;
    
    NSMutableArray *muArr = [NSMutableArray array];
    for (int i = 0; i<30; i++) {
        Event *Ev = [[Event alloc] init];
        Ev.userid = @"12221313";
        Ev.time = @"2019-11-20 12:22:49";
        Ev.other_info = @"{}";
        Ev.country = @"中国";
        Ev.event_type = @"pageview";
        Ev.event_value = @"首页-女足";
        Ev.app_version = @"3.0.1";
        Ev.region = @"广东省";
        Ev.brand = @"apple";
        Ev.channel = @"苹果商店";
        Ev.action = @"app_010101";
        Ev.duration = 0;
        Ev.city = @"深圳市";
        Ev.algorithm = @"";
        Ev.resolution = @"750x1334";
        Ev.type = @"";
        Ev.refer = @"首页-赛事";
        Ev.deviceid = @"a7dbbeddcad8e07ef0d50c9c56a8cc4107843db4";
        Ev.platform = @"ios";
        
        Ev.os_version = @"IOS13.20";
        Ev.page = @"首页-女足";
        
        NSDictionary *dic = [self backDicWithEvent:Ev];
        [muArr addObject:dic];
    }
    NSError *error = NULL;
    NSData *requestData = [[CJSONSerializer serializer] serializeArray:muArr error:&error];
    NSString *requestStr = [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
    NSString *encodedString = [requestStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (NSDictionary *)backDicWithEvent:(Event *)mEvent {
    NSMutableDictionary *requestDictionary = [[NSMutableDictionary alloc] init];
    
    
    
    if(!kStringIsEmpty(mEvent.action)){
        [requestDictionary setObject:mEvent.action forKey:@"action"];
    }else {
       [requestDictionary setObject:@"" forKey:@"action"];
    }
    
    
    if(!kStringIsEmpty(mEvent.page)){
        [requestDictionary setObject:mEvent.page forKey:@"page"];
    }else {
        [requestDictionary setObject:@"" forKey:@"page"];
    }
    
    if(!kStringIsEmpty(mEvent.refer)){
        [requestDictionary setObject:mEvent.refer forKey:@"refer"];
    }else {
       [requestDictionary setObject:@"" forKey:@"refer"];
    }
    
    
    if(!kStringIsEmpty(mEvent.event_type)){
        [requestDictionary setObject:mEvent.event_type forKey:@"event_type"];
    }else {
       [requestDictionary setObject:@"" forKey:@"event_type"];
    }
    
    if(!kStringIsEmpty(mEvent.event_value)){
        [requestDictionary setObject:mEvent.event_value forKey:@"event_value"];
    }else {
       [requestDictionary setObject:@"" forKey:@"event_value"];
    }
    
    
    if (!kStringIsEmpty(mEvent.algorithm)) {
        [requestDictionary setObject:mEvent.algorithm forKey:@"algorithm"];
    }else {
       [requestDictionary setObject:@"" forKey:@"algorithm"];
    }
    
    if(!kStringIsEmpty(mEvent.deviceid)){
        [requestDictionary setObject:mEvent.deviceid forKey:@"deviceid"];
    }else {
       [requestDictionary setObject:@"" forKey:@"deviceid"];
    }
    
    if(!kStringIsEmpty(mEvent.os_version)){
        [requestDictionary setObject:mEvent.os_version forKey:@"os_version"];
    }else {
       [requestDictionary setObject:@"" forKey:@"os_version"];
    }
    
    if(!kStringIsEmpty(mEvent.resolution)){
        [requestDictionary setObject:mEvent.resolution forKey:@"resolution"];
    }else {
       [requestDictionary setObject:@"" forKey:@"resolution"];
    }
    
    
    if (mEvent.duration==0) {
        [requestDictionary setObject:@(0) forKey:@"duration"];
    }else {
        [requestDictionary setObject:@(mEvent.duration) forKey:@"duration"];
    }
    
    if(!kStringIsEmpty(mEvent.platform)){
        [requestDictionary setObject:mEvent.platform forKey:@"platform"];
    }else {
       [requestDictionary setObject:@"" forKey:@"platform"];
    }

    if(!kStringIsEmpty(mEvent.city)){
        [requestDictionary setObject:mEvent.city forKey:@"city"];
    }else {
       [requestDictionary setObject:@"" forKey:@"city"];
    }
    
    if(!kStringIsEmpty(mEvent.country)){
        [requestDictionary setObject:mEvent.country forKey:@"country"];
    }else {
       [requestDictionary setObject:@"" forKey:@"country"];
    }
    
    if(!kStringIsEmpty(mEvent.region)){
        [requestDictionary setObject:mEvent.region forKey:@"region"];
    }else {
       [requestDictionary setObject:@"" forKey:@"region"];
    }
    
    if(!kStringIsEmpty(mEvent.time)){
        [requestDictionary setObject:mEvent.time forKey:@"time"];
    }else {
       [requestDictionary setObject:@"" forKey:@"time"];
    }
    
    if (!kStringIsEmpty(mEvent.userid)) {
        [requestDictionary setObject:mEvent.userid forKey:@"userid"];
    }else {
       [requestDictionary setObject:@"" forKey:@"userid"];
    }
    
    if(!kStringIsEmpty(mEvent.app_version)){
        [requestDictionary setObject:mEvent.app_version forKey:@"app_version"];
    }else {
       [requestDictionary setObject:@"" forKey:@"app_version"];
    }

    
    if (!kStringIsEmpty(mEvent.channel)) {
        [requestDictionary setObject:mEvent.channel forKey:@"channel"];
    }else {
       [requestDictionary setObject:@"" forKey:@"channel"];
    }
    
//    if (!kStringIsEmpty(mEvent.type)) {
//        [requestDictionary setObject:mEvent.type forKey:@"type"];
//    }else {
//       [requestDictionary setObject:@"" forKey:@"type"];
//    }
//
//    if (!kStringIsEmpty(mEvent.brand)) {
//        [requestDictionary setObject:mEvent.brand forKey:@"brand"];
//    }else {
//       [requestDictionary setObject:@"" forKey:@"brand"];
//    }
//
//    if (!kStringIsEmpty(mEvent.other_info)) {
//        [requestDictionary setObject:mEvent.other_info forKey:@"other_info"];
//    }else {
//       [requestDictionary setObject:@"{}" forKey:@"other_info"];
//    }
    
    return [requestDictionary copy];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    Event *ev = [Event new];
//    ev.duration = 0;
//    ev.page = @"呵呵";
//    [self storeData:ev];
}

///存储数据
- (void)storeData:(Event *)event {
    NSArray *eventArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"haha"];
    for (NSData *currentData in eventArr) {
        Event *currentModel = [NSKeyedUnarchiver unarchiveObjectWithData:currentData];
        NSLog(@"---%@",currentModel);
    }
    NSMutableArray *muArr = [NSMutableArray arrayWithArray:eventArr];
    if (!kObjectIsEmpty(event)) {
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:event];
        [muArr addObject:data];
    }
    if (muArr.count>=3) {
        ///上传 并清空本地
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"haha"];
    }else {
        if (!kArrayIsEmpty(muArr)) {
            [[NSUserDefaults standardUserDefaults] setObject:[muArr copy] forKey:@"haha"];
        }
    }
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

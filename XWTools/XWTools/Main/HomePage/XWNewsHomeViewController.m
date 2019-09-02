//
//  XWNewsHomeViewController.m
//  SuperBabyTest
//
//  Created by mac on 2019/5/14.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "XWNewsHomeViewController.h"

#import "XMLimitCharViewController.h"
@interface XWNewsHomeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *sourArr;
@end

@implementation XWNewsHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"main";
    [self init_UI];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
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
            XMLimitCharViewController *VC = [[XMLimitCharViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark UI
- (void)init_UI {
    
    self.sourArr = @[@"字符限制",@"",@""];
    
    
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

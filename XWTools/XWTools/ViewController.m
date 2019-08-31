//
//  ViewController.m
//  XWTools
//
//  Created by mac on 2019/2/14.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ViewController.h"
#import "XMLimitCharViewController.h"
@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *sourArr;
@end

@implementation ViewController

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

@end

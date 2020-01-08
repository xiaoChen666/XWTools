//
//  XWShakeViewController.m
//  XWTools
//
//  Created by xuwen_chen on 2019/10/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "XWShakeViewController.h"

@interface XWShakeViewController ()

@end

@implementation XWShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"num3"];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 25, 25)];
    imageV.image = image;
    [self.view addSubview:imageV];
    
    CABasicAnimation *animationOne = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animationOne.fromValue = [NSNumber numberWithFloat:-M_PI*0.25f];
    animationOne.toValue = [NSNumber numberWithFloat: M_PI*0.25 ];
//    animationOne.duration = 3;
//    animationOne.repeatCount = 3;
//    animationOne.autoreverses = NO;
//    animationOne.fillMode = kCAFillModeForwards;
//    animationOne.removedOnCompletion = NO;

    
    CABasicAnimation *animationTwo = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animationTwo.fromValue = [NSNumber numberWithFloat:M_PI*0.25];
    animationTwo.toValue = [NSNumber numberWithFloat: -M_PI*0.25];
//    animationTwo.duration = 1;
//    animationTwo.autoreverses = NO;
//    animationTwo.fillMode = kCAFillModeForwards;
//    animationTwo.removedOnCompletion = NO;

    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 0.5/8.0;
    group.repeatCount = 8; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    group.animations = [NSArray arrayWithObjects:animationOne,animationTwo, nil];
    group.autoreverses =YES;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = YES;
    [imageV.layer addAnimation:group forKey:nil];
    
    
    // Do any additional setup after loading the view.
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

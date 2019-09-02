//
//  XWWelcomeViewController.m
//  voiceAIApp
//
//  Created by mac on 2019/3/20.
//  Copyright © 2019年 Avsnest. All rights reserved.
//

#import "XWWelcomeViewController.h"
#import "CXWLocationTools.h"
#import "CXWBaseScrollView.h"
#import "UIImage+Extension.h"

#import "CXWBaseNavigationController.h"
#import "XWTabbarController.h"
#import "AppDelegate.h"
#import "XWLoginViewController.h"

#define NewfeatureCount 1



@interface XWWelcomeViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, copy) CXWPublicVoidBlock missBlock;
@end

@implementation XWWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)CXWAddSubviews{
    
    CXWBaseScrollView *scrollView = [[CXWBaseScrollView alloc] initWithFrame:CGRectMake(0, 0, KAPPWidth, KAppHeight)];
    scrollView.center = self.view.center;
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    
    
    // 2.添加图片到scrollView中
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    NSString *firstName = @"guide_image_";
    if (kIs_iPhoneX) {
        firstName = @"guide_image_big_";
    }
    for (int i = 0; i < NewfeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(i * scrollW, 0, scrollW, scrollH);
        NSString *name = [NSString stringWithFormat:@"%@%d.png",firstName,i+1];
        imageView.image = [UIImage CXWGetImageWithContentsOfFileName:name];
        [scrollView addSubview:imageView];
        
        if (i == NewfeatureCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    // 3.设置scrollView属性
    scrollView.contentSize = CGSizeMake(NewfeatureCount * scrollW, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    
    // 4.添加pageControl，用于分页
    
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = NewfeatureCount;
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:CXWThemeColorStr];
    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = KAppHeight - 50;
//    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}




- (void)setupLastImageView:(UIImageView *)imageView
{
    
    
    
    // 开启交互
    imageView.userInteractionEnabled = YES;
    
    // 2.开始微博
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setTitleColor:[UIColor colorWithHexString:CXWThemeColorStr] forState:UIControlStateNormal];
    [startBtn setTitle:@"立即体验" forState:UIControlStateNormal];
    startBtn.titleLabel.font = [UIFont CXWFontWithName:CXWPingFang_SC_Regular size:17];
    startBtn.backgroundColor = [UIColor colorWithHexString:CXWWriteColorStr];
    startBtn.layer.cornerRadius = 17.5;
    
    startBtn.layer.shadowOffset = CGSizeMake(4, 4);
    startBtn.layer.shadowRadius = 2;
    startBtn.layer.shadowColor = [UIColor colorWithHexString:@"#7DCBFF"].CGColor;
    startBtn.layer.shadowOpacity = 1.0;

    
    CGFloat  btnWidth = 200*KAPPWidth/375.0;
    CGFloat  btnHeight = 35*KAPPWidth/375.0;
    startBtn.frame = CGRectMake((imageView.width-btnWidth)*0.5, KAppHeight-CURRENTSCREN_SafeArea_HEIGHT-114, btnWidth, btnHeight);
    
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
    
}

- (void)startClick
{
    /*
     切换控制器的手段
     1.push：依赖于UINavigationController，控制器的切换是可逆的，比如A切换到B，B又可以回到A
     2.modal：控制器的切换是可逆的，比如A切换到B，B又可以回到A
     3.切换window的rootViewController
     */
    [self LastJump];
}

- (void)LastJump
{
    
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [self setAnimatedWithTransition];
    
//    if (kStringIsEmpty([XWUserManager shareManager].userModel.NickName)) {
//        XWLoginViewController *login = [[XWLoginViewController alloc] init];
//        CXWBaseNavigationController *navi = [[CXWBaseNavigationController alloc] initWithRootViewController:login];
//        delegate.window.rootViewController = navi;
//    }else {
//        delegate.window.rootViewController = [[XWTabbarController alloc] init];
//    }
    
    delegate.window.rootViewController = [[XWTabbarController alloc] init];
}

- (void)setAnimatedWithTransition{
    
    CATransition *animation = [CATransition animation];
    //动画时间
    animation.duration = 1.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //过渡效果
    animation.type = @"cube";
    //过渡方向
    animation.subtype = kCATransitionFromRight;
    
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
}



#pragma mark - UIScrollViewDelegate
//// 该代理方法能监听当前scroll的更多属性 隐藏最后一个按钮
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    //     四舍五入计算出页码
    //     1.3四舍五入 1.3 + 0.5 = 1.8 强转为整数(int)1.8= 1
    //     1.5四舍五入 1.5 + 0.5 = 2.0 强转为整数(int)2.0= 2
    //     1.6四舍五入 1.6 + 0.5 = 2.1 强转为整数(int)2.1= 2
    //     0.7四舍五入 0.7 + 0.5 = 1.2 强转为整数(int)1.2= 1
    self.pageControl.currentPage = (int)(page + 0.5);
    
    
}


- (void)dealloc {
    NSString *versionKey = CXWBundleVersion;
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:versionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
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

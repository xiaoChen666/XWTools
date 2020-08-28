//
//  XWCameraViewController.m
//  XWTools
//
//  Created by xuwen_chen on 2019/9/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import "XWCameraViewController.h"

#import "GPUImage.h"

#import <Photos/Photos.h>

#import "XWPhotoCollectionViewCell.h"
#import "XMFilerModel.h"


#import "GPUImageGrayscaleFilter.h"
#import "GPUImageBeautifyFilter.h"
#import "XMGrayFilter.h"


@interface XWCameraViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property(strong,nonatomic) GPUImageStillCamera *myCamera;
@property(strong,nonatomic) GPUImageView *myGPUImageView;
@property(strong,nonatomic) GPUImageOutput *myFilter;


@property (nonatomic, strong) UIButton *cameraBtn;
@property (nonatomic, strong) UIButton *switchBtn;

@property (nonatomic, strong) UICollectionView *collectView;
@property (nonatomic, strong) NSMutableArray *muArr;

@end

@implementation XWCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self initUI];
    [self init_data];
  

    // Do any additional setup after loading the view.
}


#pragma mark Event
- (void)switchIsChanged:(UIButton *)sender {
    [self.myCamera rotateCamera];
}



//开始拍照
- (void)capturePhoto:(UIButton *)sender {
    //定格一张图片 保存到相册
    [self.myCamera capturePhotoAsPNGProcessedUpToFilter:self.myFilter withCompletionHandler:^(NSData *processedPNG, NSError *error) {
        
        //拿到相册，需要引入Photo Kit
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            //写入图片到相册
            PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:[UIImage imageWithData:processedPNG]];
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            
            NSLog(@"success = %d, error = %@", success, error);
            
        }];
        
    }];
}


#pragma mark CollectViewDataSourceDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.muArr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XWPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XWPhotoCollectionViewCell" forIndexPath:indexPath];
    cell.currentModel = self.muArr[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XMFilerModel *model = self.muArr[indexPath.row];
    
    [self.myCamera removeTarget:self.myFilter];
    [self.myFilter removeTarget:self.myGPUImageView];
    
    GPUImageFilter *filter = model.currentFiler;
    
    [self.myCamera addTarget:filter];
    [filter addTarget:self.myGPUImageView];
    
    self.myFilter = filter;
    

}


#pragma mark UI

- (void)initUI {
    
  [self init_set];
    
    [self.view addSubview:self.myGPUImageView];

    [self.view addSubview:self.switchBtn];
    [self.view addSubview:self.cameraBtn];
    [self.view addSubview:self.collectView];
    
    
 
    
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 35));
        make.top.equalTo(self.view).with.offset(30);
        make.right.equalTo(self.view).with.offset(-60);
    }];
    
    [self.cameraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.bottom.equalTo(self.view).with.offset(-80);
        make.centerX.equalTo(self.view);
    }];
    
    [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 200));
        make.left.equalTo(self.view).with.offset(10);
        make.centerY.equalTo(self.view);
    }];
    
}

- (void)init_set {
    self.myCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionFront];
    
    //竖屏方向
    self.myCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    


           //初始化GPUImageView
    self.myGPUImageView = [[GPUImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];

    GPUImageBeautifyFilter *beautyFielter = [[GPUImageBeautifyFilter alloc] init];
//
//        //初始设置为哈哈镜效果
    [self.myCamera addTarget:beautyFielter];
//
    
    [beautyFielter addTarget:self.myGPUImageView];
        //
    self.myFilter = beautyFielter;
    
    RunAfter(0.01, ^{
        [self.myCamera startCameraCapture];
    });
    
}

- (void)init_data {
   
    
    XMFilerModel *beatyModel = [[XMFilerModel alloc] init];
    GPUImageBeautifyFilter *beautyFielter = [[GPUImageBeautifyFilter alloc] init];
    beatyModel.currentFiler = beautyFielter;
    beatyModel.filerTitle = @"美颜";
    
    XMFilerModel *GrayModel = [[XMFilerModel alloc] init];
    GPUImageGrayscaleFilter *GrayFielter = [[GPUImageGrayscaleFilter alloc] init];
    GrayModel.currentFiler = GrayFielter;
    GrayModel.filerTitle = @"灰度";
    
    XMFilerModel *XMGrayModel = [[XMFilerModel alloc] init];
    XMGrayFilter *XMGrayFielter = [[XMGrayFilter alloc] init];
    XMGrayModel.currentFiler = XMGrayFielter;
    XMGrayModel.filerTitle = @"灰度2";
    
    
    XMFilerModel *SketchModel = [[XMFilerModel alloc] init];
    GPUImageSketchFilter *SketchFielter = [[GPUImageSketchFilter alloc] init];
    SketchModel.currentFiler = SketchFielter;
    SketchModel.filerTitle = @"素描";
    

    
    
    
    [self.muArr addObjectsFromArray:@[beatyModel,GrayModel,XMGrayModel,SketchModel]];
    
    [self.collectView reloadData];
}



#pragma mark lazy
- (UIButton *)switchBtn {
    if (!_switchBtn) {
        UIButton *switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置2s内不可以连续点击,防止用户连续点击

        [switchBtn setImage:[UIImage imageNamed:@"switch.png"] forState:UIControlStateNormal];
        [switchBtn addTarget:self action:@selector(switchIsChanged:) forControlEvents:UIControlEventTouchUpInside];
        switchBtn.backgroundColor = [UIColor redColor];
        _switchBtn = switchBtn;
    }
    return _switchBtn;
}

- (UIButton *)cameraBtn {
    if (!_cameraBtn) {
        _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraBtn addTarget:self action:@selector(capturePhoto:) forControlEvents:UIControlEventTouchUpInside];
        _cameraBtn.backgroundColor = [UIColor redColor];
        [_cameraBtn setBackgroundImage:[UIImage imageNamed:@"photo.png"] forState:UIControlStateNormal];
    }
    return _cameraBtn;
}

- (NSMutableArray *)muArr {
    if (!_muArr) {
        _muArr = [NSMutableArray array];
    }
    return _muArr;
}

- (UICollectionView *)collectView {
    if (!_collectView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(40,40);
        
        UICollectionView *collectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectView.dataSource = self;
        collectView.delegate = self;
        [collectView registerClass:[XWPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"XWPhotoCollectionViewCell"];
        collectView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        _collectView = collectView;
    }
    return _collectView;
}

@end

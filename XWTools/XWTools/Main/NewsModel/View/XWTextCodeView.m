//
//  XWTextCodeView.m
//  XWTools
//
//  Created by xuwen_chen on 2019/9/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "XWTextCodeView.h"

///视图的宽和高
CGFloat viewWidth = 200;
CGFloat viewHeight = 200;

///防止旋转后文字重叠 扩大本身的区域
NSInteger labelMargin = 10;

@interface XWTextCodeView ()

// 需要点击的文字数组
@property (nonatomic, strong) NSArray *needTapArray;

// 已点击的文字 数组
@property (nonatomic, strong) NSMutableArray *resultArray;


// 文字数组
@property (nonatomic, strong) NSMutableArray *textArr;


@property (nonatomic, strong) NSMutableArray *frameArray;

///当前点击的数字
@property (nonatomic, assign) NSInteger currentNumber;



// 视图消失
- (void)didmiss;



@end


@implementation XWTextCodeView



- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.currentNumber = 1;
        [self createUI];
    }
    
    return self;
    
}

- (void)createUI{
    
    self.textArr = [NSMutableArray array];
    
    self.resultArray = [NSMutableArray array];
    
    self.textString = nil;
    
    // 默认随机生成5个不同汉字
    for (int i = 0; i < self.textTotal; i ++) {
        
        NSString *text = [self Written];
        
        BOOL is = YES;
        
        for (NSString *str in self.textArr) {
            
            if ([str isEqualToString:text]) {
                i = i - 1;
                is = NO;
                break;
            }
        }
        
        if (is) {
            [self.textArr addObject:text];
            
        }
        
    }
    
    
    for (int i = 0; i < self.textArr.count; i ++) {
        
        int wh = [self getRandomNumber:20 to:28];
    
        UILabel *label = [[UILabel alloc] initWithFrame:[self getFrameWithWidth:wh]];
        label.backgroundColor = [UIColor whiteColor];
        
        int font = wh-5;
        
        
        label.font =  [UIFont fontWithName:[self fonStyle] size:font];
        
        label.adjustsFontSizeToFitWidth = YES;
        
        NSString *text = self.textArr[i];
        
        label.text = text;
        
        label.textAlignment = NSTextAlignmentCenter;
        
        int pi = [self getRandomNumber:-180 to:180];
        
        label.transform = CGAffineTransformMakeRotation(M_PI/pi);
        
        [self addSubview:label];
        
    }
    
    self.needTapArray = [self randomArray];
    
    
    for (NSString *str in self.needTapArray) {
        
        if (self.textString) {
            
            self.textString = [NSString stringWithFormat:@"%@ '%@'",self.textString,str];
            
        }else{
            
            self.textString = [NSString stringWithFormat:@"'%@'",str];;
            
        }
        
    }
    
}

///随机获取每个文字的frame 由于文字旋转了 所以要加大size 防止文字之间重叠
- (CGRect)getFrameWithWidth:(NSInteger)width {
    
    CGRect frame = CGRectMake(arc4random()%(int)(viewWidth-width),arc4random()%(int)(viewHeight-width), width, width);
    
    if (self.frameArray.count==0) {
        [self.frameArray addObject:NSStringFromCGRect(frame)];
        return frame;
    }
    
    BOOL  result = NO;
    
    while (!result) {
        
        BOOL currentResult = NO;
        
        for (NSString *frameStr in self.frameArray) {
            CGRect currentFrame = CGRectFromString(frameStr);
            currentFrame = CGRectMake(currentFrame.origin.x-labelMargin, currentFrame.origin.y-labelMargin, currentFrame.size.width+labelMargin, currentFrame.size.height+labelMargin);
            currentResult = CGRectIntersectsRect(currentFrame, frame);
            
            if (currentResult) {
                break;
            }
        }
        
        if (currentResult) {
            frame = CGRectMake(arc4random()%(int)(viewWidth-width),arc4random()%(int)(viewHeight-width), width, width);
        }else {
            result = YES;
        }
    }
    
    
    [self.frameArray addObject:NSStringFromCGRect(frame)];
    return frame;
}






// 视图点击事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (self.resultArray.count < self.textNum) {
        
        UITouch *touch = touches.anyObject;
        
        CGPoint touchLocation = [touch locationInView:self];
        
        
        for (int i = 0; i<self.frameArray.count; i++) {
            NSString *frameStr = self.frameArray[i];
            CGRect currentFrame = CGRectFromString(frameStr);
            BOOL result =  CGRectContainsPoint(currentFrame, touchLocation);
            if (result) {
                
                UILabel *label = [[UILabel alloc] initWithFrame:currentFrame];
                label.text = [NSString stringWithFormat:@"%d",self.currentNumber];
                self.currentNumber ++;
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor redColor];
                [self addSubview:label];
    
                NSString *tapTitle = self.textArr[i];
                
                [self.resultArray addObject:tapTitle];
                
                
                break;
            }
        }
        
    }
    
    if (self.resultArray.count==self.textNum) {
        
        NSString *needTapStr = [self.needTapArray componentsJoinedByString:nil];
        NSString *resultStr = [self.resultArray componentsJoinedByString:nil];
        
        if (self.successBlock) {
            if ([needTapStr isEqualToString:resultStr]) {
                self.successBlock(YES);
            }else {
                self.successBlock(NO);
            }
        }
        
    }
    
}



#pragma mark public

- (void)change{
    
    NSArray *views = [self subviews];
    
    for (UIView *view in views) {
        
        [view removeFromSuperview];
        
    }
    
    [self.frameArray removeAllObjects];
    [self.resultArray removeAllObjects];
    
    self.currentNumber=1;
    [self createUI];
    
}



- (void)didmiss{
    [self removeFromSuperview];
}



#pragma mark private

// 范围生成随机数
- (int)getRandomNumber:(int)from to:(int)to{
    
    if (from < to) {
        
        return (int)(from + (arc4random() % (to - from + 1)));
        
    }else{
        
        return (int)(to + (arc4random() % (from - to + 1)));
        
    }
}

// 生成随机文字
- (NSString *)Written{
    
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSInteger randomH = 0xA1+arc4random()%(0xFE - 0xA1+1);
    
    NSInteger randomL = 0xB0+arc4random()%(0xF7 - 0xB0+1);
    
    NSInteger number = (randomH<<8)+randomL;
    
    NSData *data = [NSData dataWithBytes:&number length:2];
    
    NSString *string = [[NSString alloc] initWithData:data encoding:gbkEncoding];
    
    return string;
    
}

// 默认随机取3个汉字
- (NSArray *)randomArray
{
    //随机数产生结果
    NSMutableArray *resultArray=[[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *textArr = [self.textArr copy];
    //随机3个汉字
    for (int i = 0; i < self.textNum; i ++) {
        
        int t = arc4random()%self.textArr.count;
        
        resultArray[i] = self.textArr[t];
        
        self.textArr[t] = [self.textArr lastObject]; //为更好的乱序，故交换下位置
        
        [self.textArr removeLastObject];
        
    }
    self.textArr = [textArr copy];
    return resultArray;
    
}

// 随机一个字体样式
- (NSString *)fonStyle{
    
    NSMutableArray *fontArr = [NSMutableArray arrayWithObjects:@"American Typewriter",@"AppleGothic",@"Arial",@"Arial Rounded MT Bold",@"Arial Unicode MS",@"Courier",@"Courier New",@"DB LCD Temp",@"Georgia",@"Helvetica",@"Helvetica Neue",@"Hiragino Kaku Gothic **** W3",@"Hiragino Kaku Gothic **** W6",@"Marker Felt",@"STHeiti J",@"STHeiti K",@"STHeiti SC",@"STHeiti TC",@"Times New Roman",@"Trebuchet MS",@"Verdana",@"Zapfino", nil];
    
    int t = arc4random()%fontArr.count;
    
    NSString *font = fontArr[t];
    
    return font;
    
}



#pragma mark Get && lazy

- (NSInteger)textNum{
    
    if (!_textNum) {
        
        _textNum = 3;
        
    }
    
    if (self.textTotal < _textNum) {
        
        _textNum = 3;
        
    }
    
    return _textNum;
    
}

- (NSInteger)textTotal{
    
    if (!_textTotal) {
        
        _textTotal = 5;
        
    }
    
    return _textTotal;
    
}


- (NSMutableArray *)frameArray {
    if (!_frameArray) {
        _frameArray = [NSMutableArray array];
    }
    return _frameArray;
}

- (NSMutableArray *)resultArray {
    if (!_resultArray) {
        _resultArray = [NSMutableArray array];
    }
    return _resultArray;
}

- (NSMutableArray *)textArr {
    if (!_textArr) {
        _textArr = [NSMutableArray array];
    }
    return _textArr;
}

@end

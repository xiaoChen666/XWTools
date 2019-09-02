//
//  CXWNetPublicScoreModel.h
//  voiceAIApp
//
//  Created by mac on 2018/11/14.
//  Copyright © 2018年 Avsnest. All rights reserved.
//

#import "CXWBaseJsonModel.h"

@interface CXWNetPublicScoreModel : CXWBaseJsonModel

//IsShow = 1;
//ScoreReason = "\U786e\U8ba4\U5b9d\U5b9d\U54ed\U95f9\U539f\U56e0";
//ScoreStr = "\U79ef\U5206+2";
@property (nonatomic, assign) NSInteger IsShow;

@property (nonatomic, copy) NSString *ScoreReason;

@property (nonatomic, copy) NSString *ScoreStr;
@end

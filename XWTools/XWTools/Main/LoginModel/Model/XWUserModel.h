//
//  XWUserModel.h
//  SuperBabyTest
//
//  Created by mac on 2019/5/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CXWBaseJsonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XWUserModel : CXWBaseJsonModel

///
@property (nonatomic, copy) NSString *AccessToken;

///
@property (nonatomic, copy) NSString *BirthDay;

///默认的BabyID
@property (nonatomic, assign) NSInteger DefaultBabyID;

///客户ID
@property (nonatomic, assign) NSInteger GTCustID;

///是否已经填写用户信息：1是
@property (nonatomic, assign) NSInteger HasCustomerInfo;

///是否含有宝宝信息:1是
@property (nonatomic, assign) NSInteger HasFirstBaby;

///
@property (nonatomic, copy) NSString *HeadImageUrl;

///
@property (nonatomic, copy) NSString *NickName;

///
@property (nonatomic, copy) NSString *PhoneNum;

///
@property (nonatomic, copy) NSString *Sex;


///
@property (nonatomic, copy) NSString *sexName;
//AccessToken = 389190F54EAEA7F1359DD19AEC8E419F748EEA61D6CC17A5C133713A0E060D40DC79B1EA0226BD1D6E37EBB9E7A5F7BD55F274E132A4BD8D9F338E60022D376338460052E994864C8E0EC4BE06D6D4A8A04D6F81020C3B44CADC7D6A34574FBFA5B284491302879740BD952AF1088C52A7A66F4DCC2326CA4C57101AF8B468FEC53AF9283403B1E47AD356156A25BD4677D6D7BBC7CA6AEDF0942A2159CFAC334679F943;
//BirthDay = "<null>";
//DefaultBabyID = "<null>";
//GTCustID = 11112;
//HasCustomerInfo = 0;
//HasFirstBaby = 0;
//HeadImageUrl = "";
//NickName = "<null>";
//PhoneNum = 13686819674;
//Sex = "<null>";
@end

NS_ASSUME_NONNULL_END

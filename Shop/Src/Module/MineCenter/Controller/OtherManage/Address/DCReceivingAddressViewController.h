//
//  DCReceivingAddressViewController.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/18.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCReceivingAddressViewController : STBaseViewController
//@property (nonatomic, strong) DRUserInfoModel *userModel;
@property (nonatomic,retain)NSString *selectStr;
@property (nonatomic, copy) void (^changeURLBLOCK)(NSString *addressid,NSString *receiverStr,NSString *mobileStr,NSString*addressStr);
@end

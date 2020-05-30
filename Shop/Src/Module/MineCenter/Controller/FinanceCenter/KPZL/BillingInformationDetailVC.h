//
//  BillingInformationDetailVC.h
//  Shop
//
//  Created by BWJ on 2019/2/27.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BillingInformationDetailVC : STBaseViewController
{
    
    //****************  司机  ******************
    NSString *name;         ///<姓名
    NSString *phone;        ///<电话
    NSString *identifyID;   ///<身份证
    
    NSInteger Tag;    ///<1:身份证正面照   2：身份证反面照
    
    NSString *identifyImg1;   ///<身份证正面照
    NSString *identifyImg2;   ///<身份证反面照
    
    
    
    //****************  车辆  ******************
    NSString *carID;         ///<车牌号
    NSString *carType;       ///<车型
    NSString *time;          ///<车辆注册时间
    
    // NSInteger Tag;    ///<11:驾驶证左侧页  12：驾驶证右侧页   21：行驶证左侧页   22：行驶证右侧页    31：人车合影左   32：人车合影右
    
    NSString *jiaImg1;   ///<驾驶证左侧页
    NSString *jiaImg2;   ///<驾驶证右侧页
    
    NSString *xingImg1;   ///<行驶证左侧页
    NSString *xingImg2;   ///<行驶证右侧页
    
    NSString *heImg1;   ///<人车合影左
    NSString *heImg2;   ///<人车合影右
}
@property(nonatomic,retain)NSMutableDictionary *dataDic;
@property(nonatomic,assign)NSInteger status;
@end

NS_ASSUME_NONNULL_END

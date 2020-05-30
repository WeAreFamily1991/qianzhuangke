//
//  DCNewAdressViewController.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/19.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger,DCSaveAdressType){
    DCSaveAdressNewType = 0,  //保存
    DCSaveAdressChangeType = 1, //编辑
};


@class DRAdressListModel;
@interface DCNewAdressViewController : STBaseViewController
//@property (nonatomic, strong) DRUserInfoModel *userModel;

/* type */
@property (nonatomic,assign) DCSaveAdressType saveType;

/* 更改数据 */
@property (strong , nonatomic)DRAdressListModel *adressItem;
@property (nonatomic, copy) void (^addressBlock)();
@end

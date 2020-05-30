//
//  DCFiltrateViewController.h
//  CDDStoreDemo
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCFiltrateViewController : STBaseViewController


/** 点击已选回调 */
@property (nonatomic , copy) void(^sureClickBlock)(NSArray *selectArray);
@property (nonatomic , copy) void(^selectClickBlock)(NSMutableDictionary *selectDic);

@end

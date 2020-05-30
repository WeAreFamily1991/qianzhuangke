//
//  AskSellOutVC.h
//  Shop
//
//  Created by BWJ on 2019/4/15.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AskSellOutModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AskSellOutVC : STBaseViewController
@property (nonatomic,retain)AskSellOutModel *sellOutModel;
@property (nonatomic,retain)NSMutableDictionary *senderDic;
@property(nonatomic,retain)NSDictionary *sourDic;
/**
 表单数据源，数据源格式应为 @[JhFormSection..]，否则断言会直接崩溃
 */
@property (strong, nonatomic) NSMutableArray *Jh_formModelArr;
@property (strong ,nonatomic)dispatch_block_t refreshSourceBlock;
@end

NS_ASSUME_NONNULL_END

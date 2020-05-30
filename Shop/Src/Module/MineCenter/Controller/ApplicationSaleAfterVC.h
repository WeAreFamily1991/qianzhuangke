//
//  ApplicationSaleAfterVC.h
//  Shop
//
//  Created by BWJ on 2019/3/20.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApplicationSaleAfterVC : STBaseViewController
@property(nonatomic,retain)NSDictionary *sourDic;
/**
 表单数据源，数据源格式应为 @[JhFormSection..]，否则断言会直接崩溃
 */
@property (strong, nonatomic) NSMutableArray *Jh_formModelArr;
@end

NS_ASSUME_NONNULL_END

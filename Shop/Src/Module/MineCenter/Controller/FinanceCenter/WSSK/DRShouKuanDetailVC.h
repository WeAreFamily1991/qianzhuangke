//
//  DRShouKuanDetailVC.h
//  Shop
//
//  Created by BWJ on 2019/7/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRShouKuanDetailVC : STBaseViewController
@property(nonatomic,assign)NSInteger status;
@property (nonatomic)NSMutableDictionary *sourceDic;
-(void)setSourceWithDic:(NSMutableDictionary*)dic withIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END

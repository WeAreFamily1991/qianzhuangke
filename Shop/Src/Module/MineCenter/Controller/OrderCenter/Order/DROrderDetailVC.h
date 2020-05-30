//
//  DROrderDetailVC.h
//  Shop
//
//  Created by BWJ on 2019/5/28.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DROrderDetailVC : STBaseViewController
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property(nonatomic,assign)NSInteger status;
@property (nonatomic,retain)NSMutableDictionary *mudic;

@end

NS_ASSUME_NONNULL_END

//
//  SalesOrderVC.h
//  Shop
//
//  Created by BWJ on 2019/2/26.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SalesOrderVC : STBaseViewController
@property(nonatomic,assign)NSInteger num;
@property (copy,nonatomic) void (^sourceDicBlock) (NSDictionary *sourceDic);
@end

NS_ASSUME_NONNULL_END

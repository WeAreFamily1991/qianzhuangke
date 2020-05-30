//
//  DRShouKuanVC.h
//  Shop
//
//  Created by BWJ on 2019/7/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRShouKuanVC : STBaseViewController
@property(nonatomic,assign)NSInteger num;
@property (copy,nonatomic) void (^sourceDicBlock) (NSDictionary *sourceDic);
@end

NS_ASSUME_NONNULL_END

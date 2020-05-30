//
//  BillMessageDetailChildVC.h
//  Shop
//
//  Created by BWJ on 2019/3/1.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillMessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BillMessageDetailChildVC : STBaseViewController
@property (nonatomic,retain)BillMessageModel *MessageModel;
@property (nonatomic, copy) void (^changeInfo)();
@end

NS_ASSUME_NONNULL_END

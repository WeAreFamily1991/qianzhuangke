//
//  BackVC.h
//  Shop
//
//  Created by BWJ on 2019/2/28.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillMessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BackVC : STBaseViewController
@property (nonatomic,retain)BillMessageModel *MessageModel;
- (void)show;
@end

NS_ASSUME_NONNULL_END

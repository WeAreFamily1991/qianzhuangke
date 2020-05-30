//
//  ChildAddVC.h
//  Shop
//
//  Created by BWJ on 2019/3/6.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRChildCountModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ChildAddVC : STBaseViewController
@property (nonatomic,assign)BOOL selectType;
@property (nonatomic,retain)DRChildCountModel *childModel;
@property (nonatomic, copy) void (^childBlock)();
@end

NS_ASSUME_NONNULL_END

//
//  DRMessageDetailView.h
//  Shop
//
//  Created by BWJ on 2019/6/17.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillMessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DRMessageDetailView : UIView
@property (weak, nonatomic) IBOutlet UIButton *colseBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic,strong)dispatch_block_t closeBtnBlock;
@property (nonatomic,strong)dispatch_block_t backBtnBlock;
@property (nonatomic,retain)BillMessageModel *MessageModel;
@end

NS_ASSUME_NONNULL_END

//
//  CustomFooterView.h
//  Shop
//
//  Created by BWJ on 2019/3/19.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomFooterView : UIView
@property (weak, nonatomic) IBOutlet UIButton *compTypeBtn;
@property (weak, nonatomic) IBOutlet UILabel *companyLab;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UILabel *contentlAB;
@property (weak, nonatomic) IBOutlet UIButton *selectType;
@property (nonatomic,retain)dispatch_block_t seleectTypeBtnBlock;

@end

NS_ASSUME_NONNULL_END

//
//  WeiShuiHeaderView.h
//  Shop
//
//  Created by rockding on 2019/12/9.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeiShuiHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *waitPayLab;
@property (weak, nonatomic) IBOutlet UIButton *countPayBtn;
@property (weak, nonatomic) IBOutlet UIButton *allPayBtn;
@property (weak, nonatomic) IBOutlet UILabel *orderPayLab;
@property (weak, nonatomic) IBOutlet UILabel *payedLab;

@end

NS_ASSUME_NONNULL_END

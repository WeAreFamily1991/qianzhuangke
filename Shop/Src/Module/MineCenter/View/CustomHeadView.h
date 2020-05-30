//
//  CustomHeadView.h
//  Shop
//
//  Created by BWJ on 2019/3/1.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomHeadView : UIView
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *payAllLab;
@property (weak, nonatomic) IBOutlet UILabel *allCountLab;
@property (weak, nonatomic) IBOutlet UILabel *onlineLab;
@property (weak, nonatomic) IBOutlet UILabel *onlineBackLab;
@property (weak, nonatomic) IBOutlet UILabel *EDuLab;
@property (weak, nonatomic) IBOutlet UILabel *eDuBackLab;
@property (weak, nonatomic) IBOutlet UILabel *shopMoneyLab;
@property (weak, nonatomic) IBOutlet UILabel *yFMoneyLab;

@end

NS_ASSUME_NONNULL_END

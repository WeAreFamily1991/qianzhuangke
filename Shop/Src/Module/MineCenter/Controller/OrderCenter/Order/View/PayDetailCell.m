//
//  PayDetailCell.m
//  Shop
//
//  Created by rockding on 2020/3/3.
//  Copyright © 2020 SanTie. All rights reserved.
//

#import "PayDetailCell.h"

@implementation PayDetailCell
-(UILabel*)leftLab
{
    if (!_leftLab) {
        self.leftLab =[UILabel labelWithText:@"订单" font:DR_FONT(14) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:0 superView:self];
    }
    return _leftLab;
}
-(UILabel*)rightLab
{
    if (!_rightLab) {
        self.rightLab =[UILabel labelWithText:@"右边" font:DR_FONT(14) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:2 superView:self];
    }
    return _rightLab;
}
-(void)layoutSubviews
{
    [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
               make.left.mas_equalTo(self).offset(WScale(10));
               make.centerY.mas_equalTo(self);
               make.height.mas_equalTo(WScale(14));
       
    }];
    [self.rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftLab.mas_right).offset(WScale(17));
        make.right.mas_equalTo(self).offset(-WScale(10));
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(WScale(14));
    
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

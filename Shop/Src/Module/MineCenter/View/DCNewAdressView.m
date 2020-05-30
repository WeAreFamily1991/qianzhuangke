

//
//  DCNewAdressView.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/19.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCNewAdressView.h"

// Controllers

// Models

// Views
#import "DCPlaceholderTextView.h"
// Vendors

// Categories

// Others

@interface DCNewAdressView ()

@end

@implementation DCNewAdressView

#pragma mark - Intial
- (void)awakeFromNib
{
    [super awakeFromNib];
    _detailTextView.placeholder= @"请输入详细地址";
    
    [self setUpBase];
}

- (void)setUpBase
{
    
}


#pragma mark - 选择地址
- (IBAction)addressButtonClick {    
    !_selectAdBlock ? : _selectAdBlock();
}
- (IBAction)isDefautsBtnClick:(id)sender {
    !_isDefautsBlock ? : _isDefautsBlock();
}
#pragma mark - Setter Getter Methods

@end

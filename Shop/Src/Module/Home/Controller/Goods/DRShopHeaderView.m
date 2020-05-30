//
//  DRShopHeaderView.m
//  Shop
//
//  Created by BWJ on 2019/5/5.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRShopHeaderView.h"

@implementation DRShopHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)phoneBtnClick:(id)sender
{
    
}
- (IBAction)backBtnClick:(id)sender {
    !_backBtnClickBlock?:_backBtnClickBlock();
}

@end

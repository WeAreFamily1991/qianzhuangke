//
//  DRHeaderTitleView.m
//  Shop
//
//  Created by rockding on 2019/12/30.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRHeaderTitleView.h"

@implementation DRHeaderTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI
{
    self.backgroundColor =WHITECOLOR;
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WScale(10))];
    lineView.backgroundColor =BACKGROUNDCOLOR;
    [self addSubview:lineView];
    
    self.titleLab =[UILabel labelWithText:@"购物指南" font:DR_FONT(16) textColor:BLACKCOLOR backGroundColor:WHITECOLOR textAlignment:0 superView:self];
    self.titleLab.frame =CGRectMake(WScale(10), WScale(26), WScale(70),WScale(18));

}
@end

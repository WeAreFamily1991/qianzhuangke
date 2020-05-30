//
//  DRMinHedView.m
//  Shop
//
//  Created by rockding on 2019/11/15.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRMinHedView.h"

@implementation DRMinHedView
-(instancetype)initWithFrame:(CGRect)frame
{
     self = [super initWithFrame:frame];
        if (self) {
            [self setupUI];
        }
        return self;
    
}
-(void)setupUI
{
    UIImageView *backImag =[[UIImageView alloc]initWithFrame:self.bounds];
    backImag.image =[UIImage imageNamed:@"personal_bg_image"];
    backImag.contentMode =UIViewContentModeScaleAspectFill;
    [self addSubview:backImag];
    UILabel *navLab =[UILabel labelWithText:@"个人中心" font:DR_BoldFONT(18) textColor:WHITECOLOR backGroundColor:CLEARCOLOR textAlignment:1 superView:self];
    self.iconBtn =[UIButton buttonWithImage:@"personal_img_head portrait" target:self action:@selector(iconBtnClick:) showView:self];
    
    self.titleLab =[UILabel labelWithText:@"三铁最骚的男人" font:DR_BoldFONT(18) textColor:WHITECOLOR backGroundColor:CLEARCOLOR textAlignment:0 superView:self];
    
    self.phoneLab =[UILabel labelWithText:@"15370337896" font:DR_FONT(14) textColor:WHITECOLOR backGroundColor:CLEARCOLOR textAlignment:0 superView:self];
    
    UIButton *setBtn =[UIButton buttonWithImage:@"personal_ico_shezhi" target:self action:@selector(setBtnClick:) showView:self];
    
    self.sCountLab =[UILabel labelWithText:@"0" font:DR_BoldFONT(19) textColor:WHITECOLOR backGroundColor:CLEARCOLOR textAlignment:1 superView:self];
    
    self.sNameLab =[UILabel labelWithText:@"商品收藏" font:DR_FONT(12) textColor:WHITECOLOR backGroundColor:CLEARCOLOR textAlignment:1 superView:self];
    
    UIButton *sBtn =[UIButton buttonWithHeadImage:@"" target:self action:@selector(btnClick:) showView:self];
    sBtn.tag =1;
    
    self.cCountLab =[UILabel labelWithText:@"0" font:DR_BoldFONT(19) textColor:WHITECOLOR backGroundColor:CLEARCOLOR textAlignment:1 superView:self];
    
    self.CNameLab =[UILabel labelWithText:@"店铺收藏" font:DR_FONT(12) textColor:WHITECOLOR backGroundColor:CLEARCOLOR textAlignment:1 superView:self];
     UIButton *cBtn =[UIButton buttonWithHeadImage:@"" target:self action:@selector(btnClick:) showView:self];
    cBtn.tag =2;
    
    self.qCountLab =[UILabel labelWithText:@"0" font:DR_BoldFONT(19) textColor:WHITECOLOR backGroundColor:CLEARCOLOR textAlignment:1 superView:self];
    
    self.qNameLab =[UILabel labelWithText:@"抵用券" font:DR_FONT(12) textColor:WHITECOLOR backGroundColor:CLEARCOLOR textAlignment:1 superView:self];
     UIButton *qBtn =[UIButton buttonWithHeadImage:@"" target:self action:@selector(btnClick:) showView:self];
    qBtn.tag=3;
    
    self.dCountLab =[UILabel labelWithText:@"0" font:DR_BoldFONT(19) textColor:WHITECOLOR backGroundColor:CLEARCOLOR textAlignment:1 superView:self];
    
    self.dNameLab =[UILabel labelWithText:@"到货通知" font:DR_FONT(12) textColor:WHITECOLOR backGroundColor:CLEARCOLOR textAlignment:1 superView:self];
     UIButton *dBtn =[UIButton buttonWithHeadImage:@"" target:self action:@selector(btnClick:) showView:self];
    dBtn.tag =4;
    
    [navLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HScale(30));
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(HScale(26));
    }];
    
    [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(WScale(10));
        make.top.mas_equalTo(navLab.mas_bottom).offset(WScale(25));
        make.width.height.mas_equalTo(HScale(55));
    }];
    
    [self.titleLab  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(navLab.mas_bottom).offset(WScale(32));
           make.left.mas_equalTo(self.iconBtn.mas_right).offset(WScale(10));
           make.height.mas_equalTo(HScale(18));
    }];
    
    [self.phoneLab  mas_makeConstraints:^(MASConstraintMaker *make) {
              make.top.mas_equalTo(self.titleLab.mas_bottom).offset(WScale(8));
              make.left.mas_equalTo(self.titleLab);
              make.height.mas_equalTo(HScale(14));
    }];
    
    [setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
           make.centerY.mas_equalTo(self.iconBtn);
           make.right.mas_equalTo(self).offset(WScale(-10));
           make.width.height.mas_equalTo(WScale(24));
    }];
    
    [self.sCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(self.iconBtn.mas_bottom).offset(WScale(25));
           make.left.mas_equalTo(self);
           make.width.mas_equalTo(SCREEN_WIDTH/4);
           make.height.mas_equalTo(HScale(18));
    }]; 
    
    
    [self.sNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(self.sCountLab.mas_bottom).offset(WScale(9));
           make.left.mas_equalTo(self);
           make.width.mas_equalTo(SCREEN_WIDTH/4);
           make.height.mas_equalTo(HScale(12));
    }];
    
    [sBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
        make.left.mas_equalTo(self);
        make.width.height.mas_equalTo(SCREEN_WIDTH/4);
        make.bottom.mas_equalTo(self);
    }];
    
    [self.cCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(self.sCountLab);
           make.left.mas_equalTo(self.sNameLab.mas_right);
           make.width.mas_equalTo(SCREEN_WIDTH/4);
           make.height.mas_equalTo(HScale(18));
    }];
    
    [self.CNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(self.sNameLab);
           make.left.mas_equalTo(self.sNameLab.mas_right);
           make.width.mas_equalTo(SCREEN_WIDTH/4);
           make.height.mas_equalTo(HScale(12));
    }];
    [cBtn mas_makeConstraints:^(MASConstraintMaker *make) {
              
           make.left.mas_equalTo(self.cCountLab);
           make.width.height.mas_equalTo(SCREEN_WIDTH/4);
           make.bottom.mas_equalTo(self);
       }];
    
    [self.qCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
              make.top.mas_equalTo(self.sCountLab);
              make.left.mas_equalTo(self.CNameLab.mas_right);
              make.width.mas_equalTo(SCREEN_WIDTH/4);
              make.height.mas_equalTo(HScale(18));
       }];
       
    [self.qNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
              make.top.mas_equalTo(self.sNameLab);
              make.left.mas_equalTo(self.CNameLab.mas_right);
              make.width.mas_equalTo(SCREEN_WIDTH/4);
              make.height.mas_equalTo(HScale(12));
    }];
    [qBtn mas_makeConstraints:^(MASConstraintMaker *make) {
              
           make.left.mas_equalTo(self.qCountLab);
           make.width.height.mas_equalTo(SCREEN_WIDTH/4);
           make.bottom.mas_equalTo(self);
       }];
    
    [self.dCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
              make.top.mas_equalTo(self.sCountLab);
              make.left.mas_equalTo(self.qCountLab.mas_right);
              make.width.mas_equalTo(SCREEN_WIDTH/4);
              make.height.mas_equalTo(HScale(18));
       }];
       
    [self.dNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
              make.top.mas_equalTo(self.sNameLab);
              make.left.mas_equalTo(self.qNameLab.mas_right);
              make.width.mas_equalTo(SCREEN_WIDTH/4);
              make.height.mas_equalTo(HScale(12));
    }];
    [dBtn mas_makeConstraints:^(MASConstraintMaker *make) {
              
           make.left.mas_equalTo(self.dCountLab);
           make.width.height.mas_equalTo(SCREEN_WIDTH/4);
           make.bottom.mas_equalTo(self);
       }];
    
    
}
-(void)iconBtnClick:(UIButton *)sender
{
    if (_iconBtnBlock) {
        _iconBtnBlock();
    }
}

-(void)setBtnClick:(UIButton *)sender
{
    if (_setBtnBlock) {
        _setBtnBlock();
    }
}
-(void)btnClick:(UIButton *)sender
{
    if (_selectedTagBlock) {
        _selectedTagBlock(sender.tag);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

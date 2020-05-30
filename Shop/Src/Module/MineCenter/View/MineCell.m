//
//  MineCell.m
//  Shop
//
//  Created by BWJ on 2019/2/19.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "MineCell.h"

@implementation MineCell
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"MineCell";
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MineCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

     [cell.setBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:WScale(2)];
    [cell.dealOrderBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.aftersaleBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.arrivalnoticeBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shoucangBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.diyongBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.setBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
   
    
    

    return cell;
}
-(void)setCountModel:(DROrderCountModel *)countModel
{
    _countModel =countModel;
    
    self.daifuIMG.redDotNumber =countModel.waitPayment;
    self.daifuIMG.redDotTextFont =DR_FONT(9);
    self.daifuIMG.redDotTextColor =REDCOLOR;
    self.daifuIMG.redDotBorderWidth =0.5;
    self.daifuIMG.redDotOffset =CGPointMake(-10,6);
    [self.daifuIMG ShowBadgeView];
    
    self.daishenIMG.redDotNumber =countModel.waitConfirm;
    self.daishenIMG.redDotTextColor =REDCOLOR;
    self.daishenIMG.redDotTextFont =DR_FONT(9);
    self.daishenIMG.redDotBorderWidth =0.5;
    self.daishenIMG.redDotOffset =CGPointMake(-10,6);
    [self.daishenIMG ShowBadgeView];
    
    self.daifaIMG.redDotNumber =countModel.waitDeliver;
    self.daifaIMG.redDotTextColor =REDCOLOR;
     self.daifaIMG.redDotTextFont =DR_FONT(9);
    self.daifaIMG.redDotBorderWidth =0.5;
    self.daifaIMG.redDotOffset =CGPointMake(-10,6);
    [self.daifaIMG ShowBadgeView];
    
    
    self.daishouIMG.redDotNumber =countModel.waitingReceived;
     self.daishouIMG.redDotTextFont =DR_FONT(9);
    self.daishouIMG.redDotTextColor =REDCOLOR;
    self.daishouIMG.redDotBorderWidth =0.5;
    self.daishouIMG.redDotOffset =CGPointMake(-10,6);
    [self.daishouIMG ShowBadgeView];
    
    self.shouhouIMG.redDotNumber =countModel.afterSaleCount;
     self.shouhouIMG.redDotTextFont =DR_FONT(9);
    self.shouhouIMG.redDotTextColor =REDCOLOR;
    self.shouhouIMG.redDotBorderWidth =0.5;
    self.shouhouIMG.redDotOffset =CGPointMake(-10,6);
    [self.shouhouIMG ShowBadgeView];
   
}
-(void)BtnClick:(UIButton *)sender
{
    
    if (_BtnManagetagBlock) {
        _BtnManagetagBlock (sender.tag);
    }
    
    
}
-(void)configueCellBadgeStyle:(YeeBadgeStytle)style
{
    switch (style) {
        case YeeBadgeNumberStytle:
        {
            
        }
            break;
            
        default:
            break;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end



@implementation MineCell2
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"MineCell2";
    MineCell2 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MineCell" owner:nil options:nil] objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.shoukuanBtn.layer.cornerRadius =3;
    cell.shoukuanBtn.layer.masksToBounds =3;
    cell.shopOrderBtn.layer.cornerRadius =3;
    cell.shopOrderBtn.layer.masksToBounds =3;
    cell.kaipiaoBtn.layer.cornerRadius =3;
    cell.kaipiaoBtn.layer.masksToBounds =3;
    cell.shenqingBtn.layer.cornerRadius =3;
    cell.shenqingBtn.layer.masksToBounds =3;
    cell.jiluBtn.layer.cornerRadius =3;
    cell.jiluBtn.layer.masksToBounds =3;
    [cell.shoukuanBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:HScale(9)];
    [cell.shopOrderBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:HScale(9)];
    [cell.kaipiaoBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:HScale(9)];
    [cell.shenqingBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:HScale(9)];
       [cell.jiluBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:HScale(9)];
    [cell.shoukuanBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shopOrderBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.kaipiaoBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shenqingBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.jiluBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shopOrderBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside]; 
    return cell;
}
-(void)BtnClick:(UIButton *)sender
{
    
    if (_BtnMoneytagBlock) {
        _BtnMoneytagBlock (sender.tag);
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end


@implementation MineCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"MineCell3";
    MineCell3 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MineCell" owner:nil options:nil] objectAtIndex:2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.kefuBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:HScale(9)];
    [cell.messageBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:HScale(9)];
    [cell.personBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:HScale(9)];
    [cell.changePWBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:HScale(9)];
    [cell.shouhuoBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:HScale(9)];
    [cell.childBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:HScale(9)];
    [cell.guanlianBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:HScale(9)];
    [cell.loginOutBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:HScale(9)];
    
    [cell.kefuBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.messageBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.personBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.changePWBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shouhuoBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.childBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.guanlianBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.loginOutBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return cell;
}
-(void)BtnClick:(UIButton *)sender
{
    
    if (_BtnOthertagBlock) {
        _BtnOthertagBlock (sender.tag);
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end



@implementation MineCell4

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"MineCell4";
    MineCell4 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MineCell" owner:nil options:nil] objectAtIndex:3];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.groundView.layer.cornerRadius =5;
    cell.groundView.layer.masksToBounds =5;
    [cell.kefuBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.messageBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.personBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.changePWBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.shouhuoBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.guanlianBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.loginOutBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    
    [cell.kefuBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.messageBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.personBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.changePWBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shouhuoBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.guanlianBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.loginOutBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return cell;
}
-(void)BtnClick:(UIButton *)sender
{
    
    if (_BtnOthertagBlock) {
        _BtnOthertagBlock (sender.tag);
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end

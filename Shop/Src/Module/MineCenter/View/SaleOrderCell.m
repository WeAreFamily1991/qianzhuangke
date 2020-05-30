//
//  SaleOrderCell.m
//  Shop
//
//  Created by BWJ on 2019/2/26.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "SaleOrderCell.h"
#import "SalesOrderModel.h"
@implementation SaleOrderCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"SaleOrderCell";
    SaleOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SaleOrderCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    [cell.collectSelectBtn addTarget:cell action:@selector(collectSelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.phoneBtn addTarget:cell action:@selector(phoneBtnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.detailBtn.layer.masksToBounds=4;
    cell.detailBtn.layer.cornerRadius =4;
    cell.detailBtn.layer.borderColor =REDCOLOR.CGColor;
    cell.detailBtn.layer.borderWidth =0.5;
    
    return cell;
}
-(void)setSaleModel:(SalesOrderModel *)saleModel
{
    self.orderLab.text =[NSString stringWithFormat:@"对账单号：%@",saleModel.dzNo];
    self.getTimeLab.text =[NSString stringWithFormat:@"生成日期：%@",[SNTool StringTimeFormat:saleModel.createTime]];
    self.saleTimeLab.text =[NSString stringWithFormat:@"对账账期：%@",saleModel.dzPeriod?:@""];
    self.saleCountLab.text =[NSString stringWithFormat:@"对账数量：%@",saleModel.qty?:@""];
    self.moneyCountLab.text =[NSString stringWithFormat:@"对账金额：￥%@",saleModel.totalOrderAmt?:@""];
    [SNTool setTextColor:self.moneyCountLab FontNumber:DR_FONT(12) AndRange:NSMakeRange(5, self.moneyCountLab.text.length-5) AndColor:REDCOLOR];
    self.yunfeiLab.text =[NSString stringWithFormat:@"运费：￥%@",saleModel.expressFeeTotal?:@""];
     [SNTool setTextColor:self.yunfeiLab FontNumber:DR_FONT(12) AndRange:NSMakeRange(3, self.yunfeiLab.text.length-3) AndColor:REDCOLOR];
}
-(void)setShoukuanModel:(SalesOrderModel *)shoukuanModel
{
    self.orderLab.text =[NSString stringWithFormat:@"对账单号：%@",shoukuanModel.dzNo];
    self.getTimeLab.text =[NSString stringWithFormat:@"生成日期：%@",[SNTool StringTimeFormat:shoukuanModel.createTime]];
    self.saleTimeLab.text =[NSString stringWithFormat:@"对账账期：%@",shoukuanModel.dzPeriod?:@""];
    self.saleCountLab.text =[NSString stringWithFormat:@"对账数量：%@",shoukuanModel.qty?:@""];
    self.moneyCountLab.text =[NSString stringWithFormat:@"对账金额：￥%@",shoukuanModel.wsOrderAmt?:@""];
    [SNTool setTextColor:self.moneyCountLab FontNumber:DR_FONT(12) AndRange:NSMakeRange(5, self.moneyCountLab.text.length-5) AndColor:REDCOLOR];
    self.yunfeiLab.text =[NSString stringWithFormat:@"运费：￥%@",shoukuanModel.expressFeeTotal?:@""];
    [SNTool setTextColor:self.yunfeiLab FontNumber:DR_FONT(12) AndRange:NSMakeRange(3, self.yunfeiLab.text.length-3) AndColor:REDCOLOR];
    if ([shoukuanModel.payStatus intValue]==1) {
        self.typeLab.text  =@"已付款";
    }
    else
    {
        self.typeLab.text = @"未付款";
    }
}
- (IBAction)detailBtnClick:(id)sender {
    !_detailClickBlock ? : _detailClickBlock();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end



@implementation SaleOrderCell1
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"SaleOrderCell1";
    SaleOrderCell1 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SaleOrderCell" owner:nil options:nil] objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
 
//    cell.detailBtn.layer.masksToBounds=cell.detailBtn.dc_height/2;
//    cell.detailBtn.layer.cornerRadius =cell.detailBtn.dc_height/2;
    
    return cell;
}
-(void)setSaleModel:(SalesOrderModel *)saleModel
{
    
    self.orderLab.text =[NSString stringWithFormat:@"对账单号：%@",saleModel.dzNo];
    self.getTimeLab.text =[NSString stringWithFormat:@"费用账期：%@",saleModel.dzPeriod?:@""];
    self.saleTimeLab.text =[NSString stringWithFormat:@"退货金额：￥%@",saleModel.returnOrderAmt?:@""];
    [SNTool setTextColor:self.saleTimeLab FontNumber:DR_FONT(12) AndRange:NSMakeRange(5, self.saleTimeLab.text.length-5) AndColor:REDCOLOR];
    self.saleCountLab.text =[NSString stringWithFormat:@"费用金额：￥%@",saleModel.qty?:@""];
     [SNTool setTextColor:self.saleCountLab FontNumber:DR_FONT(12) AndRange:NSMakeRange(5, self.saleCountLab.text.length-5) AndColor:REDCOLOR];
}
- (IBAction)detailBtnClick:(id)sender {
     !_detailClickBlock ? : _detailClickBlock();
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end


@implementation SaleOrderCell2
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"SaleOrderCell2";
    SaleOrderCell2 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SaleOrderCell" owner:nil options:nil] objectAtIndex:2];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.detailBtn.layer.cornerRadius =4;
    cell.detailBtn.layer.masksToBounds =4;
    cell.detailBtn.layer.borderColor =REDCOLOR.CGColor;
    cell.detailBtn.layer.borderWidth =0.5;
    
    cell.contentBtn.layer.cornerRadius =4;
    cell.contentBtn.layer.masksToBounds =4;
    cell.contentBtn.layer.borderColor =REDCOLOR.CGColor;
    cell.contentBtn.layer.borderWidth =0.5;
    
    cell.returnBackBtn.layer.cornerRadius =4;
    cell.returnBackBtn.layer.masksToBounds =4;
    cell.returnBackBtn.layer.borderColor =BACKGROUNDCOLOR.CGColor;
    cell.returnBackBtn.layer.borderWidth =0.5;
    //    cell.groundView.layer.cornerRadius =5;
    //    cell.groundView.layer.masksToBounds =5;
    //    [cell.shopOrderBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.kaipiaoBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.shenqingBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.jiluBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.shopOrderBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.kaipiaoBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.shenqingBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.jiluBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.shopOrderBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
   
    
    return cell;
}
-(void)BtnClick:(UIButton *)sender
{
    
}
- (IBAction)btn:(id)sender {
    UIButton *btn =(UIButton *)sender;
    if (_BtntagBlock) {
        _BtntagBlock(btn.tag);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end



@implementation SaleOrderCell3
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"SaleOrderCell3";
    SaleOrderCell3 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SaleOrderCell" owner:nil options:nil] objectAtIndex:3];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //    cell.groundView.layer.cornerRadius =5;
    //    cell.groundView.layer.masksToBounds =5;
    //    [cell.shopOrderBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.kaipiaoBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.shenqingBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.jiluBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.shopOrderBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.kaipiaoBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.shenqingBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.jiluBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.shopOrderBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    return cell;
}
-(void)BtnClick:(UIButton *)sender
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end

@implementation SaleOrderCell4
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"SaleOrderCell4";
    SaleOrderCell4 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SaleOrderCell" owner:nil options:nil] objectAtIndex:4];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.detailBtn.layer.masksToBounds=4;
    cell.detailBtn.layer.cornerRadius =4;
    cell.detailBtn.layer.borderColor =REDCOLOR.CGColor;
    cell.detailBtn.layer.borderWidth =0.5;
    return cell;
}
-(void)setSaleModel:(SalesOrderModel *)saleModel
{
    
    self.orderLab.text =[NSString stringWithFormat:@"对账单号：%@",saleModel.dzNo];
    self.getTimeLab.text =[NSString stringWithFormat:@"费用账期：%@",saleModel.dzPeriod?:@""];
    self.saleTimeLab.text =[NSString stringWithFormat:@"退货金额：￥%@",saleModel.returnOrderAmt?:@""];
    [SNTool setTextColor:self.saleTimeLab FontNumber:DR_FONT(12) AndRange:NSMakeRange(5, self.saleTimeLab.text.length-5) AndColor:REDCOLOR];
    self.saleCountLab.text =[NSString stringWithFormat:@"费用金额：￥%@",saleModel.qty?:@""];
    [SNTool setTextColor:self.saleCountLab FontNumber:DR_FONT(12) AndRange:NSMakeRange(5, self.saleCountLab.text.length-5) AndColor:REDCOLOR];
}
- (IBAction)detailBtnClick:(id)sender {
    !_detailClickBlock ? : _detailClickBlock();
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end


@implementation SaleOrderCell5
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"SaleOrderCell5";
    SaleOrderCell5 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SaleOrderCell" owner:nil options:nil] objectAtIndex:5];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.detailBtn.layer.masksToBounds=4;
    cell.detailBtn.layer.cornerRadius =4;
    cell.detailBtn.layer.borderColor =REDCOLOR.CGColor;
    cell.detailBtn.layer.borderWidth =0.5;
    return cell;
}
-(void)setShoppingModel:(ShoppingModel *)shoppingModel{
    
    _shoppingModel = shoppingModel;
    self.orderLab.text = [NSString stringWithFormat:@"%@",shoppingModel.orderNo];
    
    self.timeLab.text  = [NSString stringWithFormat:@"%@",[SNTool StringTimeFormat:[NSString stringWithFormat:@"%ld",(long)shoppingModel.createTime]]];
    self.monenyLab.text =[NSString stringWithFormat:@"%.2f",shoppingModel.orderAmt];
    self.returnLab.text =[NSString stringWithFormat:@"%.2f",[shoppingModel.returnedAmt doubleValue]];
   
    self.canKPMoneyLab.text =[NSString stringWithFormat:@"可开票金额：%.2f",shoppingModel.canReturnAmt];
    
}
- (IBAction)detailBtnClick:(id)sender {
    !_detailClickBlock ? : _detailClickBlock();
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end

//
//  CollectionCell.m
//  Shop
//
//  Created by BWJ on 2019/2/25.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "CollectionCell.h"
#import "VoucherModel.h"
#import "LSXAlertInputView.h"
#import "BillApplicationModel.h"
@implementation CollectionCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CollectionCell";
    CollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.collectSelectBtn addTarget:cell action:@selector(collectSelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
     [cell.phoneBtn addTarget:cell action:@selector(phoneBtnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.iconImg.layer setBorderColor:BACKGROUNDCOLOR.CGColor];
    [cell.iconImg.layer setBorderWidth:1.0];
  
    return cell;
}
-(void)setFavoriModel:(FavoriteModel *)favoriModel
{
    _favoriModel =favoriModel;
    //type 0自营 1厂家 2供应商
    if ([favoriModel.compType intValue]==0) {
        [self.tagLab setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
        [self.tagLab setTitle:@"自营" forState:UIControlStateNormal];
       
    }else if ([favoriModel.compType intValue]==1)
    {
        [self.tagLab setBackgroundImage:[UIImage imageNamed:@"分类购买_08"] forState:UIControlStateNormal];
        [self.tagLab setTitle:@"厂家" forState:UIControlStateNormal];
        
    }
    else if ([favoriModel.compType intValue]==2)
    {
        [self.tagLab setBackgroundImage:[UIImage imageNamed:@"blue-bg"] forState:UIControlStateNormal];
        [self.tagLab setTitle:@"批发商" forState:UIControlStateNormal];
    }
    self.addressLab.text =favoriModel.sellerName;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:favoriModel.compLog] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
   
    self.contentLab.text =[NSString stringWithFormat:@"主营产品：%@",favoriModel.storePrdt];
    
    
    
}
-(void)collectSelectBtnClick:(UIButton *)sender
{
    if (_collectionSelectBlock) {
        _collectionSelectBlock(sender.tag);
    }
}
-(void)phoneBtnBtnClick:(UIButton *)sender
{
    NSString *mobileStr=self.favoriModel.kfPhone;
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",mobileStr]]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


@implementation CollectionCell1
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CollectionCell1";
    CollectionCell1 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:nil options:nil] objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
   
    [cell.statusBtn.layer setBorderColor:REDCOLOR.CGColor];
    [cell.statusBtn.layer setBorderWidth:1.0];
    [cell.statusBtn.layer setMasksToBounds:YES];
    [cell.statusBtn.layer setCornerRadius:12.5];
    [cell.detailBtn layoutButtonWithEdgeInsetsStyle:LXButtonEdgeInsetsStyleRight imageTitleSpace:WScale(2)];
    return cell;
}
-(void)setVouchModel:(VoucherModel *)vouchModel
{
    _vouchModel =vouchModel;
    
    self.moneyCountLab.text =[NSString stringWithFormat:@"￥%.0f",vouchModel.voucherSum];
    [SNTool setTextColor:self.moneyCountLab FontNumber:DR_FONT(18) AndRange:NSMakeRange(0, 1) AndColor:REDCOLOR];
    self.companyLab.text =vouchModel.sellerName;
    self.manjianLab.text =[NSString stringWithFormat:@"满%.0f元可用",vouchModel.voucherCond];
    self.titleLab.text =vouchModel.topicType?@"店铺抵用券":@"平台抵用券";
//    self.titleLab.textColor =vouchModel.topicType?RGBHex(0x0094ec):REDCOLOR;
    
    if (vouchModel.descriptionStr.length==0) {
        self.conditionLab.text =@"适用于三铁云仓所有商品";
    }else
    {
        self.conditionLab.text =vouchModel.descriptionStr;
    }
    if ([vouchModel.voidType intValue]==1) {
        self.timeLab.text =[NSString stringWithFormat:@"%@至%@",[SNTool yearMonthTimeFormat:[NSString stringWithFormat:@"%ld",(long)vouchModel.userStartTime]],[SNTool yearMonthTimeFormat:[NSString stringWithFormat:@"%ld",(long)vouchModel.userEndTime]]];
    }
    if (vouchModel.endtime>1609344000000l&&[vouchModel.voidType intValue]!=1) {
        self.timeLab.text =@"无门槛、无时间限制、无产品限制";
    }
    if (vouchModel.endtime<=1609344000000l&&[vouchModel.voidType intValue]!=1) {
        self.timeLab.text =[NSString stringWithFormat:@"%@至%@",[SNTool yearMonthTimeFormat:[NSString stringWithFormat:@"%ld",(long)vouchModel.validTimeSta]],[SNTool yearMonthTimeFormat:[NSString stringWithFormat:@"%ld",(long)vouchModel.validTimeEnd]]];
    }
    
    self.hidenBtn.hidden =!vouchModel.valid;
    self.moneyCountLab.text =[NSString stringWithFormat:@"￥%.0f",vouchModel.voucherSum];
    
}
-(void)BtnClick:(UIButton *)sender
{
   
}
- (IBAction)statusBtnClick:(id)sender {
    !_selectlickBlock?:_selectlickBlock();
}
- (IBAction)detailBtnClick:(id)sender {
    self.detailBtn.selected =!self.detailBtn.selected;
    !_detailBtnBlock?:_detailBtnBlock();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end

@implementation CollectionCell2
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CollectionCell2";
    CollectionCell2 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:nil options:nil] objectAtIndex:2];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
  
    return cell;
}
- (IBAction)tellBtnClick:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://4006185027"]];
}
-(void)setOrderModel:(OrderModel *)orderModel
{
    _orderModel =orderModel;
    self.orderLAb.text =[NSString stringWithFormat:@"订单号：%@",orderModel.orderNo];
    self.timeLab.text =[SNTool StringTimeFormat:[NSString stringWithFormat:@"%ld",orderModel.createTime]];
    NSArray *statusArr =@[@"已取消", @"待审核", @"待付款", @"待发货", @"待收货",@"已完成",@"退货中",@"已退货"];
    if (orderModel.status==101) {
        self.statusLAb.text =@"已支付";
    }else
    {
        self.statusLAb.text =statusArr[orderModel.status];
    }
    if (orderModel.isReturn==1) {
        self.statusLAb.text =@"退货中";
    }
    if ([orderModel.sellerExpressType intValue]==0) {
        [self.santieBtn setImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
//        [self.santieBtn setTitle:@"自营" forState:UIControlStateNormal];
    }else if ([orderModel.sellerExpressType intValue]==1)
    {
        [self.santieBtn setImage:[UIImage imageNamed:@"分类购买_08"] forState:UIControlStateNormal];
//        [self.santieBtn setTitle:@"厂家" forState:UIControlStateNormal];
    }
    else if ([orderModel.sellerExpressType intValue]==2)
    {
        [self.santieBtn setImage:[UIImage imageNamed:@"blue-bg"] forState:UIControlStateNormal];
//        [self.santieBtn setTitle:@"批发商" forState:UIControlStateNormal];
    }
//    [self.companyBtn layoutButtonWithEdgeInsetsStyle:LXButtonEdgeInsetsStyleRight imageTitleSpace:5];
    [self.companyBtn setTitle:orderModel.sellerName forState:UIControlStateNormal];
    [self.companyBtn layoutButtonWithEdgeInsetsStyle:LXButtonEdgeInsetsStyleRight imageTitleSpace:WScale(5)];
    if (orderModel.kpName.length!=0) {
         self.companyLab.text =[NSString stringWithFormat:@"开票方：%@",orderModel.kpName?:@""];
    }else
    {
         self.companyLab.text =@"";
    }
   
    NSArray *expressTypeArr =@[@"自提",@"卖家直发",@"三铁配送"];
    NSArray *payArr =@[@"现金",@"月结",@"月结30天",@"月结60天"];
    self.peisongLab.text =[NSString stringWithFormat:@"%@  %@  %@",orderModel.storeName,payArr[orderModel.orderPayType],expressTypeArr[[orderModel.expressType intValue]]];
//    [SNTool setTextColor:self.peisongLab FontNumber:DR_FONT(12) AndRange:NSMakeRange(orderModel.storeName.length, self.peisongLab.text.length-orderModel.storeName.length) AndColor:REDCOLOR];
    NSString *sellTypeCodeStr;
    if (![orderModel.compType isEqualToString:@"0"]) {
        
        if ([orderModel.priceType isEqualToString:@"0"]) {
            sellTypeCodeStr=@"含税";
        }
        else if ([orderModel.priceType isEqualToString:@"1"]) {
            sellTypeCodeStr =@"未税";
        }
        NSString *str ;
        if ([orderModel.isHy isEqualToString:@"0"]) {
            str =@"含运";
        }
        else if ([orderModel.isHy isEqualToString:@"1"]) {
            str =@"不含运";
        }
        [self.typeBtn setTitle:[NSString stringWithFormat:@"%@%@",sellTypeCodeStr,str] forState:UIControlStateNormal];
//        self.typeBtn.hidden =NO;
    }else
    {
         self.typeBtn.hidden =YES;
    }
}
-(void)setSelloutModel:(DRSellAfterModel *)selloutModel
{
    _selloutModel =selloutModel;
    self.orderLAb.text =[NSString stringWithFormat:@"退货单号：%@",selloutModel.returnOrderNo];
    self.timeLab.text =[SNTool StringTimeFormat:selloutModel.createTime];
    NSArray *statusArr =@[@"待取货", @"待审核", @"待回寄", @"已回寄", @"已收货",@"待退款",@"已完成",@"不通过",@"已取件",@"已取消"];
    if (selloutModel.returnOrderStatus==99) {
        self.statusLAb.text =@"待取件";
    }else
    {
        self.statusLAb.text =statusArr[selloutModel.returnOrderStatus];
    }
    [self.companyBtn setTitle:selloutModel.sellerName forState:UIControlStateNormal];
    self.companyLab.text =[NSString stringWithFormat:@"开票方：%@",selloutModel.kpName?:@""];
    [self.companyBtn layoutButtonWithEdgeInsetsStyle:LXButtonEdgeInsetsStyleRight imageTitleSpace:WScale(5)];
    NSArray *expressTypeArr =@[@"自提",@"卖家直发",@"三铁配送"];
    NSArray *payArr =@[@"现金",@"月结",@"月结30天",@"月结60天"];
    self.peisongLab.text =[NSString stringWithFormat:@"%@  %@  %@",selloutModel.storeName,payArr[selloutModel.orderPayType],expressTypeArr[[selloutModel.expressType intValue]]];
    [SNTool setTextColor:self.peisongLab FontNumber:DR_FONT(12) AndRange:NSMakeRange(selloutModel.storeName.length, self.peisongLab.text.length-selloutModel.storeName.length) AndColor:REDCOLOR];
//    if (![selloutModel.compType isEqualToString:@"0"]) {
//        self.typeBtn.hidden =NO;
//        [self.typeBtn setTitle:[NSString stringWithFormat:@"%@%@",selloutModel.priceTypeName,selloutModel.isHy] forState:UIControlStateNormal];
//    }else
//    {
//        self.typeBtn.hidden =YES;
//    }

}

-(void)BtnClick:(UIButton *)sender
{
    
}
- (IBAction)companyBtnClick:(id)sender {
    !_companyClickBlock?:_companyClickBlock();
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end



@implementation CollectionCell3
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CollectionCell3";
    CollectionCell3 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:nil options:nil] objectAtIndex:3];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    return cell;
}
-(void)setApplicationModel:(BillApplicationModel *)applicationModel
{
    _applicationModel =applicationModel;

    if ([applicationModel.compType intValue]==0) {
        [self.typeBtn setImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
//        [self.typeBtn setTitle:@"自营" forState:UIControlStateNormal];
        
    }else if ([applicationModel.compType intValue]==1)
    {
        [self.typeBtn setImage:[UIImage imageNamed:@"分类购买_08"] forState:UIControlStateNormal];
//        [self.typeBtn setTitle:@"厂家" forState:UIControlStateNormal];
        
    }
    else if ([applicationModel.compType intValue]==2)
    {
        [self.typeBtn setImage:[UIImage imageNamed:@"blue-bg"] forState:UIControlStateNormal];
//        [self.typeBtn setTitle:@"批发商" forState:UIControlStateNormal];
    }
    self.companyLab.text =applicationModel.sellerName;
    self.contentLab.text =[NSString stringWithFormat:@"开票方：%@",applicationModel.kpName];
    
}
-(void)setGoodsModel:(GoodsModel *)goodsModel
{
    _goodsModel =goodsModel;

    if ([goodsModel.sellerTypeCode intValue]==0) {
        [self.typeBtn setImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
//        [self.typeBtn setTitle:@"自营" forState:UIControlStateNormal];
        self.companyLab.textColor =REDCOLOR;
    }else if ([goodsModel.sellerTypeCode intValue]==1)
    {
        [self.typeBtn setImage:[UIImage imageNamed:@"分类购买_08"] forState:UIControlStateNormal];
//        [self.typeBtn setTitle:@"厂家" forState:UIControlStateNormal];
        self.companyLab.textColor =BLACKCOLOR;
    }
    else if ([goodsModel.sellerTypeCode intValue]==2)
    {
        [self.typeBtn setImage:[UIImage imageNamed:@"blue-bg"] forState:UIControlStateNormal];
//        [self.typeBtn setTitle:@"批发商" forState:UIControlStateNormal];
        self.companyLab.textColor =BLACKCOLOR;
    }
    self.companyLab.text =goodsModel.sellerName;
   
    NSString *sellTypeCodeStr;
    if ([goodsModel.priceType isEqualToString:@"0"]) {
        sellTypeCodeStr=@"含税";
    }
    else if ([goodsModel.priceType isEqualToString:@"1"]) {
        sellTypeCodeStr =@"未税";
    }
    NSString *str ;
    if ([goodsModel.isHy isEqualToString:@"0"]) {
        str =@"含运";
    }
    else if ([goodsModel.isHy isEqualToString:@"1"]) {
        str =@"不含运";
    }
    if (goodsModel.kpName.length!=0) {
        
        self.contentLab.text =[NSString stringWithFormat:@"%@  |  开票方：%@",str,goodsModel.kpName];
    }else
    {
        self.contentLab.text = [NSString stringWithFormat:@"%@",str];
    }
    self.peisongLab.text =[NSString stringWithFormat:@"%@%@",sellTypeCodeStr,str];
    self.peisongLab.textColor =REDCOLOR;
    
}
-(void)BtnClick:(UIButton *)sender
{
}

- (IBAction)kefuBtnClick:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://4006185027"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end


@implementation CollectionCell4
- (void)awakeFromNib {
    [super awakeFromNib];
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CollectionCell4";
    CollectionCell4 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:nil options:nil] objectAtIndex:4];
    
        cell.saleOutBtn.layer.cornerRadius =4;
        cell.saleOutBtn.layer.masksToBounds =4;
        cell.saleOutBtn.layer.borderColor =REDCOLOR.CGColor;
        cell.saleOutBtn.layer.borderWidth =0.5;
        
        cell.cancelBtn.layer.cornerRadius =4;
        cell.cancelBtn.layer.masksToBounds =4;
        cell.cancelBtn.layer.borderColor =RGBHex(0X888888).CGColor;
        cell.cancelBtn.layer.borderWidth =0.5;
        
        cell.againBuyBtn.layer.cornerRadius =4;
        cell.againBuyBtn.layer.masksToBounds =4;
        cell.againBuyBtn.layer.borderColor =REDCOLOR.CGColor;
        cell.againBuyBtn.layer.borderWidth =0.5;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(void)BtnClick:(UIButton *)sender
{
 
}
-(void)setOrderModel:(OrderModel *)orderModel
{
    _orderModel =orderModel;
    self.allPriceCountLab.text =[NSString stringWithFormat:@"共%lu件商品  合计:￥%.2f",(unsigned long)orderModel.goodsList.count,orderModel.totalAmt];
    NSString *lengStr =[NSString stringWithFormat:@"%.2f",orderModel.realAmt];
    [SNTool setTextColor:self.allPriceCountLab FontNumber:DR_FONT(18) AndRange:NSMakeRange(self.allPriceCountLab.text.length-lengStr.length-1, lengStr.length+1) AndColor:REDCOLOR];
    if (orderModel.status==0) {
        self.saleOutBtn.hidden =YES;
        self.cancelBtn.hidden =YES;
    }
   else  if (orderModel.status==1) {
        self.saleOutBtn.hidden =YES;
        self.cancelBtn.hidden =NO;
    }
   else  if (orderModel.status==2) {
       self.saleOutBtn.hidden =NO;
       self.cancelBtn.hidden =NO;
       [self.saleOutBtn setTitle:@"取消订单" forState:UIControlStateNormal];
       self.saleOutBtn.layer.borderColor =LINECOLOR.CGColor;
       self.saleOutBtn.layer.borderWidth =0.5;
       [self.saleOutBtn setTitleColor:RGBHex(0X888888) forState:UIControlStateNormal];
       [self.cancelBtn setTitle:@"去付款" forState:UIControlStateNormal];
       self.cancelBtn.layer.borderColor =REDCOLOR.CGColor;
       self.cancelBtn.layer.borderWidth =0.5;
       [self.cancelBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
       self.cancelBtn.backgroundColor =REDCOLOR;
   }
   else  if (orderModel.status==3) {
       self.saleOutBtn.hidden =YES;
       self.cancelBtn.hidden =YES;
       
   }
   else  if (orderModel.status==4) {
       self.saleOutBtn.hidden =NO;
       self.cancelBtn.hidden =NO;
       [self.saleOutBtn setTitle:@"申请售后" forState:UIControlStateNormal];
       [self.cancelBtn setTitle:@"确认收货" forState:UIControlStateNormal];
       self.cancelBtn.layer.borderColor =REDCOLOR.CGColor;
       self.cancelBtn.layer.borderWidth =0.5;
      [self.cancelBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
       self.cancelBtn.backgroundColor =REDCOLOR;
   }
  
   else  if (orderModel.status==7) {
       self.saleOutBtn.hidden =YES;
       self.cancelBtn.hidden =YES;
   }
    if (orderModel.isReturn==1) {
       self.saleOutBtn.hidden =YES;
       self.cancelBtn.hidden =NO;
       [self.cancelBtn setTitle:@"取消退货" forState:UIControlStateNormal];
        self.cancelBtn.layer.borderColor =REDCOLOR.CGColor;
        self.cancelBtn.layer.borderWidth =0.5;
        [self.cancelBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        self.cancelBtn.backgroundColor =REDCOLOR;
   }
    if (orderModel.status==101) {
        self.saleOutBtn.hidden =YES;
        self.cancelBtn.hidden =YES;
    }
    
    if (orderModel.status ==5) {
       
        
            self.saleOutBtn.hidden = ![orderModel.payType boolValue];
            self.cancelBtn.hidden = ![orderModel.payType boolValue];
        
        [self.saleOutBtn setTitle:@"申请售后" forState:UIControlStateNormal];
        [self.cancelBtn setTitle:@"去评价" forState:UIControlStateNormal];
    }
    if (orderModel.status==4||orderModel.status==5||orderModel.status==7) {
        if (orderModel.check==YES) {
            self.saleOutBtn.hidden = NO;
            self.cancelBtn.hidden = NO;
        }
        
    }
}
- (IBAction)btnClick:(id)sender {
    UIButton *btn =(UIButton *)sender;
    NSLog(@"btn=%ld",(long)btn.tag);
    if ([btn.titleLabel.text isEqualToString:@"取消订单"]) {
        LSXAlertInputView * alert=[[LSXAlertInputView alloc]initWithTitle:@"取消原因" PlaceholderText:@"请输入取消原因" WithKeybordType:LSXKeyboardTypeDefault CompleteBlock:^(NSString *contents) {
            NSLog(@"-----%@",contents);
           
            NSDictionary *dic =@{@"cancelReason":contents,@"orderId":self.orderModel.order_id};
            [SNAPI postWithURL:@"buyer/cancelOrder" parameters:dic.mutableCopy success:^(SNResult *result) {
                [MBProgressHUD showSuccess:@"取消成功"];
                if (_BtnBlock) {
                    _BtnBlock(btn.tag,btn.titleLabel.text);
                }
            } failure:^(NSError *error) {
                
            }];
        }];
        [alert show];
    }else
    {
        
        if (_BtnBlock) {
            _BtnBlock(btn.tag,btn.titleLabel.text);
        }
    }
}
-(void)setStatus:(NSInteger)status
{
    switch (status) {
        case 0:
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



@implementation CollectionCell5
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CollectionCell5";
    CollectionCell5 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:nil options:nil] objectAtIndex:5];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (IBAction)tellBtnClick:(id)sender {
    !_selectlickBlock?:_selectlickBlock();
}

-(void)setGoodsModel:(GoodsModel *)goodsModel
{
    _goodsModel =goodsModel;
//    if ([goodsModel.serviceType isEqualToString:@"0"]) {
//        self.cangkuLab.text =@"本地云仓（三铁配送）";
//        
//    }
//    else if ([goodsModel.serviceType isEqualToString:@"st"])
//    {
//        self.cangkuLab.text =@"卖家库存（三铁配送）";
//    }
//    else if ([goodsModel.serviceType isEqualToString:@"zf"])
//    {
//        self.cangkuLab.text =@"卖家库存（卖家直发）";
//    }
    if ([goodsModel.sellerTypeCode intValue]==0) {
        [self.dianpubTN setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
        [self.dianpubTN setTitle:@"自营" forState:UIControlStateNormal];
        self.shopNameLab.textColor =REDCOLOR;
    }else if ([goodsModel.sellerTypeCode intValue]==1)
    {
        [self.dianpubTN setBackgroundImage:[UIImage imageNamed:@"分类购买_08"] forState:UIControlStateNormal];
        [self.dianpubTN setTitle:@"厂家" forState:UIControlStateNormal];
        self.shopNameLab.textColor =BLACKCOLOR;
    }
    else if ([goodsModel.sellerTypeCode intValue]==2)
    {
        [self.dianpubTN setBackgroundImage:[UIImage imageNamed:@"blue-bg"] forState:UIControlStateNormal];
        [self.dianpubTN setTitle:@"批发商" forState:UIControlStateNormal];
        self.shopNameLab.textColor =BLACKCOLOR;
    }
    self.shopNameLab.text =goodsModel.sellerName;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
@end



@implementation CollectionCell6
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CollectionCell6";
    CollectionCell6 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:nil options:nil] objectAtIndex:6];
        
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


@implementation CollectionCell7
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CollectionCell7";
    CollectionCell7 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:nil options:nil] objectAtIndex:7];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}
-(void)setOrderModel:(OrderModel *)orderModel
{
    _orderModel =orderModel;
    
    if ([orderModel.compType intValue]==0) {
        [self.santieBtn setImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
//        [self.santieBtn setTitle:@"自营" forState:UIControlStateNormal];
        
    }else if ([orderModel.compType intValue]==1)
    {
        [self.santieBtn setImage:[UIImage imageNamed:@"分类购买_08"] forState:UIControlStateNormal];
//        [self.santieBtn setTitle:@"厂家" forState:UIControlStateNormal];
        
    }
    else if ([orderModel.compType intValue]==2)
    {
        [self.santieBtn setImage:[UIImage imageNamed:@"blue-bg"] forState:UIControlStateNormal];
//        [self.santieBtn setTitle:@"批发商" forState:UIControlStateNormal];
        
    }
    self.cangkeLab.text =orderModel.sellerName;
    self.companyLab.text =[NSString stringWithFormat:@"开票方：%@",orderModel.kpName];
    NSString *sellTypeCodeStr;
    NSString *eestr ;
    if (![orderModel.compType isEqualToString:@"0"]) {
        
        if ([orderModel.priceType isEqualToString:@"0"]) {
            sellTypeCodeStr=@"含税";
        }
        else if ([orderModel.priceType isEqualToString:@"1"]) {
            sellTypeCodeStr =@"未税";
        }
       
        if ([orderModel.isHy isEqualToString:@"0"]) {
            eestr =@"含运";
        }
        else if ([orderModel.isHy isEqualToString:@"1"]) {
            eestr =@"不含运";
        }
    }
    NSArray *expressTypeArr =@[@"自提",@"卖家直发",@"三铁配送"];
    NSArray *payArr =@[@"现金",@"月结",@"月结30天",@"月结60天"];
    self.peisongLab.text =[NSString stringWithFormat:@"%@ %@%@ | %@  %@",orderModel.storeName, payArr[orderModel.orderPayType],sellTypeCodeStr?:@"",eestr?:@"",expressTypeArr[[orderModel.expressType intValue]]];
//    [SNTool setTextColor:self.peisongLab FontNumber:DR_FONT(12) AndRange:NSMakeRange(orderModel.storeName.length, self.peisongLab.text.length-orderModel.storeName.length) AndColor:REDCOLOR];
//    NSString *sellTypeCodeStr;
//    if (![orderModel.compType isEqualToString:@"0"]) {
//
//        if ([orderModel.priceType isEqualToString:@"0"]) {
//            sellTypeCodeStr=@"含税";
//        }
//        else if ([orderModel.priceType isEqualToString:@"1"]) {
//            sellTypeCodeStr =@"未税";
//        }
//        NSString *str ;
//        if ([orderModel.isHy isEqualToString:@"0"]) {
//            str =@"含运";
//        }
//        else if ([orderModel.isHy isEqualToString:@"1"]) {
//            str =@"不含运";
//        }
//        [self.typeBtn setTitle:[NSString stringWithFormat:@"%@%@",sellTypeCodeStr,str] forState:UIControlStateNormal];
//        self.typeBtn.hidden =NO;
//    }else
//    {
//        self.typeBtn.hidden =YES;
//    }
    
}
-(void)setDetailOrderModel:(OrderModel *)detailOrderModel
{
    _detailOrderModel =detailOrderModel;
    if ([detailOrderModel.compType intValue]==0) {
        [self.santieBtn setImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
//        [self.santieBtn setTitle:@"自营" forState:UIControlStateNormal];
        
    }else if ([detailOrderModel.compType intValue]==1)
    {
        [self.santieBtn setImage:[UIImage imageNamed:@"分类购买_08"] forState:UIControlStateNormal];
//        [self.santieBtn setTitle:@"厂家" forState:UIControlStateNormal];
        
    }
    else if ([detailOrderModel.compType intValue]==2)
    {
        [self.santieBtn setImage:[UIImage imageNamed:@"blue-bg"] forState:UIControlStateNormal];
//        [self.santieBtn setTitle:@"批发商" forState:UIControlStateNormal];
        
    }
    self.cangkeLab.text =detailOrderModel.sellerName;
    self.companyLab.text =[NSString stringWithFormat:@"开票方：%@",detailOrderModel.kpName];
    
    NSArray *expressTypeArr =@[@"自提",@"卖家直发",@"三铁配送"];
    self.peisongLab.text =[NSString stringWithFormat:@"%@  %@  %@",detailOrderModel.storeName,detailOrderModel.orderPayType?@"月结":@"现金",expressTypeArr[[detailOrderModel.expressType intValue]]];
    [SNTool setTextColor:self.peisongLab FontNumber:DR_FONT(12) AndRange:NSMakeRange(detailOrderModel.storeName.length, self.peisongLab.text.length-detailOrderModel.storeName.length) AndColor:REDCOLOR];
}
-(void)setGoodsModel:(GoodsModel *)goodsModel
{
    _goodsModel =goodsModel;

    if ([goodsModel.sellerTypeCode intValue]==0) {
        [self.santieBtn setImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
        self.companyLab.textColor =REDCOLOR;
    }else if ([goodsModel.sellerTypeCode intValue]==1)
    {
        [self.santieBtn setImage:[UIImage imageNamed:@"分类购买_08"] forState:UIControlStateNormal];
//        [self.santieBtn setTitle:@"厂家" forState:UIControlStateNormal];
        self.companyLab.textColor =BLACKCOLOR;
    }
    else if ([goodsModel.sellerTypeCode intValue]==2)
    {
        [self.santieBtn setImage:[UIImage imageNamed:@"blue-bg"] forState:UIControlStateNormal];
//        [self.santieBtn setTitle:@"批发商" forState:UIControlStateNormal];
        self.companyLab.textColor =BLACKCOLOR;
    }
    
    self.typeBtn.hidden =YES;
    self.cangkeLab.text =goodsModel.sellerName;
    if (goodsModel.kpName.length!=0) {
        
        self.companyLab.text =[NSString stringWithFormat:@"开票方：%@",goodsModel.kpName];
    }else
    {
        self.companyLab.text =@"";
    }
     NSString *sellTypeCodeStr;
    if ([goodsModel.priceType isEqualToString:@"0"]) {
        sellTypeCodeStr=@"含税";
    }
    else if ([goodsModel.priceType isEqualToString:@"1"]) {
        sellTypeCodeStr =@"未税";
    }
    NSString *str ;
    if ([goodsModel.isHy isEqualToString:@"0"]) {
        str =@"含运";
    }
    else if ([goodsModel.isHy isEqualToString:@"1"]) {
        str =@"不含运";
    }
    self.peisongLab.text =[NSString stringWithFormat:@"%@%@",sellTypeCodeStr?:@"",str?:@""];
    self.peisongLab.textColor =REDCOLOR;
}
-(void)BtnClick:(UIButton *)sender
{
    
}
- (IBAction)selectBtnClick:(id)sender {
    !_selectBtnClickBlock?:_selectBtnClickBlock();
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
@end



@implementation CollectionCell8
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CollectionCell8";
    CollectionCell8 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:nil options:nil] objectAtIndex:8];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(void)setSellOutModel:(AskSellOutModel *)sellOutModel
{
    _sellOutModel =sellOutModel;
    if ([sellOutModel.compType intValue]==0) {
        [self.santieBtn setImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
//        [self.santieBtn setTitle:@"自营" forState:UIControlStateNormal];
        
    }else if ([sellOutModel.compType intValue]==1)
    {
        [self.santieBtn setImage:[UIImage imageNamed:@"分类购买_08"] forState:UIControlStateNormal];
//        [self.santieBtn setTitle:@"厂家" forState:UIControlStateNormal];
        
    }
    else if ([sellOutModel.compType intValue]==2)
    {
        [self.santieBtn setImage:[UIImage imageNamed:@"blue-bg"] forState:UIControlStateNormal];
//        [self.santieBtn setTitle:@"批发商" forState:UIControlStateNormal];
        
    }
    self.cangkeLab.text =sellOutModel.sellerName;
}

-(void)BtnClick:(UIButton *)sender
{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
@end

@implementation CollectionCell9
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CollectionCell9";
    CollectionCell9 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:nil options:nil] objectAtIndex:9];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(void)setSellOutModel:(AskSellOutModel *)sellOutModel
{
    _sellOutModel =sellOutModel;

}

-(void)BtnClick:(UIButton *)sender
{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
@end



@implementation CollectionCell10
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CollectionCell10";
    CollectionCell10 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:nil options:nil] objectAtIndex:10];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.cancelBtn.layer setBorderColor:BACKGROUNDCOLOR.CGColor];
    [cell.cancelBtn.layer setBorderWidth:1.0];
    [cell.cancelBtn.layer setCornerRadius:4];
    cell.cancelBtn.layer.masksToBounds =4;
    cell.sellAfterBtn.layer.cornerRadius =4;
    cell.sellAfterBtn.layer.masksToBounds =4;
    
    return cell;
}
-(void)BtnClick:(UIButton *)sender
{
    
}
-(void)setSelloutModel:(DRSellAfterModel *)selloutModel
{
    _selloutModel =selloutModel;
    if (selloutModel.returnOrderStatus!=6&&selloutModel.returnOrderStatus!=7&&selloutModel.returnOrderStatus!=9) {
        self.cancelBtn.hidden =NO;
    }
    else{
        self.cancelBtn.hidden =YES;
    }
}

- (IBAction)btnClick:(id)sender {
    UIButton *btn =(UIButton *)sender;
    NSLog(@"btn=%ld",(long)btn.tag);
   
        
        if (_BtnBlock) {
            _BtnBlock(btn.tag,btn.titleLabel.text);
        }
    
}
-(void)setStatus:(NSInteger)status
{
    switch (status) {
        case 0:
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


@implementation CollectionCell11
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CollectionCell11";
    CollectionCell11 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:nil options:nil] objectAtIndex:11];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}
- (IBAction)tellBtnClick:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://4006185027"]];
}
-(void)setOrderModel:(OrderModel *)orderModel
{
    _orderModel =orderModel;
    self.orderLAb.text =[NSString stringWithFormat:@"订单号：%@",orderModel.orderNo];
    self.timeLab.text =[SNTool StringTimeFormat:[NSString stringWithFormat:@"%ld",orderModel.createTime]];
    NSArray *statusArr =@[@"已取消", @"待审核", @"待付款", @"待发货", @"待收货",@"已完成",@"退货中",@"已退货"];
    if (orderModel.status==101) {
        self.statusLAb.text =@"已支付";
    }else
    {
        self.statusLAb.text =statusArr[orderModel.status];
    }
    if (orderModel.isReturn==1) {
        self.statusLAb.text =@"退货中";
    }
    if ([orderModel.sellerExpressType intValue]==0) {
        [self.santieBtn setImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
//        [self.santieBtn setTitle:@"自营" forState:UIControlStateNormal];
    }else if ([orderModel.sellerExpressType intValue]==1)
    {
        [self.santieBtn setImage:[UIImage imageNamed:@"分类购买_08"] forState:UIControlStateNormal];
//        [self.santieBtn setTitle:@"厂家" forState:UIControlStateNormal];
    }
    else if ([orderModel.sellerExpressType intValue]==2)
    {
        [self.santieBtn setImage:[UIImage imageNamed:@"blue-bg"] forState:UIControlStateNormal];
//        [self.santieBtn setTitle:@"批发商" forState:UIControlStateNormal];
    }
    [self.companyBtn setTitle:orderModel.sellerName forState:UIControlStateNormal];
    if (orderModel.kpName.length!=0) {
        self.companyLab.text =[NSString stringWithFormat:@"开票方：%@",orderModel.kpName?:@""];
    }else
    {
        self.companyLab.text =@"";
    }
    
    NSArray *expressTypeArr =@[@"自提",@"卖家直发",@"三铁配送"];
    NSArray *payArr =@[@"现金",@"月结",@"月结30天",@"月结60天"];
    self.peisongLab.text =[NSString stringWithFormat:@"%@  %@  %@",orderModel.storeName,payArr[orderModel.orderPayType],expressTypeArr[[orderModel.expressType intValue]]];
    [SNTool setTextColor:self.peisongLab FontNumber:DR_FONT(12) AndRange:NSMakeRange(orderModel.storeName.length, self.peisongLab.text.length-orderModel.storeName.length) AndColor:REDCOLOR];
    NSString *sellTypeCodeStr;
    if (![orderModel.compType isEqualToString:@"0"]) {
        
        if ([orderModel.priceType isEqualToString:@"0"]) {
            sellTypeCodeStr=@"含税";
        }
        else if ([orderModel.priceType isEqualToString:@"1"]) {
            sellTypeCodeStr =@"未税";
        }
        NSString *str ;
        if ([orderModel.isHy isEqualToString:@"0"]) {
            str =@"含运";
        }
        else if ([orderModel.isHy isEqualToString:@"1"]) {
            str =@"不含运";
        }
        [self.typeBtn setTitle:[NSString stringWithFormat:@"%@%@",sellTypeCodeStr?:@"",str?:@""] forState:UIControlStateNormal];
        self.typeBtn.hidden =NO;
    }else
    {
        self.typeBtn.hidden =YES;
    }
}
-(void)setSelloutModel:(DRSellAfterModel *)selloutModel
{
    _selloutModel =selloutModel;
    self.orderLAb.text =[NSString stringWithFormat:@"退货单号：%@",selloutModel.returnOrderNo];
    self.timeLab.text =[SNTool StringTimeFormat:selloutModel.createTime];
    NSArray *statusArr =@[@"待取货", @"待审核", @"待回寄", @"已回寄", @"已收货",@"待退款",@"已完成",@"不通过",@"已取件",@"已取消"];
    if (selloutModel.returnOrderStatus==99) {
        self.statusLAb.text =@"待取件";
    }else
    {
        self.statusLAb.text =statusArr[selloutModel.returnOrderStatus];
    }
    [self.companyBtn setTitle:selloutModel.sellerName forState:UIControlStateNormal];
    self.companyLab.text =[NSString stringWithFormat:@"开票方：%@",selloutModel.kpName?:@""];
    
    NSArray *expressTypeArr =@[@"自提",@"卖家直发",@"三铁配送"];
    NSArray *payArr =@[@"现金",@"月结",@"月结30天",@"月结60天"];
    self.peisongLab.text =[NSString stringWithFormat:@"%@  %@  %@",selloutModel.storeName,payArr[selloutModel.orderPayType],expressTypeArr[[selloutModel.expressType intValue]]];
    [SNTool setTextColor:self.peisongLab FontNumber:DR_FONT(12) AndRange:NSMakeRange(selloutModel.storeName.length, self.peisongLab.text.length-selloutModel.storeName.length) AndColor:REDCOLOR];
//    if (![selloutModel.compType isEqualToString:@"0"]) {
//        self.typeBtn.hidden =NO;
//        [self.typeBtn setTitle:[NSString stringWithFormat:@"%@%@",selloutModel.priceTypeName,selloutModel.isHy] forState:UIControlStateNormal];
//    }else
//    {
//        self.typeBtn.hidden =YES;
//    }
}

-(void)BtnClick:(UIButton *)sender
{
    
}
- (IBAction)companyBtnClick:(id)sender {
    !_companyClickBlock?:_companyClickBlock();
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end

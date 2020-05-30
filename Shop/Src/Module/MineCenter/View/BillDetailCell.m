//
//  BillDetailCell.m
//  Shop
//
//  Created by BWJ on 2019/3/28.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "BillDetailCell.h"

@implementation BillDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"BillDetailCell";
    BillDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BillDetailCell" owner:nil options:nil] firstObject];
    }
    cell.detailBtn.layer.cornerRadius =4;
    cell.detailBtn.layer.masksToBounds =4;
    
    
    cell.detailBtn.layer.borderColor =RGBHex(0XE5E5E5).CGColor;
    cell.detailBtn.layer.borderWidth =0.5;
    return cell;
}
-(void)setListModel:(DetailListModel *)listModel
{
    _listModel =listModel;
    self.orderLab.text =[NSString stringWithFormat:@"订单号：%@",listModel.orderNo];
    self.companyNameLab.text =[NSString stringWithFormat:@"店铺名称：%@",listModel.sellerName];
    self.orderCountLab.text =[NSString stringWithFormat:@"订单金额：￥%.2f",listModel.realAmt];
    self.returnBackLab.text =[NSString stringWithFormat:@"退货金额：￥%.2f",listModel.returnedAmt];
    self.realCountLab.text =[NSString stringWithFormat:@"可开票金额：￥%.2f",listModel.totalAmt];
    self.orderTimeLab.text =[NSString stringWithFormat:@"订单时间：%@",[SNTool StringTimeFormat:[NSString stringWithFormat:@"%ld",(long)listModel.billDate]]];
}
- (IBAction)detailBtnClick:(id)sender {
    !_detailClickBlock ? : _detailClickBlock();
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
@end

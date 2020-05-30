//
//  ChildCell.m
//  Shop
//
//  Created by BWJ on 2019/3/6.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "ChildCell.h"
#import "DRChildCountModel.h"
@implementation ChildCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"ChildCell";
    
    ChildCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil)
    {
         cell = [[[NSBundle mainBundle] loadNibNamed:@"ChildCell" owner:nil options:nil] firstObject];
    }
    cell.editBtn.layer.borderWidth =1;
    cell.editBtn.layer.borderColor =REDCOLOR.CGColor;
    cell.editBtn.layer.cornerRadius=5;
    cell.editBtn.layer.masksToBounds =5;
    cell.startBtn.layer.borderWidth =1;
    cell.startBtn.layer.borderColor =REDCOLOR.CGColor;
    cell.startBtn.layer.cornerRadius=5;
    cell.startBtn.layer.masksToBounds =5;
    cell.cancelBtn.layer.borderWidth =1;
    cell.cancelBtn.layer.borderColor =REDCOLOR.CGColor;
    cell.cancelBtn.layer.cornerRadius=5;
    cell.cancelBtn.layer.masksToBounds =5;
    
    return cell;
}

- (void)setAdItem:(DRChildCountModel *)adItem
{
    _adItem = adItem;
    _nameCountLab.text =[NSString stringWithFormat:@"姓名：%@  账号：%@",adItem.accountName,adItem.account];
    _phoneLab.text =[NSString stringWithFormat:@"手机号：%@",adItem.mobilePhone];
    _statusLab.text =adItem.status?@"锁定":@"启用";
    _startBtn.selected =!adItem.status;
}
- (IBAction)editBtnClick:(id)sender {
    !_isEditBlock ? :_isEditBlock();
   
}
- (IBAction)startBtnClick:(id)sender {
      !_isStartBlock ? :_isStartBlock();
}
- (IBAction)cancelBtnClick:(id)sender {
    !_isCancelBlock ? :_isCancelBlock();
}

@end

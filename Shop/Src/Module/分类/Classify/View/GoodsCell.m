//
//  GoodsCell.m
//  Shop
//
//  Created by BWJ on 2019/4/2.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "GoodsCell.h"

@implementation GoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"GoodsCell";
    GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GoodsCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [DCSpeedy dc_chageControlCircularWith:cell.quanBtn AndSetCornerRadius:2 SetBorderWidth:1 SetBorderColor:REDCOLOR canMasksToBounds:YES];
    
    
    return cell;
}
- (IBAction)quanBtnClick:(id)sender {
}
- (IBAction)selectBtnClick:(id)sender {
     !_selectShopBtnBlock?:_selectShopBtnBlock();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    if ([goodsModel.sellerTypeCode isEqualToString:@"0"]) {
        self.cangkuLab.text =@"本地云仓（三铁配送）";
        if (![goodsModel.serviceType isEqualToString:@"st"]) {
            self.cangkuLab.text =@"本地云仓（三铁配送）您不在配送范围之内, 需要承担运费";
        }
       
    }else
    {
        if ([goodsModel.serviceType isEqualToString:@"st"]) {
            self.cangkuLab.text =@"卖家库存（三铁配送）";
        }
        else if ([goodsModel.serviceType isEqualToString:@"0"])
        {
             self.cangkuLab.text =@"本地云仓（三铁配送）";
        }
        else if ([goodsModel.serviceType isEqualToString:@"zf"])
        {
            self.cangkuLab.text =@"卖家库存（卖家直发）";
        }
        
    }
    
    if ([goodsModel.sellerTypeCode intValue]==0) {
        [self.ziyingBtn setImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
//        [self.ziyingBtn setTitle:@"自营" forState:UIControlStateNormal];
        self.ziyingpeisongLab.textColor =BLACKCOLOR;
    }else if ([goodsModel.sellerTypeCode intValue]==1)
    {
        [self.ziyingBtn setImage:[UIImage imageNamed:@"分类购买_08"] forState:UIControlStateNormal];
//         [self.ziyingBtn setTitle:@"厂家" forState:UIControlStateNormal];
        self.ziyingpeisongLab.textColor =BLACKCOLOR;
    }
    else if ([goodsModel.sellerTypeCode intValue]==2)
    {
         [self.ziyingBtn setImage:[UIImage imageNamed:@"blue-bg"] forState:UIControlStateNormal];
//         [self.ziyingBtn setTitle:@"批发商" forState:UIControlStateNormal];
        self.ziyingpeisongLab.textColor =BLACKCOLOR;
    }
    self.ziyingpeisongLab.text =goodsModel.sellerName;
    self.kaipiaoLab.text =[NSString stringWithFormat:@"开票方：%@",goodsModel.kpName];
    
    if (![goodsModel.sellerTypeCode isEqualToString:@"0"]) {
        
        if ([goodsModel.priceType isEqualToString:@"0"]) {
            self.sellTypeCodeStr=@"含税";
        }
        else if ([goodsModel.priceType isEqualToString:@"1"]) {
             self.sellTypeCodeStr =@"未税";
        }
        NSString *str ;
        if ([goodsModel.isHy isEqualToString:@"0"]) {
            str =@"含运";
        }
        else if ([goodsModel.isHy isEqualToString:@"1"]) {
             str =@"不含运";
        }
        self.sellTypeCodeStr =[NSString stringWithFormat:@"%@%@",self.sellTypeCodeStr,str];
    }    
    self.jiesuanLab.text =[NSString stringWithFormat:@"%@ %@",[goodsModel.payType boolValue]?@"月结":@"现金",self.sellTypeCodeStr?:@""];
    //未完待续
}
-(void)setSameModel:(DRSameModel *)sameModel
{
    _sameModel =sameModel;
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
    if ([sameModel.sellerTypeCode isEqualToString:@"0"]) {
        self.cangkuLab.text =@"本地云仓（三铁配送）";
        if (![sameModel.serviceType isEqualToString:@"st"]) {
            self.cangkuLab.text =@"本地云仓（三铁配送）您不在配送范围之内, 需要承担运费";
        }
       
    }else
    {
        if ([sameModel.serviceType isEqualToString:@"st"]) {
            self.cangkuLab.text =@"卖家库存（三铁配送）";
        }
        else if ([sameModel.serviceType isEqualToString:@"0"])
        {
             self.cangkuLab.text =@"本地云仓（三铁配送）";
        }
        else if ([sameModel.serviceType isEqualToString:@"zf"])
        {
            self.cangkuLab.text =@"卖家库存（卖家直发）";
        }
        
    }
    
    if ([sameModel.sellerTypeCode intValue]==0) {
        [self.ziyingBtn setImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
//        [self.ziyingBtn setTitle:@"自营" forState:UIControlStateNormal];
        self.ziyingpeisongLab.textColor =REDCOLOR;
    }else if ([sameModel.sellerTypeCode intValue]==1)
    {
        [self.ziyingBtn setImage:[UIImage imageNamed:@"分类购买_08"] forState:UIControlStateNormal];
//         [self.ziyingBtn setTitle:@"厂家" forState:UIControlStateNormal];
        self.ziyingpeisongLab.textColor =BLACKCOLOR;
    }
    else if ([sameModel.sellerTypeCode intValue]==2)
    {
         [self.ziyingBtn setImage:[UIImage imageNamed:@"blue-bg"] forState:UIControlStateNormal];
//         [self.ziyingBtn setTitle:@"批发商" forState:UIControlStateNormal];
        self.ziyingpeisongLab.textColor =BLACKCOLOR;
    }
    self.ziyingpeisongLab.text =sameModel.sellerName;
    self.kaipiaoLab.text =[NSString stringWithFormat:@"开票方：%@",sameModel.kpName];
    
    if (![sameModel.sellerTypeCode isEqualToString:@"0"]) {
        
        if (sameModel.priceType==0) {
            self.sellTypeCodeStr=@"含税";
        }
        else if (sameModel.priceType==1) {
             self.sellTypeCodeStr =@"未税";
        }
        NSString *str ;
        if ([sameModel.isHy isEqualToString:@"0"]) {
            str =@"含运";
        }
        else if ([sameModel.isHy isEqualToString:@"1"]) {
             str =@"不含运";
        }
        self.sellTypeCodeStr =[NSString stringWithFormat:@"%@%@",self.sellTypeCodeStr,str];
    }
    self.jiesuanLab.text =[NSString stringWithFormat:@"%@ %@",[sameModel.payType boolValue]?@"月结":@"现金",self.sellTypeCodeStr?:@""];
    //未完待续
}
- (IBAction)callBtnClick:(id)sender {
     !_selectlickBlock?:_selectlickBlock();
}

@end


@implementation GoodsCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"GoodsCell1";
    
    GoodsCell1 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GoodsCell" owner:nil options:nil] objectAtIndex:1];
    }
    return cell;
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
    if ([goodsModel.sellerTypeCode isEqualToString:@"0"]) {
        self.cangkuLab.text =@"本地云仓（三铁配送）";
        if (![goodsModel.serviceType isEqualToString:@"st"]) {
            self.cangkuLab.text =@"本地云仓（三铁配送）您不在配送范围之内, 需要承担运费";
        }
        
    }else
    {
        if ([goodsModel.serviceType isEqualToString:@"st"]) {
            self.cangkuLab.text =@"卖家库存（三铁配送）";
        }
        else if ([goodsModel.serviceType isEqualToString:@"0"])
        {
            self.cangkuLab.text =@"本地云仓（三铁配送）";
        }
        else if ([goodsModel.serviceType isEqualToString:@"zf"])
        {
            self.cangkuLab.text =@"卖家库存（卖家直发）";
        }
        
    }
    
    if ([goodsModel.sellerTypeCode intValue]==0) {
        [self.ziyingBtn setImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
//        [self.ziyingBtn setTitle:@"自营" forState:UIControlStateNormal];
        self.ziyingpeisongLab.textColor =BLACKCOLOR;
    }else if ([goodsModel.sellerTypeCode intValue]==1)
    {
        [self.ziyingBtn setImage:[UIImage imageNamed:@"分类购买_08"] forState:UIControlStateNormal];
//        [self.ziyingBtn setTitle:@"厂家" forState:UIControlStateNormal];
        self.ziyingpeisongLab.textColor =BLACKCOLOR;
    }
    else if ([goodsModel.sellerTypeCode intValue]==2)
    {
        [self.ziyingBtn setImage:[UIImage imageNamed:@"blue-bg"] forState:UIControlStateNormal];
//        [self.ziyingBtn setTitle:@"批发商" forState:UIControlStateNormal];
        self.ziyingpeisongLab.textColor =BLACKCOLOR;
    }
    self.ziyingpeisongLab.text =goodsModel.sellerName;
    if (![goodsModel.sellerTypeCode isEqualToString:@"0"]) {
        
        if ([goodsModel.priceType isEqualToString:@"0"]) {
            self.sellTypeCodeStr=@"含税";
        }
        else if ([goodsModel.priceType isEqualToString:@"1"]) {
            self.sellTypeCodeStr =@"未税";
        }
        NSString *str ;
        if ([goodsModel.isHy isEqualToString:@"0"]) {
            str =@"含运";
        }
        else if ([goodsModel.isHy isEqualToString:@"1"]) {
            str =@"不含运";
        }
        self.sellTypeCodeStr =[NSString stringWithFormat:@"%@%@",self.sellTypeCodeStr,str];
    }
    self.jiesuanLab.text =[NSString stringWithFormat:@"%@ %@",[goodsModel.payType boolValue]?@"月结":@"现金",self.sellTypeCodeStr?:@""];
    //未完待续
}
- (IBAction)quanBtnClick:(id)sender {
}
- (IBAction)callBtnClick:(id)sender {
    !_selectlickBlock?:_selectlickBlock();
}
- (IBAction)selectShopBtnClick:(id)sender {
     !_selectShopBtnBlock?:_selectShopBtnBlock();
}

@end


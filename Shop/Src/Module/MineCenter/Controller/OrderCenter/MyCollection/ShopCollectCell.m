//
//  ShopCollectCell.m
//  Shop
//
//  Created by rockding on 2020/3/27.
//  Copyright © 2020 SanTie. All rights reserved.
//
#import "GoodsModel.h"
#import "ShopCollectCell.h"
@implementation ShopCollectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}
-(void)layoutSubviews
{
    [DCSpeedy dc_chageControlCircularWith:self.cancelBtn AndSetCornerRadius:4 SetBorderWidth:1 SetBorderColor:BACKGROUNDCOLOR canMasksToBounds:YES];
    [DCSpeedy dc_chageControlCircularWith:self.callBtn AndSetCornerRadius:4 SetBorderWidth:0 SetBorderColor:nil canMasksToBounds:YES];
}
- (IBAction)callBtnClick:(id)sender {
    !_callPhoneBlock?:_callPhoneBlock();
}
- (IBAction)cancelBtnClick:(id)sender {
    !_cancelBlock?:_cancelBlock();
}
-(void)setFavorteModel:(FavoriteModel *)favorteModel
{
    _favorteModel =favorteModel;
//    if (favorteModel.favorite_id.length!=0) {
//        self.typeBtn.selected =YES;
//    }
//    else
//    {
//        self.collectionBtn.selected =NO;
//    }
    [self.iconIMG sd_setImageWithURL:[NSURL URLWithString:favorteModel.compLog] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
       if (favorteModel.storeTitle.length!=0) {
           self.companyLab.text = favorteModel.storeTitle;
       }else
       {
           self.companyLab.text =favorteModel.sellerName;
          
       }
//       if ([favorteModel.isSendVoucher isEqualToString:@"1"]) {
//           [self.titBtn setImage:[UIImage imageNamed:@"quan"] forState:UIControlStateNormal];
//
//       }else
//       {
//           [self.titBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//       }
       
    if (favorteModel.storePrdt.length==0) {
        self.ContentLab.text =@"";
    }else
    {
        self.ContentLab.text =[NSString stringWithFormat:@"主营产品：%@",favorteModel.storePrdt];
    }
       //compType 0 自营 1厂家  2批发商
//       NSString *typeStr;
//       if ([favorteModel.compType isEqualToString:@"0"]) {
//           typeStr =@"自营";
//       }else if ([favorteModel.compType isEqualToString:@"1"])
//       {
//           typeStr =@"厂家";
//       }
//       else if ([favorteModel.compType isEqualToString:@"2"])
//       {
//           typeStr =@"批发商";
//       }
//       self.typeLab.text =[NSString stringWithFormat:@"%@",typeStr];
//       self.addressLab.text =[NSString stringWithFormat:@"所在地：%@",favorteModel.compAddr];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

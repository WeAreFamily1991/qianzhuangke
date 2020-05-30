//
//  DRLocationCell.m
//  Shop
//
//  Created by BWJ on 2019/4/27.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRLocationCell.h"
#import "DRLocationModel.h"
#import "GoodsModel.h"
@implementation DRLocationCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    SNTool
    
    
    [DCSpeedy dc_chageControlCircularWith:self.collectionBtn AndSetCornerRadius:4 SetBorderWidth:0.5 SetBorderColor:RGBHex(0XE5E5E5) canMasksToBounds:YES];
    [DCSpeedy dc_chageControlCircularWith:self.phoneBtn AndSetCornerRadius:4 SetBorderWidth:0 SetBorderColor:RGBHex(0XE5E5E5) canMasksToBounds:YES];
    
    // Initialization code
}
-(void)setLocationModel:(DRLocationModel *)locationModel
{
    _locationModel =locationModel;
    if (locationModel.favoriteId.length!=0) {
        self.collectionBtn.selected =YES;
    }
    else
    {
        self.collectionBtn.selected =NO;
    }
    [self.iconIMG sd_setImageWithURL:[NSURL URLWithString:locationModel.compLog] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
      if (locationModel.storeTitle.length!=0) {
          [self.titBtn setTitle:locationModel.storeTitle forState:UIControlStateNormal];
      }else
      {
          [self.titBtn setTitle:locationModel.sellerName forState:UIControlStateNormal];;
      }
      self.typeLab.text =[NSString stringWithFormat:@"主营产品：%@",locationModel.storePrdt];
      //compType 0 自营 1厂家  2批发商
      NSString *typeStr;
      if ([locationModel.compType isEqualToString:@"0"]) {
          typeStr =@"自营";
      }else if ([locationModel.compType isEqualToString:@"1"])
      {
          typeStr =@"厂家";
      }
      else if ([locationModel.compType isEqualToString:@"2"])
      {
          typeStr =@"批发商";
      }
      self.typeLab.text =[NSString stringWithFormat:@"经营模式：%@",typeStr];
      self.addressLab.text =[NSString stringWithFormat:@"所在地：%@",locationModel.regArea];
    if (locationModel.isSendVoucher==0) {
        if (locationModel.sellerClass<4) {
//            [self.titBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_offset(self.iconIMG.mas_right).offset(10);
//            }];
            self.quanIMG.hidden =YES;
            self.nullImg.hidden =YES;
//            [self.titBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_offset(self.iconIMG.mas_right).offset(10);
//
//            }];
        }
        else
        {
            self.nullImg.hidden =NO;
            self.quanIMG.hidden =YES;
//            [self.nullImg mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_offset(self.iconIMG.mas_right).offset(10);
//            }];
            
//            [self.titBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_offset(self.nullImg.mas_right).offset(5);
//            }];
            
        }
    }else
    {
       if (locationModel.sellerClass<4) {
//            [self.titBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_offset(self.iconIMG.mas_right).offset(10);
//            }];
            self.quanIMG.hidden =NO;
            self.nullImg.hidden =YES;
//           [self.quanIMG mas_updateConstraints:^(MASConstraintMaker *make) {
//               make.left.mas_offset(self.iconIMG.mas_right).offset(10);
//           }];
//           [self.titBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//               make.left.mas_offset(self.quanIMG.mas_right).offset(5);
//
//           }];
        }
        else
        {
            self.nullImg.hidden =NO;
            self.quanIMG.hidden =NO;
//            [self.quanIMG mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_offset(self.iconIMG.mas_right).offset(10);
//            }];
//            [self.nullImg mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_offset(self.quanIMG.mas_right).offset(5);
//            }];
//            [self.titBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_offset(self.nullImg.mas_right).offset(5);
//            }];
        }
    }
}
-(void)setFavorteModel:(FavoriteModel *)favorteModel
{
    _favorteModel =favorteModel;
    if (favorteModel.favorite_id.length!=0) {
        self.collectionBtn.selected =YES;
    }
    else
    {
        self.collectionBtn.selected =NO;
    }
    [self.iconIMG sd_setImageWithURL:[NSURL URLWithString:favorteModel.compLog] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
       if (favorteModel.storeTitle.length!=0) {
           [self.titBtn setTitle:favorteModel.storeTitle forState:UIControlStateNormal];
       }else
       {
           [self.titBtn setTitle:favorteModel.sellerName forState:UIControlStateNormal];
       }
       if ([favorteModel.isSendVoucher isEqualToString:@"1"]) {
           [self.titBtn setImage:[UIImage imageNamed:@"quan"] forState:UIControlStateNormal];
           
       }else
       {
           [self.titBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
       }
       self.modelLab.text =[NSString stringWithFormat:@"主营产品：%@",favorteModel.storePrdt];
       //compType 0 自营 1厂家  2批发商
       NSString *typeStr;
       if ([favorteModel.compType isEqualToString:@"0"]) {
           typeStr =@"自营";
       }else if ([favorteModel.compType isEqualToString:@"1"])
       {
           typeStr =@"厂家";
       }
       else if ([favorteModel.compType isEqualToString:@"2"])
       {
           typeStr =@"批发商";
       }
       self.typeLab.text =[NSString stringWithFormat:@"%@",typeStr];
       self.addressLab.text =[NSString stringWithFormat:@"所在地：%@",favorteModel.compAddr];
    if ([favorteModel.isSendVoucher integerValue]==0) {
          if (favorteModel.sellerClass<4) {
//              [self.titBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//                  make.left.mas_offset(self.iconIMG.mas_right).offset(10);
//              }];
              self.quanIMG.hidden =YES;
              self.nullImg.hidden =YES;
//              [self.titBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//                  make.left.mas_offset(self.iconIMG.mas_right).offset(10);
//
//              }];
          }
          else
          {
              self.nullImg.hidden =NO;
              self.quanIMG.hidden =YES;
//              [self.nullImg mas_updateConstraints:^(MASConstraintMaker *make) {
//                  make.left.mas_offset(self.iconIMG.mas_right).offset(10);
//              }];
//              [self.titBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//                  make.left.mas_offset(self.nullImg.mas_right).offset(5);
//              }];
              
          }
      }else
      {
         if (favorteModel.sellerClass<4) {
//              [self.titBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//                  make.left.mas_offset(self.iconIMG.mas_right).offset(10);
//              }];
              self.quanIMG.hidden =NO;
              self.nullImg.hidden =YES;
//             [self.quanIMG mas_updateConstraints:^(MASConstraintMaker *make) {
//                 make.left.mas_offset(self.iconIMG.mas_right).offset(10);
//             }];
//             [self.titBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//                 make.left.mas_offset(self.quanIMG.mas_right).offset(5);
//
//             }];
          }
          else
          {
              self.nullImg.hidden =NO;
              self.quanIMG.hidden =NO;
//              [self.quanIMG mas_updateConstraints:^(MASConstraintMaker *make) {
//                  make.left.mas_offset(self.iconIMG.mas_right).offset(10);
//              }];
//              
//              [self.nullImg mas_updateConstraints:^(MASConstraintMaker *make) {
//                  make.left.mas_offset(self.quanIMG.mas_right).offset(5);
//              }];
//              [self.titBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//                  make.left.mas_offset(self.nullImg.mas_right).offset(5);
//              }];
              
          }
      }
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)collectionBtnClick:(id)sender {
    if (_favorteModel) {
        !_collectionBtnBlock?:_collectionBtnBlock();
    }else
    {
        
        NSMutableDictionary *mudic =[NSMutableDictionary dictionary];
        NSString *urlStr;
        if (self.collectionBtn.selected) {
            urlStr =@"buyer/cancelSellerFavorite";
            
            mudic =[NSMutableDictionary dictionaryWithObject:self.locationModel.favoriteId forKey:@"id"];
            [SNIOTTool deleteWithURL:urlStr parameters:mudic success:^(SNResult *result) {
                if (result.state==200) {
                    NSLog(@"result=%@",result.data);
                    
                    self.locationModel.favoriteId =@"";
                    self.collectionBtn.selected =NO;
                    //               [MBProgressHUD showSuccess:@"取消成功"];
                }
            } failure:^(NSError *error) {
                [MBProgressHUD showError:error.description];
            }];
        }
        else
        {
            urlStr =@"buyer/favoriteSeller";
            NSDictionary *dic =@{@"id":self.locationModel.sellerId?:@""};
            
            [SNAPI postWithURL:urlStr parameters:dic.mutableCopy success:^(SNResult *result) {
                if (result.state==200) {
                    NSLog(@"result=%@",result.data);
                    self.locationModel.favoriteId=result.data;
                    self.collectionBtn.selected =YES;
                    [MBProgressHUD showSuccess:@"收藏成功"];
                    //
                }
            } failure:^(NSError *error) {
                
            }];
        }
    }
}
- (IBAction)phoneBtnClick:(id)sender {
}

@end

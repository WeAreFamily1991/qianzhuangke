
//
//  CatgoryDetailCell.m
//  Shop
//
//  Created by BWJ on 2019/3/7.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "CatgoryDetailCell.h"
#import "ShopCarDetailModel.h"
#import "GoodsModel.h"
#import "CGXPickerView.h"
#import "CustomAlertView.h"
#import "DRAddShopModel.h"
#import "DRAddShopView.h"
@interface  CatgoryDetailCell ()<ATChooseCountDelegate,UITextFieldDelegate>
@property(nonatomic,strong)ATChooseCountView *chooseCountView;     //输入框加减
@end
@implementation CatgoryDetailCell
-(NSMutableDictionary *)sourceDic
{
    if (!_sourceDic) {
        _sourceDic =[NSMutableDictionary dictionary];
    }
    return _sourceDic;
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CatgoryDetailCell";
    CatgoryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CatgoryDetailCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.shoucangBtn.layer.cornerRadius =4;
    cell.shoucangBtn.layer.masksToBounds =4;
    cell.shoucangBtn.layer.borderColor =REDCOLOR.CGColor;
    cell.shoucangBtn.layer.borderWidth =0.5;
    cell.shopCarBtn.layer.cornerRadius =4;
    cell.shopCarBtn.layer.masksToBounds =4;
    cell.sourceDic =[NSMutableDictionary dictionary];
    cell.danweiBtn.layer.borderColor =BACKGROUNDCOLOR.CGColor;
    cell.danweiBtn.layer.borderWidth =1;
    cell.countTF.layer.borderWidth =1;
    cell.danweiBtn.enabled =NO;
    cell.countTF.enabled =NO;
    cell.countTF.placeholder =@"0.000";
//    [cell.countTF addTarget:cell action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];//
    cell.countTF.layer.borderColor =BACKGROUNDCOLOR.CGColor;
    cell.chooseCountView = [[ATChooseCountView alloc] initWithFrame:cell.numberview.bounds];
    cell.chooseCountView.delegate =cell;
    cell.chooseCountView.countColor = BLACKCOLOR;
    cell.chooseCountView.canEdit = NO;
    cell.chooseCountView.minusButton.enabled =NO;
    cell.chooseCountView.plusButton.enabled =NO;
    cell.chooseCountView.countTextField.text =nil;
    cell.chooseCountView.countTextField.placeholder =@"0.00";
    [cell.numberview addSubview:cell.chooseCountView];
    
    [cell.moreBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:0];
      [cell.cancelBtn addTarget:cell action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shoucangBtn addTarget:cell action:@selector(shoucangBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shopCarBtn addTarget:cell action:@selector(shopCarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [DCSpeedy dc_chageControlCircularWith:cell.numberview AndSetCornerRadius:WScale(4) SetBorderWidth:1 SetBorderColor:BACKGROUNDCOLOR canMasksToBounds:YES];
    [DCSpeedy dc_chageControlCircularWith:cell.danweiBtn AndSetCornerRadius:WScale(4) SetBorderWidth:1 SetBorderColor:BACKGROUNDCOLOR canMasksToBounds:YES];
    [DCSpeedy dc_chageControlCircularWith:cell.countTF AndSetCornerRadius:WScale(4) SetBorderWidth:1 SetBorderColor:BACKGROUNDCOLOR canMasksToBounds:YES];
    return cell;
}
-(void)layoutSubviews
{
    [self.moreBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(WScale(10));
        make.width.mas_equalTo(WScale(90));
    }];
    
    [self.numberview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(WScale(110));
    }];
    [self.chooseCountView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.numberview);
    }];
    
}
-(void)cancelBtnClick:(UIButton *)sender
{
    if (_cancelBlock) {
        _cancelBlock(sender.tag);
    }
}
-(void)shoucangBtnClick:(UIButton *)sender
{
    NSMutableDictionary *mudic =[NSMutableDictionary dictionary];
    NSString *urlStr;
   
    if (self.shoucangBtn.selected) {
        urlStr =@"buyer/cancelItemFavorite";
        
        mudic =[NSMutableDictionary dictionaryWithObject:self.goodsModel.favouriteId forKey:@"id"];
        [SNIOTTool deleteWithURL:urlStr parameters:mudic success:^(SNResult *result) {
            if (result.state==200) {
                NSLog(@"result=%@",result.data);
                
                self.goodsModel.favouriteId =@"";
                self.shoucangBtn.selected =NO;
               
                 [MBProgressHUD showSuccess:@"已取消"];
                if (_shoucangBlock) {
                    _shoucangBlock(sender.tag);
                }
            }
        } failure:^(NSError *error) {
            [MBProgressHUD showError:error.description];
        }];
    }
    else
    {
        urlStr =@"buyer/favoriteItem";
        NSDictionary *dic =@{@"itemId":self.goodsModel.goods_id,@"sellerId":self.goodsModel.sellerId,@"storeId":self.goodsModel.storeId,@"branchId":self.goodsModel.branchId,@"areaId":self.goodsModel.areaId};
        mudic =[NSMutableDictionary dictionaryWithObject:[SNTool convertToJsonData:dic] forKey:@"item"];
        [SNAPI postWithURL:urlStr parameters:mudic success:^(SNResult *result) {
            if (result.state==200) {
                NSLog(@"result=%@",result.data);
                self.goodsModel.favouriteId=result.data[@"favoriteId"];
                self.shoucangBtn.selected =YES;
                [MBProgressHUD showSuccess:@"收藏成功"];
                //
            }
        } failure:^(NSError *error) {
            
        }];
    }
}
-(void)shopCarBtnClick:(UIButton *)sender
{
    DRWeakSelf;
    if (_goodsModel.qty!=0) {
        if ([_shoucangStr isEqualToString:@"1"])
        {
            NSMutableDictionary *mudic =[NSMutableDictionary dictionaryWithObjects:@[self.goodsModel.sellerId,self.goodsModel.goods_id,self.goodsModel.storeId] forKeys:@[@"sellerId",@"id",@"storeId"]];
            [SNAPI getWithURL:@"mainPage/getSingleItem" parameters:mudic success:^(SNResult *result) {
                _shoucangStr =@"";
                DRAddShopModel *addShopmodel =[DRAddShopModel mj_objectWithKeyValues:result.data];
                DRAddShopView *AddshopView = [[[NSBundle mainBundle]loadNibNamed:@"DRAddShopView" owner:self options:nil] lastObject];
                AddshopView.goodsModel =self.goodsModel;
                AddshopView.addshopModel =addShopmodel;
                AddshopView.frame =self.superview.superview.bounds;
                AddshopView.closeclickBlock = ^{
                    if (AddshopView) {
                        [AddshopView removeFromSuperview];
                    }
                };
                AddshopView.sureclickBlock = ^{
                    if (AddshopView) {
                        [AddshopView removeFromSuperview];
                    }
                    if (_shopCarBlock) {
                        _shopCarBlock(sender.tag);
                    }
                };
                [self.superview.superview addSubview:AddshopView];
                AddshopView.itemListArr =weakSelf.itemListArr;
                
            } failure:^(NSError *error) {
                [MBProgressHUD showError:error.domain];
            }];
        }else
        {
            NSDictionary *dic =@{@"sourceType":@"wechat",@"payType":[NSString stringWithFormat:@"%@",self.goodsModel.payType]?:@"", @"serviceType":self.goodsModel.serviceType?:@"",@"userPrice":[NSString stringWithFormat:@"%f",self.goodsModel.userPrice]?:@"",@"id":self.goodsModel.goods_id?:@"",@"buyNum":[GoodsShareModel sharedManager].countNumStr?:@"",@"itemUnit":[GoodsShareModel sharedManager].selectcode?:@"",@"sellerId":self.goodsModel.sellerId?:@"",@"storeId":self.goodsModel.storeId?:@"",@"branchId":self.goodsModel.branchId?:@"",@"areaId":self.goodsModel.areaId?:@"",@"qty":[NSString stringWithFormat:@"%f",self.goodsModel.qty]?:@""};
            
            [SNAPI postWithURL:@"buyer/addCart" parameters:dic.mutableCopy success:^(SNResult *result) {
                if (result.state==200) {
                    NSLog(@"result=%@",result.data);
                    [MBProgressHUD showSuccess:result.data];
                    if (weakSelf.noticeBlock) {
                        weakSelf.noticeBlock(sender.tag);
                    }
                    //                            [MBProgressHUD showSuccess:result]
                    
                    //                                [self.tableView reloadData];
                }
            } failure:^(NSError *error) {
                [MBProgressHUD showError:error.domain];
            }];
            
        }
        
//        if (_shopCarBlock) {
//            _shopCarBlock(sender.tag);
//        }
    }else
    {
        if (self.daohuoTongzhiStr.length==0) {
            
            CustomAlertView *alertView = [[[NSBundle mainBundle] loadNibNamed:@"CustomAlertView" owner:self options:nil] lastObject];
            //                CustomAlertView *alertView =[[CustomAlertView alloc]initWithFrame:self.view.bounds];
            alertView.goodsModel =self.goodsModel;
            alertView.frame=self.superview.superview.bounds;
            alertView.closeclickBlock = ^{
                if (alertView) {
                    [alertView removeFromSuperview];
                }
            };
            alertView.sureclickBlock = ^{
                NSArray *hopeDayArr =@[@"5",@"15",@"30",@"60",];
                NSDictionary *dic =@{@"noticeMobile":alertView.phoneTF.text?:@"",@"hopeDay":hopeDayArr[alertView.selectBtnTag-1], @"qty":[alertView.sjchlLab.text substringWithRange:NSMakeRange(6, alertView.sjchlLab.text.length-6-self.goodsModel.basicUnitName.length)],@"itemId":self.goodsModel.goods_id,@"sellerId":self.goodsModel.sellerId,@"storeId":self.goodsModel.storeId,@"branchId":self.goodsModel.branchId,@"areaId":self.goodsModel.areaId};
                NSMutableDictionary *muDic =[NSMutableDictionary dictionaryWithObject:[SNTool convertToJsonData:dic] forKey:@"notice"];
                [SNAPI postWithURL:@"buyer/addArrivalNotice" parameters:muDic success:^(SNResult *result) {
                    if (result.state==200) {
                        NSLog(@"result=%@",result.data);
                        [MBProgressHUD showSuccess:result.data];
                        if (weakSelf.noticeBlock) {
                            weakSelf.noticeBlock(sender.tag);
                        }
                    }
                } failure:^(NSError *error) {
                    [MBProgressHUD showError:error.domain];
                }];
                if (alertView) {
                    [alertView removeFromSuperview];
                }
            };
            [self.superview.superview addSubview:alertView];
        }else
        {
            if (_goodsModel.qty==0) {
                UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"溫馨提示" message:@"您需要的货品还未到货呦！请耐心等待" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
                [al show];
            }
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setGoodsModel:(GoodsModel *)goodsModel
{
    _goodsModel =goodsModel;
    NSLog(@"id =%@",goodsModel.favouriteId);
    if (goodsModel.favouriteId.length!=0) {
        self.shoucangBtn.selected =YES;
    }
    else
    {
       self.shoucangBtn.selected =NO;
    }
    if (_goodsModel.qty==0) {
        self.shopCarBtn.selected =YES;
    }
    else
    {
       self.shopCarBtn.selected =NO;
    }
    self.priceAccountLab.text =[NSString stringWithFormat:@"单价：%.2f元/%@",goodsModel.userPrice,goodsModel.basicUnitName];
}
- (IBAction)moreBtnClick:(id)sender {
    UIButton *btn =(UIButton*)sender;
    btn.selected =!btn.selected;
    self.moreBtn.selected =btn.selected;
    !_moreBtnBlock?:_moreBtnBlock();
}
-(void)setDaohuoTongzhiStr:(NSString *)daohuoTongzhiStr
{
    _daohuoTongzhiStr =daohuoTongzhiStr;
    self.shopCarBtn.selected =NO;
    
    
}
//-(void)setSameModel:(DRSameModel *)sameModel
//{
//    _sameModel =sameModel;
//    
//   
//    _orderPriceLab.hidden =NO;
//    _lineView.hidden =NO;
//    self.priceAccountLab.text =[NSString stringWithFormat:@"单价：%.2f/%@",sameModel.userPrice,sameModel.basicUnitName];
//    self.orderPriceLab.text =[NSString stringWithFormat:@"%.2f/%@",sameModel.bidPrice,sameModel.basicUnitName];
//}
-(void)setShoucangStr:(NSString *)shoucangStr
{
    _shoucangStr =shoucangStr;
    
}
-(void)setTitleStr:(NSString *)titleStr
{
    _titleStr =titleStr;
    _orderPriceLab.hidden =NO;
    _lineView.hidden =NO;
    
}
@end

@interface  CatgoryDetailCell1 ()<ATChooseCountDelegate,UITextFieldDelegate>
@property(nonatomic,strong)ATChooseCountView *chooseCountView;     //输入框加减
@end
@implementation CatgoryDetailCell1
- (void)awakeFromNib {
    [super awakeFromNib];
}

+(instancetype)cellWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath
{
    NSString *identify = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
//    static NSString *identify = @"CatgoryDetailCell1";
    CatgoryDetailCell1 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CatgoryDetailCell" owner:nil options:nil] objectAtIndex:1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.shoucangBtn.layer.cornerRadius =4;
    cell.shoucangBtn.layer.masksToBounds =4;
    cell.shoucangBtn.layer.borderColor =REDCOLOR.CGColor;
    cell.shoucangBtn.layer.borderWidth =0.5;
    cell.shopCarBtn.layer.cornerRadius =4;
    cell.shopCarBtn.layer.masksToBounds =4;
    cell.sourceDic =[NSMutableDictionary dictionary];
   
   
     [cell.countTF addTarget:cell action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];//
    
    
    cell.countTF.delegate =cell;
    cell.chooseCountView = [[ATChooseCountView alloc] initWithFrame:cell.numberview.bounds];
    cell.chooseCountView.delegate =cell;
    cell.chooseCountView.countColor = BLACKCOLOR;
    cell.chooseCountView.canEdit = YES;
    [cell.numberview addSubview:cell.chooseCountView];
    [cell.danweiBtn addTarget:cell action:@selector(danweiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.cancelBtn addTarget:cell action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shoucangBtn addTarget:cell action:@selector(shoucangBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shopCarBtn addTarget:cell action:@selector(shopCarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.moreBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:0];

    [DCSpeedy dc_chageControlCircularWith:cell.numberview AndSetCornerRadius:WScale(4) SetBorderWidth:1 SetBorderColor:BACKGROUNDCOLOR canMasksToBounds:YES];
    [DCSpeedy dc_chageControlCircularWith:cell.danweiBtn AndSetCornerRadius:WScale(4) SetBorderWidth:1 SetBorderColor:BACKGROUNDCOLOR canMasksToBounds:YES];
    [DCSpeedy dc_chageControlCircularWith:cell.countTF AndSetCornerRadius:WScale(4) SetBorderWidth:1 SetBorderColor:BACKGROUNDCOLOR canMasksToBounds:YES];
    return cell;
}
-(void)layoutSubviews
{
    [self.numberview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(WScale(110));
    }];
    [self.chooseCountView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.numberview);
       }];
}
#pragma buttonClick
-(void)cancelBtnClick:(UIButton *)sender
{
    if (_cancelBlock) {
        _cancelBlock(sender.tag);
    }
}
- (IBAction)moreBtnClick:(id)sender {
    UIButton *btn =(UIButton*)sender;
    btn.selected =!btn.selected;
    self.moreBtn.selected =btn.selected;
    !_moreBtnBlock?:_moreBtnBlock();
}
-(void)shoucangBtnClick:(UIButton *)sender
{
    //    if (_shopCarBlock) {
    //        _shoucangBlock(sender.tag);
    //    }
    NSMutableDictionary *mudic =[NSMutableDictionary dictionary];
    NSString *urlStr;
   
        if (self.shoucangBtn.selected) {
               urlStr =@"buyer/cancelItemFavorite";
                if ([self.queryTypeStr isEqualToString:@"nowBuy"]) {
                      mudic =[NSMutableDictionary dictionaryWithObject:self.sameModel.favouriteId forKey:@"id"];
                }else
                {
                      mudic =[NSMutableDictionary dictionaryWithObject:self.goodsModel.favouriteId forKey:@"id"];
                }
            
               [SNIOTTool deleteWithURL:urlStr parameters:mudic success:^(SNResult *result) {
                   if (result.state==200) {
                       NSLog(@"result=%@",result.data);
                       if ([self.queryTypeStr isEqualToString:@"nowBuy"]) {
                           self.sameModel.favouriteId =@"";
                       }else
                       {
                           self.goodsModel.favouriteId =@"";
                       }
                      
                       self.shoucangBtn.selected =NO;
                      [MBProgressHUD showSuccess:@"已取消"];
                   }
               } failure:^(NSError *error) {
                   [MBProgressHUD showError:error.description];
               }];
           }
           else
           {
               urlStr =@"buyer/favoriteItem";
               NSDictionary *dic =@{};
               if ([self.queryTypeStr isEqualToString:@"nowBuy"]) {
                   dic =@{@"itemId":self.sameModel.sameID,@"sellerId":self.sameModel.sellerId,@"storeId":self.sameModel.storeId,@"branchId":self.sameModel.branchId,@"areaId":self.sameModel.areaId};
               }else
               {
                   dic =@{@"itemId":self.goodsModel.goods_id,@"sellerId":self.goodsModel.sellerId,@"storeId":self.goodsModel.storeId,@"branchId":self.goodsModel.branchId,@"areaId":self.goodsModel.areaId};
               }
               
               mudic =[NSMutableDictionary dictionaryWithObject:[SNTool convertToJsonData:dic] forKey:@"item"];
               [SNAPI postWithURL:urlStr parameters:mudic success:^(SNResult *result) {
                   if (result.state==200) {
                       NSLog(@"result=%@",result.data);
                       if ([self.queryTypeStr isEqualToString:@"nowBuy"]) {
                            self.sameModel.favouriteId=result.data[@"favoriteId"];
                       }else
                       {
                            self.goodsModel.favouriteId=result.data[@"favoriteId"];
                       }
                     
                       self.shoucangBtn.selected =YES;
                       [MBProgressHUD showSuccess:@"收藏成功"];
                       //
                   }
               } failure:^(NSError *error) {
                   
               }];
           }
    
    
}
-(void)shopCarBtnClick:(UIButton *)sender
{
    
    DRWeakSelf;
    if (_goodsModel.qty!=0) {
        if ([_shoucangStr isEqualToString:@"1"])
        {
            NSMutableDictionary *mudic =[NSMutableDictionary dictionaryWithObjects:@[self.goodsModel.sellerId,self.goodsModel.goods_id,self.goodsModel.storeId] forKeys:@[@"sellerId",@"id",@"storeId"]];
            [SNAPI getWithURL:@"mainPage/getSingleItem" parameters:mudic success:^(SNResult *result) {
                DRAddShopModel *addShopmodel =[DRAddShopModel mj_objectWithKeyValues:result.data];
                DRAddShopView *AddshopView = [[[NSBundle mainBundle]loadNibNamed:@"DRAddShopView" owner:self options:nil] lastObject];
                AddshopView.goodsModel =self.goodsModel;
                AddshopView.addshopModel =addShopmodel;
                AddshopView.frame =self.superview.superview.bounds;
                AddshopView.closeclickBlock = ^{
                    if (AddshopView) {
                        [AddshopView removeFromSuperview];
                    }
                };
                AddshopView.sureclickBlock = ^{
                    if (AddshopView) {
                        [AddshopView removeFromSuperview];
                    }
                };
                [self.superview.superview addSubview:AddshopView];
                AddshopView.itemListArr =weakSelf.itemListArr;
  
            } failure:^(NSError *error) {
                
            }];
        }else
        {
            NSDictionary *dic =@{@"sourceType":@"wechat",@"payType":[NSString stringWithFormat:@"%@",self.goodsModel.payType]?:@"", @"serviceType":self.goodsModel.serviceType?:@"",@"userPrice":[NSString stringWithFormat:@"%f",self.goodsModel.userPrice]?:@"",@"id":self.goodsModel.goods_id?:@"",@"buyNum":self.countNumStr?:@"",@"itemUnit":self.selectDanWei?:@"",@"sellerId":self.goodsModel.sellerId?:@"",@"storeId":self.goodsModel.storeId?:@"",@"branchId":self.goodsModel.branchId?:@"",@"areaId":self.goodsModel.areaId?:@"",@"qty":self.countTF.text};
            
            
            [SNAPI postWithURL:@"buyer/addCart" parameters:dic.mutableCopy success:^(SNResult *result) {
                if (result.state==200) {
//                    NSLog(@"result=%@",result.data);
                    [MBProgressHUD showSuccess:result.data[@"msg"]];
//                    if (_shopCarBlock) {
//                        _shopCarBlock(sender.tag);
//                    }
                }
            } failure:^(NSError *error) {
                [MBProgressHUD showError:error.domain];
            }];
            
        }
        
    }else
    {
        
        
        CustomAlertView *alertView = [[[NSBundle mainBundle] loadNibNamed:@"CustomAlertView" owner:self options:nil] lastObject];
        //                CustomAlertView *alertView =[[CustomAlertView alloc]initWithFrame:self.view.bounds];
        alertView.goodsModel =self.goodsModel;
        alertView.frame=self.superview.superview.bounds;
        alertView.closeclickBlock = ^{
            if (alertView) {
                [alertView removeFromSuperview];
            }
        };
        alertView.sureclickBlock = ^{
            
            NSArray *hopeDayArr =@[@"5",@"15",@"30",@"60",];
            NSDictionary *dic =@{@"noticeMobile":alertView.phoneTF.text?:@"",@"hopeDay":hopeDayArr[alertView.selectBtnTag-1], @"qty":[alertView.sjchlLab.text substringWithRange:NSMakeRange(10, alertView.sjchlLab.text.length-10)],@"itemId":self.goodsModel.goods_id,@"sellerId":self.goodsModel.sellerId,@"storeId":self.goodsModel.storeId,@"branchId":self.goodsModel.branchId,@"areaId":self.goodsModel.areaId};
            NSMutableDictionary *muDic =[NSMutableDictionary dictionaryWithObject:[SNTool convertToJsonData:dic] forKey:@"notice"];
            [SNAPI postWithURL:@"buyer/addArrivalNotice" parameters:muDic success:^(SNResult *result) {
                if (result.state==200) {
                    NSLog(@"result=%@",result.data);
                    [MBProgressHUD showSuccess:result.data];
                    if (weakSelf.noticeBlock) {
                        weakSelf.noticeBlock(sender.tag);
                    }
                    //                            [MBProgressHUD showSuccess:result]
                    //                                [self.tableView reloadData];
                }
            } failure:^(NSError *error) {
                
            }];
            
            if (alertView) {
                [alertView removeFromSuperview];
            }
        };
        [self.superview.superview addSubview:alertView];
    }
}
-(void)setSameModel:(DRSameModel *)sameModel
{
    _sameModel =sameModel;
    _orderPriceLab.hidden =NO;
    _lineView.hidden =NO;
    self.orderPriceLab.font =DR_FONT(8);
    [self.priceAccountLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (self.bottomView.bottom).offset(WScale(11));
        make.left.mas_equalTo(self).offset(WScale(10));
        make.height.mas_equalTo(WScale(14));
    }];
    [self.orderPriceLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceAccountLab.mas_bottom).offset(WScale(3));
        make.left.mas_equalTo(self).offset(WScale(10));
        make.height.mas_equalTo(WScale(10));
    }];
    self.priceAccountLab.text =[NSString stringWithFormat:@"%.2f元/%@",sameModel.userPrice,sameModel.basicUnitName];
    self.orderPriceLab.text =[NSString stringWithFormat:@"%.2f/%@",sameModel.bidPrice,sameModel.basicUnitName];
}
-(void)setGoodsModel:(GoodsModel *)goodsModel
{
    _goodsModel =goodsModel;
    [self.moreBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(WScale(10));
        make.width.mas_equalTo(WScale(90));
    }];
    [self.numberview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.moreBtn.mas_right).offset(WScale(10));
    }];
    if (goodsModel.sellerClass>1) {
        self.shopCarBtn.hidden =NO;        
    }
    else
    {
        self.shopCarBtn.hidden =YES;
        self.shoucangBtn.frame=CGRectMake(290, 8, HScale(70), 25);
    }
    if (goodsModel.favouriteId.length!=0) {
        self.shoucangBtn.selected =YES;
    }
    else
    {
        self.shoucangBtn.selected =NO;
    }
    NSString *baseStr;//basicUnitId 5千支  6公斤  7吨
    if ([_goodsModel.basicUnitId intValue]==5) {
        baseStr =@"千支";
    }
    if ([_goodsModel.basicUnitId intValue]==6) {
        baseStr =@"公斤";
    }
    if ([_goodsModel.basicUnitId intValue]==7) {
        baseStr =@"吨";
    }
    _goodsModel.basicUnitName  =baseStr;
    self.danweiLab.text =baseStr;
  
    NSMutableArray *unitconversionArr =[NSMutableArray array];
     NSMutableArray *unitNameArr =[NSMutableArray array];
     NSMutableArray *uniDanWeiArr =[NSMutableArray array];
    if (self.goodsModel.unitConversion1!=0) {
        [unitconversionArr addObject:[NSString stringWithFormat:@"%.3f",self.goodsModel.unitConversion1]];
        [unitNameArr addObject:self.goodsModel.unitName1];
        [uniDanWeiArr addObject:self.goodsModel.unit1];
    }
    if (self.goodsModel.unitConversion2!=0) {
        [unitconversionArr addObject:[NSString stringWithFormat:@"%.3f",self.goodsModel.unitConversion2]];
        [unitNameArr addObject:self.goodsModel.unitName2];
         [uniDanWeiArr addObject:self.goodsModel.unit2];
    }
    if (self.goodsModel.unitConversion3!=0) {
        
      [unitconversionArr addObject:[NSString stringWithFormat:@"%.3f",self.goodsModel.unitConversion3]];
      [unitNameArr addObject:self.goodsModel.unitName3];
      [uniDanWeiArr addObject:self.goodsModel.unit3];
    }
    if (self.goodsModel.unitConversion4!=0) {
 
        [unitconversionArr addObject:[NSString stringWithFormat:@"%.3f",self.goodsModel.unitConversion4]];
        [unitNameArr addObject:self.goodsModel.unitName4];
        [uniDanWeiArr addObject:self.goodsModel.unit4];

    }
    if (self.goodsModel.unitConversion5!=0) {
         [unitconversionArr addObject:[NSString stringWithFormat:@"%.3f",self.goodsModel.unitConversion5]];
         [unitNameArr addObject:self.goodsModel.unitName5];
         [uniDanWeiArr addObject:self.goodsModel.unit5];
    }
    self.selectNameArr =[NSMutableArray array];
    self.selectCodeArr=[NSMutableArray array];
    self.selectDanweiArr=[NSMutableArray array];
    if ([self.goodsModel.saleUnitId intValue]==5||[self.goodsModel.saleUnitId intValue]==6||[self.goodsModel.saleUnitId intValue]==7)
    {
        [self.selectCodeArr addObject:[NSString stringWithFormat:@"%.3f",self.goodsModel.saleUnitConversion]];
        [self.selectNameArr addObject:self.goodsModel.saleUnitName];
        [self.selectDanweiArr addObject:self.goodsModel.saleUnitId];
        if ([self.goodsModel.saleUnitId intValue]==5||[self.goodsModel.saleUnitId intValue]==7) {
            self.chooseCountView.multipleNum =0.001;
        }
    }
    NSInteger selectrow = 0;
    for (int i=0; i<unitNameArr.count; i++) {
        if ([self.goodsModel.saleUnitName isEqualToString:unitNameArr[i]]) {
            selectrow =i;
        }
    }
    [self.selectCodeArr addObjectsFromArray:[unitconversionArr subarrayWithRange:NSMakeRange(selectrow, unitconversionArr.count-selectrow)]];
     [self.selectDanweiArr addObjectsFromArray:[uniDanWeiArr subarrayWithRange:NSMakeRange(selectrow, uniDanWeiArr.count-selectrow)]];
    [self.selectNameArr addObjectsFromArray:[unitNameArr subarrayWithRange:NSMakeRange(selectrow, unitconversionArr.count-selectrow)]];
    self.selectcode =[[self.selectCodeArr firstObject] doubleValue];
    self.selectDanWei =[self.selectDanweiArr firstObject];
     self.selectName =[self.selectNameArr firstObject];
    [self.danweiBtn setTitle:[self.selectNameArr firstObject] forState:UIControlStateNormal];
    [self.danweiBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%.3f",self.goodsModel.minQuantity] doubleValue];
    self.chooseCountView.minCount =[[NSString stringWithFormat:@"%.3f",self.goodsModel.minQuantity] doubleValue];
    self.countNumStr = [NSString stringWithFormat:@"%.3f",self.chooseCountView.currentCount];
    self.countTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr intValue]*self.selectcode];
   //处理尾货逻辑
    if (self.selectcode>self.goodsModel.qty) {
        self.countTF.text  =[NSString stringWithFormat:@"%.3f",self.goodsModel.qty ];
    }
    self.priceAccountLab.text =[NSString stringWithFormat:@"单价：%.2f元/%@",self.goodsModel.userPrice,self.goodsModel.basicUnitName];
    self.chooseCountView.canEdit =NO;
    
}
-(void)danweiBtnClick:(UIButton *)sender
{
    DRWeakSelf;
//    showStringPickerWithTitle:@"全部订单" DataSource:@[ @"全部订单",@"近一个月订单", @"近两个月订单", @"一年内订单"] DefaultSelValue:@"全部订单" IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow)
    
    [CGXPickerView showStringPickerWithTitle:[self.selectNameArr firstObject] DataSource:self.selectNameArr DefaultSelValue:[self.selectNameArr firstObject] IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
        self.selectcode =[[self.selectCodeArr objectAtIndex:[selectRow intValue]] doubleValue];
        self.selectDanWei =[self.selectDanweiArr objectAtIndex:[selectRow intValue]];
        self.selectName =selectValue;
        [self.danweiBtn setTitle:selectValue forState:UIControlStateNormal];
        if ([ self.selectName isEqualToString:@"千支"]||[ self.selectName isEqualToString:@"吨"]){
            self.chooseCountView.multipleNum =0.001;
        }
        else{
             self.chooseCountView.multipleNum =1;
        }
        NSLog(@"%@",selectValue);
        if (self.countNumStr.length!=0&&self.countTF.text.length!=0) {
            self.countTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr intValue]*self.selectcode];
             self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%.0f",ceil([self.countTF.text doubleValue]/self.selectcode)] doubleValue];
             if ([self.countTF.text doubleValue]>=self.goodsModel.qty) {
                  self.countTF.text =[NSString stringWithFormat:@"%.3f",weakSelf.goodsModel.qty];
                  self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%.3f",weakSelf.goodsModel.qty/self.selectcode] doubleValue];
                 self.countNumStr =[NSString stringWithFormat:@"%.3f",self.chooseCountView.currentCount];
             }
        }
        [self.danweiBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    }];
    if (_danweiBtnBlock) {
        _danweiBtnBlock(sender.tag);
    }
}
#pragma ATChooseCountDelegate
- (void)resultNumber:(NSString *)number{
//    self.numberCalculate =number;
    self.countNumStr =number;
    if ([ self.selectName isEqualToString:@"千支"]||[ self.selectName isEqualToString:@"吨"]) {
    }
    else
    {        
         self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%d",[number intValue]] doubleValue];
    }
   
    self.countTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr doubleValue]*self.selectcode];
    
    
    if ([[NSString stringWithFormat:@"%.3f",[number doubleValue]*self.selectcode] doubleValue]>=self.goodsModel.qty) {
        self.countTF.text =[NSString stringWithFormat:@"%.3f",_goodsModel.qty];
       
        self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%.3f",_goodsModel.qty/self.selectcode] doubleValue];
        self.countNumStr =[NSString stringWithFormat:@"%.3f",self.chooseCountView.currentCount];
    }
}
-(void)textChange:(UITextField *)textField
{

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.countTF)
    {
        if (string.length == 0) return YES;
        
        if ([textField.text doubleValue]>=_goodsModel.qty) {
            textField.text =[NSString stringWithFormat:@"%.3f",_goodsModel.qty];
            
            self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%.3f",_goodsModel.qty/self.selectcode] doubleValue];
            self.countNumStr =[NSString stringWithFormat:@"%.3f",self.chooseCountView.currentCount];
        }
        else
        {
            
            //
            self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%.0f",ceil([textField.text doubleValue]/self.selectcode)] doubleValue];
            if (ceil([textField.text intValue]/self.selectcode)<1&&textField.text.length!=0) {
                self.chooseCountView.currentCount =1.f;
            }
            return YES;
        }
        return NO;
    }
    
    return YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end


@interface  CatgoryDetailCell2 ()<ATChooseCountDelegate,UITextFieldDelegate>
@property(nonatomic,strong)ATChooseCountView *chooseCountView;     //输入框加减
@end
@implementation CatgoryDetailCell2

- (void)awakeFromNib {
    [super awakeFromNib];
}
+(instancetype)cellWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath
{
    NSString *identify = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    //    static NSString *identify = @"CatgoryDetailCell1";
    CatgoryDetailCell2 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CatgoryDetailCell" owner:nil options:nil] objectAtIndex:2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.shoucangBtn.layer.cornerRadius =4;
    cell.shoucangBtn.layer.masksToBounds =4;
    cell.shoucangBtn.layer.borderColor =RGBHex(0XE5E5E5).CGColor;
    cell.shoucangBtn.layer.borderWidth =0.5;
    cell.shopCarBtn.layer.cornerRadius =4;
    cell.shopCarBtn.layer.masksToBounds =4;
    cell.sourceDic =[NSMutableDictionary dictionary];
    cell.danweiBtn.layer.borderColor =BACKGROUNDCOLOR.CGColor;
    cell.danweiBtn.layer.borderWidth =1;
    cell.countTF.layer.borderWidth =1;
    [cell.countTF addTarget:cell action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];//
    cell.countTF.layer.borderColor =BACKGROUNDCOLOR.CGColor;
    cell.countTF.delegate =cell;
    cell.chooseCountView = [[ATChooseCountView alloc] initWithFrame:cell.numberview.bounds];
    cell.chooseCountView.delegate =cell;
    cell.chooseCountView.countColor = BLACKCOLOR;
    cell.chooseCountView.canEdit = YES;
    [cell.numberview addSubview:cell.chooseCountView];
    [cell.danweiBtn addTarget:cell action:@selector(danweiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.cancelBtn addTarget:cell action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shoucangBtn addTarget:cell action:@selector(shoucangBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shopCarBtn addTarget:cell action:@selector(shopCarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
-(void)setSameModel:(DRSameModel *)sameModel
{
    _sameModel =sameModel;
    if ([sameModel.sellerClass intValue]>1) {
        self.shopCarBtn.hidden =NO;
    }
    else
    {
        self.shopCarBtn.hidden =YES;
         self.shoucangBtn.frame=CGRectMake(290, 8, HScale(70), 25);
    }
    NSString *baseStr;//basicUnitId 5千支  6公斤  7吨
    if ([_sameModel.basicUnitId intValue]==5) {
        baseStr =@"千支";
    }
    if ([_sameModel.basicUnitId intValue]==6) {
        baseStr =@"公斤";
    }
    if ([_sameModel.basicUnitId intValue]==7) {
        baseStr =@"吨";
    }
    _sameModel.basicUnitName  =baseStr;
    self.danweiLab.text =baseStr;
    
    NSMutableArray *unitconversionArr =[NSMutableArray array];
    NSMutableArray *unitNameArr =[NSMutableArray array];
    NSMutableArray *uniDanWeiArr =[NSMutableArray array];
    if (_sameModel.unitConversion1!=0) {
        [uniDanWeiArr addObject:_sameModel.unit1];
        [unitconversionArr addObject:[NSString stringWithFormat:@"%.3f",[_sameModel.unitConversion1 doubleValue]]];
        [unitNameArr addObject:_sameModel.unitName1];
    }
    if (_sameModel.unitConversion2!=0) {
        [uniDanWeiArr addObject:_sameModel.unit2];
        [unitconversionArr addObject:[NSString stringWithFormat:@"%.3f",[_sameModel.unitConversion2 doubleValue]]];
        [unitNameArr addObject:_sameModel.unitName2];
        
    }
    if (_sameModel.unitConversion3!=0) {
         [uniDanWeiArr addObject:_sameModel.unit3];
        [unitconversionArr addObject:[NSString stringWithFormat:@"%.3f",[_sameModel.unitConversion3 doubleValue]]];
        [unitNameArr addObject:_sameModel.unitName3];
    }
    if (_sameModel.unitConversion4!=0) {
        
        [unitconversionArr addObject:[NSString stringWithFormat:@"%.3f",[_sameModel.unitConversion4 doubleValue]]];
        [unitNameArr addObject:_sameModel.unitName4];
         [uniDanWeiArr addObject:_sameModel.unit4];
  
    }
    if (_sameModel.unitConversion5.length!=0) {
        [unitconversionArr addObject:[NSString stringWithFormat:@"%.3f",[_sameModel.unitConversion5 doubleValue]]];
        [unitNameArr addObject:_sameModel.unitName5];
         [uniDanWeiArr addObject:_sameModel.unit4];
 
    }
    self.selectNameArr =[NSMutableArray array];
    self.selectCodeArr=[NSMutableArray array];
    self.selectDanweiArr=[NSMutableArray array];
    if ([_sameModel.saleUnitId intValue]==5||[_sameModel.saleUnitId intValue]==6||[_sameModel.saleUnitId intValue]==7)
    {        
        [self.selectCodeArr addObject:[NSString stringWithFormat:@"%.3f",_sameModel.saleUnitConversion]];
         [self.selectDanweiArr addObject:_sameModel.saleUnitId];
        [self.selectNameArr addObject:_sameModel.saleUnitName];
        if ([_sameModel.saleUnitId intValue]==5||[_sameModel.saleUnitId intValue]==7) {
            self.chooseCountView.multipleNum =0.001;
        }
    }
    NSInteger selectrow = 0;
    for (int i=0; i<unitNameArr.count; i++) {
        if ([_sameModel.saleUnitName isEqualToString:unitNameArr[i]]) {
            selectrow =i;
        }
    }
    [self.selectCodeArr addObjectsFromArray:[unitconversionArr subarrayWithRange:NSMakeRange(selectrow, unitconversionArr.count-selectrow)]];
    [self.selectNameArr addObjectsFromArray:[unitNameArr subarrayWithRange:NSMakeRange(selectrow, unitconversionArr.count-selectrow)]];
     [self.selectDanweiArr addObjectsFromArray:[uniDanWeiArr subarrayWithRange:NSMakeRange(selectrow, uniDanWeiArr.count-selectrow)]];
    self.selectDanWei =[self.selectDanweiArr firstObject];
    self.selectcode =[[self.selectCodeArr firstObject] doubleValue];
    self.selectName =[self.selectNameArr firstObject];
    [self.danweiBtn setTitle:[self.selectNameArr firstObject] forState:UIControlStateNormal];
    [self.danweiBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    
    self.chooseCountView.currentCount =self.sameModel.minQuantity;
    self.chooseCountView.minCount =self.sameModel.minQuantity;
    self.countNumStr = [NSString stringWithFormat:@"%.3f",self.chooseCountView.currentCount];
    self.countTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr intValue]*self.selectcode];
    //处理尾货逻辑
    if (self.selectcode>_sameModel.qty) {
        self.countTF.text  =[NSString stringWithFormat:@"%.3f",_sameModel.qty];
    }
    _orderPriceLab.hidden =NO;
    _lineView.hidden =NO;
    self.priceAccountLab.text =[NSString stringWithFormat:@"单价：%.2f元/%@",sameModel.userPrice,sameModel.basicUnitName];
    self.orderPriceLab.text =[NSString stringWithFormat:@"%.2f/%@",sameModel.level_price,sameModel.basicUnitName];
}
-(void)shoucangBtnClick:(UIButton *)sender
{
    //    if (_shopCarBlock) {
    //        _shoucangBlock(sender.tag);
    //    }
    NSMutableDictionary *mudic =[NSMutableDictionary dictionary];
    NSString *urlStr;
    if (self.shoucangBtn.selected) {
        urlStr =@"buyer/cancelItemFavorite";
        
        mudic =[NSMutableDictionary dictionaryWithObject:self.sameModel.favouriteId forKey:@"id"];
        [SNIOTTool deleteWithURL:urlStr parameters:mudic success:^(SNResult *result) {
            if (result.state==200) {
                NSLog(@"result=%@",result.data);
                
                self.sameModel.favouriteId =@"";
                self.shoucangBtn.selected =NO;
                [MBProgressHUD showSuccess:@"已取消"];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD showError:error.description];
        }];
    }
    else
    {
        urlStr =@"buyer/favoriteItem";
        NSDictionary *dic =@{@"itemId":self.sameModel.sameID,@"sellerId":self.sameModel.sellerId,@"storeId":self.sameModel.storeId,@"branchId":self.sameModel.branchId,@"areaId":self.sameModel.areaId};
        mudic =[NSMutableDictionary dictionaryWithObject:[SNTool convertToJsonData:dic] forKey:@"item"];
        [SNAPI postWithURL:urlStr parameters:mudic success:^(SNResult *result) {
            if (result.state==200) {
                NSLog(@"result=%@",result.data);
                self.sameModel.favouriteId=result.data[@"favoriteId"];
                self.shoucangBtn.selected =YES;
                [MBProgressHUD showSuccess:@"收藏成功"];
                //
            }
        } failure:^(NSError *error) {
            
        }];
    }
    
}
-(void)shopCarBtnClick:(UIButton *)sender
{
    
    DRWeakSelf;
    if (_sameModel.qty!=0) {
        if ([_shoucangStr isEqualToString:@"1"])
        {
            NSMutableDictionary *mudic =[NSMutableDictionary dictionaryWithObjects:@[self.sameModel.sellerId,self.sameModel.sameID,self.sameModel.storeId] forKeys:@[@"sellerId",@"id",@"storeId"]];
            [SNAPI getWithURL:@"mainPage/getSingleItem" parameters:mudic success:^(SNResult *result) {
                DRAddShopModel *addShopmodel =[DRAddShopModel mj_objectWithKeyValues:result.data];
                DRAddShopView *AddshopView = [[[NSBundle mainBundle]loadNibNamed:@"DRAddShopView" owner:self options:nil] lastObject];
                AddshopView.goodsModel =(GoodsModel*)self.sameModel;
                AddshopView.addshopModel =addShopmodel;
                AddshopView.frame =self.superview.superview.bounds;
                AddshopView.closeclickBlock = ^{
                    if (AddshopView) {
                        [AddshopView removeFromSuperview];
                    }
                };
                AddshopView.sureclickBlock = ^{
                    if (AddshopView) {
                        [AddshopView removeFromSuperview];
                    }
                };
                [self.superview.superview addSubview:AddshopView];
                AddshopView.itemListArr =weakSelf.itemListArr;
                
            } failure:^(NSError *error) {
                
            }];
        }else
        {
            NSDictionary *dic =@{@"sourceType":@"wechat",@"payType":[NSString stringWithFormat:@"%@",self.sameModel.payType]?:@"", @"serviceType":self.sameModel.serviceType?:@"",@"userPrice":[NSString stringWithFormat:@"%.2f",self.sameModel.userPrice]?:@"",@"id":self.sameModel.sameID?:@"",@"buyNum":self.countNumStr?:@"",@"itemUnit":self.selectDanWei?:@"",@"sellerId":self.sameModel.sellerId?:@"",@"storeId":self.sameModel.storeId?:@"",@"branchId":self.sameModel.branchId?:@"",@"areaId":self.sameModel.areaId?:@"",@"qty":self.countTF.text};
            
            
            [SNAPI postWithURL:@"buyer/addCart" parameters:dic.mutableCopy success:^(SNResult *result) {
                if (result.state==200) {
                    //                    NSLog(@"result=%@",result.data);
                    [MBProgressHUD showSuccess:result.data[@"msg"]];
                    //                    if (_shopCarBlock) {
                    //                        _shopCarBlock(sender.tag);
                    //                    }
                }
            } failure:^(NSError *error) {
                 [MBProgressHUD showError:error.domain];
            }];
            
        }
        
    }else
    {
        
        
        CustomAlertView *alertView = [[[NSBundle mainBundle] loadNibNamed:@"CustomAlertView" owner:self options:nil] lastObject];
        //                CustomAlertView *alertView =[[CustomAlertView alloc]initWithFrame:self.view.bounds];
        alertView.goodsModel =(GoodsModel*)self.sameModel;
        alertView.frame=self.superview.superview.bounds;
        alertView.closeclickBlock = ^{
            if (alertView) {
                [alertView removeFromSuperview];
            }
        };
        alertView.sureclickBlock = ^{
            //                    if (alertView.selectBtnTag==0) {
            //                        [MBProgressHUD showError:@"请选择期望时间"];
            //                        return ;
            //                    }
            NSArray *hopeDayArr =@[@"5",@"15",@"30",@"60",];
            NSDictionary *dic =@{@"noticeMobile":alertView.phoneTF.text?:@"",@"hopeDay":hopeDayArr[alertView.selectBtnTag-1], @"qty":[alertView.sjchlLab.text substringWithRange:NSMakeRange(10, alertView.sjchlLab.text.length-10)],@"itemId":self.sameModel.sameID,@"sellerId":self.sameModel.sellerId,@"storeId":self.sameModel.storeId,@"branchId":self.sameModel.branchId,@"areaId":self.sameModel.areaId};
            
            NSMutableDictionary *muDic =[NSMutableDictionary dictionaryWithObject:[SNTool convertToJsonData:dic] forKey:@"notice"];
            [SNAPI postWithURL:@"buyer/addArrivalNotice" parameters:muDic success:^(SNResult *result) {
                if (result.state==200) {
                    NSLog(@"result=%@",result.data);
                    [MBProgressHUD showSuccess:result.data];
                    if (weakSelf.noticeBlock) {
                        weakSelf.noticeBlock(sender.tag);
                    }
                    //                            [MBProgressHUD showSuccess:result]
                    
                    //                                [self.tableView reloadData];
                }
            } failure:^(NSError *error) {
                
            }];
            
            if (alertView) {
                [alertView removeFromSuperview];
            }
        };
        [self.superview.superview addSubview:alertView];
        
        
        
        
    }
}

-(void)danweiBtnClick:(UIButton *)sender
{
    DRWeakSelf;
    //    showStringPickerWithTitle:@"全部订单" DataSource:@[ @"全部订单",@"近一个月订单", @"近两个月订单", @"一年内订单"] DefaultSelValue:@"全部订单" IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow)
    
    [CGXPickerView showStringPickerWithTitle:[self.selectNameArr firstObject] DataSource:self.selectNameArr DefaultSelValue:[self.selectNameArr firstObject] IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
        self.selectDanWei =self.selectDanweiArr[[selectRow intValue]];
        self.selectcode =[[self.selectCodeArr objectAtIndex:[selectRow intValue]] doubleValue];
        self.selectName =selectValue;
        [self.danweiBtn setTitle:selectValue forState:UIControlStateNormal];
        if ([ self.selectName isEqualToString:@"千支"]||[ self.selectName isEqualToString:@"吨"]) {
            self.chooseCountView.multipleNum =0.001;
        }
        else
        {
            self.chooseCountView.multipleNum =1;
        }
        NSLog(@"%@",selectValue);
        if (self.countNumStr.length!=0&&self.countTF.text.length!=0) {
            //            self.countTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr intValue]*self.selectcode];
            self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%.0f",ceil([self.countTF.text doubleValue]/self.selectcode)] doubleValue];
            if ([self.countTF.text doubleValue]>=self.sameModel.qty) {
                self.countTF.text =[NSString stringWithFormat:@"%.3f",weakSelf.sameModel.qty];
                self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%.3f",weakSelf.sameModel.qty/self.selectcode] doubleValue];
                self.countNumStr =[NSString stringWithFormat:@"%.3f",self.chooseCountView.currentCount];
            }
        }
        [self.danweiBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    }];
    if (_danweiBtnBlock) {
        _danweiBtnBlock(sender.tag);
    }
}
#pragma ATChooseCountDelegate
- (void)resultNumber:(NSString *)number{
    
    //    self.numberCalculate =number;
    self.countNumStr =number;
    
    if ([ self.selectName isEqualToString:@"千支"]||[ self.selectName isEqualToString:@"吨"]) {
        
    }
    else
    {
        
        self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%d",[number intValue]] doubleValue];
    }
    
    self.countTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr doubleValue]*self.selectcode];
    
    
    if ([[NSString stringWithFormat:@"%.3f",[number doubleValue]*self.selectcode] doubleValue]>=self.sameModel.qty) {
        self.countTF.text =[NSString stringWithFormat:@"%.3f",_sameModel.qty];
        
        self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%.3f",_sameModel.qty/self.selectcode] doubleValue];
        self.countNumStr =[NSString stringWithFormat:@"%.3f",self.chooseCountView.currentCount];
    }

}
-(void)textChange:(UITextField *)textField
{
   
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.countTF)
    {
        if (string.length == 0) return YES;
        
        if ([textField.text doubleValue]>=_sameModel.qty) {
            textField.text =[NSString stringWithFormat:@"%.3f",_sameModel.qty];
            
            self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%.3f",_sameModel.qty/self.selectcode] doubleValue];
            self.countNumStr =[NSString stringWithFormat:@"%.3f",self.chooseCountView.currentCount];
        }
        else
        {
            
            //
            self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%.0f",ceil([textField.text doubleValue]/self.selectcode)] doubleValue];
            if (ceil([textField.text intValue]/self.selectcode)<1&&textField.text.length!=0) {
                self.chooseCountView.currentCount =1.f;
            }
            return YES;
        }
        return NO;
    }
    
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end


@implementation CatgoryDetailCell3
-(NSMutableDictionary *)sourceDic
{
    if (!_sourceDic) {
        _sourceDic =[NSMutableDictionary dictionary];
    }
    return _sourceDic;
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CatgoryDetailCell";
    CatgoryDetailCell3 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CatgoryDetailCell" owner:nil options:nil] objectAtIndex:3];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.cancelBtn.layer.cornerRadius =4;
    cell.cancelBtn.layer.masksToBounds =4;
    cell.cancelBtn.layer.borderColor =RGBHex(0XE5E5E5).CGColor;
    cell.cancelBtn.layer.borderWidth =0.5;
    cell.shopCarBtn.layer.cornerRadius =4;
    cell.shopCarBtn.layer.masksToBounds =4;
    
    [cell.cancelBtn addTarget:cell action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.shopCarBtn addTarget:cell action:@selector(shopCarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)cancelBtnClick:(UIButton *)sender
{
    if (_cancelBlock) {
        _cancelBlock(sender.tag);
    }
}
-(void)shopCarBtnClick:(UIButton *)sender
{
    DRWeakSelf;
    if (_goodsModel.qty!=0) {
        if ([_shoucangStr isEqualToString:@"1"])
        {
            NSMutableDictionary *mudic =[NSMutableDictionary dictionaryWithObjects:@[self.goodsModel.sellerId,self.goodsModel.goods_id,self.goodsModel.storeId] forKeys:@[@"sellerId",@"id",@"storeId"]];
            [SNAPI getWithURL:@"mainPage/getSingleItem" parameters:mudic success:^(SNResult *result) {
//                _shoucangStr =@"";
                DRAddShopModel *addShopmodel =[DRAddShopModel mj_objectWithKeyValues:result.data];
                DRAddShopView *AddshopView = [[[NSBundle mainBundle]loadNibNamed:@"DRAddShopView" owner:self options:nil] lastObject];
                AddshopView.goodsModel =self.goodsModel;
                AddshopView.addshopModel =addShopmodel;
                AddshopView.frame =CGRectMake(0, 0, ScreenW, ScreenH);
                AddshopView.closeclickBlock = ^{
                    [AddshopView diss];
                };
                AddshopView.sureclickBlock = ^{
                    [AddshopView diss];
                    if (_shopCarBlock) {
                        _shopCarBlock(sender.tag);
                    }
                };
                [AddshopView show];
                AddshopView.itemListArr =weakSelf.itemListArr;
                
            } failure:^(NSError *error) {
                [MBProgressHUD showError:error.domain];
            }];
        }else
        {
            NSDictionary *dic =@{@"sourceType":@"wechat",@"payType":[NSString stringWithFormat:@"%@",self.goodsModel.payType]?:@"", @"serviceType":self.goodsModel.serviceType?:@"",@"userPrice":[NSString stringWithFormat:@"%f",self.goodsModel.userPrice]?:@"",@"id":self.goodsModel.goods_id?:@"",@"buyNum":[GoodsShareModel sharedManager].countNumStr?:@"",@"itemUnit":[GoodsShareModel sharedManager].selectcode?:@"",@"sellerId":self.goodsModel.sellerId?:@"",@"storeId":self.goodsModel.storeId?:@"",@"branchId":self.goodsModel.branchId?:@"",@"areaId":self.goodsModel.areaId?:@"",@"qty":[NSString stringWithFormat:@"%f",self.goodsModel.qty]?:@""};
            
            [SNAPI postWithURL:@"buyer/addCart" parameters:dic.mutableCopy success:^(SNResult *result) {
                if (result.state==200) {
                    NSLog(@"result=%@",result.data);
                    [MBProgressHUD showSuccess:result.data];
                    if (weakSelf.noticeBlock) {
                        weakSelf.noticeBlock(sender.tag);
                    }
                    //                            [MBProgressHUD showSuccess:result]
                    
                    //                                [self.tableView reloadData];
                }
            } failure:^(NSError *error) {
                [MBProgressHUD showError:error.domain];
            }];
            
        }
        
//        if (_shopCarBlock) {
//            _shopCarBlock(sender.tag);
//        }
    }else
    {
        if (self.daohuoTongzhiStr.length==0) {
            
            CustomAlertView *alertView = [[[NSBundle mainBundle] loadNibNamed:@"CustomAlertView" owner:self options:nil] lastObject];
            //                CustomAlertView *alertView =[[CustomAlertView alloc]initWithFrame:self.view.bounds];
            alertView.goodsModel =self.goodsModel;
            alertView.frame=self.superview.superview.bounds;
            alertView.closeclickBlock = ^{
                if (alertView) {
                    [alertView removeFromSuperview];
                }
            };
            alertView.sureclickBlock = ^{
                NSArray *hopeDayArr =@[@"5",@"15",@"30",@"60",];
                NSDictionary *dic =@{@"noticeMobile":alertView.phoneTF.text?:@"",@"hopeDay":hopeDayArr[alertView.selectBtnTag-1], @"qty":[alertView.sjchlLab.text substringWithRange:NSMakeRange(6, alertView.sjchlLab.text.length-6-self.goodsModel.basicUnitName.length)],@"itemId":self.goodsModel.goods_id,@"sellerId":self.goodsModel.sellerId,@"storeId":self.goodsModel.storeId,@"branchId":self.goodsModel.branchId,@"areaId":self.goodsModel.areaId};
                NSMutableDictionary *muDic =[NSMutableDictionary dictionaryWithObject:[SNTool convertToJsonData:dic] forKey:@"notice"];
                [SNAPI postWithURL:@"buyer/addArrivalNotice" parameters:muDic success:^(SNResult *result) {
                    if (result.state==200) {
                        NSLog(@"result=%@",result.data);
                        [MBProgressHUD showSuccess:result.data];
                        if (weakSelf.noticeBlock) {
                            weakSelf.noticeBlock(sender.tag);
                        }
                    }
                } failure:^(NSError *error) {
                    [MBProgressHUD showError:error.domain];
                }];
                if (alertView) {
                    [alertView removeFromSuperview];
                }
            };
            [self.superview.superview addSubview:alertView];
        }else
        {
            if (_goodsModel.qty==0) {
                UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"溫馨提示" message:@"您需要的货品还未到货呦！请耐心等待" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
                [al show];
            }
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)setGoodsModel:(GoodsModel *)goodsModel
{
    _goodsModel =goodsModel;
    NSLog(@"id =%@",goodsModel.favouriteId);
    if (goodsModel.favouriteId.length!=0) {
    }
    else
    {
        
    }
    if ([[NSString stringWithFormat:@"%.3f",_goodsModel.qty] isEqualToString:@"0.000"]) {
        self.shopCarBtn.selected =YES;
    }
    else
    {
       self.shopCarBtn.selected =NO;
    }
    self.priceAccountLab.text =[NSString stringWithFormat:@"单价：%.2f元/%@",goodsModel.userPrice,goodsModel.basicUnitName];
}
-(void)setDaohuoTongzhiStr:(NSString *)daohuoTongzhiStr
{
    _daohuoTongzhiStr =daohuoTongzhiStr;
    self.shopCarBtn.selected =NO;
    
    
}
//-(void)setSameModel:(DRSameModel *)sameModel
//{
//    _sameModel =sameModel;
//
//
//    _orderPriceLab.hidden =NO;
//    _lineView.hidden =NO;
//    self.priceAccountLab.text =[NSString stringWithFormat:@"单价：%.2f/%@",sameModel.userPrice,sameModel.basicUnitName];
//    self.orderPriceLab.text =[NSString stringWithFormat:@"%.2f/%@",sameModel.bidPrice,sameModel.basicUnitName];
//}
-(void)setShoucangStr:(NSString *)shoucangStr
{
    _shoucangStr =shoucangStr;
    
}
-(void)setTitleStr:(NSString *)titleStr
{
    _titleStr =titleStr;
    _orderPriceLab.hidden =NO;
    _lineView.hidden =NO;
    
}
@end


@implementation CatgoryDetailCell4
-(NSMutableDictionary *)sourceDic
{
    if (!_sourceDic) {
        _sourceDic =[NSMutableDictionary dictionary];
    }
    return _sourceDic;
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CatgoryDetailCell";
    CatgoryDetailCell4 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CatgoryDetailCell" owner:nil options:nil] objectAtIndex:4];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.shopCarBtn.layer.cornerRadius =4;
    cell.shopCarBtn.layer.masksToBounds =4;
    
      [cell.cancelBtn addTarget:cell action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.shopCarBtn addTarget:cell action:@selector(shopCarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)cancelBtnClick:(UIButton *)sender
{
    if (_cancelBlock) {
        _cancelBlock(sender.tag);
    }
}

-(void)shopCarBtnClick:(UIButton *)sender
{
        if (_shopCarBlock) {
            _shopCarBlock(sender.tag);
        }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setGoodsModel:(GoodsModel *)goodsModel
{
    _goodsModel =goodsModel;
    NSLog(@"id =%@",goodsModel.favouriteId);
    if (goodsModel.favouriteId.length!=0) {
    }
    else
    {
    }
    if (_goodsModel.qty==0) {
        self.shopCarBtn.selected =YES;
    }
    else
    {
       self.shopCarBtn.selected =NO;
    }
    self.priceAccountLab.text =[NSString stringWithFormat:@"单价：%.2f元/%@",goodsModel.userPrice,goodsModel.basicUnitName];
}
-(void)setDaohuoTongzhiStr:(NSString *)daohuoTongzhiStr
{
    _daohuoTongzhiStr =daohuoTongzhiStr;
    self.shopCarBtn.selected =NO;
    
    
}

-(void)setShoucangStr:(NSString *)shoucangStr
{
    _shoucangStr =shoucangStr;
    
}
-(void)setTitleStr:(NSString *)titleStr
{
    _titleStr =titleStr;
    _orderPriceLab.hidden =NO;
    _lineView.hidden =NO;
    
}
@end

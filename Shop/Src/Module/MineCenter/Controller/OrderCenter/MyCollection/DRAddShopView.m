//
//  DRAddShopView.m
//  Shop
//
//  Created by BWJ on 2019/4/11.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRAddShopView.h"
#import "CGXPickerView.h"
@implementation DRAddShopView
+ (DRAddShopView *)getDRAddShopView
{
    DRAddShopView *AddshopView = [[[NSBundle mainBundle]loadNibNamed:@"DRAddShopView" owner:self options:nil] firstObject];
//    AddshopView.frame =CGRectMake(0, 0, ScreenW, WScale(404));
    
    return AddshopView;
}
-(void)setUI
{
    self.itemListArr =[NSArray array];
    self.itemListArr =[ItemsModel mj_objectArrayWithKeyValuesArray:self.addshopModel.items];
    [DCSpeedy dc_chageControlCircularWith:self.selectBtn AndSetCornerRadius:4 SetBorderWidth:1 SetBorderColor:BACKGROUNDCOLOR canMasksToBounds:YES];
    [self.selectBtn layoutButtonWithEdgeInsetsStyle:LXButtonEdgeInsetsStyleRight imageTitleSpace:WScale(3)];
    [DCSpeedy dc_chageControlCircularWith:self.numberTF AndSetCornerRadius:4 SetBorderWidth:1 SetBorderColor:BACKGROUNDCOLOR canMasksToBounds:YES];
     [DCSpeedy dc_chageControlCircularWith:self.danweiTF AndSetCornerRadius:4 SetBorderWidth:1 SetBorderColor:BACKGROUNDCOLOR canMasksToBounds:YES];
    [self.danweiTF addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];//
    self.numberTF.baseNum =@"1";
    self.numberTF.minNum =1;
    _upScrollView = [[UIScrollView alloc]initWithFrame:self.bACKvIEW.bounds];
    _upScrollView.showsHorizontalScrollIndicator = NO;
    _upScrollView.contentSize = CGSizeMake(1.3*ScreenW, _upScrollView.frame.size.height);
    if (self.itemListArr.count<3) {
        
        _upScrollView.showsVerticalScrollIndicator = NO;
        _upScrollView.contentSize = CGSizeMake(ScreenW, _upScrollView.frame.size.height);
    }
    [self.bACKvIEW addSubview:_upScrollView];
   
    
    CGFloat btnW = WScale(135);
    
    for (NSInteger i = 0; i < self.itemListArr.count; i++) {
        ItemsModel *itemModel =self.itemListArr[i];
        UIView *titleView =[[UIView alloc]initWithFrame:CGRectMake(15*(i+1)+btnW*i, WScale(10), btnW,WScale(50))];
        [self.upScrollView addSubview:titleView];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        button.titleLabel.font = DR_FONT(12);
        button.titleLabel.numberOfLines = 0;
        NSString *titleStr;       
        if ([itemModel.serviceType isEqualToString:@"st"]) {
            titleStr =@"(三铁配送)";
        }
        else if ([itemModel.serviceType isEqualToString:@"wl"]) {
            titleStr =@"(物流配送)";
        }
        else if ([itemModel.serviceType isEqualToString:@"zf"]) {
            titleStr =@"(卖家直发)";
        }
        NSString *nameStr =[NSString stringWithFormat:@"%@%@",[itemModel.payType boolValue]?@"月结":@"现金",titleStr];
        
        NSString *bottomStr= [NSString stringWithFormat:@"￥%.3f/%@",itemModel.price,self.baseStr];
    
        [button setTitle:[NSString stringWithFormat:@"%@\n%@",nameStr,bottomStr] forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage imageNamed:@"normal_BACK"] forState:UIControlStateNormal];
        button.backgroundColor =REDCOLOR;
        button.layer.cornerRadius =6;
        button.layer.masksToBounds =6;
        [button setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.frame = titleView.bounds;
        button.tag =i+100;
        if (i==0) {
            [self buttonBtnClick:button];
        }
        [button addTarget:self action:@selector(buttonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
    }
    
}
-(void)buttonBtnClick:(UIButton *)sender
{
    self.currentSelectedBtn.selected = NO ;
    sender.selected = YES ;
    self.currentSelectedBtn = sender ;
    self.selectBtnTag =sender.tag;
    NSLog(@"点击 %ld",sender.tag) ;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self setUI];
}
-(void)setAddshopModel:(DRAddShopModel *)addshopModel
{
    _addshopModel =addshopModel;
    
    self.santieMoneyLab.text =[NSString stringWithFormat:@"三铁配送起订金额(元)：%.2f",addshopModel.stMoq];
    self.otherMoneyLab.text =[NSString stringWithFormat:@"卖家直发起订金额(元)：%.2f",addshopModel.zfMoq];
    
    
}
-(void)setGoodsModel:(GoodsModel *)goodsModel
{
    self.numberTF.delegate =self;
    self.numberTF.baseNum=@"1";
    self.numberTF.minNum =1;
    if ([goodsModel.deliveryDay intValue]==0) {        
        self.timeLab.text =@"预计发货时间：当天发货";
    }else if ([goodsModel.deliveryDay intValue]==1)
    {
        self.timeLab.text =@"预计发货时间：明天发货";
    }
    else if ([goodsModel.deliveryDay intValue]==2)
    {
        self.timeLab.text =@"预计发货时间：后天发货";
    }
    else
    {
        self.timeLab.text =[NSString stringWithFormat:@"预计发货时间(天)：%@",goodsModel.deliveryDay];
    }
    _goodsModel =goodsModel;
    //basicUnitId 5千支  6公斤  7吨
    if ([_goodsModel.basicUnitId intValue]==5) {
        self.baseStr =@"千支";
    }
    if ([_goodsModel.basicUnitId intValue]==6) {
        self.baseStr =@"公斤";
    }
    if ([_goodsModel.basicUnitId intValue]==7) {
        self.baseStr =@"吨";
    }
    self.danweiLab.text =self.baseStr;
    self.qtyLab.text =[NSString stringWithFormat:@"当前库存数(%@)：%.3f",self.baseStr,goodsModel.qty];
    self.selectNameArr =[NSMutableArray array];
    self.selectCodeArr=[NSMutableArray array];
    self.selectIDArr=[NSMutableArray array];
    NSString *nameStr;
    if (self.goodsModel.unitConversion1!=0) {
        nameStr =[NSString stringWithFormat:@"%.3f%@/%@",goodsModel.unitConversion1,_baseStr,goodsModel.unitName1];
        [self.selectNameArr addObject:self.goodsModel.unitName1];
        [self.selectCodeArr addObject:[NSString stringWithFormat:@"%.3f",self.goodsModel.unitConversion1]];
        [self.selectIDArr addObject:self.goodsModel.unit1];
        if (!self.selectcode) {
            self.selectcode =self.goodsModel.unitConversion1;
            self.selectName =self.goodsModel.unitName1;
            self.selectID =self.goodsModel.unit1;
            
        }
    }
    
    if (self.goodsModel.unitConversion2!=0) {
        
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",goodsModel.unitConversion2,_baseStr,goodsModel.unitName2];
        [self.selectNameArr addObject:self.goodsModel.unitName2];
        [self.selectCodeArr addObject:[NSString stringWithFormat:@"%.3f",self.goodsModel.unitConversion2]];
        [self.selectIDArr addObject:self.goodsModel.unit2];
        if (!self.selectcode) {
            
            self.selectcode =self.goodsModel.unitConversion2;
            self.selectName =self.goodsModel.unitName2;
            self.selectID =self.goodsModel.unit2;
        }
        
    }
    if (self.goodsModel.unitConversion3!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",goodsModel.unitConversion3,_baseStr,goodsModel.unitName3];
        [self.selectNameArr addObject:self.goodsModel.unitName3];
        [self.selectCodeArr addObject:[NSString stringWithFormat:@"%.3f",self.goodsModel.unitConversion3]];
        [self.selectIDArr addObject:self.goodsModel.unit3];
        if (!self.selectcode) {
            
            self.selectcode =self.goodsModel.unitConversion3;
            self.selectName =self.goodsModel.unitName3;
            self.selectID =self.goodsModel.unit3;
        }
        
    }
    if (self.goodsModel.unitConversion4!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",goodsModel.unitConversion4,_baseStr,goodsModel.unitName4];
        [self.selectNameArr addObject:self.goodsModel.unitName4];
        [self.selectCodeArr addObject:[NSString stringWithFormat:@"%.3f",self.goodsModel.unitConversion4]];
        [self.selectIDArr addObject:self.goodsModel.unit4];
        if (!self.selectcode) {
            
            self.selectcode =self.goodsModel.unitConversion4;
            self.selectName =self.goodsModel.unitName4;
            self.selectID =self.goodsModel.unit4;
        }
        
        
    }
    if (self.goodsModel.unitConversion5!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",goodsModel.unitConversion5,_baseStr,goodsModel.unitName5];
        [self.selectNameArr addObject:self.goodsModel.unitName5];
        [self.selectCodeArr addObject:[NSString stringWithFormat:@"%.3f",self.goodsModel.unitConversion5]];
        [self.selectIDArr addObject:self.goodsModel.unit5];
        if (!self.selectcode) {
            
            self.selectcode =self.goodsModel.unitConversion5;
            self.selectName =self.goodsModel.unitName5;
            self.selectID =self.goodsModel.unit5;
        }
    }
    self.BZCSlAB.text =[NSString stringWithFormat:@"包装参数：%@",nameStr];    
    [self.selectBtn setTitle:self.selectName forState:UIControlStateNormal];
    self.countNumStr = self.numberTF.baseNum ;
    self.danweiTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr intValue]*self.selectcode];
    self.sjchsLab.text =[NSString stringWithFormat:@"实际出货数（%@）：%.3f",self.baseStr,[self.danweiTF.text doubleValue]];
}
-(void)danweiBtnClick:(UIButton *)sender
{
    
}
- (void)resultNumber:(NSString *)number{
    //    self.numberCalculate =number;
    self.countNumStr =number;
    self.danweiTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr intValue]*self.selectcode];
    self.sjchsLab.text =[NSString stringWithFormat:@"实际出货数（%@）：%.3f",self.baseStr,[self.danweiTF.text doubleValue]];
    
    self.numberTF.baseNum =[NSString stringWithFormat:@"%.0f",ceil([self.danweiTF.text doubleValue]/self.selectcode)];
    NSLog(@"%@>>>resultDelegate>>",number);
    if ([self.danweiTF.text doubleValue]>=self.goodsModel.qty) {
        self.danweiTF.text =[NSString stringWithFormat:@"%f",self.goodsModel.qty];
        self.sjchsLab.text =[NSString stringWithFormat:@"实际出货数（%@）：%.3f",self.baseStr,[self.danweiTF.text doubleValue]];
        self.numberTF.baseNum =[NSString stringWithFormat:@"%.0f",ceil(self.goodsModel.qty/self.selectcode)];
        self.countNumStr =self.numberTF.baseNum;
    }
    
}
-(void)textChange:(UITextField *)textField
{
    if (textField.text.length>11) {
        self.danweiTF.text = [self.danweiTF.text substringToIndex:11];
    }
    
    self.numberTF.baseNum =[NSString stringWithFormat:@"%.0f",ceil([textField.text intValue]/self.selectcode)];
    if (ceil([textField.text intValue]/self.selectcode)<1&&textField.text.length!=0) {
        self.numberTF.baseNum =@"1";
    }
    self.sjchsLab.text =[NSString stringWithFormat:@"实际出货数（%@）：%.3f",self.baseStr,[textField.text floatValue]];
    NSLog(@"baseNum=%@quzheng%lf text==%d",self.numberTF.baseNum,ceil([textField.text intValue]/self.selectcode),[textField.text intValue]);
        if ([textField.text doubleValue]>=_goodsModel.qty) {
            self.danweiTF.text =[NSString stringWithFormat:@"%f",self.goodsModel.qty];
            self.sjchsLab.text =[NSString stringWithFormat:@"实际出货数（%@）：%.3f",self.baseStr,_goodsModel.qty];
            self.numberTF.baseNum =[NSString stringWithFormat:@"%.0f",ceil(_goodsModel.qty/self.selectcode)];
            self.countNumStr =self.numberTF.baseNum;
        }
}
-(BOOL)judgeStr:(NSString *)str1 with:(NSString *)str2
{
    int a=[str1 intValue];
    double s1=[str2 doubleValue];
    int s2=[str2 intValue];
    if (s1/a-s2/a>0) {
        return NO;
    }
    return YES;
}
- (IBAction)selectBtnClick:(id)sender {
    [CGXPickerView showStringPickerWithTitle:@"单位" DataSource:self.selectNameArr DefaultSelValue:@"袋" IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
        self.selectcode =[[self.selectCodeArr objectAtIndex:[selectRow intValue]] doubleValue];
         self.selectID =[self.selectIDArr objectAtIndex:[selectRow intValue]];
        [self.selectBtn setTitle:selectValue forState:UIControlStateNormal];
        NSLog(@"%@",selectValue);        
        if (self.countNumStr.length!=0&&self.danweiTF.text.length!=0) {
            self.danweiTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr intValue]*self.selectcode];
            self.sjchsLab.text =[NSString stringWithFormat:@"实际出货数（%@）：%.3f",self.baseStr,[self.countNumStr intValue]*self.selectcode];
            
            self.numberTF.baseNum =[NSString stringWithFormat:@"%.0f",ceil([self.danweiTF.text doubleValue]/self.selectcode)];
            
            if ([self.danweiTF.text doubleValue]>=self.goodsModel.qty) {
                self.danweiTF.text =[NSString stringWithFormat:@"%f",self.goodsModel.qty];
                self.numberTF.baseNum =[NSString stringWithFormat:@"%.0f",ceil(self.goodsModel.qty/self.selectcode)];
                self.countNumStr =self.numberTF.baseNum;
            }
        }
        
    }];
}

- (IBAction)closeBtnClick:(id)sender {
    !_closeclickBlock?:_closeclickBlock();
}
- (IBAction)sureBtn:(id)sender {
 ItemsModel *itemModel =self.itemListArr[self.selectBtnTag-100];
    NSMutableDictionary *muDic =[NSMutableDictionary dictionaryWithObjects:@[@"Wechat",itemModel.payType?:@"",itemModel.serviceType?:@"",[NSString stringWithFormat:@"%.2f",itemModel.price]?:@"",self.goodsModel.goods_id,self.countNumStr?:@"",self.selectID?:@"",self.goodsModel.sellerId,self.goodsModel.storeId,self.goodsModel.branchId,self.goodsModel.areaId,[NSString stringWithFormat:@"%f",self.goodsModel.qty]?:@""] forKeys:@[@"sourceType",@"payType",@"serviceType",@"userPrice",@"id",@"buyNum",@"itemUnit",@"sellerId",@"storeId",@"branchId",@"areaId",@"qty"]];
    [SNAPI postWithURL:@"buyer/addCart" parameters:muDic success:^(SNResult *result) {
        if (result.state==200) {
            NSLog(@"result=%@",result.data);
            [MBProgressHUD showSuccess:result.data[@"msg"]];
              !_sureclickBlock?:_sureclickBlock();
            //                            [MBProgressHUD showSuccess:result]
            
            //                                [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:error.domain];
    }];
  
}
-(void)show
{
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self];
}
-(void)diss
{
    [self removeFromSuperview];
}
@end

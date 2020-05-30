//
//  CustomAlertView.m
//  Shop
//
//  Created by BWJ on 2019/4/9.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "CustomAlertView.h"
#import "CGXPickerView.h"
@interface CustomAlertView ()<NumberCalculateDelegate>
@property (nonatomic,strong)NSMutableArray *selectNameArr,*selectCodeArr,*selectIDArr;

@end
@implementation CustomAlertView



-(void)setUI
{
    [DCSpeedy dc_chageControlCircularWith:self.phoneTF AndSetCornerRadius:4 SetBorderWidth:1 SetBorderColor:BACKGROUNDCOLOR canMasksToBounds:YES];
     [DCSpeedy dc_chageControlCircularWith:self.numbeiTF AndSetCornerRadius:4 SetBorderWidth:1 SetBorderColor:BACKGROUNDCOLOR canMasksToBounds:YES];
     [DCSpeedy dc_chageControlCircularWith:self.canshuBtn AndSetCornerRadius:4 SetBorderWidth:1 SetBorderColor:BACKGROUNDCOLOR canMasksToBounds:YES];
     [DCSpeedy dc_chageControlCircularWith:self.danweiTF AndSetCornerRadius:4 SetBorderWidth:1 SetBorderColor:BACKGROUNDCOLOR canMasksToBounds:YES];
    [self.canshuBtn layoutButtonWithEdgeInsetsStyle:LXButtonEdgeInsetsStyleRight imageTitleSpace:WScale(2)];
    self.phoneTF.layer.borderColor =BACKGROUNDCOLOR.CGColor;
    self.phoneTF.layer.borderWidth =1;
//    if (self.fiveBtn.tag==1) {
//        [self buttonBtnClick:self.fiveBtn];
//    }
//    [self.fiveBtn addTarget:self action:@selector(buttonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//     [self.fifthBtn addTarget:self action:@selector(buttonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//     [self.thirtyBtn addTarget:self action:@selector(buttonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//     [self.fiveBtn addTarget:self action:@selector(buttonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
   
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
     [self setUI];
}
-(void)setGoodsModel:(GoodsModel *)goodsModel
{
    self.numbeiTF.delegate =self;
    self.numbeiTF.baseNum=@"1";
    self.numbeiTF.minNum =1;
 
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
    self.selectNameArr =[NSMutableArray array];
    self.selectCodeArr=[NSMutableArray array];
     NSString *nameStr;
    if (self.goodsModel.unitConversion1!=0) {
        nameStr =[NSString stringWithFormat:@"%.3ld%@/%@",(long)goodsModel.unitConversion1,_baseStr,goodsModel.unitName1];
        [self.selectNameArr addObject:self.goodsModel.unitName1];
        [self.selectCodeArr addObject:[NSString stringWithFormat:@"%ld",(long)self.goodsModel.unitConversion1]];
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
        [self.selectCodeArr addObject:[NSString stringWithFormat:@"%ld",(long)self.goodsModel.unitConversion2]];
        [self.selectIDArr addObject:self.goodsModel.unit2];
        if (!self.selectcode) {
            
            self.selectcode =self.goodsModel.unitConversion2;
            self.selectName =self.goodsModel.unitName2;
            self.selectID =self.goodsModel.unit2;
        }
        
    }
    if (self.goodsModel.unitConversion3!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3ld%@/%@",nameStr?:@"",(long)goodsModel.unitConversion3,_baseStr,goodsModel.unitName3];
        [self.selectNameArr addObject:self.goodsModel.unitName3];
        [self.selectCodeArr addObject:[NSString stringWithFormat:@"%ld",(long)self.goodsModel.unitConversion3]];
        [self.selectIDArr addObject:self.goodsModel.unit3];
        if (!self.selectcode) {
            
            self.selectcode =self.goodsModel.unitConversion3;
            self.selectName =self.goodsModel.unitName3;
            self.selectID =self.goodsModel.unit3;
        }
        
    }
    if (self.goodsModel.unitConversion4!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3ld%@/%@",nameStr?:@"",(long)goodsModel.unitConversion4,_baseStr,goodsModel.unitName4];
        [self.selectNameArr addObject:self.goodsModel.unitName4];
        [self.selectCodeArr addObject:[NSString stringWithFormat:@"%ld",(long)self.goodsModel.unitConversion4]];
        [self.selectIDArr addObject:self.goodsModel.unit4];
        if (!self.selectcode) {
            
            self.selectcode =self.goodsModel.unitConversion4;
            self.selectName =self.goodsModel.unitName4;
            self.selectID =self.goodsModel.unit4;
        }
        
        
    }
    if (self.goodsModel.unitConversion5!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3ld%@/%@",nameStr?:@"",(long)goodsModel.unitConversion5,_baseStr,goodsModel.unitName5];
        [self.selectNameArr addObject:self.goodsModel.unitName5];
        [self.selectCodeArr addObject:[NSString stringWithFormat:@"%ld",(long)self.goodsModel.unitConversion5]];
        [self.selectIDArr addObject:self.goodsModel.unit5];
        if (!self.selectcode) {
            
            self.selectcode =self.goodsModel.unitConversion5;
            self.selectName =self.goodsModel.unitName5;
            self.selectID =self.goodsModel.unit5;
        }
    }
   
    NSInteger selectrow = 0;
    for (int i=0; i<self.selectNameArr.count; i++) {
        if ([self.goodsModel.saleUnitName isEqualToString:self.selectNameArr[i]]) {
            selectrow =i;
        }
    }
//    [self.selectCodeArr insertObject:self.selectCodeArr atIndex:selectrow];
//    [self.selectNameArr insertObject:self.selectNameArr atIndex:selectrow];
//    [self.selectIDArr insertObject:self.selectCodeArr atIndex:selectrow];
    self.selectCodeArr =[self.selectCodeArr subarrayWithRange:NSMakeRange(selectrow, self.selectCodeArr.count-selectrow)].mutableCopy;
    self.selectNameArr =[self.selectNameArr subarrayWithRange:NSMakeRange(selectrow, self.selectNameArr.count-selectrow)].mutableCopy;
    self.selectIDArr =[self.selectIDArr subarrayWithRange:NSMakeRange(selectrow, self.selectIDArr.count-selectrow)].mutableCopy;
    self.selectName =[self.selectNameArr firstObject];
    self.bzcsLab.text =[NSString stringWithFormat:@"包装参数：%@",nameStr];
    [self.canshuBtn setTitle:self.selectName forState:UIControlStateNormal];
    self.countNumStr = self.numbeiTF.baseNum;
    
    self.sjchlLab.text =[NSString stringWithFormat:@"实际出货数：%.3f%@",[self.countNumStr intValue]*self.selectcode,self.baseStr];
     self.sjfhLab.text =[NSString stringWithFormat:@"实际发货数：%.3f%@",[self.countNumStr floatValue],self.selectName];
  
    self.danweiTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr intValue]*self.selectcode];
}





-(void)danweiBtnClick:(UIButton *)sender
{
   
}

- (void)resultNumber:(NSString *)number{
    //    self.numberCalculate =number;
    self.countNumStr =number;
    self.danweiTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr intValue]*self.selectcode];
    self.sjchlLab.text =[NSString stringWithFormat:@"实际出货数：%.3f%@",[self.countNumStr intValue]*self.selectcode,self.baseStr];
   self.sjfhLab.text =[NSString stringWithFormat:@"实际发货数：%.3f%@",[self.countNumStr floatValue],self.selectName];
    
    NSLog(@"%@>>>resultDelegate>>",number);
    if ([self.danweiTF.text doubleValue]>= self.goodsModel.qty) {
        self.danweiTF.text =[NSString stringWithFormat:@"%f",self.goodsModel.qty];
        self.numbeiTF.baseNum =[NSString stringWithFormat:@"%.0f",ceil(self.goodsModel.qty/self.selectcode)];
        self.countNumStr =self.numbeiTF.baseNum;
    }
    
}
-(void)textChange:(UITextField *)textField
{
    if (textField.text.length>11) {
//        self.danweiTF.text = [self.danweiTF.text substringToIndex:11];
    }
    
    self.numbeiTF.baseNum =[NSString stringWithFormat:@"%.0f",ceil([textField.text intValue]/self.selectcode)];
    if (ceil([textField.text intValue]/self.selectcode)<1&&textField.text.length!=0) {
        self.numbeiTF.baseNum =@"1";
    }
    
    NSLog(@"baseNum=%@quzheng%lf text==%d",self.numbeiTF.baseNum,ceil([textField.text intValue]/self.selectcode),[textField.text intValue]);
    if ([textField.text doubleValue]>=_goodsModel.qty) {
        self.danweiTF.text =[NSString stringWithFormat:@"%f",self.goodsModel.qty];
        self.numbeiTF.baseNum =[NSString stringWithFormat:@"%.0f",ceil(_goodsModel.qty/self.selectcode)];
        self.countNumStr =self.numbeiTF.baseNum;
    }
    self.sjchlLab.text =[NSString stringWithFormat:@"实际出货数（%@）：%.3f",self.baseStr,[textField.text floatValue]];
    self.sjfhLab.text =[NSString stringWithFormat:@"实际发货数：%.3f%@",[self.countNumStr floatValue],self.selectName];
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

- (IBAction)timeBtnClick:(id )sender {
    UIButton *button =(UIButton *)sender ;
    self.currentSelectedBtn.selected = NO ;
    button.selected = YES ;
    self.currentSelectedBtn = button ;
    
    NSLog(@"点击 %ld",button.tag) ;
    self.selectBtnTag =button.tag;
}
- (IBAction)selectBtnClick:(id)sender {
    [CGXPickerView showStringPickerWithTitle:@"单位" DataSource:self.selectNameArr DefaultSelValue:@"袋" IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
        self.selectcode =[[self.selectCodeArr objectAtIndex:[selectRow intValue]] doubleValue];
        self.selectName =[self.selectNameArr objectAtIndex:[selectRow intValue]];
        self.selectID =[self.selectIDArr objectAtIndex:[selectRow intValue]];
        [self.canshuBtn setTitle:selectValue forState:UIControlStateNormal];
        NSLog(@"%@",selectValue);
       
        if (self.countNumStr.length!=0) {
           
             self.sjchlLab.text =[NSString stringWithFormat:@"实际出货数：%.3f%@",[self.countNumStr intValue]*self.selectcode,self.baseStr];
            self.sjfhLab.text =[NSString stringWithFormat:@"实际发货数：%.3f%@",[self.countNumStr floatValue],self.selectName];
           
            self.numbeiTF.baseNum =[NSString stringWithFormat:@"%.0f",ceil([self.danweiTF.text doubleValue]/self.selectcode)];
            
            if ([self.danweiTF.text doubleValue]>=self.goodsModel.qty) {
                self.danweiTF.text =[NSString stringWithFormat:@"%f",self.goodsModel.qty];
                self.numbeiTF.baseNum =[NSString stringWithFormat:@"%.0f",ceil(self.goodsModel.qty/self.selectcode)];
                self.countNumStr =self.numbeiTF.baseNum;
            }
        }
        
    }];
}

- (IBAction)closeBtnClick:(id)sender {
    !_closeclickBlock?:_closeclickBlock();
}
- (IBAction)sureBtn:(id)sender {
    if (self.selectBtnTag==0) {
        [MBProgressHUD showError:@"请选择期望到货时间"];
        return;
    }
    !_sureclickBlock?:_sureclickBlock();
}

@end

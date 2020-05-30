//
//  FirstTableViewCell.m
//  Save
//
//  Created by 解辉 on 2019/2/25.
//  Copyright © 2019年 FM. All rights reserved.
//

#import "FourthCell.h"
#import "Masonry.h"
#import "NSString+Extension.h"



#define ZF_FONT(__fontsize__) [UIFont systemFontOfSize:WScale(__fontsize__)]
@implementation FourthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
//-(void)setDataDict:(NSDictionary *)dataDict
//{
//    self.productImg.image = [UIImage imageNamed:@"product"];
//    self.productName.text = @"哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
//    
//    NSArray * array = @[@"M1.6-0.35*2",@"12.9级",@"35CrMo(合金钢)",@"淬黑",@"哈哈",@"紧固之星"];
//    Height = WScale(30);
//    [self setStandWithArray:array];
//    
//    self.parameterLabel.text = @"包装参数：哈哈哈哈哈 哈哈哈哈哈 或或或或或或或或 哈哈哈";
//    self.cellLabel.text = @"最小销售单位：哈哈哈哈哈 哈哈哈哈哈 或或或或或或或或 哈哈哈";
//    self.countLabel.text = @"库存数：72.0000支 华东仓";
//    self.number.baseNum = @"2";
//    self.danweiLab.text =@"千支";
//    self.allCountLabel.text =@"小计:0.00";
//    [self.saleOutBtn setTitle:@"申请售后" forState:UIControlStateNormal];
//}
-(void)setSelectRow:(NSInteger)selectRow
{
    _selectRow =selectRow;
}
-(void)setGoodModel:(GoodModel *)goodModel
{
    _goodModel =goodModel;
    self.chooseCountView.canEdit =NO;
//    _chooseCountView.currentCount =3;
//    _chooseCountView.minCount =3;
//    _chooseCountView.maxCount =10;
//    _chooseCountView.multipleNum =0.001;
//    [[NSString stringWithFormat:@"%.3f",goodModel.saleUnitConversion] doubleValue]*1000%[[NSString stringWithFormat:@"%.3f",goodModel.canReturnQty] doubleValue]*1000
//    if ( [[NSString stringWithFormat:@"%.0f",goodModel.saleUnitConversion*1000] intValue]%[[NSString stringWithFormat:@"%.0f",goodModel.canReturnQty*1000] intValue]==0) {
    if (goodModel.saleUnitConversion>goodModel.canReturnQty)
    {
        if (_numStr) {
            self.chooseCountView.currentCount= [_numStr doubleValue];
        }
        else
        {
            self.chooseCountView.currentCount=[[NSString stringWithFormat:@"%.3f",goodModel.canReturnQty] doubleValue];
        }
        self.chooseCountView.multipleNum=goodModel.saleUnitConversion;
        self.chooseCountView.minCount=goodModel.saleUnitConversion;
        self.chooseCountView.maxCount =[[NSString stringWithFormat:@"%.3f",goodModel.canReturnQty] doubleValue];
    }else
    {
        if (_numStr) {
            self.chooseCountView.currentCount= [_numStr doubleValue];
        }
        else
        {
            self.chooseCountView.currentCount=goodModel.canReturnQty;
        }
        self.chooseCountView.multipleNum=goodModel.saleUnitConversion;
//        self.chooseCountView.minCount =[[NSString stringWithFormat:@"%.3f",goodModel.canReturnQty] doubleValue];
        self.chooseCountView.maxCount =[[NSString stringWithFormat:@"%.3f",goodModel.canReturnQty] doubleValue];
    }

    NSString *urlStr;
    if (goodModel.imgUrl.length!=0) {
        urlStr =goodModel.imgUrl;
    }
    if (goodModel.imgUrl.length!=0) {
        urlStr =goodModel.imgUrl;
    }
    
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
    
    self.productType.text =goodModel.brandName?:@"";
    CGSize maximumLabelSize = CGSizeMake(100, 100);//labelsize的最大值
    //关键语句
    CGSize expectSize = [self.productType sizeThatFits:maximumLabelSize];
    [self.productType mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(expectSize.width+WScale(13));
    }];
    self.productName.text =goodModel.itemName;
    NSArray * array = @[goodModel.spec?:@"",goodModel.levelName?:@"",goodModel.materialName?:@"",goodModel.surfaceName?:@""];
    NSMutableArray *titArr =[NSMutableArray array];
    for (NSString *str in array) {
        if (str.length!=0) {
            [titArr addObject:str];
        }
    }
    Height = WScale(30);
    [self setStandWithArray:titArr];
    NSString *baseStr;//basicUnitId 5千支  6公斤  7吨
    if ([goodModel.basicUnitId intValue]==5) {
        baseStr =@"千支";
    }
    if ([goodModel.basicUnitId intValue]==6) {
        baseStr =@"公斤";
    }
    if ([goodModel.basicUnitId intValue]==7) {
        baseStr =@"吨";
    }
    self.danweiLab.text =baseStr;
    
    NSString *nameStr,*cellStr;
    if (goodModel.unitConversion1.length!=0&&![goodModel.unitConversion1 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%.3f%@/%@",[goodModel.unitConversion1 doubleValue],baseStr,goodModel.unitName1];
        cellStr =goodModel.unitName1;
    }
    if (goodModel.unitConversion2.length!=0&&![goodModel.unitConversion2 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodModel.unitConversion2 doubleValue],baseStr,goodModel.unitName2];
        if (cellStr.length==0) {
            cellStr =goodModel.unitName2;
        }
    }
    if (goodModel.unitConversion3.length!=0&&![goodModel.unitConversion3 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodModel.unitConversion3 doubleValue],baseStr,goodModel.unitName3];
        if (cellStr.length==0) {
            cellStr =goodModel.unitName3;
        }
    }
    
    if (goodModel.unitConversion4.length!=0&&![goodModel.unitConversion4 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodModel.unitConversion4 doubleValue],baseStr,goodModel.unitName4];
        if (cellStr.length==0) {
            cellStr =goodModel.unitName4;
        }
    }
    
    if (goodModel.unitConversion5.length!=0&&![goodModel.unitConversion5 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodModel.unitConversion5 doubleValue],baseStr,goodModel.unitName5];
        if (cellStr.length==0) {
            cellStr =goodModel.unitName5;
        }
    }
    self.parameterLabel.text =[NSString stringWithFormat:@"包装参数：%@",nameStr];
    self.cellLabel.text =[NSString stringWithFormat:@"订单数量(%@)：%.3f  已退数量：%.3f",baseStr,goodModel.qty,goodModel.returnQty];
    self.countLabel.text = [NSString stringWithFormat:@"单价：￥%.2f  销售单位：%@",goodModel.realPrice,goodModel.saleUnitName];
//    self.countLabel.textColor =REDCOLOR;
    self.allCountLabel.text =[NSString stringWithFormat:@"小计：￥%.3f",goodModel.realPrice*goodModel.canReturnQty];
//    [SNTool setTextColor:self.cellLabel FontNumber:DR_FONT(12) AndRange:NSMakeRange(0, [NSString stringWithFormat:@"%.3f",goodModel.qty].length) AndColor:REDCOLOR];
    [SNTool setTextColor:self.countLabel FontNumber:DR_FONT(12) AndRange:NSMakeRange(3, [NSString stringWithFormat:@"%.2f",goodModel.realPrice].length+1) AndColor:REDCOLOR];
}
- (void)resultNumber:(NSString *)number
{
    _numStr =number;
    _goodModel.numModelStr =_numStr;
    if ([_numStr doubleValue]>_goodModel.canReturnQty) {
        self.chooseCountView.currentCount=_goodModel.canReturnQty;
    }
    if (_numberBlock) {
        _numberBlock(_goodModel.numModelStr,_selectRow);
    }
      self.allCountLabel.text =[NSString stringWithFormat:@"小计：￥%.3f",_goodModel.realPrice*[_numStr doubleValue]];
}
-(UIImageView *)productImg
{
    if (!_productImg) {
        _productImg = [[UIImageView alloc] init];
        _productImg.backgroundColor =WHITECOLOR;
        _productImg.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_productImg];
        [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(10));
            make.top.mas_equalTo(WScale(12));
            make.height.mas_equalTo(WScale(90));
            make.width.mas_equalTo(WScale(90));
        }];
    }
    return _productImg;
}

-(UILabel *)productType
{
    if (!_productType) {
        _productType = [[UILabel alloc] init];
        _productType.backgroundColor =RGBHex(0XFD8A30);
        _productType.textColor = WHITECOLOR;
        _productType.textAlignment =1;
        _productType.layer.cornerRadius =2.0;
         _productType.layer.masksToBounds =YES;
        _productType.font = DR_FONT(10);
        [self addSubview:_productType];
        [_productType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productImg.mas_right).offset(WScale(10));
            make.top.mas_equalTo(WScale(12));
            make.height.mas_equalTo(WScale(17));
        }];
        
    }
    return _productType;
}

-(UILabel *)productName
{
    if (!_productName) {
        _productName = [[UILabel alloc] init];
        _productName.textColor = BLACKCOLOR;
        _productName.font = DR_FONT(14);
        [self addSubview:_productName];
        [_productName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productType.mas_right).offset(WScale(5));
            make.top.mas_equalTo(self.productImg);
            make.right.mas_equalTo(WScale(-10));
            make.height.mas_equalTo(WScale(17));
        }];
    }
    return _productName;
}


-(UIView *)standardView
{
    if (!_standardView) {
        _standardView = [[UIView alloc] init];
        [self addSubview:_standardView];
        [_standardView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productType);
            make.top.mas_equalTo(self.productName.mas_bottom).offset(WScale(5));
            make.right.mas_equalTo(WScale(-10));
            make.height.mas_equalTo(Height);
        }];
    }
    return _standardView;
}
-(void)setStandWithArray:(NSArray *)array
{
    [self.standardView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat tagBtnX = 0;
    CGFloat tagBtnY = 0;
    for (int i = 0; i<array.count; i++) {
        CGSize tagTextSize = [array[i] sizeWithFont:ZF_FONT(12) maxSize:CGSizeMake(WScale(280),WScale(12))];
        if (tagBtnX+tagTextSize.width+HScale(12) >WScale(250)) {
            
            tagBtnX = 0;
            tagBtnY += WScale(12)+WScale(5);
        }
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(tagBtnX, tagBtnY, tagTextSize.width+WScale(5),WScale(12));
        label.text = array[i];
        label.textColor = BLACKCOLOR;
        label.font = DR_FONT(12);
        label.textAlignment = 0;
//        label.layer.cornerRadius = 2;
        label.layer.masksToBounds = YES;
//        label.backgroundColor = BACKGROUNDCOLOR;
        [self.standardView addSubview:label];
        tagBtnX = CGRectGetMaxX(label.frame)+WScale(5);
    }
    Height = tagBtnY +WScale(12);
    [self.standardView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(Height);
    }];
    
}
-(UILabel *)parameterLabel
{
    if (!_parameterLabel) {
        _parameterLabel = [[UILabel alloc] init];
        _parameterLabel.textColor = RGBHex(0X888888);
        _parameterLabel.font = DR_FONT(11);
        _parameterLabel.numberOfLines = 0;
        [self addSubview:_parameterLabel];
        [_parameterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.standardView.mas_bottom).offset(WScale(5));
            make.left.mas_equalTo(self.productType);
            make.right.mas_equalTo(WScale(-10));
        }];
    }
    return _parameterLabel;
}

-(UILabel *)cellLabel
{
    if (!_cellLabel) {
        _cellLabel = [[UILabel alloc] init];
        _cellLabel.textColor = BLACKCOLOR;
        _cellLabel.font = DR_FONT(12);
        _cellLabel.numberOfLines = 0;
        [self addSubview:_cellLabel];
        [_cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productType);
            make.top.mas_equalTo(self.parameterLabel.mas_bottom).mas_equalTo(WScale(11));
            make.right.mas_equalTo(WScale(-5));
        }];
    }
    return _cellLabel;
}
-(UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textColor = BLACKCOLOR;
        _countLabel.font = ZF_FONT(12);
        _countLabel.numberOfLines = 0;
        [self addSubview:_countLabel];
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productType);
            make.top.mas_equalTo(self.cellLabel.mas_bottom).mas_equalTo(WScale(10));
            make.right.mas_equalTo(WScale(-5));
//            make.bottom.mas_equalTo(WScale(-10));
        }];
    }
    return _countLabel;
}

-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor =LINECOLOR;
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(10));
            make.top.mas_equalTo(self.countLabel.mas_bottom).offset(WScale(12));
            make.right.mas_equalTo(WScale(-10));
            make.height.mas_equalTo(WScale(1));
        }];
    }
    return _lineView;
}


-(UILabel *)allCountLabel
{
    if (!_allCountLabel) {
        _allCountLabel = [[UILabel alloc] init];
        _allCountLabel.textColor = REDCOLOR;
        _allCountLabel.font = ZF_FONT(12);
        //        _allCountLabel.numberOfLines = 0;
        [self addSubview:_allCountLabel];
        [_allCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(WScale(10));
            make.top.mas_equalTo(self.lineView.mas_bottom).mas_equalTo(WScale(14));
            make.width.mas_offset(200);
            make.height.mas_offset(WScale(17));
            make.bottom.mas_equalTo(WScale(-14));
        }];
    }
    return _allCountLabel;
}

-(UILabel *)danweiLab
{
    if (!_danweiLab) {
        _danweiLab = [[UILabel alloc] init];
        _danweiLab.textColor = BLACKCOLOR;
        _danweiLab.font = ZF_FONT(12);
        _danweiLab.textAlignment =2;
        //        _allCountLabel.numberOfLines = 0;
        [self addSubview:_danweiLab];
        [_danweiLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-WScale(10));
            make.top.mas_equalTo(self.lineView.mas_bottom).mas_equalTo(WScale(16));
            make.width.mas_offset(WScale(25));
            make.height.mas_offset(WScale(13));
        }];
    }
    return _danweiLab;
}

-(ATChooseCountView *)chooseCountView
{
    if (!_chooseCountView) {
        _chooseCountView = [[ATChooseCountView alloc] init];
        _chooseCountView.delegate =self;
        _chooseCountView.countColor = BLACKCOLOR;
        
        _chooseCountView.canEdit = YES;
        [self addSubview:_chooseCountView];
        [_chooseCountView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.lineView.mas_bottom).offset(WScale(10));
            make.width.mas_offset(WScale(100));
            make.height.mas_offset(WScale(25));
            make.right.mas_equalTo(self.danweiLab.mas_left).offset(-WScale(5));
        }];
    }
    return _chooseCountView;
}


-(UIButton *)saleOutBtn
{
    if (!_saleOutBtn) {
        _saleOutBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_saleOutBtn];
        _saleOutBtn.layer.cornerRadius =10;
        _saleOutBtn.layer.masksToBounds =10;
        //        [_saleOutBtn setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
        _saleOutBtn.backgroundColor =REDCOLOR;
        [_saleOutBtn setTitle:@"申请售后" forState:UIControlStateNormal];
        [_saleOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _saleOutBtn.titleLabel.font =DR_FONT(14);
        [_saleOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.allCountLabel.mas_top);
            make.right.mas_equalTo(-15);
            make.height.mas_offset(HScale(20));
            make.width.mas_offset(WScale(80));
            //            make.bottom.mas_equalTo(WScale(-10));
        }];
        
    }
    return _saleOutBtn;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(BOOL)judgeStr:(NSString *)str1 with:(NSString *)str2

{
    
    double a=[str1 doubleValue];
    
    double s1=[str2 doubleValue];
    
    double s2=[str2 doubleValue];
    
    
    
    if (s1/a-s2/a>0) {
        
        return NO;
        
    }
    
    return YES;
    
}

@end

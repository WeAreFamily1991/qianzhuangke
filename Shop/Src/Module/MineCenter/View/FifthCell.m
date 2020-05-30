//
//  FirstTableViewCell.m
//  Save
//
//  Created by 解辉 on 2019/2/25.
//  Copyright © 2019年 FM. All rights reserved.
//

#import "FifthCell.h"
#import "Masonry.h"
#import "NSString+Extension.h"



#define ZF_FONT(__fontsize__) [UIFont systemFontOfSize:WScale(__fontsize__)]
@implementation FifthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setGoodModel:(AfterSellList *)goodModel
{
    _goodModel =goodModel;
   
   
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:goodModel.imgUrl] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
    self.productName.text =goodModel.itemName;
    NSArray * array = @[goodModel.spec?:@"",goodModel.levelName?:@"",goodModel.materialName?:@"",goodModel.surfaceName?:@"",goodModel.brandName?:@""];
    NSMutableArray *titArr =[NSMutableArray array];
    for (NSString *str in array) {
        if (str.length!=0) {
            [titArr addObject:str];
        }
    }
    Height = WScale(30);
    [self setStandWithArray:titArr];
    NSString *baseStr;//basicUnitId 5千支  6公斤  7吨
    baseStr =goodModel.basicUnitName;
    NSString *nameStr,*cellStr;
    if (goodModel.unitConversion1!=0) {
        nameStr =[NSString stringWithFormat:@"%.3ld%@/%@",(long)goodModel.unitConversion1,baseStr,goodModel.unitName1];
        cellStr =goodModel.unitName1;
    }
    if (goodModel.unitConversion2!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3ld%@/%@",nameStr?:@"",(long)goodModel.unitConversion2,baseStr,goodModel.unitName2];
        if (cellStr.length==0) {
            cellStr =goodModel.unitName2;
            
        }
    }
    if (goodModel.unitConversion3!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3ld%@/%@",nameStr?:@"",(long)goodModel.unitConversion3,baseStr,goodModel.unitName1];
        if (cellStr.length==0) {
            cellStr =goodModel.unitName3;
            
        }
    }
    if (goodModel.unitConversion4!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3ld%@/%@",nameStr?:@"",(long)goodModel.unitConversion4,baseStr,goodModel.unitName4];
        if (cellStr.length==0) {
            cellStr =goodModel.unitName4;
            
        }
    }
    if (goodModel.unitConversion5!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3ld%@/%@",nameStr?:@"",(long)goodModel.unitConversion5,baseStr,goodModel.unitName5];
        if (cellStr.length==0) {
            cellStr =goodModel.unitName5;
            
        }
    }
    self.parameterLabel.text =[NSString stringWithFormat:@"包装参数：%@",nameStr];
    self.cellLabel.text =[NSString stringWithFormat:@"价格：￥%.2ld",(long)goodModel.returnPrice];
    self.cellLabel.textColor =REDCOLOR;
    self.countLabel.text = [NSString stringWithFormat:@"实际退货数(%@)：%.3ld",baseStr,(long)goodModel.returnedQty ];
    self.danweiLab.text =[NSString stringWithFormat:@"小计：￥%.2ld",(long)goodModel.returnedAmt];
    
    
   
}

-(UIImageView *)productImg
{
    if (!_productImg) {
        _productImg = [[UIImageView alloc] init];
        _productImg.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_productImg];
        [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(5));
            make.top.mas_equalTo(WScale(5));
            make.width.height.mas_equalTo(WScale(50));
        }];
    }
    return _productImg;
}
-(UILabel *)productName
{
    if (!_productName) {
        _productName = [[UILabel alloc] init];
        _productName.textColor = BLACKCOLOR;
        _productName.font = ZF_FONT(15);
        _productName.numberOfLines = 0;
        [self addSubview:_productName];
        [_productName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productImg.mas_right).mas_equalTo(WScale(5));
            make.top.mas_equalTo(WScale(10));
            make.right.mas_equalTo(WScale(-5));
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
            make.left.mas_equalTo(self.productName.mas_left);
            make.top.mas_equalTo(self.productName.mas_bottom).mas_equalTo(WScale(5));
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
        CGSize tagTextSize = [array[i] sizeWithFont:ZF_FONT(12) maxSize:CGSizeMake(WScale(300),WScale(25))];
        if (tagBtnX+tagTextSize.width+WScale(25) >WScale(300)) {
            
            tagBtnX = 0;
            tagBtnY += WScale(25)+WScale(5);
        }
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(tagBtnX, tagBtnY, tagTextSize.width+WScale(5),WScale(25));
        label.text = array[i];
        label.textColor = BLACKCOLOR;
        label.font = ZF_FONT(12);
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.cornerRadius = 2;
        label.layer.masksToBounds = YES;
        label.backgroundColor = BACKGROUNDCOLOR;
        [self.standardView addSubview:label];
        tagBtnX = CGRectGetMaxX(label.frame)+WScale(5);
    }
    Height = tagBtnY +WScale(25);
    [self.standardView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(Height);
    }];
    
}
-(UILabel *)parameterLabel
{
    if (!_parameterLabel) {
        _parameterLabel = [[UILabel alloc] init];
        _parameterLabel.textColor = BLACKCOLOR;
        _parameterLabel.font = ZF_FONT(12);
        _parameterLabel.numberOfLines = 0;
        [self addSubview:_parameterLabel];
        [_parameterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productName.mas_left);
            make.top.mas_equalTo(self.standardView.mas_bottom).mas_equalTo(WScale(10));
            make.right.mas_equalTo(WScale(-5));
            
        }];
    }
    return _parameterLabel;
}
-(UILabel *)cellLabel
{
    if (!_cellLabel) {
        _cellLabel = [[UILabel alloc] init];
        _cellLabel.textColor = BLACKCOLOR;
        _cellLabel.font = ZF_FONT(12);
        _cellLabel.numberOfLines = 0;
        [self addSubview:_cellLabel];
        [_cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productName.mas_left);
            make.top.mas_equalTo(self.parameterLabel.mas_bottom).mas_equalTo(WScale(7));
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
            make.left.mas_equalTo(self).offset(DCMargin);
            make.top.mas_equalTo(self.cellLabel.mas_bottom).mas_equalTo(WScale(7));
            make.right.mas_equalTo(WScale(-5));
           make.bottom.mas_equalTo(WScale(-10));
        }];
    }
    return _countLabel;
}

-(UILabel *)danweiLab
{
    if (!_danweiLab) {
        _danweiLab = [[UILabel alloc] init];
        _danweiLab.textColor = REDCOLOR;
        _danweiLab.textAlignment =NSTextAlignmentRight;
        _danweiLab.font = ZF_FONT(12);
        //        _allCountLabel.numberOfLines = 0;
        [self addSubview:_danweiLab];
        [_danweiLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(ScreenW/2);
            make.top.mas_equalTo(self.cellLabel.mas_bottom).mas_equalTo(WScale(7));
            make.width.mas_equalTo(ScreenW/2-DCMargin);
            make.right.mas_equalTo(WScale(-5));
            make.bottom.mas_equalTo(WScale(-10));
        }];
    }
    return _danweiLab;
}
//-(UIView *)backView
//{
//    if (!_backView) {
//        _backView =[[UIView alloc]init];
//        _backView.backgroundColor =REDCOLOR;
//        [self addSubview:_backView];
////        _number=[[NumberCalculate alloc]initWithFrame:_backView.bounds];
////        _number.delegate =self;
////        [_backView addSubview:_number];
//        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.countLabel.mas_left).offset(WScale(115));
//            make.top.mas_equalTo(self.countLabel.mas_bottom).mas_equalTo(WScale(7));
//            make.width.mas_offset(WScale(110));
//            make.height.mas_offset(HScale(25));
//        }];
//
//    }
//
//    return _backView;
//}
//-(NumberCalculate *)number
//{
//    if (!_number) {
//        [_number mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_offset(WScale(55));
//            make.width.mas_offset(WScale(110));
//            make.height.mas_offset(HScale(25));
//            make.bottom.mas_equalTo(WScale(-41));
//        }];
//    }
//    return _number;
//}

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

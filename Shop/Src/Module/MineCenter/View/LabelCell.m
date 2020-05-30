//
//  LabelCell.m
//  LXTagsView
//
//  Created by 万众创新 on 2018/7/25.
//  Copyright © 2018年 漫漫. All rights reserved.
//

#import "LabelCell.h"
#import "LXTagsView.h"
@interface LabelCell()
@property (nonatomic ,strong)LXTagsView *tagsView;

@property (nonatomic ,strong)UIView *container;

@end
@implementation LabelCell
//-(void)setItems:(NSArray *)items{
//    _items = items;
//    self.tagsView.dataA = items;
//    [self.contentView layoutIfNeeded];
//}

-(void)setGoodListModel:(GoodsListModel *)goodListModel
{
    _goodListModel =goodListModel;
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:goodListModel.imgUrl] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
    self.productName.text =goodListModel.itemName;
    
    NSArray * array = @[goodListModel.spec?:@"",goodListModel.levelName?:@"",goodListModel.materialName?:@"",goodListModel.surfaceName?:@""];
    NSMutableArray *titArr =[NSMutableArray array];
    for (NSString *str in array) {
        if (str.length!=0) {
            [titArr addObject:str];
        }
    }
    
    self.tagsView.dataA =titArr.copy;
//    HeightF = WScale(30);
//    [self setStandWithArray:titArr.copy];
    self.productType.text =goodListModel.brandName;
    CGSize maximumLabelSize = CGSizeMake(100, 100);//labelsize的最大值
    //关键语句
    CGSize expectSize = [self.productType sizeThatFits:maximumLabelSize];
    [self.productType mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(expectSize.width+WScale(13));
    }];
    self.parameterLabel.text =[NSString stringWithFormat:@"小计：￥%.2f",goodListModel.realAmt];
    [SNTool setTextColor:self.parameterLabel FontNumber:DR_FONT(18) AndRange:NSMakeRange(4, self.parameterLabel.text.length-4) AndColor:BLACKCOLOR];
    self.countLabel.text =[NSString stringWithFormat:@"x%.2f(%@)",goodListModel.qty,goodListModel.basicUnitName];
}
-(void)setGoodSellOutModel:(GoodsListModel *)goodSellOutModel
{
    _goodSellOutModel =goodSellOutModel;
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:goodSellOutModel.imgUrl] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
    self.productName.text =goodSellOutModel.itemName;
    NSArray * array = @[goodSellOutModel.spec?:@"",goodSellOutModel.levelName?:@"",goodSellOutModel.materialName?:@"",goodSellOutModel.surfaceName?:@""];
    NSMutableArray *titArr =[NSMutableArray array];
    for (NSString *str in array) {
        if (str.length!=0) {
            [titArr addObject:str];
        }
    }
    self.productType.text =goodSellOutModel.brandName;
    self.tagsView.dataA =titArr.copy;
    //    HeightF = WScale(30);
    //    [self setStandWithArray:titArr.copy];
    NSString *baseStr;//basicUnitId 5千支  6公斤  7吨
    if ([goodSellOutModel.basicUnitId intValue]==5) {
        baseStr =@"千支";
    }
    if ([goodSellOutModel.basicUnitId intValue]==6) {
        baseStr =@"公斤";
    }
    if ([goodSellOutModel.basicUnitId intValue]==7) {
        baseStr =@"吨";
    }
    NSString *nameStr,*cellStr;
    if (goodSellOutModel.unitConversion1!=0) {
        nameStr =[NSString stringWithFormat:@"%.3f%@/%@",goodSellOutModel.unitConversion1 ,baseStr,goodSellOutModel.unitName1];
        cellStr =goodSellOutModel.unitName1;
    }
    if (goodSellOutModel.unitConversion2!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",goodSellOutModel.unitConversion2,baseStr,goodSellOutModel.unitName2];
        if (cellStr.length==0) {
            cellStr =goodSellOutModel.unitName2;
        }
    }
    
    if (goodSellOutModel.unitConversion3!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %3.f%@/%@",nameStr?:@"",goodSellOutModel.unitConversion3,baseStr,goodSellOutModel.unitName1];
        if (cellStr.length==0) {
            cellStr =goodSellOutModel.unitName3;
        }
    }
    if (goodSellOutModel.unitConversion4!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",goodSellOutModel.unitConversion4,baseStr,goodSellOutModel.unitName4];
        if (cellStr.length==0) {
            cellStr =goodSellOutModel.unitName4;
            
        }
    }
    if (goodSellOutModel.unitConversion5!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",goodSellOutModel.unitConversion5,baseStr,goodSellOutModel.unitName5];
        if (cellStr.length==0) {
            cellStr =goodSellOutModel.unitName5;
        
        }
    }
    self.parameterLabel.text = [NSString stringWithFormat:@"价格：￥%.2f%@  包装参数：%@",goodSellOutModel.price,goodSellOutModel.basicUnitName,nameStr];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _productImg = [[UIImageView alloc] init];
        _productImg.backgroundColor =WHITECOLOR;
        _productImg.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_productImg];
        
         _productType = [[UILabel alloc] init];
         _productType.backgroundColor =RGBHex(0XFD8A30);
         _productType.textColor = WHITECOLOR;
         _productType.textAlignment =1;
         _productType.layer.cornerRadius =2;
         _productType.layer.masksToBounds =2;
         _productType.font = DR_FONT(10);
         [self addSubview:_productType];
         
                      
        _productName = [[UILabel alloc] init];
        _productName.textColor = BLACKCOLOR;
        _productName.font = DR_FONT(14);
        _productName.numberOfLines = 0;
        [self addSubview:_productName];       
        self.tagsView =[[LXTagsView alloc]init];
//        self.tagsView.layer.borderWidth = 1;
//        self.tagsView.layer.borderColor = REDCOLOR.CGColor;
        [self.contentView addSubview:self.tagsView];
        self.tagsView.tagClick = ^(NSString *tagTitle) {
            NSLog(@"cell打印---%@",tagTitle);
        };
        _parameterLabel = [[UILabel alloc] init];
        _parameterLabel.textColor = BLACKCOLOR;
        _parameterLabel.font = DR_FONT(12);
        _parameterLabel.numberOfLines = 0;
        [self addSubview:_parameterLabel];
        _countLabel = [[UILabel alloc] init];
        _countLabel.textColor = BLACKCOLOR;
        _countLabel.font = DR_FONT(12);
        _countLabel.textAlignment =2;
        _countLabel.numberOfLines = 0;
        [self addSubview:_countLabel];
        
        UIView *lineView =[[UIView alloc]init];
        lineView.backgroundColor =BACKGROUNDCOLOR;
        [self addSubview:lineView];
        [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(DCMargin);
            make.top.equalTo(self.contentView).offset(12);
            make.height.mas_equalTo(WScale(77));
            make.width.mas_equalTo(WScale(77));
        }];        
        [_productType mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(self.productImg.mas_right).offset(WScale(10));
           make.top.mas_equalTo(WScale(12));
           make.height.mas_equalTo(WScale(17));
        }];
        
        [_productName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.productType.mas_right).offset(5);
            make.top.mas_equalTo(WScale(13.5));
            make.right.mas_equalTo(WScale(-5));
            make.height.mas_equalTo(WScale(14));
        }];
        
        [self.tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(WScale(87));
            make.top.equalTo(self.contentView).offset(WScale(39));
            make.right.equalTo(self.contentView).offset(-5);
            make.height.mas_equalTo(WScale(12));
        }];
        [_parameterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.productType.mas_left);
            make.top.equalTo(self.tagsView.mas_bottom).offset(WScale(20));
            make.height.mas_equalTo(WScale(18));
//            make.bottom.mas_equalTo(WScale(12));
        }];
        
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).offset(-DCMargin);
            make.top.mas_equalTo(self.tagsView.mas_bottom).offset(WScale(20));
            make.height.mas_equalTo(WScale(18));
        }];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).offset(-DCMargin);
            make.left.mas_equalTo(self.contentView).offset(DCMargin);
            make.top.mas_equalTo(_countLabel.mas_bottom).offset(WScale(10));
            make.height.mas_equalTo(WScale(1));
        }];
    }
    return self;
}
-(void)layoutSubviews
{
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

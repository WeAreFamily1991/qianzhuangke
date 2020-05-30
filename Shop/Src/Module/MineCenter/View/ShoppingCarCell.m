//
//  ShoppingCarCell.m
//  ShoppingCarDemo
//
//  Created by huanglianglei on 15/11/5.
//  Copyright © 2015年 huanglianglei. All rights reserved.
//

#import "ShoppingCarCell.h"
#import "UIViewExt.h"

@implementation ShoppingCarCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    
    
    self.selectBtn =[DDButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.frame =CGRectMake(WScale(10), WScale(97)/2, WScale(20), WScale(20));
    [_selectBtn setBackgroundImage:[UIImage imageNamed:@"list_unchoose"] forState:UIControlStateNormal];
    [_selectBtn addTarget:self action:@selector(selectedGoods:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_selectBtn];
    
//
   
    self.orderLab = [[UILabel alloc]initWithFrame:CGRectMake( self.selectBtn.right+10,WScale(12),SCREEN_WIDTH- self.selectBtn.right-20-self.typeRightLab.width, WScale(12))];
    self.orderLab.text = @"单据编码：XD-00005-201902-D00019";
    self.orderLab.numberOfLines = 0;
    self.orderLab.textColor =BLACKCOLOR;
    self.orderLab.font = DR_FONT(13);
    [self addSubview:self.orderLab];
    
    self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(self.orderLab.dc_x,self.orderLab.dc_bottom+WScale(7),self.orderLab.dc_width, WScale(12))];
    self.timeLab.text = @"单据时间：2019/2/19 10:44:52";
    self.timeLab.textColor =BLACKCOLOR;
    self.timeLab.font = DR_FONT(13);
    [self addSubview:self.timeLab];
    
    self.orderPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(self.orderLab.dc_x,self.timeLab.dc_bottom+WScale(12),self.orderLab.dc_width, WScale(12))];
    self.orderPriceLab.text = @"单据金额：￥0.00";
    self.orderPriceLab.textColor = BLACKCOLOR;
    self.orderPriceLab.font = DR_FONT(12);
    [self addSubview:self.orderPriceLab];
    
    self.backPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(self.orderLab.dc_x,self.orderPriceLab.dc_bottom+WScale(7),self.orderLab.dc_width, WScale(12))];
    self.backPriceLab.text = @"退货金额：￥0.00";
    self.backPriceLab.textColor = [UIColor grayColor];
    self.backPriceLab.font = DR_FONT(12);
    [self addSubview:self.backPriceLab];
    
    self.numberLab = [[UILabel alloc]initWithFrame:CGRectMake(self.orderLab.dc_x,self.backPriceLab.dc_bottom+WScale(7),self.orderLab.dc_width, WScale(12))];
    self.numberLab.text = @"可开票金额：￥0.00";
    self.numberLab.textColor = BLACKCOLOR;
    self.numberLab.font = DR_FONT(12);
    [self addSubview:self.numberLab];
    
    self.typeRightLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50-10,(self.dc_height-WScale(70))/2,50, WScale(20))];
    self.typeRightLab.text = @"可开票";
    self.typeRightLab.textAlignment =NSTextAlignmentRight;
    self.typeRightLab.textColor = REDCOLOR;
    self.typeRightLab.font = DR_FONT(13);
    [self addSubview:self.typeRightLab];
    
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(WScale(10), self.numberLab.bottom+WScale(12), ScreenW-WScale(20), WScale(1))];
    lineView.backgroundColor =BACKGROUNDCOLOR;
    [self addSubview:lineView];
    self.detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.detailBtn.frame = CGRectMake(SCREEN_WIDTH-WScale(80)-10,WScale(127),WScale(80), WScale(30));
    [self.detailBtn setBackgroundColor:WHITECOLOR];
    
    self.detailBtn.layer.borderColor =REDCOLOR.CGColor;
    self.detailBtn.layer.borderWidth =0.5;
    self.detailBtn.layer.masksToBounds = YES;
    self.detailBtn.layer.cornerRadius = 4;
    [self.detailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    [self.detailBtn addTarget:self action:@selector(detailBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.detailBtn setTitleColor:REDCOLOR forState:UIControlStateNormal];
    self.detailBtn.titleLabel.font = DR_FONT(14.0);
    self.detailBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [self addSubview:self.detailBtn];

//    self.addNumberView = [[AddNumberView alloc]initWithFrame:CGRectMake(numberTitleLab.right+5, numberTitleLab.top-2, 93, 22)];
//    self.addNumberView.delegate = self;
//    self.addNumberView.backgroundColor = [UIColor clearColor];
//    [self addSubview:self.addNumberView];
   
}

-(void)detailBtnClick
{
    !_selectClickBlock?:_selectClickBlock();
}
- (void)selectedGoods:(UIButton *)btn {
    _select = !_select;
    UIImage *selectBtnImage = (_select)?(ImgName(@"login_ico_ check_click")):(ImgName(@"list_unchoose"));
    [_selectBtn setBackgroundImage:selectBtnImage forState:UIControlStateNormal];
    
//    if ([self.delegate respondsToSelector:@selector(cell:selected:indexPath:)]) {
        [self.delegate cell:self selected:_select indexPath:self.indexPath];
//    }
}

-(void)setShoppingModel:(ShoppingModel *)shoppingModel{
    
    _shoppingModel = shoppingModel;
   
    
    _select = shoppingModel.isSelected;
    UIImage *selectBtnImage = _select?(ImgName(@"login_ico_ check_click")):(ImgName(@"list_unchoose"));
    [_selectBtn setBackgroundImage:selectBtnImage forState:UIControlStateNormal];

    self.orderLab.text = [NSString stringWithFormat:@"单据编码：%@",shoppingModel.orderNo];
    
    self.timeLab.text  = [NSString stringWithFormat:@"单据时间：%@",[SNTool StringTimeFormat:[NSString stringWithFormat:@"%ld",(long)shoppingModel.createTime]]];
    
    self.backPriceLab.text =[NSString stringWithFormat:@"退货金额：%.2f",[shoppingModel.returnedAmt doubleValue]];
    NSString *lonStr =[NSString stringWithFormat:@"%.2f",[shoppingModel.returnedAmt doubleValue]];
    [SNTool setTextColor:self.backPriceLab FontNumber:DR_FONT(12) AndRange:NSMakeRange(5,lonStr.length) AndColor:REDCOLOR];
    self.numberLab.text =[NSString stringWithFormat:@"可开票金额：%.2f",shoppingModel.canReturnAmt];
    NSString *loStr =[NSString stringWithFormat:@"%.2f",shoppingModel.canReturnAmt];
    [SNTool setTextColor:self.numberLab FontNumber:DR_FONT(12) AndRange:NSMakeRange(6,loStr.length) AndColor:REDCOLOR];
    
}
- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

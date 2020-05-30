//
//  CartTableViewCell.m
//  ArtronUp
//
//  Created by Artron_LQQ on 15/12/1.
//  Copyright © 2015年 ArtronImages. All rights reserved.
//

#import "CartTableViewCell.h"
//#import "LQQPictureManager.h"

@interface CartTableViewCell ()

//选中按钮
@property (nonatomic,retain) UIButton *selectBtn;

//商品名
@property (nonatomic,retain) UILabel *nameLabel;

//时间
@property (nonatomic,retain) UILabel *dateLabel;

//商品名
@property (nonatomic,retain) UILabel *contentLabel;

//line
@property (nonatomic,retain) UIView *lineView;

@end

@implementation CartTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        self.backgroundColor = RGBCOLOR(245, 246, 248);
//        [self setupMainView];
//    }
//    return self;
//}
//选中按钮点击事件
-(void)selectBtnClick:(UIButton*)button
{
    button.selected = !button.selected;
    if (self.cartBlock) {
        self.cartBlock(button.selected);
    }
}

// 数量加按钮
-(void)addBtnClick
{
    if (self.numAddBlock) {
        self.numAddBlock();
    }
}

//数量减按钮
-(void)cutBtnClick
{
    if (self.numCutBlock) {
        self.numCutBlock();
    }
}

-(void)reloadDataWith:(CartModel*)model
{
    self.nameLabel.text =model.title;
    
    self.dateLabel.text =[SNTool StringTimeFormat:[NSString stringWithFormat:@"%ld",(long)model.addTime]];

    self.nameLabel.textColor =model.isRead?BLACKCOLOR:REDCOLOR;
    self.dateLabel.textColor =model.isRead?[UIColor lightGrayColor]:REDCOLOR;
    self.contentLabel.text =model.content;
    self.selectBtn.selected = self.isSelected;

}
//-(UIButton *)selectBtn
//{
//    if (!_selectBtn) {
//        self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.selectBtn.selected = self.isSelected;
//        [self.selectBtn setImage:[UIImage imageNamed:@"Unchecked"] forState:UIControlStateNormal];
//        [self.selectBtn setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
//        [self.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:self.selectBtn];
//        [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self).offset(10);
//            make.centerY.equalTo(self);
//            make.width.equalTo(@30);
//            make.height.equalTo(@30);
//        }];
//    }
//    return _selectBtn;
//}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        self.nameLabel = [[UILabel alloc]init];
        //    self.nameLabel.text = @"海报";
        self.nameLabel.textColor =BLACKCOLOR;
        self.nameLabel.font = DR_FONT(16);
        [self addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(10);
            make.top.mas_equalTo(self).offset(13);
            make.right.mas_equalTo(self).offset(-10);
            make.height.mas_equalTo(WScale(16));
        }];
    }
    return _nameLabel;
}
-(UILabel *)dateLabel
{
    if (!_dateLabel) {
        self.dateLabel = [[UILabel alloc]init];
        self.dateLabel.font = DR_FONT(12);
        self.dateLabel.textColor =RGBHex(0XFFFFFF);
        [self addSubview:self.dateLabel];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_left);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5);
            make.right.mas_equalTo(WScale(-5));
           make.height.mas_equalTo(WScale(12));
            
        }];
    }
    return _dateLabel;
}

-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        self.contentLabel = [[UILabel alloc]init];
        //    self.nameLabel.text = @"海报";
        self.contentLabel.numberOfLines =0;
        self.contentLabel.font = DR_FONT(12);
        self.contentLabel.textColor =RGBHex(0X888888);
        [self addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_left);
             make.top.mas_equalTo(self.dateLabel.mas_bottom).offset(5);
             make.right.mas_equalTo(WScale(-5));
            make.height.mas_equalTo(WScale(36));
        }];
    }
    return _contentLabel;
}
@end

//
//  DCGoodsSortCell.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DRFactoryCell.h"

// Controllers

// Models
#import "DCClassMianItem.h"
// Views
#import <UIImageView+WebCache.h>
// Vendors

// Categories

// Others

@interface DRFactoryCell ()

/* imageView */
@property (strong , nonatomic)UIImageView *goodsImageView;
/* label */
@property (strong , nonatomic)UILabel *goodsTitleLabel;
@end

@implementation DRFactoryCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}
#pragma mark - UI
- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    _goodsImageView = [[UIImageView alloc] init];
    _goodsImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_goodsImageView];
    _goodsTitleLabel = [[UILabel alloc] init];
    _goodsTitleLabel.font = DR_FONT(14);
    _goodsTitleLabel.textColor =BLACKCOLOR;
    _goodsTitleLabel.textAlignment = 0;
    [self addSubview:_goodsTitleLabel];
}
#pragma mark - 布局
- (void)layoutSubviews
{
    //    DRWeakSelf;
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(self.dc_width*0.6);
        
    }];
    [_goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_goodsImageView.mas_bottom);
        make.left.mas_equalTo(self->_goodsTitleLabel);
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
   
}
#pragma mark - Setter Getter Methods
//-(void)setTitleStr:(NSString *)titleStr
//{
//     _goodsTitleLabel.text = titleStr;
//}
-(void)setFactoryModel:(DRFactoryModel *)factoryModel
{
    _factoryModel =factoryModel;
    _goodsTitleLabel.text =factoryModel.name;
    
     [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:factoryModel.logo] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
}



@end

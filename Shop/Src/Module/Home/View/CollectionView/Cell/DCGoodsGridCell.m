//
//  DCGoodsGridCell.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCGoodsGridCell.h"
#import "DTHomeButton.h"
#import "DTHomeScrollView.h"
// Controllers

// Models
#import "DCGridItem.h"
// Views

// Vendors
#import <UIImageView+WebCache.h>
// Categories
#import "UIView+DCRolling.h"
#import "UIColor+DCColorChange.h"
// Others

@interface DCGoodsGridCell ()<DTHomeScrollViewDelegate>

/* imageView */
@property (strong , nonatomic)UIImageView *gridImageView;
/* gridLabel */
@property (strong , nonatomic)UILabel *gridLabel;
/* tagLabel */
@property (strong , nonatomic)UILabel *tagLabel;

@property (nonatomic,strong)DTHomeScrollView *scrollView;

@end

@implementation DCGoodsGridCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];

    }
    return self;
}
-(void)setYouLikeItem:(DCRecommendItem *)youLikeItem
{
    _youLikeItem =youLikeItem;
    self.backgroundColor =BACKGROUNDCOLOR;
    NSMutableArray *views = [NSMutableArray array];
    NSArray *titles = @[@"课程1",@"阿米巴",@"创客",@"大赛",@"人才银行",@"小邮局",@"蚤市2",@"课程",@"阿米巴",@"创客",@"大赛",@"人才银行",@"小邮局3",@"蚤市",@"课程",@"阿米巴",@"创客",@"大赛",@"人才银行",@"小邮局4",@"蚤市"];
    for (int i = 0; i < titles.count; i++) {
        DTHomeButton *btn = [[DTHomeButton alloc]initWithFrame:CGRectZero withTitle:titles[i] withImageURLString:@""];
        btn.youLikeItem =youLikeItem;
        //        [btn setTitle:titles[i] forState:0];
        //        [btn setTitleColor:REDCOLOR forState:0];
        [views addObject:btn];
        
    }
    
    //坐标自己需要设置
    self.scrollView = [[DTHomeScrollView alloc]initWithFrame:self.bounds viewsArray:views];
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
}
- (void)setUpUI
{
  

}
#pragma DTHomeScrollViewDelegate
- (void)buttonUpInsideWithView:(UIButton *)btn withIndex:(NSInteger)index withView:(DTHomeScrollView *)view{
    NSLog(@"%ld",index);
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//
//    [_gridImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        [make.top.mas_equalTo(self)setOffset:DCMargin];
//        if (iphone5) {
//            make.size.mas_equalTo(CGSizeMake(38, 38));
//        }else{
//            make.size.mas_equalTo(CGSizeMake(45, 45));
//        }
//        make.centerX.mas_equalTo(self);
//    }];
//
//    [_gridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self);
//        [make.top.mas_equalTo(_gridImageView.mas_bottom)setOffset:5];
//    }];
//
//
//
//    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_gridImageView.mas_centerX);
//        make.top.mas_equalTo(_gridImageView);
//        make.size.mas_equalTo(CGSizeMake(35, 15));
//    }];
//
//}

#pragma mark - Setter Getter Methods
//- (void)setGridItem:(DCGridItem *)gridItem
//{
//    _gridItem = gridItem;
//
//
//    _gridLabel.text = gridItem.gridTitle;
//    _tagLabel.text = gridItem.gridTag;
//    
//    _tagLabel.hidden = (gridItem.gridTag.length == 0) ? YES : NO;
//    _tagLabel.textColor = [UIColor dc_colorWithHexString:gridItem.gridColor];
//    [DCSpeedy dc_chageControlCircularWith:_tagLabel AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:_tagLabel.textColor canMasksToBounds:YES];
//
//    if (_gridItem.iconImage.length == 0) return;
//    if ([[_gridItem.iconImage substringToIndex:4] isEqualToString:@"http"]) {
//        
//        [_gridImageView sd_setImageWithURL:[NSURL URLWithString:gridItem.iconImage]placeholderImage:[UIImage imageNamed:@"default_49_11"]];
//    }else{
//        _gridImageView.image = [UIImage imageNamed:_gridItem.iconImage];
//    }
//}

@end

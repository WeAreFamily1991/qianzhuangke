//
//  DCGoodsCountDownCell.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCGoodsCountDownCell.h"
#import "DCGridItem.h"
#import "DRItemModel.h"
// Controllers
#import "DCGoodsGridCell.h"      //10个选项
#import <FWCycleScrollView/FWCycleScrollView-Swift.h>
// Models
#import "DCRecommendItem.h"
// Views
#import "DCGoodsSurplusCell.h"

// Vendors
#import <MJExtension.h>
// Categories

// Others

@interface DCGoodsCountDownCell ()
@property (nonatomic, strong) UIScrollView          *scrollView;
///* collection */
//@property (strong , nonatomic)UICollectionView *collectionView;
///* 推荐商品数据 */
////@property (strong , nonatomic)NSMutableArray<DCRecommendItem *> *countDownItem;
///* 底部 */
//@property (strong , nonatomic)UIView *bottomLineView;
///* 10个属性 */
//@property (strong , nonatomic)NSMutableArray<DCGridItem *> *gridItem;
@end
//static NSString *const DCGoodsGridCellID = @"DCGoodsGridCell";
//static NSString *const DCGoodsSurplusCellID = @"DCGoodsSurplusCell";

@implementation DCGoodsCountDownCell

#pragma mark - lazyload

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    
    
}
-(void)setItemMuArr:(NSMutableArray *)itemMuArr
{
    _itemMuArr =itemMuArr;
    self.backgroundColor = [UIColor whiteColor];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.backgroundColor = UIColor.clearColor;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    [self addSubview:self.scrollView];
    /// 例八：仿直播间礼物列表
    FWCycleScrollView *cycleScrollView8 = [FWCycleScrollView cycleWithFrame:CGRectMake(0, WScale(10), ScreenW, self.dc_height) loopTimes:1];
    cycleScrollView8.viewArray = [self setupCustomSubView:0 withItemMuArr:itemMuArr];
    cycleScrollView8.backgroundColor =BACKGROUNDCOLOR;
    cycleScrollView8.currentPageDotEnlargeTimes = 1.0;
    cycleScrollView8.customDotViewType = FWCustomDotViewTypeSolid;
    cycleScrollView8.pageDotColor = [UIColor grayColor];
    cycleScrollView8.currentPageDotColor = REDCOLOR;
    cycleScrollView8.pageControlDotSize = CGSizeMake(8, 8);
    cycleScrollView8.pageControlInsets = UIEdgeInsetsMake(-10, 0, 0, 0);
    cycleScrollView8.autoScroll = NO;
    [self.scrollView addSubview:cycleScrollView8];
}
- (UIView *)setupUIView3:(int)index frame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    NSMutableArray *titleArr=[NSMutableArray arrayWithArray:@[@"爆品专区",@"促销专区",@"领券中心",@"卖家入驻",@"购买记录",@"帮助中心"]];
    NSMutableArray *insertTitleArr =[NSMutableArray array];
    for (DRItemModel *model in _itemMuArr) {
        [insertTitleArr addObject:model.name];
    }
    [titleArr insertObjects:insertTitleArr atIndex:0];
    
    NSMutableArray *imgArr=[NSMutableArray arrayWithArray:@[@"爆品专区",@"促销专区",@"领券中心",@"卖家入驻",@"购买记录",@"帮助中心"]];
    NSMutableArray *insertImgArr =[NSMutableArray array];
    for (DRItemModel *model in _itemMuArr) {
        [insertImgArr addObject:model.imgM];
    }
    [imgArr insertObjects:insertImgArr atIndex:0];
    
    UIImageView *iconIMG =[[UIImageView alloc]initWithFrame:CGRectMake((view.dc_width-WScale(44))/2, 0, WScale(44), WScale(44))];
    if (![self isChinese:imgArr[index]]) {
        [iconIMG sd_setImageWithURL:[NSURL URLWithString:imgArr[index]]];
    }else
    {
        iconIMG.image =[UIImage imageNamed:imgArr[index]];
    }
//    iconIMG.layer.cornerRadius =WScale(22);
//    iconIMG.layer.masksToBounds =YES;
    [view addSubview:iconIMG];
    
    UILabel *titleLab =[UILabel labelWithText:titleArr[index] font:DR_FONT(12) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:1 superView:view];
    titleLab.frame =CGRectMake(0, iconIMG.dc_bottom+WScale(10), view.dc_width,WScale(12));
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    titleBtn.backgroundColor =CLEARCOLOR;
    titleBtn.frame =CGRectMake(0, 0, view.dc_width, view.dc_height);
    
//    titleBtn.titleLabel.font = DR_FONT(12);
    titleBtn.tag =index;
//    [titleBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
//    [titleBtn setTitle:titleArr[index] forState:UIControlStateNormal];
    
//    if (![self isChinese:imgArr[index]]) {
//        [titleBtn sd_setImageWithURL:[NSURL URLWithString:imgArr[index]] forState:UIControlStateNormal];
//    }else
//    {
//        [titleBtn setImage:[UIImage imageNamed:imgArr[index]] forState:UIControlStateNormal];
//    }
    
    [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:titleBtn];
   
    return view;
}
-(void)titleBtnClick:(UIButton *)sender
{
    if (_btnItemBlock) {
        _btnItemBlock(sender.tag);
    }
}
- (BOOL)isChinese:(NSString *)str
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:str];
}
- (UIView *)setupUIView4:(int)index frame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    int tmpW = view.frame.size.width *0.5;
    int tmpH = view.frame.size.height *0.5;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((view.frame.size.width-tmpW)/2, (view.frame.size.height-tmpH)/2, tmpW, tmpH)];
    label.text = [NSString stringWithFormat:@"%d", (index + 1)];
    label.textColor = UIColor.whiteColor;
    label.backgroundColor = [UIColor colorWithRed:(float)(1+arc4random()%99)/100 green:(float)(1+arc4random()%99)/100 blue:(float)(1+arc4random()%99)/100 alpha:1];
    label.font = [UIFont systemFontOfSize:25.0];
    label.textAlignment = NSTextAlignmentCenter;
//    label.layer.cornerRadius = label.dc_width / 2;
//    label.clipsToBounds = YES;
    [view addSubview:label];
    return view;
}
- (NSMutableArray *)setupCustomSubView:(int)subViewType withItemMuArr:(NSMutableArray *)itemArr
{
    int tmpX = 0;
    int tmpY = WScale(15);
    
    int horizontalRow = 4;
    int verticalRow = 2;    
    int tmpW = self.frame.size.width / horizontalRow;
    int tmpH = self.frame.size.width / 2 / verticalRow;
    
    UIView *viewContrainer = nil;
    NSMutableArray *customSubViewArray = [NSMutableArray array];
    
    for (int i=0; i<itemArr.count+6; i++) {
        tmpX = (i % horizontalRow) * tmpW;
        if (i % (horizontalRow * verticalRow) < horizontalRow) {
            tmpY = WScale(15);
        } else {
            tmpY = tmpH+WScale(15);
        }
        
        if (viewContrainer == nil || (i % (horizontalRow * verticalRow) == 0)) {
            viewContrainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width /2 + 30)];
            viewContrainer.backgroundColor = UIColor.whiteColor;
            [customSubViewArray addObject:viewContrainer];
        }
        
        if (subViewType == 0) {
            [viewContrainer addSubview:[self setupUIView3:i frame:CGRectMake(tmpX, tmpY, tmpW, tmpH)]];
        } else {
            [viewContrainer addSubview:[self setupUIView4:i frame:CGRectMake(tmpX, tmpY, tmpW, tmpH)]];
        }
    }
    return customSubViewArray;
}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - Setter Getter Methods
#pragma mark - <UICollectionViewDataSource>

@end



//
//  DCSlideshowHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DRShopBannerFootView.h"
#import "DRShopBannerCollectionViewCell.h"
// Controllers

// Models
#import "NewsModel.h"
#import "DRFooterModel.h"
// Views

// Vendors
#import <SDCycleScrollView.h>

// Categories

// Others

@interface DRShopBannerFootView ()<SDCycleScrollViewDelegate>

/* 轮播图 */
@property (strong , nonatomic)SDCycleScrollView *cycleScrollView;

@property (strong , nonatomic)NSMutableArray *tipArr;

@property (strong , nonatomic)UIButton *quickButton;
@property (strong , nonatomic) UIView *backView;
@end

@implementation DRShopBannerFootView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        
    }
    return self;
}
-(void)setDataArr:(NSMutableArray *)dataArr
{
    _dataArr =dataArr;
    NSMutableArray *muArr =[NSMutableArray array];
    for (DRFooterModel *footeModel in _dataArr) {
        
            
        [muArr addObject:footeModel.img?:@""];
        
    }

    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"default_160"];
    if (muArr.count == 0) return;
    _cycleScrollView.imageURLStringsGroup = muArr;
    
    
}
//-(void)setGoodListModel:(GoodsListModel *)goodListModel
//{
//    _goodListModel =goodListModel;
//    [self.productImg sd_setImageWithURL:[NSURL URLWithString:goodListModel.imgUrl] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
//    self.productName.text =goodListModel.itemName;
//    NSArray * array = @[goodListModel.spec?:@"",goodListModel.levelName?:@"",goodListModel.materialName?:@"",goodListModel.surfaceName?:@"",goodListModel.brandName?:@""];
//    NSMutableArray *titArr =[NSMutableArray array];
//    for (NSString *str in array) {
//        if (str.length!=0) {
//            [titArr addObject:str];
//        }
//    }
//    Height = WScale(30);
////    [self setStandWithArray:titArr];
//    self.parameterLabel.text = [NSString stringWithFormat:@"购买数量：%f%@  小计：￥%f",goodListModel.qty,goodListModel.basicUnitName,goodListModel.realAmt];
//}
- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
  
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW, self.dc_height) delegate:self placeholderImage:nil];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    _cycleScrollView.currentPageDotColor =REDCOLOR;
    _cycleScrollView.pageDotColor =[UIColor lightGrayColor];
    
    [self addSubview:_cycleScrollView];
  
  

}
// 如果要实现自定义cell的轮播图，必须先实现customCollectionViewCellClassForCycleScrollView:和setupCustomCell:forIndex:代理方法
- (Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view
{
    if (view!=_cycleScrollView) {
        return nil;
    }
    return [DRShopBannerCollectionViewCell class];
}
- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view
{
    DRShopBannerCollectionViewCell *myCell = (DRShopBannerCollectionViewCell *)cell;
    myCell.footModel =_dataArr[index];
    
}



#pragma mark - 点击图片Bannar跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd轮播图",index);
    if (_ManageIndexBlock) {
        _ManageIndexBlock(index);
    }
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - Setter Getter Methods


@end

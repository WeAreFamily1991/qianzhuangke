//
//  DCHandPickViewController.m
//  CDDMall
//
//  Created by apple on 2017/5/26.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DRNullMainVC.h"
#import "HQCollectionViewFlowLayout.h"


// Models
#import "DCGridItem.h"
#import "DCRecommendItem.h"
// Views
#import "DCNavSearchBarView.h"
#import "DCHomeTopToolView.h"
/* cell */
#import "DRNullGoodLikesCell.h"  //爆品牛商cell
/* head */
#import "DCCountDownHeadView.h"  //倒计时标语
/* foot */
//#import "DRFooterView.h"
//#import "DCTopLineFootView.h"    //热点
//#import "DCOverFootView.h"       //结束
//#import "DCScrollAdFootView.h"   //底滚动广告
//#import "DRGuangGaoView.h"
// Vendors
#import "DCHomeRefreshGifHeader.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
// Categories
#import "UIBarButtonItem+DCBarButtonItem.h"
// Others
#import "CDDTopTip.h"
#import "NetworkUnit.h"

@interface DRNullMainVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>



/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 10个属性 */
@property (strong , nonatomic)NSMutableArray<DCGridItem *> *gridItem;
/* 推荐商品属性 */
@property (strong , nonatomic)NSArray<DCRecommendItem *> *youLikeItem;
///* 顶部工具View */
//@property (nonatomic, strong) DCHomeTopToolView *topToolView;
/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;



@end
/* cell */
static NSString *const DRNullGoodLikesCellCellID = @"DRNullGoodLikesCell";
/* head */
static NSString *const DCCountDownHeadViewID = @"DCCountDownHeadView";


@implementation DRNullMainVC

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        HQCollectionViewFlowLayout *flowlayout = [[HQCollectionViewFlowLayout alloc] init];
        //设置悬停高度
        flowlayout.naviHeight = 0;
        //
        //左右间距
        flowlayout.minimumInteritemSpacing = 1;
        //上下间距
        flowlayout.minimumLineSpacing = 1;
        flowlayout.sectionInset = UIEdgeInsetsMake(0, 2, 0, 2);
        //        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        //        layout.sectionHeadersPinToVisibleBounds = YES;//头视图悬浮
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 0, ScreenW, ScreenH-DRTopHeight);
        _collectionView.showsVerticalScrollIndicator = NO;        //注册
        [_collectionView registerClass:[DRNullGoodLikesCell class] forCellWithReuseIdentifier:DRNullGoodLikesCellCellID];
        
       
        [_collectionView registerClass:[DCCountDownHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCCountDownHeadViewID];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"爆品牛商";
    [self setUpBase];
    [self setUpGoodsData];
    [self setUpScrollToTopView];
    [self setUpGIFRrfresh];
    [self getNetwork];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSLog(@"location =%@",[DRUserInfoModel sharedManager].locationCode?:@"");
}
#pragma mark - initialize
- (void)setUpBase
{
    self.collectionView.backgroundColor = BACKGROUNDCOLOR;
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
#pragma mark - 获取网络
- (void)getNetwork
{
    if ([[NetworkUnit getInternetStatus] isEqualToString:@"notReachable"]) { //网络
        [CDDTopTip showTopTipWithMessage:@"您现在暂无可用网络"];
    }
}
#pragma mark - 设置头部header
- (void)setUpGIFRrfresh
{
    self.collectionView.mj_header = [DCHomeRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(setUpRecData)];
}
#pragma mark - 刷新
- (void)setUpRecData
{
    DRWeakSelf;
    [DCSpeedy dc_callFeedback]; //触动
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ //手动延迟
        [self setUpGoodsData];
        [weakSelf.collectionView.mj_header endRefreshing];
    });
}

#pragma mark - 加载数据
- (void)setUpGoodsData
{
    _gridItem = [DCGridItem mj_objectArrayWithFilename:@"GoodsGrid.plist"];
    _youLikeItem = [DCRecommendItem mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
}

#pragma mark - 滚回顶部
- (void)setUpScrollToTopView
{
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(ScreenW - 50, ScreenH - 80-DRTabBarHeight, 40, 40);
}

#pragma mark - 导航栏处理


#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _youLikeItem.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
   
    DRNullGoodLikesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DRNullGoodLikesCellCellID forIndexPath:indexPath];
    cell.lookSameBlock = ^{
        NSLog(@"点击了第%zd商品的比价格",indexPath.row);
    };
    cell.youLikeItem = _youLikeItem[indexPath.row];
    gridcell = cell;
    return gridcell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        DCCountDownHeadView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCCountDownHeadViewID forIndexPath:indexPath];
        footerView.backgroundColor = BACKGROUNDCOLOR;
//        [footerView.timeBtn setTitle:@"————  爆品牛商  ————" forState:UIControlStateNormal];
//        footerView.timeBtn.titleLabel.font =DR_FONT(18);
//        [footerView.timeBtn setTitleColor:REDCOLOR forState:UIControlStateNormal];
        return footerView;
    }
    return nil;
}
//这里我为了直观的看出每组的CGSize设置用if 后续我会用简洁的三元表示
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    return CGSizeMake((ScreenW - 8)/2,  (ScreenW - 6)/2 + HScale(80)+ScreenW*0.13);
}
#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
     return CGSizeMake(ScreenW, HScale(40));
}
#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
   
    return CGSizeZero;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 5) ? 4 : 0;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 5) ? 4 : 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//10
        
        //        DCGoodsSetViewController *goodSetVc = [[DCGoodsSetViewController alloc] init];
        //        goodSetVc.goodPlisName = @"ClasiftyGoods.plist";
        //        [self.navigationController pushViewController:goodSetVc animated:YES];
        //        NSLog(@"点击了10个属性第%zd",indexPath.row);
    }else if (indexPath.section == 5){
        NSLog(@"点击了推荐的第%zd个商品",indexPath.row);
        
        //        DCGoodDetailViewController *dcVc = [[DCGoodDetailViewController alloc] init];
        //        dcVc.goodTitle = _youLikeItem[indexPath.row].main_title;
        //        dcVc.goodPrice = _youLikeItem[indexPath.row].price;
        //        dcVc.goodSubtitle = _youLikeItem[indexPath.row].goods_title;
        //        dcVc.shufflingArray = _youLikeItem[indexPath.row].images;
        //        dcVc.goodImageView = _youLikeItem[indexPath.row].image_url;
        //
        //        [self.navigationController pushViewController:dcVc animated:YES];
    }
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    _backTopButton.hidden = (scrollView.contentOffset.y > ScreenH) ? NO : YES;//判断回到顶部按钮是否隐藏
//    _topToolView.hidden = (scrollView.contentOffset.y < 0) ? YES : NO;//判断顶部工具View的显示和隐形
    
    if (scrollView.contentOffset.y > DCNaviH) {
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        [[NSNotificationCenter defaultCenter]postNotificationName:SHOWTOPTOOLVIEW object:nil];
    }else{
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        [[NSNotificationCenter defaultCenter]postNotificationName:HIDETOPTOOLVIEW object:nil];
    }
}

#pragma mark - collectionView滚回顶部
- (void)ScrollToTop
{
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

#pragma mark - 消息
- (void)messageItemClick
{
    
}
@end

//
//  DCHandPickViewController.m
//  CDDMall
//
//  Created by apple on 2017/5/26.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DRCuXiaoVC.h"
#import "HQCollectionViewFlowLayout.h"
#import "CategoryDetailVC.h"
#import "QZConditionFilterView.h"
#import "UIView+QZExtension.h"
// Models
#import "DCGridItem.h"
#import "DCRecommendItem.h"
// Views
#import "DCNavSearchBarView.h"
#import "DCHomeTopToolView.h"
/* cell */
#import "DRCuxiaoCell.h"  //爆品牛商cell
/* head */
#import "DRCuXiaoHeaderView.h"  //倒计时标语
#import "CollectionReusableView.h"
/* foot */
//#import "DRFooterView.h"
//#import "DCTopLineFootView.h"    //热点
//#import "DCOverFootView.h"       //结束
//#import "DCScrollAdFootView.h"   //底滚动广告
//#import "DRGuangGaoView.h"
// Vendors
#import "DCHomeRefreshGifHeader.h"
#import <MJExtension.h>
#import "DOPDropDownMenu.h"
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
// Categories
#import "UIBarButtonItem+DCBarButtonItem.h"
// Others
#import "CDDTopTip.h"
#import "NetworkUnit.h"
#import "DRCuXiaoModel.h"
#define KHeadImageViewHeight 250
#define KMenuViewHeight      45
@interface DRCuXiaoVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>



/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 10个属性 */
@property (strong , nonatomic)NSMutableArray<DCGridItem *> *gridItem;
/* 推荐商品属性 */
@property (strong , nonatomic)NSArray<DCRecommendItem *> *youLikeItem;
/* 推荐商品属性 */
@property (strong , nonatomic)NSArray<DRCuXiaoModel *> *cuxiaoArr;
///* 顶部工具View */
//@property (nonatomic, strong) DCHomeTopToolView *topToolView;
/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;

@property (nonatomic, strong) NSMutableArray *classifys;
@property (nonatomic, strong) NSArray *cates;
@property (nonatomic, strong) NSArray *movices;
@property (nonatomic, strong) NSArray *hostels;
@property (nonatomic, strong) NSMutableArray *areas;
@property (nonatomic, strong) NSMutableDictionary *sendDic;


@property (nonatomic, strong) NSMutableArray *sorts;
@property (nonatomic, strong) QZConditionFilterView *conditionFilterView;
@property (nonatomic, strong) NSArray *filtersArray;

@end
/* cell */
static NSString *const DRCuxiaoCellID = @"DRCuxiaoCell";
/* head */
static NSString *const DRCuXiaoHeaderViewID = @"CollectionReusableView";


@implementation DRCuXiaoVC

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
//        HQCollectionViewFlowLayout *flowlayout = [[HQCollectionViewFlowLayout alloc] init];
//        //设置悬停高度
//        flowlayout.naviHeight = 0;
//        //
//        //左右间距
//        flowlayout.minimumInteritemSpacing = 1;
//        //上下间距
//        flowlayout.minimumLineSpacing = 1;
//        flowlayout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.sectionHeadersPinToVisibleBounds = YES;//头视图悬浮
        layout.sectionInset = UIEdgeInsetsMake(WScale(10), WScale(10), WScale(10), WScale(10));
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 44,ScreenW, ScreenH-DRTopHeight);
//        _collectionView.showsVerticalScrollIndicator = NO;        //注册
        _collectionView.backgroundColor =REDCOLOR;
        _collectionView.panGestureRecognizer.delaysTouchesBegan = _collectionView.delaysContentTouches;
        [_collectionView registerClass:[DRCuxiaoCell class] forCellWithReuseIdentifier:DRCuxiaoCellID];
        
        
        [_collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DRCuXiaoHeaderViewID];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"促销专区";
   
    [self setUpBase];
    [self setUpGoodsData];
    [self setUpScrollToTopView];
    [self setUpGIFRrfresh];
    [self getNetwork];
    
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTableViewContenInset) name:@"kSetTableViewContentInsetNSNotification" object:nil];
}
#pragma mark - 样式1
- (void)style1 {
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 1)];
    lineView.backgroundColor =BACKGROUNDCOLOR;
    [self.view addSubview:lineView];
    _conditionFilterView = [QZConditionFilterView conditionFilterViewWithListCount:3 FilterBlock:^(NSArray<NSString *> *filters) {
        self.filtersArray = filters;
        NSLog(@"%@", filters);
    }];
    _conditionFilterView.y = 1;
    // 设置初次加载显示的默认数据 即初次加载还没有选择操作之前要显示的标题数据
    NSArray *titlesArray = @[@"材质", @"大类", @"小类"];
    // 传入数据源，对应tableView顺序
    NSMutableArray *czArr =[NSMutableArray array];
    for (NSDictionary *dic in self.classifys) {
        [czArr addObject:dic[@"name"]];
    }
    NSMutableArray *dlArr =[NSMutableArray array];
    for (NSDictionary *dic in self.areas) {
        [dlArr addObject:dic[@"name"]];
    }
    NSMutableArray *xlArr =[NSMutableArray array];
    for (NSDictionary *dic in self.sorts) {
        [xlArr addObject:dic[@"name"]];
    }
    NSArray *dataArray1 =czArr.copy;
    NSArray *dataArray2 = dlArr.copy;
    NSArray *dataArray3 = xlArr.copy;
    _conditionFilterView.dataArrays = @[dataArray1, dataArray2, dataArray3];
    [_conditionFilterView updateFilterTableTitleWithTitleArray:titlesArray];
    [self.view addSubview:_conditionFilterView];
}

-(void)getPromotion
{
    NSDictionary *dic =@{@"cz":self.sendDic[@"cz"]?:@"",@"district":[DRUserInfoModel sharedManager].locationCode?:@"",@"id":self.sendDic[@"id"]?:@""};
    [SNAPI getWithURL:@"mainPage/getPromotion" parameters:dic.mutableCopy success:^(SNResult *result) {
        _cuxiaoArr =[DRCuXiaoModel mj_objectArrayWithKeyValuesArray:result.data];
        [_collectionView reloadData];
    } failure:^(NSError *error) {
   
    }];
    
}
- (void)setTableViewContenInset {
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
//    [self.collectionView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSLog(@"location =%@",[DRUserInfoModel sharedManager].locationCode?:@"");
}
#pragma mark - initialize
- (void)setUpBase
{
    self.collectionView.backgroundColor = REDCOLOR;
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
    [self getCZList];
    [self getPromotion];
//    _gridItem = [DCGridItem mj_objectArrayWithFilename:@"GoodsGrid.plist"];
//    _youLikeItem = [DCRecommendItem mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
}
-(void)getCZList
{
    [SNAPI getWithURL:@"mainPage/getCzList" parameters:nil success:^(SNResult *result) {
        self.classifys =[NSMutableArray array];
        NSDictionary *dic =@{@"name":@"材质",@"code":@"",@"id":@""};
        [self.classifys addObject:dic];
         [self.classifys addObjectsFromArray:result.data];
        NSDictionary *bigdic =@{@"name":@"大类",@"code":@"",@"id":@""};
        self.areas =[NSMutableArray array];
        self.sendDic =[NSMutableDictionary dictionary];
        [self.sendDic setObject:self.classifys[1][@"id"] forKey:@"cz"];
        [self.areas addObject:bigdic];
        [self promotionCategory];
//         [_menu reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(void)promotionCategory
{
    NSDictionary *dic =@{@"cz":self.sendDic[@"cz"],@"districtId": [DRUserInfoModel sharedManager].locationCode?:@""};
    [SNAPI getWithURL:@"mainPage/promotionCategory" parameters:dic.mutableCopy success:^(SNResult *result) {
        NSDictionary *dic =@{@"name":@"大类",@"code":@"",@"id":@""};
        self.areas =[NSMutableArray array];
        [self.areas addObject:dic];
        [self.areas addObjectsFromArray:result.data];
         NSDictionary *smalldic =@{@"name":@"小类",@"code":@"",@"id":@""};
        self.sorts =[NSMutableArray array];
        [self.sorts addObject:smalldic];
      [self style1];
    } failure:^(NSError *error) {

    }];
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

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _cuxiaoArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section==0) {
       
    }
    DRCuxiaoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DRCuxiaoCellID forIndexPath:indexPath];
    cell.lookSameBlock = ^{
        NSLog(@"点击了第%zd商品的比价格",indexPath.row);
    };
    cell.cuxiaoModel = _cuxiaoArr[indexPath.row];
    gridcell = cell;
    return gridcell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        CollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DRCuXiaoHeaderViewID forIndexPath:indexPath];
        footerView.userInteractionEnabled =NO;
       
        return footerView;
    }
    return nil;
}
//这里我为了直观的看出每组的CGSize设置用if 后续我会用简洁的三元表示
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        CGSizeMake(ScreenW, WScale(187));
    }
    return CGSizeMake((ScreenW -30)/2, WScale(187));
}
#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(ScreenW, 44);
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
    CategoryDetailVC *goodSetVc =[[CategoryDetailVC alloc] init];
    goodSetVc.classListStr =_cuxiaoArr[indexPath.row].classList;
    goodSetVc.czID =_cuxiaoArr[indexPath.row].cz;
    goodSetVc.queryTypeStr =@"promotion";
    [GoodsShareModel sharedManager].queryType =goodSetVc.queryTypeStr;
    [self.navigationController pushViewController:goodSetVc animated:YES];
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

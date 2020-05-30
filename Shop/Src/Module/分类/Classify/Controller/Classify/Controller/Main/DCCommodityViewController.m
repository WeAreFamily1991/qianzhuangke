//
//  DCCommodityViewController.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//
#define tableViewH  105

#import "DCCommodityViewController.h"

// Controllers
#import "DCGoodsSetViewController.h"
#import "MLSearchViewController.h"
#import "DRLocationVC.h"
// Models
#import "DCClassMianItem.h"
#import "DCCalssSubItem.h"
#import "DCClassGoodsItem.h"
#import "SendSourceModel.h"
#import "DRFactoryModel.h"

// Views
#import "DCNavSearchBarView.h"
#import "DCClassCategoryCell.h"
#import "DCGoodsSortCell.h"
#import "DCBrandSortCell.h"
#import "DRFactoryCell.h"
#import "DCBrandsSortHeadView.h"
#import "CBSegmentView.h"
// Vendors
#import <MJExtension.h>
// Categories
#import "UIBarButtonItem+DCBarButtonItem.h"
#import "CategoryDetailVC.h"

// Others

@interface DCCommodityViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/* tableView */
@property (strong , nonatomic)UITableView *tableView;
/* collectionViw */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 搜索 */
@property (strong , nonatomic)UIView *topSearchView;
/* 搜索按钮 */
@property (strong , nonatomic)UIButton *searchButton;
/* 语音按钮 */
@property (strong , nonatomic)UIButton *voiceButton;

@property (nonatomic,retain)DCUpDownButton *bgTipButton;
/* 左边数据 */
@property (strong , nonatomic)NSMutableArray<DCClassGoodsItem *> *titleItem;
/* 右边数据 */
@property (strong , nonatomic)NSMutableArray<DCClassMianItem *> *mainItem;
/* 右边数据 */
@property (strong , nonatomic)NSMutableArray<DRFactoryModel *> *factoryArr;

@property (nonatomic,strong)NSMutableArray *sendArr ,*nameArr,*sectionArr;
@property (nonatomic,strong)SendSourceModel *souceModel;
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (strong,nonatomic) NSDictionary *hotSearchDic;

@property (strong,nonatomic)NSString *level1IdStr;
@property (strong,nonatomic)NSString *level2IdStr;
@property (strong,nonatomic)NSString *categoryIdStr;

@end

static NSString *const DCClassCategoryCellID = @"DCClassCategoryCell";
static NSString *const DCBrandsSortHeadViewID = @"DCBrandsSortHeadView";
static NSString *const DCGoodsSortCellID = @"DCGoodsSortCell";
static NSString *const DCBrandSortCellID = @"DCBrandSortCell";
static NSString *const DRFactoryCellID = @"DRFactoryCell";

@implementation DCCommodityViewController

#pragma mark - LazyLoad

-(NSDictionary *)hotSearchDic
{
    if (!_hotSearchDic) {
        _hotSearchDic =[NSDictionary dictionary];
    }
    return _hotSearchDic;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor =BACKGROUNDCOLOR;
        _tableView.frame = CGRectMake(0, 50, tableViewH, ScreenH -50-DRTabBarHeight-DRTopHeight);
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        
        [_tableView registerClass:[DCClassCategoryCell class] forCellReuseIdentifier:DCClassCategoryCellID];
        
    }
    return _tableView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumInteritemSpacing = 0; //X
        layout.minimumLineSpacing = 1;  //Y
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor =CLEARCOLOR;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.frame = CGRectMake(tableViewH ,50, ScreenW - tableViewH - DCMargin, ScreenH - DRTopHeight-50-DRTabBarHeight);
        //注册Cell
        [_collectionView registerClass:[DCGoodsSortCell class] forCellWithReuseIdentifier:DCGoodsSortCellID];
        [_collectionView registerClass:[DRFactoryCell class] forCellWithReuseIdentifier:DRFactoryCellID];
        [_collectionView registerClass:[DCBrandSortCell class] forCellWithReuseIdentifier:DCBrandSortCellID];
        //注册Header
        [_collectionView registerClass:[DCBrandsSortHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCBrandsSortHeadViewID];
    }
    return _collectionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
     [self.view addSubview:self.bgTipButton];
    _sendDataDictionary =[NSMutableDictionary dictionaryWithObjects:@[@""] forKeys:@[@"cz"]];
    self.sectionArr =[NSMutableArray array];
    [self setUpNav];
    [self setUpHeaderBtn];
    [self setUpTab];
    [self setUpData];
    [self setHotSearch];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self ConfigLightStatusColor];
   self.navigationController.navigationBar.barTintColor = REDCOLOR;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
//    [self ConfigBlackStatusColor];
    self.navigationController.navigationBar.barTintColor = WHITECOLOR;
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
-(void)setUpHeaderBtn
{
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width,50)];
    backView.backgroundColor =REDCOLOR;
    [self.view addSubview:backView];
    DRWeakSelf;
    [SNAPI getWithURL:@"mainPage/getCzList" parameters:nil success:^(SNResult *result)
    {
        NSDictionary *dic =@{@"id":@"",@"name":@"全部"};
        weakSelf.nameArr=[NSMutableArray arrayWithObject:@"全部"];
        for (NSDictionary *dic in result.data) {
            [weakSelf.nameArr addObject:dic[@"name"]];
        }
        weakSelf.sendArr=[[NSMutableArray alloc]initWithObjects:dic, nil];
        [weakSelf.sendArr addObjectsFromArray:result.data];
        CBSegmentView *zoomSegmentView = [[CBSegmentView alloc]initWithFrame:backView.bounds];
        [backView addSubview:zoomSegmentView];
       
        [zoomSegmentView setTitleArray:weakSelf.nameArr titleFont:15 titleColor:WHITECOLOR titleSelectedColor:WHITECOLOR withStyle:CBSegmentStyleSlider];
        zoomSegmentView.titleChooseReturn = ^(NSInteger x) {
            NSLog(@"点击了第%ld个按钮",x+1);
            [self.sendDataDictionary setObject:self.sendArr[x][@"id"] forKey:@"cz"];
            [self setUpData];
        };
//        UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 3)];
//        lineView.backgroundColor =WHITECOLOR;
//        [backView addSubview: lineView];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - initizlize
- (void)setUpTab
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collectionView.backgroundColor = CLEARCOLOR;
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - 加载数据
- (void)setUpData
{
    [self addSource];
    [self addgetFactoryArea];
//    _titleItem = [DCClassGoodsItem mj_objectArrayWithFilename:@"ClassifyTitles.plist"];
//    _mainItem = [DCClassMianItem mj_objectArrayWithFilename:@"ClassiftyGoods01.plist"];
    //默认选择第一行（注意一定要在加载完数据之后）
}
-(void)addSource
{
     DRWeakSelf;
    [MBProgressHUD showMessage:@""];
    [SNAPI getWithURL:@"mainPage/itemCategory" parameters:_sendDataDictionary success:^(SNResult *result) {
        
        weakSelf.mainItem =[NSMutableArray array];
        weakSelf.titleItem = [DCClassGoodsItem mj_objectArrayWithKeyValuesArray:result.data];
        [weakSelf.tableView reloadData];
        //默认选择第一行（注意一定要在加载完数据之后）
        NSArray *DATAArr =result.data;
        if (DATAArr.count!=0) {
            weakSelf.tableView.backgroundColor =BACKGROUNDCOLOR;
            [weakSelf.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
//            NSMutableArray *muItem =[NSMutableArray array];
            self.sectionArr=[ChildCategory2 mj_objectArrayWithKeyValuesArray:weakSelf.titleItem[0].childList2];
            self.level1IdStr =self.titleItem[0].title_id;
        }else
        {
            weakSelf.tableView.backgroundColor =CLEARCOLOR;
        }
        [weakSelf.collectionView reloadData];
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}
-(void)addgetFactoryArea
{
     DRWeakSelf;
    [MBProgressHUD showMessage:@""];
    NSDictionary *dic =@{@"pageNum":@"1",@"pageSize":@"10"};
    [SNAPI getWithURL:@"mainPage/getFactoryArea" parameters:dic.mutableCopy success:^(SNResult *result) {
        weakSelf.factoryArr =[NSMutableArray array];
        weakSelf.factoryArr = [DRFactoryModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
        [weakSelf.collectionView reloadData];
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}
-(void)setHotSearch
{
    DRWeakSelf;
    [SNAPI getWithURL:@"mainPage/hotSearch" parameters:nil success:^(SNResult *result) {
        weakSelf.hotSearchDic =result.data;
    } failure:^(NSError *error) {
    }];
}
#pragma mark - 设置导航条
- (void)setUpNav
{
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    negativeSpacer.width = -15;
    
//    UIButton *button = [[UIButton alloc] init];
//    [button setImage:[UIImage imageNamed:@"mshop_message_gray_icon"] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:@"mshop_message_gray_icon"] forState:UIControlStateHighlighted];
//    button.frame = CGRectMake(0, 0, 44, 44);
//    [button addTarget:self action:@selector(messButtonBarItemClick) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
//
//    self.navigationItem.rightBarButtonItems = @[negativeSpacer, backButton];
    
    _topSearchView = [[UIView alloc] init];
    _topSearchView.backgroundColor = WHITECOLOR;
    _topSearchView.layer.cornerRadius = 4;
    [_topSearchView.layer masksToBounds];
    _topSearchView.frame = CGRectMake(WScale(10), WScale(6), ScreenW - WScale(20), WScale(32));
    self.navigationItem.titleView = _topSearchView;
    
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchButton setTitle:@"请输入关键字" forState:0];
    [_searchButton setTitleColor:[UIColor lightGrayColor] forState:0];
    _searchButton.titleLabel.font = DR_FONT(14);
    [_searchButton setImage:[UIImage imageNamed:@"search_ico_search"] forState:0];
    [_searchButton adjustsImageWhenHighlighted];
    _searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2 * DCMargin, 0, 0);
    _searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, DCMargin, 0, 0);
    [_searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _searchButton.frame = CGRectMake(0, 0, _topSearchView.dc_width - 2 * DCMargin, _topSearchView.dc_height);
    [_topSearchView addSubview:_searchButton];
    
    
//    _voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _voiceButton.adjustsImageWhenHighlighted = NO;
//    _voiceButton.frame = CGRectMake(_topSearchView.dc_width - 40, 0, 35, _topSearchView.dc_height);
//    [_voiceButton addTarget:self action:@selector(voiceButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [_voiceButton setImage:[UIImage imageNamed:@"icon_voice_search"] forState:0];
//    [_topSearchView addSubview:_voiceButton];
    
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DCClassCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:DCClassCategoryCellID forIndexPath:indexPath];
    cell.titleItem = _titleItem[indexPath.row];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WScale(50);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    _mainItem = [DCClassMianItem mj_objectArrayWithFilename:_titleItem[indexPath.row].fileName];
//    NSMutableArray *muItem =[NSMutableArray array];
//    if (_titleItem[indexPath.row].childList2.count==0) {
//        [_mainItem removeAllObjects];
//    }else
//    {
//
//        for (NSDictionary *dic in _titleItem[indexPath.row].childList2) {
//
//            NSArray *mainItemArr  =[DCClassMianItem mj_objectArrayWithKeyValuesArray:dic[@"childList"]];
//            [muItem addObjectsFromArray:mainItemArr];
//            _mainItem =muItem;
//        }
//    }
     self.sectionArr=[ChildCategory2 mj_objectArrayWithKeyValuesArray:self.titleItem[indexPath.row].childList2];
    self.level1IdStr =self.titleItem[indexPath.row].title_id;
    [self.collectionView reloadData];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if ([self.statusStr isEqualToString:@"homePush"]) {
        self.bgTipButton.hidden = (_sectionArr.count > 0) ? YES : NO;
        return self.sectionArr.count+1;
    }
    self.bgTipButton.hidden = (_sectionArr.count > 0) ? YES : NO;
    return self.sectionArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if ([self.statusStr isEqualToString:@"homePush"]&&section==0) {
        return _factoryArr.count;
    }

    ChildCategory2 *sectionModel =self.sectionArr[section];
    return sectionModel.isSelected?sectionModel.childList.count:0;
}
#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *gridcell = nil;
    if ([self.statusStr isEqualToString:@"homePush"]&&indexPath.section==0) {
       DRFactoryCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:DRFactoryCellID forIndexPath:indexPath];
//        cell.mainItem = _mainItem[indexPath.row];
//        NSArray *titleArr =@[@"宁波",@"宁波",@"宁波",@"宁波",@"宁波",@"宁波",@"宁波",@"宁波",@"宁波",@"上海"];
        cell.factoryModel =_factoryArr[indexPath.row];
        gridcell = cell;
        return gridcell;
    }else
    {
        DCGoodsSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsSortCellID forIndexPath:indexPath];
         ChildCategory2 *sectionModel =self.sectionArr[indexPath.section];
        NSArray *childListArr =[ChildList mj_objectArrayWithKeyValuesArray:sectionModel.childList];
        ChildList *childModel =childListArr[indexPath.row];
        cell.childModel = childModel;
        gridcell = cell;
        return gridcell;
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        
        DCBrandsSortHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCBrandsSortHeadViewID forIndexPath:indexPath];
        ChildCategory2 *sectionModel =self.sectionArr[indexPath.section];
        headerView.cateproyModel = sectionModel;
        headerView.selectedBlock = ^{
            sectionModel.isSelected =!sectionModel.isSelected;
             [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
        };
        reusableview = headerView;
    }
    return reusableview;
}
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.statusStr isEqualToString:@"homePush"]&&indexPath.section==0) {
        return CGSizeMake((ScreenW - tableViewH  - DCMargin)/5, (ScreenW - tableViewH  - DCMargin)/5);
    }
    return CGSizeMake(ScreenW - tableViewH  - DCMargin, WScale(75));
}
#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
   return CGSizeMake(ScreenW - tableViewH, WScale(50));
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了个第%zd分组第%zd几个Item",indexPath.section,indexPath.row);
//     [self.navigationController pushViewController:[CategoryDetailVC new] animated:YES];
    if ([self.statusStr isEqualToString:@"homePush"]&&indexPath.section==0)
    {
        NSArray *advTypeArr =@[@"001",@"002",@"003",@"004",@"005",@"006",@"007",@"008",@"009",@"010"];
        DRFactoryModel *factoryModel =_factoryArr[indexPath.row];
        DRLocationVC *locationVC =[[DRLocationVC alloc]init];
        locationVC.advType =advTypeArr[indexPath.row];
        locationVC.factoryModel =_factoryArr[indexPath.row];
        locationVC.title =factoryModel.name;
        locationVC.isHome =@"0";
        [self.navigationController pushViewController:locationVC animated:YES];
        
    }else
    {
        CategoryDetailVC *goodSetVc =[[CategoryDetailVC alloc] init];
        ChildCategory2 *sectionModel =self.sectionArr[indexPath.section];
        self.level2IdStr =sectionModel.child2_id;
        NSArray *childListArr =[ChildList mj_objectArrayWithKeyValuesArray:sectionModel.childList];
        ChildList *childModel =childListArr[indexPath.row];
        self.categoryIdStr =childModel.child_id;
        goodSetVc.classListStr =[NSString stringWithFormat:@"%@,%@,%@",self.level1IdStr,self.level2IdStr,self.categoryIdStr];
        goodSetVc.categoryIdStr =self.categoryIdStr;
        goodSetVc.level1IdStr =self.level1IdStr;
        goodSetVc.level2IdStr =self.level2IdStr;
        goodSetVc.czID =[_sendDataDictionary objectForKey:@"cz"];
        goodSetVc.queryTypeStr =@"normal";
        [GoodsShareModel sharedManager].queryType =goodSetVc.queryTypeStr;
        [self.navigationController pushViewController:goodSetVc animated:YES];
    }
}
#pragma mark - 搜索点击
- (void)searchButtonClick
{
    MLSearchViewController *vc = [[MLSearchViewController alloc] init];
    vc.hotSearchDic =self.hotSearchDic;
    //    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 语音点击
- (void)voiceButtonClick
{
    
}

#pragma mark - 消息点击
- (void)messButtonBarItemClick
{
    
}
- (DCUpDownButton *)bgTipButton
{
    if (!_bgTipButton) {
        _bgTipButton = [DCUpDownButton buttonWithType:UIButtonTypeCustom];
        [_bgTipButton setImage:[UIImage imageNamed:@"img_msg_biaodan"] forState:UIControlStateNormal];
        _bgTipButton.titleLabel.font = DR_FONT(13);
        [_bgTipButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_bgTipButton setTitle:@"暂无分类信息" forState:UIControlStateNormal];
        _bgTipButton.frame = CGRectMake((ScreenW - 150) * 1/2 , (ScreenH - 150) * 1/2-DRTopHeight, 150, 150);
        _bgTipButton.adjustsImageWhenHighlighted = false;
    }
    return _bgTipButton;
}

@end

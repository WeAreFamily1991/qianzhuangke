//
//  DCHandPickViewController.m
//  CDDMall
//
//  Created by apple on 2017/5/26.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//
#define NeedStartMargin 10   // 首列起始间距
#define NeedBtnHeight 27  // 按钮高度
#import "DCHandPickViewController.h"
#import "HQCollectionViewFlowLayout.h"

#import "HQTopStopView.h"
// Controllers
#import "DRShopHomeVC.h"
#import "DRAirCloudShopVC.h"
#import "DCCommodityViewController.h"
#import "DRNewsVC.h"
#import "DRLocationVC.h"
#import "DRCuXiaoVC.h"
#import "DRTigetsVC.h"
#import "DRComeVC.h"
#import "DRHelpCenterVC.h"
#import "CGXPickerView.h"
#import "ZJViewShow.h"
#import "NewsModel.h"
#import "HomeBannerModel.h"
#import "DRSameLookVC.h"
#import "DRShopListVC.h"
#import "CategoryDetailVC.h"
#import "MLSearchViewController.h"
#import "DRSellerListVC.h"
//#import "DCGoodsSetViewController.h"
//#import "DCCommodityViewController.h"
//#import "DCMyTrolleyViewController.h"
//#import "DCGoodDetailViewController.h"
//#import "DCGMScanViewController.h"
// Models
#import "DCGridItem.h"
#import "DCRecommendItem.h"
#import "DRNullGoodModel.h"
#import "DRBigCategoryModel.h"
#import "DRItemModel.h"
// Views
#import "DCNavSearchBarView.h"
#import "DCHomeTopToolView.h"
/* cell */
#import "DCGoodsCountDownCell.h" //倒计时商品
#import "DCNewWelfareCell.h"     //新人福利
#import "DCGoodsHandheldCell.h"  //掌上专享
#import "DCExceedApplianceCell.h"//不止
#import "DCGoodsYouLikeCell.h"   //猜你喜欢商品
#import "DCGoodsGridCell.h"      //10个选项
#import "DRNullGoodLikesCell.h"  //爆品牛商cell
/* head */
#import "DCSlideshowHeadView.h"  //轮播图
#import "DCCountDownHeadView.h"  //倒计时标语
#import "DCYouLikeHeadView.h"    //猜你喜欢等头部标语
/* foot */
#import "DRFooterView.h"
#import "DCTopLineFootView.h"    //热点
#import "DCOverFootView.h"       //结束
#import "DCScrollAdFootView.h"   //底滚动广告
#import "DRGuangGaoView.h"
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
#import "DRNullMainVC.h"
static const CGFloat VerticalListCategoryViewHeight = 60;   //悬浮categoryView的高度
static const NSUInteger VerticalListPinSectionIndex = 3;    //悬浮固定section的index
@interface DCHandPickViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,CLLocationManagerDelegate>
{
    CLLocationManager*locationmanager;//定位服务
    NSString*strlatitude;//经度
    NSString*strlongitude;//纬度
    ZJViewShow *showView;


}
@property (nonatomic,strong)DRNullGoodModel *nullGoodModel;
@property (nonatomic,strong)DRBigCategoryModel *bigCategoryModel;
@property (nonatomic,strong)NewsModel *newmodel;
@property (nonatomic,strong)HomeBannerModel *bannerModel;
@property (nonatomic,strong)NSMutableArray *bannerArr,*mobileBannArr,*newsArr,*nullArr,*bottomBannerArr,* tipArr;
/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 10个属性 */
@property (strong , nonatomic)NSMutableArray<DCGridItem *> *gridItem;
/* 推荐商品属性 */
@property (strong , nonatomic)NSMutableArray *homeCatoryArr,*itemMuArr;
@property (nonatomic,strong)DCRecommendItem *listMOdel;
@property (nonatomic,strong)ItemList *itemModel;
/* 顶部工具View */
@property (nonatomic, strong) DCHomeTopToolView *topToolView;
@property (nonatomic, strong)UICollectionReusableView *topHeaderView;
@property (nonatomic, strong) HQTopStopView *DRheaderView;
/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;

@property (strong,nonatomic)NSArray *bigCartporyArr;
@property (strong,nonatomic)NSString *selectedID,*zyStoreIdStr;

@property (strong,nonatomic) NSDictionary *hotSearchDic;

@property (nonatomic, strong) NSArray <UICollectionViewLayoutAttributes *> *sectionHeaderAttributes;


@end
/* cell */
static NSString *const DCGoodsCountDownCellID = @"DCGoodsCountDownCell";
static NSString *const DCNewWelfareCellID = @"DCNewWelfareCell";
static NSString *const DCGoodsHandheldCellID = @"DCGoodsHandheldCell";
static NSString *const DCGoodsYouLikeCellID = @"DCGoodsYouLikeCell";
static NSString *const DCGoodsGridCellID = @"DCGoodsGridCell";
static NSString *const DCExceedApplianceCellID = @"DCExceedApplianceCell";
static NSString *const DRNullGoodLikesCellCellID = @"DRNullGoodLikesCell";
/* head */
static NSString *const DCSlideshowHeadViewID = @"DCSlideshowHeadView";
static NSString *const DCCountDownHeadViewID = @"DCCountDownHeadView";
static NSString *const DCYouLikeHeadViewID = @"DCYouLikeHeadView";
/* foot */
static NSString *const DRFooterViewID = @"DRFooterView";
static NSString *const DCTopLineFootViewID = @"DCTopLineFootView";
static NSString *const DCOverFootViewID = @"DCOverFootView";
static NSString *const DCScrollAdFootViewID = @"DCScrollAdFootView";
static NSString *const DRGuangGaoFootViewID = @"DRGuangGaoView";

static NSString *const DRTopViewID = @"HQTopStopView";
@implementation DCHandPickViewController

#pragma mark - LazyLoad
-(NSDictionary *)hotSearchDic
{
    if (!_hotSearchDic) {
        _hotSearchDic =[NSDictionary dictionary];
    }
    return _hotSearchDic;
}

      
  
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
//        HQCollectionViewFlowLayout *flowlayout = [[HQCollectionViewFlowLayout alloc] init];
//        //设置悬停高度
//        flowlayout.naviHeight = DRTopHeight+WScale(45);
////
//        //左右间距
//        flowlayout.minimumInteritemSpacing = 2;
//        //上下间距
//        flowlayout.minimumLineSpacing = 2;
////        flowlayout.sectionInset = UIEdgeInsetsMake(0, 2, 0, 2);
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.sectionHeadersPinToVisibleBounds = YES;//头视图悬浮
         layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, DRTopHeight+WScale(45), ScreenW, ScreenH - DRTabBarHeight-WScale(45)-DRTopHeight) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.allowsMultipleSelection=YES;
        [_collectionView registerClass:[DCGoodsCountDownCell class] forCellWithReuseIdentifier:DCGoodsCountDownCellID];
        [_collectionView registerClass:[DCGoodsHandheldCell class] forCellWithReuseIdentifier:DCGoodsHandheldCellID];
        [_collectionView registerClass:[DCGoodsYouLikeCell class] forCellWithReuseIdentifier:DCGoodsYouLikeCellID];
        [_collectionView registerClass:[DCGoodsGridCell class] forCellWithReuseIdentifier:DCGoodsGridCellID];
        [_collectionView registerClass:[DCExceedApplianceCell class] forCellWithReuseIdentifier:DCExceedApplianceCellID];
        [_collectionView registerClass:[DCNewWelfareCell class] forCellWithReuseIdentifier:DCNewWelfareCellID];
         [_collectionView registerClass:[DRNullGoodLikesCell class] forCellWithReuseIdentifier:DRNullGoodLikesCellCellID];
        
         [_collectionView registerClass:[DRFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DRFooterViewID];
        [_collectionView registerClass:[DCTopLineFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCTopLineFootViewID];
        [_collectionView registerClass:[DCOverFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCOverFootViewID];
        [_collectionView registerClass:[DCScrollAdFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCScrollAdFootViewID];
        [_collectionView registerClass:[DCYouLikeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCYouLikeHeadViewID];
        [_collectionView registerClass:[DCSlideshowHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCSlideshowHeadViewID];
        [_collectionView registerClass:[DCCountDownHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCCountDownHeadViewID];
         [_collectionView registerClass:[DRGuangGaoView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DRGuangGaoFootViewID];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:@"topHeader"];
        [self.view addSubview:_collectionView];
        
        
    }
    return _collectionView;
}
#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.bigCartporyArr =@[@"12.9级/10.9级",@"螺栓",@"螺母",@"螺丝钉",@"螺丝帽",@"螺蛳粉",@"螺蛳肉"];
    [self setUpBase];
    
    [self setUpNavTopView];
    
    [self setUpGoodsData];
    
    [self setUpScrollToTopView];
    
    [self setUpGIFRrfresh];
    
    [self getNetwork];
    
    [self loadLocation];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"HQTopStopView" object:nil];    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginHandler:) name:@"loginVC" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationHandler:) name:@"myLocation" object:nil];
    //       self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;
}
- (void)notificationHandler:(NSNotification *)notification {
    if ([notification.name isEqualToString:@"HQTopStopView"]) {
        NSDictionary *dic =notification.userInfo;
        NSString *tagStr=dic[@"tag"];
        self.selectedID =self.bigCartporyArr[[tagStr integerValue]][@"id"];
        [self getMobHomeBurstItemList];
        [self getHomeBigCategoryImg];
    }
}
-(void)loginHandler:(NSNotification *)notification
{
   [self setUpGoodsData];
   [self loadLocation];
   [self.DRheaderView removeFromSuperview];
   [_collectionView.mj_header beginRefreshing];
}
- (void)locationHandler:(NSNotification *)notification
{
    if ([notification.name isEqualToString:@"myLocation"])
    {
        NSDictionary *dic =notification.userInfo;
        NSString *nameStr=dic[@"address"];
        NSString *codeStr=dic[@"locationCode"];
        [_topToolView.voiceButton setTitle:nameStr forState:UIControlStateNormal];
        [DRUserInfoModel sharedManager].locationCode =codeStr;
        [DEFAULTS setObject:codeStr forKey:@"locationCode"];
        [DEFAULTS setObject:codeStr forKey:@"code"];
        [_collectionView.mj_header beginRefreshing];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self ConfigLightStatusColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
//    [self ConfigBlackStatusColor];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)loadLocation
{
    if (![User currentUser].isLogin) {
        if ([DEFAULTS objectForKey:@"MobileLocationCode"]) {
            [DRUserInfoModel sharedManager].locationCode  = [DEFAULTS objectForKey:@"MobileLocationCode"];
            [_topToolView.voiceButton setTitle:[DEFAULTS objectForKey:@"MobileLocationAddress"] forState:UIControlStateNormal];
            [DEFAULTS setObject:[DRUserInfoModel sharedManager].locationCode forKey:@"code"];
            [_collectionView.mj_header beginRefreshing];
        }else
        {
            if (![DEFAULTS objectForKey:@"locationCode"]) {
                [CGXPickerView showAddressPickerWithTitle:@"请选择地区" DefaultSelected:@[@0, @0] IsAutoSelect:YES Manager:nil ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
                    //NSLog(@"%@-%@",selectAddressArr,selectAddressRow);
                    self.topToolView.voiceButton.titleLabel.text =selectAddressArr[1];
                    [DRUserInfoModel sharedManager].location = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]];
                    [DRUserInfoModel sharedManager].locationCode =[selectAddressArr lastObject];
                    [DEFAULTS setObject:[NSString stringWithFormat:@"%@/%@/%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]] forKey:@"address"];
                    [DEFAULTS setObject:selectAddressArr[4] forKey:@"locationCode"];
                    [DEFAULTS setObject:selectAddressArr[4] forKey:@"code"];
                    //            weakSelf.navigationItem.title = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]];
                    [_collectionView.mj_header beginRefreshing];
                }];
            }
            else
            {
                NSArray *codeArr =[[DEFAULTS objectForKey:@"locationCode"] componentsSeparatedByString:@"/"];
                [DRUserInfoModel sharedManager].locationCode  = [codeArr lastObject];
                [DRUserInfoModel sharedManager].location  = [DEFAULTS objectForKey:@"address"];
                NSArray *nameArr =[[DRUserInfoModel sharedManager].location componentsSeparatedByString:@"/"];
                if (nameArr.count==3)
                {
                    [_topToolView.voiceButton setTitle:nameArr[1] forState:UIControlStateNormal];
                }
                [DEFAULTS setObject:[codeArr lastObject] forKey:@"code"];
            }
        }
    }else
    {
        NSArray *codeArr =[[DEFAULTS objectForKey:@"locationCode"] componentsSeparatedByString:@"/"];
        [DRUserInfoModel sharedManager].locationCode  = codeArr[1];
        [DRUserInfoModel sharedManager].addressCode =[codeArr lastObject];
        [DRUserInfoModel sharedManager].location  = [DEFAULTS objectForKey:@"address"];
        NSArray *nameArr =[[DRUserInfoModel sharedManager].location componentsSeparatedByString:@"/"];
        if (nameArr.count==3)
        {
            [_topToolView.voiceButton setTitle:[nameArr lastObject] forState:UIControlStateNormal];
        }
        [DEFAULTS setObject:codeArr[1] forKey:@"code"];
    }
}
//-(void)getLOcationWithDic:(NSMutableDictionary*)dic
//{
//    [SNAPI getWithURL:@"mainPage/getMobileLocation" parameters:dic success:^(SNResult *result) {
//        NSDictionary *dic =result.data[@"city"];
//        [_topToolView.voiceButton setTitle:dic[@"name"] forState:UIControlStateNormal];
//        [DRUserInfoModel sharedManager].locationCode =dic[@"id"];
//        [DEFAULTS setObject:dic[@"id"] forKey:@"locationCode"];
//        [DEFAULTS setObject:dic[@"id"] forKey:@"code"];
//
//        [MBProgressHUD hideHUD];
//    } failure:^(NSError *error) {
//
//    }];
//}
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
        [self geToken];
        [weakSelf.collectionView.mj_header endRefreshing];
    });
}
-(void)geToken
{
//    if ([User currentUser].isLogin) {
//        // 获取用户信息
//        [self setUpGoodsData];
//    } else {
//        // 以游客模式登录
//
//        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"ios", @"dGVzdA=="] forKeys:@[@"username", @"secret"]];
//
//        //    if (areaCode) [dict setObject:areaCode forKey:@"area_code"];
//
//        [SNIOTTool postvisiteTokenWithURL:GET_TOKEN parameters:dict success:^(SNResult *result) {
//            NSString *visiteStr =result.data[@"jwt"];
////            [User currentUser].visitetoken =visiteStr;
//            [DEFAULTS setObject:visiteStr forKey:@"visitetoken"];
            [self setUpGoodsData];
//        } failure:^(NSError *error) {
//
//        }];
//    }
}
#pragma mark - 加载数据
- (void)setUpGoodsData
{
    _gridItem = [DCGridItem mj_objectArrayWithFilename:@"GoodsGrid.plist"];
//    _youLikeItem = [DCRecommendItem mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
    [self GetNews];
    [self getSellerLink];
    [self shoujixinwen];
    [self getburstmainPageList];
    [self getHomeBigCategoryList];
    [self systemSetting];
    [self setHotSearch];
}
-(void)systemSetting
{
    [SNAPI getWithURL:@"mainPage/systemSetting" parameters:nil success:^(SNResult *result) {
       
          self.zyStoreIdStr =result.data[@"zyStoreId"];
        [DRUserInfoModel sharedManager].zyStoreId =result.data[@"zyStoreId"];
         
    } failure:^(NSError *error) {
        
    }];
}
-(void)GetNews
{
    NSDictionary *dic =@{@"bannerImgType":@"1",@"districtId":@"53990"};
    [SNAPI getWithURL:@"mainPage/mobile/banner" parameters:[dic mutableCopy] success:^(SNResult *result) {
        self.bannerArr =[NSMutableArray array];
        self.mobileBannArr =[NSMutableArray array];
        NSArray *sourceArr =[HomeBannerModel mj_objectArrayWithKeyValuesArray:result.data];
        self.mobileBannArr=sourceArr.mutableCopy;
        for (HomeBannerModel *model in sourceArr) {
            [self.bannerArr addObject:model.bannerImgUrl];
        }
        
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

-(void)getSellerLink
{
    NSDictionary *dic =@{@"districtId":[DEFAULTS objectForKey:@"code"]?:@"1243"};
    DRWeakSelf;
    [SNAPI getWithURL:@"mainPage/getCloudBaseStore" parameters:[dic mutableCopy] success:^(SNResult *result) {
        weakSelf.itemMuArr =[DRItemModel mj_objectArrayWithKeyValuesArray:result.data];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
   
    }];
}
-(void)shoujixinwen
{
    NSDictionary *dic =@{@"typeCode":@"shoujixinwen",@"pageNum":@"1",@"pageSize":@"10"};
    [SNAPI getWithURL:@"mainPage/news" parameters:[dic mutableCopy] success:^(SNResult *result) {
        self.newsArr =[NSMutableArray array];
        self.tipArr =[NSMutableArray array];
        //             NSArray *sourceArr =result.data;
        NSArray *sourceArr =[NewsModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
        for (NewsModel *model in sourceArr) {
            //                [self.newsArr addObject:model.imageurl];
            [self.tipArr addObject:model.title];
        }
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(void)getburstmainPageList
{
    NSDictionary *dic =@{@"districtId":[DEFAULTS objectForKey:@"code"]?:@"1243"};
    [SNAPI getWithURL:@"burst/mainPageList" parameters:[dic mutableCopy] success:^(SNResult *result) {
        self.nullArr =[NSMutableArray array];
        self.nullArr =[DRNullGoodModel mj_objectArrayWithKeyValuesArray:result.data];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
       
    }];
}
-(void)getHomeBigCategoryList
{
    NSDictionary *dic =@{@"districtId":[DEFAULTS objectForKey:@"code"]?:@"1243"};
    [SNAPI getWithURL:@"burst/getHomeBigCategoryList" parameters:[dic mutableCopy] success:^(SNResult *result) {
        self.bigCartporyArr =[NSMutableArray array];
        self.bigCartporyArr =result.data;
        //         self.bigCartporyArr  =[self.bigCartporyArr subarrayWithRange:NSMakeRange(0, 2)];
        self.selectedID =[self.bigCartporyArr firstObject][@"id"];
        if (self.selectedID.length!=0) {
            [self getMobHomeBurstItemList];
            [self getHomeBigCategoryImg];
        }
        //初始行_列的X、Y值设置
        float butX = NeedStartMargin;
        float butY =10;
        for(int i = 0; i < self.bigCartporyArr.count; i++){
            //宽度自适应计算宽度
            NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
            CGRect frame_W = [self.bigCartporyArr[i][@"name"] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
            //宽度计算得知当前行不够放置时换行计算累加Y值
            if (i>3) {
                butX = NeedStartMargin;
                butY = 2*NeedBtnHeight+WScale(25);//Y值累加，具体值请结合项目自身需求设置 （值 = 按钮高度+按钮间隙）
            }
            //设置计算好的位置数值
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(butX, butY, frame_W.size.width+NeedStartMargin*2, NeedBtnHeight)];
            //设置内容
            [btn setTitle:self.bigCartporyArr[i][@"name"] forState:UIControlStateNormal];
           
            btn.layer.cornerRadius= 2;
            btn.layer.masksToBounds=2;
            //添加事
            //一个按钮添加之后累加X值后续计算使用
            //NSLog(@"%f",CGRectGetMaxX(btn.frame));
            butX = CGRectGetMaxX(btn.frame)+15;
          
        }
        self.DRheaderView=[[HQTopStopView alloc]initWithFrame:CGRectMake(0, 0, ScreenW,butY)];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
    }];
}
-(void)getMobHomeBurstItemList
{
    NSDictionary *dic =@{@"districtId":[DEFAULTS objectForKey:@"code"]?:@"1243"};
    [SNAPI getWithURL:@"burst/getHomeBigCategoryCopyTranscript" parameters:[dic mutableCopy] success:^(SNResult *result) {
        self.homeCatoryArr =[NSMutableArray array];
        self.homeCatoryArr =[DCRecommendItem mj_objectArrayWithKeyValuesArray:result.data[@"bursts"]];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(void)getHomeBigCategoryImg
{
    NSDictionary *dic =@{@"districtId":[DEFAULTS objectForKey:@"code"]?:@"1243",@"bhtId":self.selectedID};
    [SNAPI getWithURL:@"burst/getMobHomeBurstAdvList" parameters:[dic mutableCopy] success:^(SNResult *result) {
        self.bottomBannerArr=[NSMutableArray array];
        for (NSDictionary *dic in result.data) {
            [self.bottomBannerArr addObject:dic[@"img"]];
        }
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
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
- (void)setUpNavTopView
{
    _topToolView = [[DCHomeTopToolView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, DRTopHeight+WScale(45))];
    DRWeakSelf;
    _topToolView.leftItemClickBlock = ^{
        //NSLog(@"点击了首页扫一扫");
//        DCGMScanViewController *dcGMvC = [DCGMScanViewController new];
//        [weakSelf.navigationController pushViewController:dcGMvC animated:YES];
    };
    _topToolView.rightItemClickBlock = ^{
        //NSLog(@"点击了首页分类");
//        DCCommodityViewController *dcComVc = [DCCommodityViewController new];
//        [weakSelf.navigationController pushViewController:dcComVc animated:YES];
    };
    _topToolView.rightRItemClickBlock = ^{
        //NSLog(@"点击了首页购物车");
//        DCMyTrolleyViewController *shopCarVc = [DCMyTrolleyViewController new];
//        shopCarVc.isTabBar = YES;
//        shopCarVc.title = @"购物车";
//        [weakSelf.navigationController pushViewController:shopCarVc animated:YES];
    };
    _topToolView.searchButtonClickBlock = ^{
        //NSLog(@"点击了首页搜索");
        [self searchButtonClick];
    };
    _topToolView.voiceButtonClickBlock = ^{
        if (![User currentUser].isLogin) {
            [CGXPickerView showAddressPickerWithTitle:@"请选择你的城市" DefaultSelected:@[@0, @0] IsAutoSelect:YES Manager:nil ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
                //NSLog(@"%@-%@",selectAddressArr,selectAddressRow);
                [DRUserInfoModel sharedManager].location = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]];
                [DRUserInfoModel sharedManager].locationCode =[selectAddressArr lastObject];
                [DEFAULTS setObject:[NSString stringWithFormat:@"%@/%@/%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]] forKey:@"address"];
                [DEFAULTS setObject:selectAddressArr[4] forKey:@"locationCode"];
                [DEFAULTS setObject:selectAddressArr[4] forKey:@"code"];
                [weakSelf.topToolView.voiceButton setTitle:selectAddressArr[1] forState:UIControlStateNormal];
                  [_collectionView.mj_header beginRefreshing];
                //            weakSelf.navigationItem.title = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]];
            }];
        }
        //NSLog(@"点击了首页语音");
    };
//    self.navigationItem.titleView  =_topToolView;
    [self.view addSubview:_topToolView];
}
#pragma mark - 搜索点击
- (void)searchButtonClick
{
    MLSearchViewController *vc = [[MLSearchViewController alloc] init];
    vc.hotSearchDic =self.hotSearchDic;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4+_homeCatoryArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ( section==1) { //广告福利  倒计时  掌上专享
        return 1;
    }
    if (section>3) {
   self.listMOdel =_homeCatoryArr[section-4];
    return self.listMOdel.itemList.count;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 1) {//工厂直营 item
        DCGoodsCountDownCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsCountDownCellID forIndexPath:indexPath];
        cell.itemMuArr =self.itemMuArr;
        cell.btnItemBlock = ^(NSInteger btnTag) {
            [self selectedWithTag:btnTag];
        };
        gridcell = cell;
    }
    else if (indexPath.section >3) {//推荐
        //        self.nullGoodModel =self.nullArr[indexPath.row];
        DRNullGoodLikesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DRNullGoodLikesCellCellID forIndexPath:indexPath];
        self.listMOdel =self.homeCatoryArr[indexPath.section-4];
        self.itemModel =[ItemList mj_objectWithKeyValues:self.listMOdel.itemList[indexPath.row]];
        cell.youLikeItem = self.itemModel;
        cell.lookSameBlock = ^{
            //NSLog(@"点击了第%zd商品的比价格",indexPath.row);
            self.itemModel =[ItemList mj_objectWithKeyValues:self.listMOdel.itemList[indexPath.row]];
            DRSameLookVC *sameLookVC = [[DRSameLookVC alloc]init];
            sameLookVC.nullGoodModel=(DRNullGoodModel*)self.itemModel;
            [self.navigationController pushViewController:sameLookVC animated:YES];
        };
        
        cell.centerShopBtnBlock = ^{
            self.itemModel =[ItemList mj_objectWithKeyValues:self.listMOdel.itemList[indexPath.row]];
            DRShopHomeVC *detailVC = [DRShopHomeVC new];
            if ([self.zyStoreIdStr isEqualToString:self.itemModel.sellerId]) {
                detailVC.ycStr =@"1";
            }
            detailVC.sellerId=self.itemModel.sellerId;
            [self.navigationController pushViewController:detailVC animated:YES];
        };
        cell.sureBuyBtnBlock = ^{
            self.itemModel =[ItemList mj_objectWithKeyValues:self.listMOdel.itemList[indexPath.row]];
            DRShopListVC * shopListVC =[[DRShopListVC alloc]init];
            shopListVC.nullGoodModel =(DRNullGoodModel*)self.itemModel;
            [GoodsShareModel sharedManager].queryType =@"nowBuy";
            shopListVC.queryTypeStr =@"nowBuy";
            [self.navigationController pushViewController:shopListVC animated:YES];
        };
        gridcell = cell;
    }
    else {//猜你喜欢
        DCGoodsHandheldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsHandheldCellID forIndexPath:indexPath];
        NSArray *images = GoodsHandheldImagesArray;
        cell.handheldImage = images[indexPath.row];
        gridcell = cell;
    }
    return gridcell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;    
    if (kind == UICollectionElementKindSectionHeader){
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"topHeader" forIndexPath:indexPath];
        self.topHeaderView = headerView;
        if (self.DRheaderView.superview == nil) {
            self.DRheaderView.backgroundColor = BACKGROUNDCOLOR;
            self.DRheaderView.bigCartporyArr =self.bigCartporyArr;
            DRWeakSelf;
            self.DRheaderView.SelectbuttonClickBlock= ^(UIButton *sender,NSInteger index) {
                weakSelf.selectedID =weakSelf.bigCartporyArr[index][@"id"];
                weakSelf.DRheaderView.selectIndex =index;
                [weakSelf.collectionView reloadData];
                [weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:index+4] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
            };
            //首次使用VerticalSectionCategoryHeaderView的时候，把pinCategoryView添加到它上面。
            [headerView addSubview:self.DRheaderView];
        }
        return headerView;
    }
    if (kind == UICollectionElementKindSectionFooter)
    {
        if (indexPath.section == 0) {
            DCSlideshowHeadView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCSlideshowHeadViewID forIndexPath:indexPath];
            footerView.imageGroupArray = self.bannerArr.copy;
            footerView.ManageIndexBlock = ^(NSInteger ManageIndexBlock) {
                [self selectBannerWithIndex:ManageIndexBlock];
            };
            return  footerView ;
        }
//       else if (indexPath.section == 2) {
//               DRGuangGaoView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DRGuangGaoFootViewID forIndexPath:indexPath];
//           if (self.bannerArr.count>2) {
//
//               footerView.imageGroupArray = [self.bannerArr subarrayWithRange:NSMakeRange(2, 1)].copy;
//           }
//               footerView.ManageIndexBlock = ^(NSInteger ManageIndexBlock) {
//
//               };
//               return  footerView ;
//
//        }
        else if (indexPath.section == 1) {
            DCTopLineFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCTopLineFootViewID forIndexPath:indexPath];
            footerView.titleGroupArray =self.tipArr;
            footerView.ManageIndexBlock = ^(NSInteger ManageIndexBlock) {
                
            };
            footerView.allBlock = ^(NSInteger allDex) {
                DRNewsVC *newsVC =[[DRNewsVC alloc]init];
                [self.navigationController pushViewController:newsVC animated:YES];
            };
            return footerView;
        }
        else if (indexPath.section == 2){
            DCCountDownHeadView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCCountDownHeadViewID forIndexPath:indexPath];
            footerView.backgroundColor = BACKGROUNDCOLOR;
            return footerView;
        }
        else if (indexPath.section>2&&indexPath.section < self.homeCatoryArr.count+3)
        {
            DRGuangGaoView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DRGuangGaoFootViewID forIndexPath:indexPath];
            if (self.homeCatoryArr.count+3!=indexPath.section) {
                self.listMOdel =self.homeCatoryArr[indexPath.section-3];
                footerView.titleLab.text =self.listMOdel.name;
            }
            return  footerView ;
        }
    }
    return nil;
}
#pragma banner跳转
-(void)selectBannerWithIndex:(NSInteger)selectIndex
{
    HomeBannerModel *model =self.mobileBannArr[selectIndex];
    NSInteger msgType  = [model.msgDetailsType integerValue];
    switch (msgType) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
        case 5:
        {
             
        }
            break;
        case 6:
        {
            
        }
            break;
        case 7:
        {
            
        }
            break;
        case 8:
        {
            
        }
            break;
        case 9:
        {
            
        }
            break;
            
            
        default:
            break;
    }
    
}
//这里我为了直观的看出每组的CGSize设置用if 后续我会用简洁的三元表示
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 1) {//广告
//        return CGSizeMake(ScreenW, ScreenW/4+10);
//    }
    if (indexPath.section == 1) {//9宫格组
        return CGSizeMake(ScreenW, WScale(221));
    }
//    if (indexPath.section == 3) {//计时
//        return CGSizeMake(ScreenW,  HScale(190));
//    }
//    if (indexPath.section == 4) {//掌上
//        return CGSizeMake(ScreenW,  HScale(190));
//    }
    if (indexPath.section==0||indexPath.section==2||indexPath.section==3) {
         return CGSizeZero;
    }
    if (indexPath.section >3)
    {//掌上
        return CGSizeMake((ScreenW -30)/2, WScale(300));
    }
    if (indexPath.section == 3+_homeCatoryArr.count) {
         return CGSizeZero;
    }
    return CGSizeZero;
}
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    if (indexPath.section == 5) {
//        if (indexPath.row == 0) {
//            layoutAttributes.size = CGSizeMake(ScreenW, ScreenW * 0.38);
//        }else if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
//            layoutAttributes.size = CGSizeMake(ScreenW * 0.5, ScreenW * 0.24);
//        }else{
//            layoutAttributes.size = CGSizeMake(ScreenW * 0.25, ScreenW * 0.35);
//        }
//    }
//    return layoutAttributes;
//}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section==2) {
        return CGSizeZero;
    }
    if (section==3) {
        //初始行_列的X、Y值设置
        float butX = NeedStartMargin;
        float butY =10;
        for(int i = 0; i < self.bigCartporyArr.count; i++){
            //宽度自适应计算宽度
            NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
            CGRect frame_W = [self.bigCartporyArr[i][@"name"] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
            //宽度计算得知当前行不够放置时换行计算累加Y值
            if (i>3) {
                butX = NeedStartMargin;
                butY = 2*NeedBtnHeight+WScale(25);//Y值累加，具体值请结合项目自身需求设置 （值 = 按钮高度+按钮间隙）
            }
            //设置计算好的位置数值
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(butX, butY, frame_W.size.width+NeedStartMargin*2, NeedBtnHeight)];
            //设置内容
            [btn setTitle:self.bigCartporyArr[i][@"name"] forState:UIControlStateNormal];
            btn.layer.cornerRadius= 2;
            btn.layer.masksToBounds=2;
            //添加事
            //一个按钮添加之后累加X值后续计算使用
            //NSLog(@"%f",CGRectGetMaxX(btn.frame));
            butX = CGRectGetMaxX(btn.frame)+15;
        }
        return CGSizeMake(ScreenW, butY); //图片滚动的宽高
    }
    return CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(ScreenW, WScale(170)); //图片滚动的宽高
    }
    if (section == 1) {
        return CGSizeMake(ScreenW, WScale(30)); 
    }
    if (section == 2) {
         return CGSizeMake(ScreenW, WScale(55));  //Top头条的宽高
    }
    if (section>2 && section < self.homeCatoryArr.count+3) {
        return CGSizeMake(ScreenW, WScale(60));
    }
    return CGSizeZero;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
#pragma mark - X间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 2;
//}
//#pragma mark - Y间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 2;
//}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//10
//        DCGoodsSetViewController *goodSetVc = [[DCGoodsSetViewController alloc] init];
//        goodSetVc.goodPlisName = @"ClasiftyGoods.plist";
//        [self.navigationController pushViewController:goodSetVc animated:YES];
//        //NSLog(@"点击了10个属性第%zd",indexPath.row);
    }
//
//    else if (indexPath.section == 5){
//        //NSLog(@"点击了推荐的第%zd个商品",indexPath.row);
////        DRShopHomeVC *detailVC = [DRShopHomeVC new];
////        self.nullGoodModel =self.nullArr[indexPath.row];
////        detailVC.sellerId=self.nullGoodModel.sellerId;
////        [self.navigationController pushViewController:detailVC animated:YES];
//        DRShopListVC * shopListVC =[[DRShopListVC alloc]init];
//        shopListVC.nullGoodModel =self.nullArr[indexPath.row];
//        [self.navigationController pushViewController:shopListVC animated:YES];
////        DCGoodDetailViewController *dcVc = [[DCGoodDetailViewController alloc] init];
////        dcVc.goodTitle = _youLikeItem[indexPath.row].main_title;
////        dcVc.goodPrice = _youLikeItem[indexPath.row].price;
////        dcVc.goodSubtitle = _youLikeItem[indexPath.row].goods_title;
////        dcVc.shufflingArray = _youLikeItem[indexPath.row].images;
////        dcVc.goodImageView = _youLikeItem[indexPath.row].image_url;
////
////        [self.navigationController pushViewController:dcVc animated:YES];
//    }“
    else if (indexPath.section>3)
    {
        self.listMOdel =self.homeCatoryArr[indexPath.section-4];
        self.itemModel =[ItemList mj_objectWithKeyValues:self.listMOdel.itemList[indexPath.row]];
        DRShopListVC * shopListVC =[[DRShopListVC alloc]init];
        shopListVC.nullGoodModel =(DRNullGoodModel*)self.itemModel;
        [GoodsShareModel sharedManager].queryType =@"nowBuy";
        shopListVC.queryTypeStr =@"nowBuy";
        [self.navigationController pushViewController:shopListVC animated:YES];
//        DRShopHomeVC *detailVC = [DRShopHomeVC new];
//        detailVC.sellerId=self.youLikeItem[indexPath.row].sellerId;
//        [self.navigationController pushViewController:detailVC animated:YES];
    }
}
#pragma mark 二级页面跳转
-(void)selectedWithTag:(NSInteger)tag
{
//    if (tag==0) {
////        self.tabBarController.selectedIndex =1;
//       DRShopHomeVC *detailVC = [DRShopHomeVC new];
//       detailVC.sellerId =self.zyStoreIdStr;
//       [self.navigationController pushViewController:detailVC animated:YES];
//    }
    if (tag<self.itemMuArr.count)
    {
        DRItemModel*model =self.itemMuArr[tag];
       if ([model.isDefault intValue]==999) {
           DRShopHomeVC *detailVC = [DRShopHomeVC new];
           detailVC.isAirCloud =model.isDefault;
           detailVC.sellerId =model.item_id;
           [self.navigationController pushViewController:detailVC animated:YES];
       }
       else
       {
           DRAirCloudShopVC *detailVC = [DRAirCloudShopVC new];
           detailVC.nameStr =model.name;
           detailVC.sellerId =model.item_id;
           detailVC.isAirCloud =model.isDefault;
           [self.navigationController pushViewController:detailVC animated:YES];
       }
       
//        DCCommodityViewController *commandVC =[[DCCommodityViewController alloc]init];
//        commandVC.statusStr =@"homePush";
//        [self.navigationController pushViewController:commandVC animated:YES];
    }
    else if (tag==self.itemMuArr.count)
    {
         self.tabBarController.selectedIndex =1;
//        DRAirCloudShopVC *detailVC = [DRAirCloudShopVC new];
//        detailVC.sellerId =self.zyStoreIdStr;
//        [self.navigationController pushViewController:detailVC animated:YES];
    }
    else if (tag==1+self.itemMuArr.count)
    {
        
//        [MBProgressHUD showSuccess:@"等待下一版"];
        DRCuXiaoVC *cuxiaoVC =[[DRCuXiaoVC alloc]init];
        [self.navigationController pushViewController:cuxiaoVC animated:YES];
    }
//    else if (tag==3+self.itemMuArr.count)
//    {
//        DRSellerListVC *selllistVC=[[DRSellerListVC alloc]init];
//
//        [self.navigationController pushViewController:selllistVC animated:YES];
//    }
    else if (tag==2+self.itemMuArr.count)
    {
        DRTigetsVC *tiketVC =[[DRTigetsVC alloc]init];
        [self.navigationController pushViewController:tiketVC animated:YES];
    }
    else if (tag==3+self.itemMuArr.count)
    {
        DRComeVC *comeVC=[[DRComeVC alloc]init];
        [self.navigationController pushViewController:comeVC animated:YES];
    }
    else if (tag==4+self.itemMuArr.count)
    {
        CategoryDetailVC *goodSetVc =[[CategoryDetailVC alloc] init];
        goodSetVc.classListStr =@"";
        goodSetVc.czID =@"";
        goodSetVc.queryTypeStr =@"history";
        [self.navigationController pushViewController:goodSetVc animated:YES];
    }
    else if (tag==5+self.itemMuArr.count)
    {
        [self.navigationController pushViewController:[DRHelpCenterVC new] animated:YES];
    }
//    switch (tag) {
//        case 0:
//        {
//            self.tabBarController.selectedIndex =1;
//
//        }
//            break;
//        case 1:
//        {
//
//            DRAirCloudShopVC *detailVC = [DRAirCloudShopVC new];
//            detailVC.sellerId =self.zyStoreIdStr;
//            [self.navigationController pushViewController:detailVC animated:YES];
//        }
//            break;
//        case 2:
//        {
//            DRCuXiaoVC *cuxiaoVC =[[DRCuXiaoVC alloc]init];
//        [self.navigationController pushViewController:cuxiaoVC animated:YES];
////            DCCommodityViewController *commandVC =[[DCCommodityViewController alloc]init];
////            commandVC.statusStr =@"homePush";
////            [self.navigationController pushViewController:commandVC animated:YES];
//
//        }
//            break;
//        case 3:
//        {
//            DRLocationVC *locationVC =[[DRLocationVC alloc]init];
//            locationVC.advType = @"000";
//            locationVC.title =@"本地批发";
//            locationVC.isHome =@"2";
//            [self.navigationController pushViewController:locationVC animated:YES];
//        }
//            break;
//        case 4:
//        {
//            DRCuXiaoVC *cuxiaoVC =[[DRCuXiaoVC alloc]init];
//            [self.navigationController pushViewController:cuxiaoVC animated:YES];
//        }
//            break;
//        case 5:
//        {
//            DRTigetsVC *tiketVC =[[DRTigetsVC alloc]init];
//            [self.navigationController pushViewController:tiketVC animated:YES];
//        }
//            break;
//        case 6:
//        {
//            DRComeVC *comeVC=[[DRComeVC alloc]init];
//            [self.navigationController pushViewController:comeVC animated:YES];
//        }
//            break;
//        case 7:
//        {
//            DRLocationVC *locationVC =[[DRLocationVC alloc]init];
//             locationVC.advType = @"007";
//            locationVC.type =@"1";
//            locationVC.isHome =@"1";
//            locationVC.title =@"永年市场";
//            [self.navigationController pushViewController:locationVC animated:YES];
//        }
//            break;
//        case 8:
//        {
//            DRLocationVC *locationVC =[[DRLocationVC alloc]init];
//            locationVC.advType = @"008";
//            locationVC.type =@"2";
//            locationVC.isHome =@"1";
//            locationVC.title =@"温州市场";
//            [self.navigationController pushViewController:locationVC animated:YES];
//        }
//            break;
//        case 9:
//        {
//            DRLocationVC *locationVC =[[DRLocationVC alloc]init];
//            locationVC.advType = @"006";
//            locationVC.isHome =@"1";
//            locationVC.type =@"3";
//            locationVC.title =@"戴南市场";
//            [self.navigationController pushViewController:locationVC animated:YES];
//        }
//            break;
//        case 10:
//        {
//            CategoryDetailVC *goodSetVc =[[CategoryDetailVC alloc] init];
//            goodSetVc.classListStr =@"";
//            goodSetVc.czID =@"";
//            goodSetVc.queryTypeStr =@"history";
//            [self.navigationController pushViewController:goodSetVc animated:YES];
//        }
//            break;
//        case 11:
//        {
//            DRHelpCenterVC *helpVC =[[DRHelpCenterVC alloc]init];
//            [self.navigationController pushViewController:helpVC animated:YES];
//        }
//            break;
//        default:
//            break;
//    }
}
//#pragma mark - <UIScrollViewDelegate>
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//
//    _backTopButton.hidden = (scrollView.contentOffset.y > ScreenH) ? NO : YES;//判断回到顶部按钮是否隐藏
//    _topToolView.hidden = (scrollView.contentOffset.y < 0) ? NO : NO;//判断顶部工具View的显示和隐形
//
//    if (scrollView.contentOffset.y > DRTopHeight+WScale(45)) {
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//        [[NSNotificationCenter defaultCenter]postNotificationName:SHOWTOPTOOLVIEW object:nil];
//    }else{
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//        [[NSNotificationCenter defaultCenter]postNotificationName:HIDETOPTOOLVIEW object:nil];
//    }
//   //    用户滚动的才处理
//    //获取categoryView下面一点的所有布局信息，用于知道，当前最上方是显示的哪个section
////    CGRect topRect = CGRectMake(0, scrollView.contentOffset.y  + 1, self.view.bounds.size.width, 1);
////    UICollectionViewLayoutAttributes *topAttributes = [self.collectionView.collectionViewLayout layoutAttributesForElementsInRect:topRect].firstObject;
////    NSUInteger topSection = topAttributes.indexPath.section;
////    if (topAttributes != nil) {
////        if (self.DRheaderView.selectIndex != topSection-3 ) {
////            //不相同才切换
////            self.DRheaderView.selectIndex=topSection-3;
////        }
////    }
//}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UICollectionViewLayoutAttributes *attri = self.sectionHeaderAttributes[VerticalListPinSectionIndex];
    if (scrollView.contentOffset.y >= attri.frame.origin.y+WScale(476)) {
    //当滚动的contentOffset.y大于了指定sectionHeader的y值，且还没有被添加到self.view上的时候，就需要切换superView
        if (self.DRheaderView.superview != self.view)
        {
            self.DRheaderView.dc_y =DRTopHeight+WScale(45);
            [self.view addSubview:self.DRheaderView];
        }
    }else if (self.DRheaderView.superview != self.topHeaderView) {
        //当滚动的contentOffset.y小于了指定sectionHeader的y值，且还没有被添加到sectionCategoryHeaderView上的时候，就需要切换superView
        self.DRheaderView.dc_y =0;
        [self.topHeaderView addSubview:self.DRheaderView];
    }
    if (!(scrollView.isTracking || scrollView.isDecelerating)) {
        //不是用户滚动的，比如setContentOffset等方法，引起的滚动不需要处理。
        return;
    }
    //    用户滚动的才处理
//    //获取categoryView下面一点的所有布局信息，用于知道，当前最上方是显示的哪个section
//    CGRect topRect = CGRectMake(0, scrollView.contentOffset.y + VerticalListCategoryViewHeight + 1+DRTopHeight+WScale(45)+WScale(301), self.view.bounds.size.width, 1);
//    UICollectionViewLayoutAttributes *topAttributes = [self.collectionView.collectionViewLayout layoutAttributesForElementsInRect:topRect].firstObject;
//    NSUInteger topSection = topAttributes.indexPath.section;
//    if (topAttributes != nil && topSection >= VerticalListPinSectionIndex+4) {
//        if (self.DRheaderView.selectIndex != topSection - VerticalListPinSectionIndex) {
//            //不相同才切换
//            [self.DRheaderView setPATH:topSection - VerticalListPinSectionIndex withBtn:self.DRheaderView.buttonBtn];
//            
//            [self.collectionView reloadData];
//        }
//    }
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

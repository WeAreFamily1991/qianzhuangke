//
//  DCHandPickViewController.m
//  CDDMall
//
//  Created by apple on 2017/5/26.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//
#define NeedStartMargin 15   // 首列起始间距
#define NeedBtnHeight 33   // 按钮高度
#import "DRHelpCenterVC.h"
#import "DRNullMainVC.h"
#import "HQCollectionViewFlowLayout.h"
#import "HQTopStopView.h"
// Controllers
#import "DRShopHomeVC.h"
#import "CGXPickerView.h"
#import "DRHelpCenterModel.h"
#import "DRSameLookVC.h"
#import "DRShopListVC.h"
#import "DRShopHomeVC.h"
#import "DRHelpDetailVC.h"
//#import "DCGoodsSetViewController.h"
//#import "DCCommodityViewController.h"
//#import "DCMyTrolleyViewController.h"
//#import "DCGoodDetailViewController.h"
//#import "DCGMScanViewController.h"
// Models
#import "DCGridItem.h"
#import "DCRecommendItem.h"
#import "DRNullGoodModel.h"
// Views
#import "DCNavSearchBarView.h"
#import "DCHomeTopToolView.h"
#import "DRHelpCenterCellCollectionViewCell.h"
#import "DRHeaderTitleView.h"
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

@interface DRHelpCenterVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
@property (strong , nonatomic)NSMutableArray *homeCatoryArr;
@property (nonatomic,strong)DRHelpCenterModel *helpModel;

@end
static NSString *const DRHelpCenterCellCollectionViewCellID = @"DRHelpCenterCellCollectionViewCell";
static NSString *const DCNewWelfareCellID = @"DCNewWelfareCell";
static NSString *const DCGoodsHandheldCellID = @"DCGoodsHandheldCell";
static NSString *const DCGoodsYouLikeCellID = @"DCGoodsYouLikeCell";
static NSString *const DCGoodsGridCellID = @"DCGoodsGridCell";
static NSString *const DCExceedApplianceCellID = @"DCExceedApplianceCell";
static NSString *const DRNullGoodLikesCellCellID = @"DRNullGoodLikesCell";

/* head */
static NSString *const DRHeaderTitleViewID =@"DRHeaderTitleView";
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
@implementation DRHelpCenterVC

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
       UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.sectionHeadersPinToVisibleBounds = YES;//头视图悬浮
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor =WHITECOLOR;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 0, ScreenW, ScreenH-DRTopHeight);
//        _collectionView.showsVerticalScrollIndicator = NO;        //注册
       
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DRHelpCenterCellCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"DRHelpCenterCellCollectionViewCell"];
        
        [_collectionView registerClass:[DRFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DRFooterViewID];
        [_collectionView registerClass:[DCTopLineFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCTopLineFootViewID];
        [_collectionView registerClass:[DCOverFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCOverFootViewID];
        [_collectionView registerClass:[DCScrollAdFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCScrollAdFootViewID];
        [_collectionView registerClass:[DCYouLikeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCYouLikeHeadViewID];
        [_collectionView registerClass:[DCSlideshowHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCSlideshowHeadViewID];
        [_collectionView registerClass:[DCCountDownHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCCountDownHeadViewID];
        [_collectionView registerClass:[DRGuangGaoView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DRGuangGaoFootViewID];
        [_collectionView registerClass:[HQTopStopView class] forSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:DRTopViewID];
        [_collectionView registerClass:[DRHeaderTitleView class] forSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:DRHeaderTitleViewID];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
   
     self.navigationItem.title = @"帮助中心";
    [self setUpBase];
    [self getButtomNavicat];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSLog(@"location =%@",[DRUserInfoModel sharedManager].locationCode?:@"");
//    [self loadLocation];
}

#pragma mark - initialize
- (void)setUpBase
{
    self.collectionView.backgroundColor = WHITECOLOR;
    
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
}



#pragma mark - 获取网络
- (void)getNetwork
{
    if ([[NetworkUnit getInternetStatus] isEqualToString:@"notReachable"]) { //网络
        [CDDTopTip showTopTipWithMessage:@"您现在暂无可用网络"];
    }
}
#pragma mark - 加载数据

-(void)getButtomNavicat
{
    NSDictionary *dic =@{@"typeCode":@"mobileHelper"};
    [SNAPI getWithURL:@"mainPage/getButtomNavicat" parameters:[dic mutableCopy] success:^(SNResult *result) {
          self.homeCatoryArr =[NSMutableArray array];
        self.homeCatoryArr =[DRHelpCenterModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.homeCatoryArr.count+1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section==0) {
        return 0;
    }
    self.helpModel =self.homeCatoryArr[section-1];
    return  self.helpModel.list.count;
    
   
   
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *gridcell = nil;
  
    if (indexPath.section==0) {
        
    }else
    {
        static NSString *ID=@"DRHelpCenterCellCollectionViewCell";
        DRHelpCenterCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
        self.helpModel = self.homeCatoryArr[indexPath.section-1];
       DRHelpList*listModel =[DRHelpList mj_objectWithKeyValues:self.helpModel.list[indexPath.row]];
        cell.titleLab.text =listModel.title;
        [cell.iconIMG sd_setImageWithURL:[NSURL URLWithString:listModel.img]];
//        if (indexPath.section==1) {
////            NSArray *titleArr =@[@"购物流程",@"发票问题",@"联系客服",@"买家须知",@"团购流程"];
////            NSArray *imgArr =@[@"help center_ico_gouwuliucheng",@"help center_ico_fapiaowenti",@"help center_ico_lianxikefu",@"help center_ico_maijiaxuzhi",@"help center_ico_tuangouliucheng"];
//
//        }
//        else if (indexPath.section==2)
//        {
//            NSArray *titleArr =@[@"上门自提",@"配送说明",@"配送费用"];
//            NSArray *imgArr =@[@"help center_ico_shangmengziti",@"help center_ico_peisongshuoming",@"help center_ico_peisongfeiyong"];
//            cell.titleLab.text =titleArr[indexPath.row];
//            cell.iconIMG.image =[UIImage imageNamed:imgArr[indexPath.row]];
//        }
//        else if (indexPath.section==3)
//        {
//            NSArray *titleArr =@[@"线下支付",@"换绑手机",@"修改资料",@"开票资料",@"开票申请"];
//            NSArray *imgArr =@[@"help center_ico_xianxiazhifu",@"help center_ico_huanbangshouji",@"help center_ico_xiugaiziliao",@"help center_ico_kaipiaoziliao",@"help center_ico_kaipiaoshenqi"];
//            cell.titleLab.text =titleArr[indexPath.row];
//            cell.iconIMG.image =[UIImage imageNamed:imgArr[indexPath.row]];
//        }
//        else
//        {
//            NSArray *titleArr =@[@"关于我们",@"退货说明",@"退货流程"];
//            NSArray *imgArr =@[@"help center_ico_guanyuwomeng",@"help center_ico_tuihuoshuoming",@"help center_ico_tuihuoliucheng"];
//            cell.titleLab.text =titleArr[indexPath.row];
//            cell.iconIMG.image =[UIImage imageNamed:imgArr[indexPath.row]];
//        }
        gridcell = cell;
    }
    
    return gridcell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
  
    if (kind == UICollectionElementKindSectionHeader)
    {
        if (indexPath.section==0) {
            
            DCYouLikeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCYouLikeHeadViewID forIndexPath:indexPath];
            return headerView;
        }
        else
        {
            DRHeaderTitleView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DRHeaderTitleViewID forIndexPath:indexPath];
            self.helpModel =self.homeCatoryArr[indexPath.section-1];
            headerView.titleLab.text =self.helpModel.name;
            return headerView;
        }
    }
    return nil;
}
//这里我为了直观的看出每组的CGSize设置用if 后续我会用简洁的三元表示
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(WScale(85), WScale(55));
}
#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section==0)
    {
        return CGSizeMake(ScreenW, WScale(128)); //图片滚动的宽高
    }
   return  CGSizeMake(ScreenW, WScale(60));
}
#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return WScale(5);
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return WScale(15);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//10
        
      
    }else {
      self.helpModel = self.homeCatoryArr[indexPath.section-1];
           DRHelpList*listModel =[DRHelpList mj_objectWithKeyValues:self.helpModel.list[indexPath.row]];
        DRHelpDetailVC *helpDetailVC =[[DRHelpDetailVC alloc]init];
        helpDetailVC.urlStr =[NSString stringWithFormat:@"https://app.santie.com/miniapp/#/helpDetail?id=%@",listModel.list_id];
        [self.navigationController pushViewController:helpDetailVC animated:YES];
        
    }
}
#pragma mark - 消息
- (void)messageItemClick
{
    
}

@end

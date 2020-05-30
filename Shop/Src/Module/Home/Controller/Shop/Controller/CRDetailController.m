//
//  CRShopDetailController.m
//  CRShopDetailDemo
//
//  Created by roger wu on 18/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "CRDetailController.h"
#import <Masonry/Masonry.h>
//#import <YYCategories/YYCategories.h>
#import "CRConst.h"
#import "CRNavigationBar.h"
#import "CRBottomBar.h"
#import "CRContentView.h"
#import "DRCatoryShopView.h"
#import "CRDetailModel.h"
#import "MBProgressHUD+CRExtention.h"
#import "DRPinpaiVC.h"
#import "DRShopHeadModel.h"
#import "CRHomeView.h"
#import "CRAllProductView.h"
#import "DRNewGoodView.h"
#import "DRShopUserView.h"
#import "DRShopListVC.h"
#import "DRNullShopModel.h"

@interface CRDetailController ()<
    DRCatoryShopViewDelegate,
    CRContentViewDelegate,
    CRNavigationBarDelegate,
    CRBottomBarDelegate,CRHomeViewDelegate,CRAllProductViewDelegate,DRNewGoodViewDelegate,DRShopUserViewDelegate>


@end

@implementation CRDetailController {
    CRNavigationBar *_navigationBar;
    CRContentView *_contentView;
     CRHomeView *_homeView;
    CRAllProductView *_AllProductView;
    DRNewGoodView *_newView;
    DRShopUserView *_shopUserView;
     DRCatoryShopView *_catoryShopView;
    CRBottomBar *_bottomBar;
    CRDetailModel *_detailModel;
    DRShopHeadModel *_shopHeadModel;
    DRNullGoodModel *_nullModel;
    NSURLSessionTask *_task;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    [self refreshAction];
    [self setupNavigationBar];
    [self setHomeView];
    [self setHomeView];
}
-(void)setHomeView
{
    _homeView = [CRHomeView new];
    _homeView.delegate = self;
    [self.view addSubview:_homeView];
}

-(void)setAllProductView
{
    _AllProductView = [CRAllProductView new];
    _AllProductView.delegate = self;
    [self.view addSubview:_AllProductView];
}
-(void)setNewView
{
    _newView = [DRNewGoodView new];
    _newView.delegate = self;
    [self.view addSubview:_newView];
}

-(void)setshopUserView
{
    _shopUserView = [DRShopUserView new];
    _shopUserView.delegate = self;
    [self.view addSubview:_shopUserView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)dealloc {
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CRHomeView" object:nil];
    [_task cancel];
}

- (void)refreshAction {
    MBProgressHUD *hud = [MBProgressHUD cr_showLoadinWithView:self.view text:@"加载中..."];
    NSDictionary *dic =@{@"sellerId":self.sellerId,@"districtId":[DEFAULTS objectForKey:@"code"]?:@""};
    [SNAPI getWithURL:@"seller/getSellerInfo" parameters:[dic mutableCopy] success:^(SNResult *result) {
      
        _detailModel=[CRDetailModel mj_objectWithKeyValues:result.data];
        _nullModel =_nullGoodModel;
        if (_detailModel.favoriteId.length==0) {
            _navigationBar.moreButton.selected =NO;
        }
        else
        {
            _navigationBar.moreButton.selected =YES;
        }            
        [self setup];
       
        [hud cr_hide];
    } failure:^(NSError *error) {
        [hud cr_hide];
    }];

}

- (void)setupNavigationBar {
    _navigationBar = [CRNavigationBar new];
   
    
    _navigationBar.delegate = self;
    [self.view addSubview:_navigationBar];
    [_navigationBar changeColor:YES];
    
    
    _navigationBar.frame = CGRectMake(0, 0, ScreenW, DRTopHeight);
}

- (void)setup {
    CGRect contentFrame = self.view.bounds;
    CGFloat bottomBarHeight = isIphoneX ? (kBottomBarHeight+kSafeAreaLayoutGuideBottomHeight) : kBottomBarHeight;
    contentFrame.size.height -= bottomBarHeight;
    _contentView = [[CRContentView alloc] initWithFrame:contentFrame contentDelegate:self detailModel:_detailModel ShopHeadModel:_shopHeadModel nullGoodModel:_nullModel withSellID:self.sellerId];
    
    [self.view addSubview:_contentView];
   
//    _catoryShopView = [[DRCatoryShopView alloc] initWithFrame:contentFrame contentDelegate:self detailModel:_detailModel ShopHeadModel:_shopHeadModel nullGoodModel:_nullModel withSellID:self.sellerId];
//    _catoryShopView.hidden =YES;
//    [self.view addSubview:_catoryShopView];
    
    [self.view bringSubviewToFront:_navigationBar];
    [_navigationBar changeColor:NO];
    
    _bottomBar = [CRBottomBar new];
    _bottomBar.delegate = self;
    _bottomBar.frame = CGRectMake(0, CGRectGetMaxY(_contentView.frame), ScreenW, DRTabBarHeight);
    [self.view addSubview:_bottomBar];
    
    if (kiOS11Later) {
        adjustsScrollViewInsets_NO(_contentView);
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"CRHomeView" object:nil];
    //       self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;
}
- (void)notificationHandler:(NSNotification *)notification {
    if ([notification.name isEqualToString:@"CRHomeView"]) {
        DRNullShopModel *nullShopModel =notification.object;
        
        DRShopListVC *goodSetVc =[[DRShopListVC alloc] init];
        goodSetVc.shopStr =@"111";
        
        goodSetVc.nullGoodModel =(DRNullGoodModel*)nullShopModel;
        [self.navigationController pushViewController:goodSetVc animated:YES];
    }
}

#pragma mark - CRContentViewDelegate
// 用于改变navigationBar的透明度
- (void)contentView:(CRContentView *)contentView offsetY:(CGFloat)offsetY {
    CGFloat top = isIphoneX ? kNavigationBarHeight88 : kNavigationBarHeight64;
    CGFloat total = [CRConst kHeaderViewHeight] - top;
    CGFloat real = offsetY + [CRConst kHeaderViewHeight];
    [_navigationBar changeAlphaWithOffsetY:real total:total];
}

#pragma mark - CRNavigationBarDelegate
- (void)navigationBarClickedBack:(CRNavigationBar *)navigationBar {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navigationBarClickedSearch:(CRNavigationBar *)navigationBar {
    DRShopListVC *goodSetVc =[[DRShopListVC alloc] init];
    goodSetVc.shopStr =@"111";
    goodSetVc.nullGoodModel =_nullGoodModel;
    goodSetVc.sellerIdStr =self.sellerId;
    [self.navigationController pushViewController:goodSetVc animated:YES];
}

- (void)navigationBarClickedCategory:(CRNavigationBar *)navigationBar {
//    [MBProgressHUD cr_showToastWithText:@"分类"];
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://4006185027"]];
}

- (void)navigationBarClickedMore:(CRNavigationBar *)navigationBar {
//    [MBProgressHUD cr_showToastWithText:@"更多"];
    NSMutableDictionary *mudic =[NSMutableDictionary dictionary];
    NSString *urlStr;
    if (_navigationBar.moreButton.selected) {
        urlStr =@"buyer/cancelSellerFavorite";
        
        mudic =[NSMutableDictionary dictionaryWithObject:_detailModel.favoriteId forKey:@"id"];
        [SNIOTTool deleteWithURL:urlStr parameters:mudic success:^(SNResult *result) {
           
                NSLog(@"result=%@",result.data);
                
                _detailModel.favoriteId =@"";
               _navigationBar.moreButton.selected =NO;
               [MBProgressHUD showSuccess:@"取消成功"];
           
        } failure:^(NSError *error) {
            [MBProgressHUD showError:error.description];
        }];
    }
    else
    {
        urlStr =@"buyer/favoriteSeller";
        NSDictionary *dic =@{@"id":_detailModel.head_id};
        
         [SNAPI postWithURL:urlStr parameters:dic.mutableCopy success:^(SNResult *result) {
            
                NSLog(@"result=%@",result.data);
                _detailModel.favoriteId=result.data;
                _navigationBar.moreButton.selected =YES;
                [MBProgressHUD showSuccess:@"收藏成功"];
                //
           
        } failure:^(NSError *error) {
            
        }];
    }
    
}
#pragma mark - CRBottomBarDelegate
-(void)bottomBarClickedHome:(CRBottomBar *)bottomBar
{
//    [MBProgressHUD cr_showToastWithText:@"首页"];
    _contentView.hidden =NO;
    _catoryShopView.hidden =YES;
  
    CGRect contentFrame = self.view.bounds;
    CGFloat bottomBarHeight = isIphoneX ? (kBottomBarHeight+kSafeAreaLayoutGuideBottomHeight) : kBottomBarHeight;
    contentFrame.size.height -= bottomBarHeight;
    _contentView = [[CRContentView alloc] initWithFrame:contentFrame contentDelegate:self detailModel:_detailModel ShopHeadModel:_shopHeadModel nullGoodModel:_nullModel withSellID:self.sellerId];
    
    [self.view addSubview:_contentView];
    
    //    _catoryShopView = [[DRCatoryShopView alloc] initWithFrame:contentFrame contentDelegate:self detailModel:_detailModel ShopHeadModel:_shopHeadModel nullGoodModel:_nullModel withSellID:self.sellerId];
    //    _catoryShopView.hidden =YES;
    //    [self.view addSubview:_catoryShopView];
    
    [self.view bringSubviewToFront:_navigationBar];
}

- (void)bottomBarClickedCategory:(CRBottomBar *)bottomBar {
//    [MBProgressHUD cr_showToastWithText:@"商品分类"];
    _contentView.hidden =YES;
    _catoryShopView.hidden =NO;
    CGRect contentFrame = self.view.bounds;
    CGFloat bottomBarHeight = isIphoneX ? (kBottomBarHeight+kSafeAreaLayoutGuideBottomHeight) : kBottomBarHeight;
    contentFrame.size.height -= bottomBarHeight;
    
    _catoryShopView = [[DRCatoryShopView alloc] initWithFrame:contentFrame contentDelegate:self detailModel:_detailModel ShopHeadModel:_shopHeadModel nullGoodModel:_nullModel withSellID:self.sellerId];
//    _catoryShopView.hidden =YES;
    [self.view addSubview:_catoryShopView];
     [self.view bringSubviewToFront:_navigationBar];
   
}
-(void)bottomBarClickedpinpai:(CRBottomBar *)bottomBar
{
//    [MBProgressHUD cr_showToastWithText:@"品牌资质"];
    DRPinpaiVC *pinpaiVC =[[DRPinpaiVC alloc]init];
    pinpaiVC.detailModel=_detailModel;
    [self.navigationController pushViewController:pinpaiVC animated:YES];
    
}
- (void)bottomBarClickedIntro:(CRBottomBar *)bottomBar {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://4006185027"]];
//    [MBProgressHUD cr_showToastWithText:@"联系卖家"];
}


#pragma CRHOMEDELEGATE
-(void)nullShopModelClickedHome:(DRNullShopModel *)nullShopModel
{
    DRShopListVC *goodSetVc =[[DRShopListVC alloc] init];
    goodSetVc.shopStr =@"111";
    goodSetVc.sellerIdStr =self.sellerId;
    goodSetVc.nullGoodModel =(DRNullGoodModel*)nullShopModel;
    [self.navigationController pushViewController:goodSetVc animated:YES];
}
@end

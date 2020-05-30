
//
//  CategoryDetailVC.m
//  Shop
//
//  Created by BWJ on 2019/3/7.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRShopListVC.h"
#import "SYTypeButtonView.h"
#import "SecondCell.h"
#import "GoodsCell.h"
#import "CatgoryDetailCell.h"
#import "GHCountField.h"
#import "CGXPickerView.h"
#import "DCSildeBarView.h"
#import "LDYSelectivityAlertView.h"
#import "StoreVC.h"
#import "DRSameModel.h"
#import "TestImageView.h"
#import "CustomAlertView.h"
#import "DRShopHeaderView.h"
#import "DRNullGoodModel.h"
#import "DRShopHomeVC.h"
#import "CRDetailModel.h"
#import "DRSameLookVC.h"
#import "DRFooterCell.h"
#import "SKFPreViewNavController.h"
#import "ZWPhotoPreviewDataModel.h"
#import "ZWPhotoPreview.h"
#import "GHDropMenu.h"
#import "GHDropMenuModel.h"
#define DIC_EXPANDED @"expanded" //是否是展开 0收缩 1展开

#define DIC_ARARRY @"array" //存放数组

#define DIC_TITILESTRING @"title"

#define CELL_HEIGHT 50.0f
@interface DRShopListVC ()<UITableViewDelegate,UITableViewDataSource,GHCountFieldDelegate,LDYSelectivityAlertViewDelegate,GHDropMenuDelegate>
{
    int pageCount;
    NSMutableArray *DataArray;
    
}
@property (nonatomic , strong) GHDropMenu *dropMenu;
@property (nonatomic , strong) GHDropMenuModel *configuration;
@property (nonatomic,retain)GoodsModel *goodsModel;
@property (retain, nonatomic)UITableView *tableView;
@property (nonatomic,strong)SYTypeButtonView *buttonView;
@property (nonatomic,strong)NSMutableArray *MsgListArr,*selectNameArr,*selectCodeArr;
@property (assign,nonatomic)NSInteger selectYes;
@property (assign,nonatomic)NSInteger selectcode;
@property (strong , nonatomic)UIButton *selectBtn;
@property (strong , nonatomic) DRShopHeaderView *headView ;
@property (nonatomic,strong)NSMutableArray <GoodsModel *> *sameArr;
/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;
@property (nonatomic,retain)DCUpDownButton *bgTipButton;
@property (strong , nonatomic)UIButton *shopCarButton;
@property(nonatomic,strong)NSMutableArray*   isOpenArr;

@end

@implementation DRShopListVC

//初始化数据
- (void)initDataSource{
    
    //创建一个数组
    DataArray=[[NSMutableArray alloc] init];
    
    for (int i = 0;i <= 5; i++) {
        
        NSMutableArray *array=[[NSMutableArray alloc] init];
        
        for (int j=0; j<=5;j++) {
            
            NSString *string=[NSString stringWithFormat:@"%i组-%i行",i,j];
            
            [array addObject:string];
            
        }
        
        NSString *string=[NSString stringWithFormat:@"第%i分组",i];
        
        //创建一个字典 包含数组，分组名，是否展开的标示
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithObjectsAndKeys:array,DIC_ARARRY,string,DIC_TITILESTRING,[NSNumber numberWithInt:0],DIC_EXPANDED,nil];
        
        //将字典加入数组
        [DataArray addObject:dic];
        
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
     [self.tableView.mj_header beginRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
     _sameArr =[NSMutableArray array];
    [self.view addSubview:self.bgTipButton];
    self.selectYes =NO;
    [self initDataSource];
   
    self.view.backgroundColor =BACKGROUNDCOLOR;
    //    self.tableView.frame =CGRectMake(0, 120, SCREEN_WIDTH, self.tableView.height - 120);
    self.title =@"产品列表";
    [self setUI];
    [self loadTableView];
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakSelf.sameArr.count) {
            [weakSelf.sameArr removeAllObjects];
        }
        pageCount=1;
        [weakSelf getMsgList];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        pageCount = pageCount +1;
        [weakSelf getMsgList];
    }];
    [self.tableView.mj_footer endRefreshing];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"select" object:nil];   
    [self setUpScrollToTopView];
//    [self addHeadView];
    [self addGetSellInfo];
    
    //       self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;
}
-(void)loadTableView
{
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH,SCREEN_HEIGHT-40-DRTopHeight) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor =CLEARCOLOR;
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    //    _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
   [_tableView registerClass:[SecondCell class] forCellReuseIdentifier:@"SecondCell"];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
}
-(void)addHeadView
{
    self.headView = [[[NSBundle mainBundle] loadNibNamed:@"DRShopHeaderView" owner:self options:nil] lastObject];
    [self.headView.IconIMG sd_setImageWithURL:[NSURL URLWithString:self.nullGoodModel.storeImg] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
    self.headView.backBtnClickBlock = ^{
        DRShopHomeVC *detailVC = [DRShopHomeVC new];
        detailVC.sellerId=self.nullGoodModel.sellerId;
        [self.navigationController pushViewController:detailVC animated:YES];
    };
    self.tableView.tableHeaderView =self.headView;
}

-(void)addGetSellInfo
{
    NSDictionary *dic =@{@"sellerId":self.nullGoodModel.sellerId,@"districtId":[DRUserInfoModel sharedManager].locationCode?:@""};
    [SNAPI getWithURL:@"seller/getSellerInfo" parameters:[dic mutableCopy] success:^(SNResult *result) {
      
              CRDetailModel *detailModel=[CRDetailModel mj_objectWithKeyValues:result.data];            
            self.headView.companyNameLab.text =detailModel.sellerName;
            self.headView.contentLab.text =[NSString stringWithFormat:@"开票方：%@ | %@",detailModel.kpName,detailModel.payType?@"月结":@"现金"];
//            [SNTool setTextColor:self.headView.contentLab FontNumber:DR_FONT(12) AndRange:NSMakeRange(self.headView.contentLab.text.length-detailModel.sellerType.length, detailModel.sellerType.length) AndColor:REDCOLOR];
       
        
    } failure:^(NSError *error) {

    }];
}
- (void)notificationHandler:(NSNotification *)notification {
    if ([notification.name isEqualToString:@"select"]) {
        NSDictionary *dic =notification.userInfo;
        NSArray * sourceArr =dic[@"array"];
        NSString *muIDStr=[NSString string];
        NSMutableArray *muIDArr =[NSMutableArray array];
        for (NSArray *IDArr in sourceArr)
        {
            if (IDArr.count>1) {
                for (NSString *IDStr in IDArr) {
                    muIDStr =[muIDStr stringByAppendingString:[IDStr stringByAppendingString:@","]];
                }
            }
            else
            {
                if (IDArr.count!=0)
                {
                    muIDStr =IDArr[0]?:@"";
                }else
                {
                    muIDStr =@"";
                }
            }
            [muIDArr addObject:muIDStr];
        
        }
        if (muIDArr.count==1) {
            
            [_sendDataDictionary setObject:muIDArr[0] forKey:@"diameterId"];
        }
        else
        {
            [_sendDataDictionary setObject:muIDArr[0] forKey:@"diameterId"];
            [_sendDataDictionary setObject:muIDArr[1] forKey:@"lengthId"];
        }
            [self.tableView.mj_header beginRefreshing];
        }
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"select" object:nil];
}

-(void)addTypeWithSource
{
       NSString *urlStr;
      //特价
      if ([[GoodsShareModel sharedManager].queryType isEqualToString:@"promotion"])
      {
          urlStr =@"mainPage/getPromotionRelationCondition";
      }
      else if ([[GoodsShareModel sharedManager].queryType isEqualToString:@"factory"])
      {
          urlStr =@"mainPage/getFactoryRelationCondition";
      }
      else if ([[GoodsShareModel sharedManager].queryType isEqualToString:@"StoreList"])
      {
          urlStr =@"mainPage/getStoreListCondition";
      }
      else
      {
          urlStr =@"mainPage/getCategoryRelationCondition";
      }

    if (!_typeDic) {
         _typeDic =[NSMutableDictionary dictionaryWithObjects:@[@"",@"",self.level1IdStr?:@"",self.level2IdStr?:@"",@"1",self.categoryIdStr?:@"",[DRUserInfoModel sharedManager].locationCode?:@""] forKeys:@[@"cz",@"type",@"level1Id",@"level2Id",@"subType",@"categoryId",@"district"]];
    }
      //立即购买特殊处理
      if ([[GoodsShareModel sharedManager].queryType isEqualToString:@"nowBuy"])
      {
          urlStr = @"burst/getBurstRelationCondition";
          _typeDic = [NSMutableDictionary dictionaryWithObjects:@[self.nullGoodModel.sellerId?:@"",self.nullGoodModel.levelId?:@"",self.nullGoodModel.surfaceId?:@"",self.nullGoodModel.materialId?:@"",self.nullGoodModel.standardId?:@""] forKeys:@[@"sellerId",@"levelId",@"surfaceId",@"materialId",@"standardId"]];
      }
      if ([[GoodsShareModel sharedManager].queryType isEqualToString:@"history"]) {
          urlStr =@"/buyer/getHistoryBuyRelationCondition";
          _typeDic = [NSMutableDictionary dictionaryWithObjects:@[@"",@""] forKeys:@[@"type",@"standardId"]];
      }
      if ([[GoodsShareModel sharedManager].queryType isEqualToString:@"search"]||[[GoodsShareModel sharedManager].queryType isEqualToString:@"searchbrand"])
      {
          urlStr =@"/mainPage/getSearchRelationCondition";
           _typeDic = [NSMutableDictionary dictionaryWithObjects:@[@"",[GoodsShareModel sharedManager].keyword?:@"",@"",@""] forKeys:@[@"type",@"keyword",@"condition",@"standardId"]];
          if ([[GoodsShareModel sharedManager].queryType isEqualToString:@"searchbrand"]) {
              [_typeDic setObject:@"item" forKey:@"searchtype"];
          }
          
      }
      if ([[GoodsShareModel sharedManager].queryType isEqualToString:@"promotion"])
      {
          NSDictionary *dic =@{@"level1Id":[GoodsShareModel sharedManager].level1Id?:@"",@"level2Id":[GoodsShareModel sharedManager].level2Id?:@"",@"categoryId":[GoodsShareModel sharedManager].categoryId?:@"",@"cz":@"",@"type":@"",@"subType":@"1",@"district":[DRUserInfoModel sharedManager].locationCode?:@""};
          _typeDic = [NSMutableDictionary dictionaryWithDictionary:dic];
          
      }
    
    [SNAPI getWithURL:urlStr parameters:_typeDic success:^(SNResult *result) {
       
        GHDropMenuModel *configuration = [[GHDropMenuModel alloc]init];
        //立即购买特殊处理
        if ([[GoodsShareModel sharedManager].queryType isEqualToString:@"nowBuy"])
        {
            NSArray *bigArr =@[@{@"headTitle":@"直径",@"content":result.data[@"zjList"]},@{@"headTitle":@"长度",@"content":result.data[@"cdList"]}];
            configuration.titles = [configuration creaFilterDropMenuData:bigArr];
        }else
        {
            NSArray *bigArr =@[@{@"headTitle":@"标准",@"content":result.data[@"bzlist"]},@{@"headTitle":@"材质",@"content":result.data[@"czlist"]},@{@"headTitle":@"级别",@"content":result.data[@"jblist"]},@{@"headTitle":@"材料",@"content":result.data[@"cllist"]},@{@"headTitle":@"直径",@"content":result.data[@"zjlist"]},@{@"headTitle":@"长度",@"content":result.data[@"cdlist"]},@{@"headTitle":@"表面处理",@"content":result.data[@"bmcllist"]},@{@"headTitle":@"品牌",@"content":result.data[@"pplist"]},@{@"headTitle":@"牙距",@"content":result.data[@"yjlist"]},@{@"headTitle":@"牙型",@"content":result.data[@"yxlist"]},@{@"headTitle":@"仓库",@"content":result.data[@"storelist"]}];
            configuration.titles = [configuration creaFilterDropMenuData:bigArr];
        }
        /** 配置筛选菜单是否记录用户选中 默认NO */
        configuration.recordSeleted = YES;
        
        self.configuration = configuration;
                    
    } failure:^(NSError *error) {
    }];
    
}
- (void)setUpScrollToTopView
{
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
     _backTopButton.hidden = YES;
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setBackgroundImage:[UIImage imageNamed:@"more-same"] forState:UIControlStateNormal];
    _backTopButton.frame = CGRectMake(ScreenW - HScale(50), ScreenH - 150-DRTopHeight , HScale(40), HScale(40));
    _shopCarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_shopCarButton];
    [_shopCarButton addTarget:self action:@selector(shopCarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //    [_shopCarButton setTitle:@"购物车" forState:UIControlStateNormal];
    //    [_shopCarButton setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    [_shopCarButton setImage:[UIImage imageNamed:@"shopCar"] forState:UIControlStateNormal];
    
        _shopCarButton.hidden = YES;
    _shopCarButton.frame = CGRectMake(ScreenW - HScale(50), ScreenH - 90-DRTopHeight , HScale(40), HScale(40));
    HCDragingView *dragmoreView =[[HCDragingView alloc]initWithFrame:CGRectMake(ScreenW - HScale(50), ScreenH - 150-DRTopHeight , HScale(40), HScale(40)) containerView:self.view];
    dragmoreView.dragImage =@"more-same";
    dragmoreView.didEventBlock = ^{
        DRSameLookVC *sameLookVC = [[DRSameLookVC alloc]init];
        sameLookVC.nullGoodModel= self.nullGoodModel;
        [self.navigationController pushViewController:sameLookVC animated:YES];
    };
    [dragmoreView show];
    
    HCDragingView *dragView =[[HCDragingView alloc]initWithFrame:CGRectMake(ScreenW - HScale(50), ScreenH - 90-DRTopHeight , HScale(40), HScale(40)) containerView:self.view];
    dragView.dragImage =@"shopCar";
    dragView.didEventBlock = ^{
        self.tabBarController.selectedIndex =3;
        [self.navigationController popToRootViewControllerAnimated:YES];
    };
    [dragView show];
}
-(void)shopCarButtonClick
{
    self.tabBarController.selectedIndex =3;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - <UIScrollViewDelegate>
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    _backTopButton.hidden = (scrollView.contentOffset.y > ScreenH) ? NO : YES;//判断回到顶部按钮是否隐藏
//    //    _topToolView.hidden = (scrollView.contentOffset.y < 0) ? YES : NO;//判断顶部工具View的显示和隐形
//    if (scrollView.contentOffset.y > DRTopHeight) {
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//        [[NSNotificationCenter defaultCenter]postNotificationName:SHOWTOPTOOLVIEW object:nil];
//    }else{
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//        [[NSNotificationCenter defaultCenter]postNotificationName:HIDETOPTOOLVIEW object:nil];
//    }
//}
#pragma mark - collectionView滚回顶部
- (void)ScrollToTop
{
    DRSameLookVC *sameLookVC = [[DRSameLookVC alloc]init];
    sameLookVC.nullGoodModel= self.nullGoodModel;
    [self.navigationController pushViewController:sameLookVC animated:YES];
}
-(void)getMsgList
{
    if (!_sendDataDictionary) {
//    districtId: 47821
//    sellerId: 53428B495CC74266870B46D04AB726BE
//    levelId: 6370b8e1f50b11e8b89a00163e104ad2
//    surfaceId: 725d24b7f50b11e8b89a00163e104ad2
//    materialId: d285064cf50b11e8b89a00163e104ad2
//    lengthId:
//    diameterId:
//    standardId: 3385e12af50b11e8b89a00163e104ad2
//    pageSize: 10
//    pageNum: 1
//    dcType:
    _sendDataDictionary = [NSMutableDictionary dictionaryWithObjects:@[[DRUserInfoModel sharedManager].locationCode?:@"",self.nullGoodModel.sellerId?:@"",self.nullGoodModel.levelId?:@"",self.nullGoodModel.surfaceId?:@"",self.nullGoodModel.materialId?:@"",@"",@"",self.nullGoodModel.standardId?:@"",@""] forKeys:@[@"districtId",@"sellerId",@"levelId",@"surfaceId",@"materialId",@"lengthId",@"diameterId",@"standardId",@"dcType"]];
    }
    //    [MBProgressHUD showMessage:@""];
    [self loadDataSource:_sendDataDictionary withpagecount:[NSString stringWithFormat:@"%d",pageCount]];
}
-(void)loadDataSource:(NSMutableDictionary*)dictionary withpagecount:(NSString *)page
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (page) {
        [dic setObject:page forKey:@"pageNum"];
         [dic setObject:@"10" forKey:@"pageSize"];
        
    }
    NSString *urlStr;
    if (self.shopStr.length!=0) {
        urlStr =@"burst/getSellerItem";
        [dictionary setObject:self.keyWordStr?:@"" forKey:@"keyword"];
        [dictionary setObject:@"false" forKey:@"saleSort"];
        [dictionary setObject:@"" forKey:@"jbcz"];
        [dictionary setObject:@"" forKey:@"containzy"];
        [dictionary setObject:@"" forKey:@"queryType"];
        [dictionary setObject:self.sellerIdStr?:@"" forKey:@"sellerId"];
       
    }
    else
    {
        urlStr =@"burst/getItem";
    }
   
    if (dictionary) {
        [dic addEntriesFromDictionary:dictionary];
    }
    [dic setObject:@"" forKey:@"onlyMonth"];
    [dic setObject:@"" forKey:@"onlyHshy"];
    DRWeakSelf;
    [MBProgressHUD showMessage:@""];
    [SNAPI getWithURL:urlStr parameters:dic success:^(SNResult *result) {
        NSLog(@"data=%@",result.data[@"list"]);
        NSArray *modelArray=[GoodsModel mj_objectArrayWithKeyValuesArray:result.data[@"items"]];
        [weakSelf.sameArr addObjectsFromArray:modelArray];
        self.isOpenArr=[[NSMutableArray alloc] init];        
        for (int i=0; i<weakSelf.sameArr.count; i++) {
            NSString*  state=@"close";
            [self.isOpenArr addObject:state];
        }
        [self.tableView reloadData];
        if (modelArray.count<10){
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        else{
            [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView.mj_header endRefreshing];
        
        [MBProgressHUD hideHUD];
        [self addTypeWithSource];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUD];
    }];
}
-(void)setUI
{
   NSArray *titleArr =@[@"综合",@"销量",@"仅看月结",@"仅看含运",@"仅看有货",@""];
    NSArray *imageArr =@[@"",@"",@"classification_ico_default",@"classification_ico_default",@"classification_ico_default",@"classification_ico_shaixuan"];
    NSArray *selectedImageArr =@[@"",@"",@"classification_ico_check",@"classification_ico_check",@"classification_ico_check",@"classification_ico_shaixuan"];
    for (int i=0; i<titleArr.count; i++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        if (i<2) {
            button.frame =CGRectMake(i*WScale(48), 0, WScale(48), WScale(40));
        }else if (i==5)
        {
            button.frame =CGRectMake(SCREEN_WIDTH-WScale(27), 0, WScale(27), WScale(40));
        }else if (i==2)
        {
             button.frame =CGRectMake(i*WScale(48), 0, WScale(84), WScale(40));
        }
        else if (i==3)
        {
             button.frame =CGRectMake(2*WScale(48)+WScale(84), 0, WScale(84), WScale(40));
        }
        else if (i==4)
        {
            button.frame =CGRectMake(2*WScale(48)+2*WScale(84), 0, WScale(84), WScale(40));
        }
        
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        button.backgroundColor =[UIColor whiteColor];
        [button setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
        [button setTitleColor:REDCOLOR forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectedImageArr[i]] forState:UIControlStateSelected];
        if (i==2) {
            
            [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
        }else if (i==3)
        {
            [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
        }
        else if (i==4)
        {
            [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
        }
        button.titleLabel.font =DR_FONT(12);
        button.tag =i;
        [button addTarget:self action:@selector(selectClickWithTag:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}
-(void)selectClickWithTag:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
        {
            self.selectBtn.selected = NO ;
            sender.selected = YES ;
            self.selectBtn = sender ;
            //            NSArray *datas =@[@"本地云仓（三铁配送）",@"卖家直发（价格便宜）"];
            //            NSArray *contentDatas =@[@"说明：本地现货库存，及时配送、出货。",@"说明：卖家现货库存，由卖家直接安排发货。"];
            //            LDYSelectivityAlertView *ldySAV = [[LDYSelectivityAlertView alloc]initWithdatas:datas contentDatas:contentDatas selectDatas:nil ifSupportMultiple:YES];
            //            ldySAV.delegate = self;
            //            [ldySAV show];
        }
            break;
        case 1:
        {
            self.selectBtn.selected = NO ;
            sender.selected = YES ;
            self.selectBtn = sender ;
            [self.sendDataDictionary setObject:sender.selected?@"1":@"" forKey:@"saleSort"];
            [self.tableView.mj_header beginRefreshing];
        }
            break;
      case 2:
        {
            sender.selected =!sender.selected;
            [self.sendDataDictionary setObject:sender.selected?@"1":@"" forKey:@"onlyMonth"];
            [self.tableView.mj_header beginRefreshing];
        }
            break;
        case 3:
        {
            sender.selected =!sender.selected;
            [self.sendDataDictionary setObject:sender.selected?@"1":@"" forKey:@"onlyHshy"];
            [self.tableView.mj_header beginRefreshing];
        }
            break;
        case 4:
        {
            sender.selected =!sender.selected;
            [self.sendDataDictionary setObject:sender.selected?@"1":@"" forKey:@"onlyqty"];
            [self.tableView.mj_header beginRefreshing];
        }
            break;
        case 5:
        {
//            [GoodsShareModel sharedManager].sellerId =self.nullGoodModel.sellerId;
//            [GoodsShareModel sharedManager].levelId =self.nullGoodModel.levelId;
//            [GoodsShareModel sharedManager].surfaceId =self.nullGoodModel.surfaceId;
//            [GoodsShareModel sharedManager].materialId =self.nullGoodModel.materialId;
//            [GoodsShareModel sharedManager].standardId =self.nullGoodModel.standardId;
            DRWeakSelf;
            GHDropMenu *dropMenu = [GHDropMenu creatDropFilterMenuWidthConfiguration:self.configuration dropMenuTagArrayBlock:^(NSArray * _Nonnull tagArray) {
                [weakSelf getStrWith:tagArray];                
            }];
            
//            [GoodsShareModel sharedManager].queryType =self.queryTypeStr;
            dropMenu.selectedBlock = ^(GHDropMenuModel * _Nonnull selectModel, NSArray * _Nonnull dataArr) {
                NSArray * sectionArr  = selectModel.sections;
                for (GHDropMenuModel *model in sectionArr) {
                    if ([model.sectionHeaderTitle isEqualToString:@"直径"]) {
                        NSArray *modelArr =model.dataArray;
                        NSString *materialIdStr;
                        for (GHDropMenuModel *model2 in modelArr) {
                            if (model2.tagSeleted) {
                                materialIdStr =[materialIdStr stringByAppendingString:[model2.tagID stringByAppendingString:@","]];
                                [_sendDataDictionary setValue:materialIdStr forKey:@"diameterid"];
                            }
                        }
                        
                    }
                    
                    else if ([model.sectionHeaderTitle isEqualToString:@"长度"]) {
                        NSArray *modelArr =model.dataArray;
                        NSString *materialIdStr;
                        for (GHDropMenuModel *model2 in modelArr) {
                            if (model2.tagSeleted) {
                                materialIdStr =[materialIdStr stringByAppendingString:[model2.tagID stringByAppendingString:@","]];
                                [_sendDataDictionary setValue:materialIdStr forKey:@"lengthId"];
                            }
                        }
                        
                    }
                    
                    
                    [self.tableView.mj_header beginRefreshing];
                    
                }
                
            };
            dropMenu.titleSeletedImageName = @"up_normal";
            dropMenu.titleNormalImageName = @"down_normal";
            dropMenu.delegate = self;
            dropMenu.durationTime = 0.5;
            self.dropMenu = dropMenu;
            [dropMenu show];
        }
            
            break;
        default:
            break;
    }
}
#pragma LDYSelectivityAlertViewDelegate
-(void)singleChoiceBlockData:(NSString *)data{
    NSLog(@"data=%@",data);
    [_sendDataDictionary setObject:data forKey:@"serviceType"];
    [self.tableView.mj_header beginRefreshing];
}
- (DCUpDownButton *)bgTipButton
{
    if (!_bgTipButton) {
        _bgTipButton = [DCUpDownButton buttonWithType:UIButtonTypeCustom];
        [_bgTipButton setImage:[UIImage imageNamed:@"MG_Empty_dizhi"] forState:UIControlStateNormal];
        _bgTipButton.titleLabel.font = DR_FONT(13);
        [_bgTipButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_bgTipButton setTitle:@"暂无数据" forState:UIControlStateNormal];
        _bgTipButton.frame = CGRectMake((ScreenW - 150) * 1/2 , (ScreenH - 150) * 1/2-DRTopHeight, 150, 150);
        _bgTipButton.adjustsImageWhenHighlighted = false;
    }
    return _bgTipButton;
}

#pragma mark 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    self.bgTipButton.hidden = (self.sameArr.count > 0) ? YES : NO;
    return self.sameArr.count;
}
#pragma mark 表的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 4;
}
#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    switch (indexPath.row) {
        case 0:
        {
            if (self.sameArr.count!=0)
            {
                GoodsModel *model =self.sameArr[indexPath.section];
                if (model.kpName.length!=0) {
                    return WScale(120);
                }
                return WScale(100);
            }
                       
        }
            break;
        case 1:
            return UITableViewAutomaticDimension;
            break;
            
        case 2:
        {
            if ([User currentUser].isLogin) {
                
                return WScale(87);
            }else
            {
                return WScale(60);
            }
        }
            break;
            
        case 3:
            return 0;
            break;
            
            
        default:
            break;
    }
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2;
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSString*  state=[self.isOpenArr objectAtIndex:section];
    if ([state isEqualToString:@"open"]) {
        return WScale(80);
    }
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DRWeakSelf;
    if (self.sameArr.count!=0)
    {
 
        if (indexPath.row==0)
        {
            GoodsCell *cell =[GoodsCell cellWithTableView:tableView];
            cell.goodsModel =self.sameArr[indexPath.section];
            return cell;
        }
        else if (indexPath.row==1)
        {
            SecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondCell"];
            cell.moreBtn.tag =indexPath.section;
            [cell.moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.goodsModel = self.sameArr[indexPath.section];
            cell.titleStr =@"爆品";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        else if (indexPath.row==2)
        {
            if ([User currentUser].isLogin) {
                
                if (self.sameArr[indexPath.section].qty!=0)
                {
                    CatgoryDetailCell1 *cell =[CatgoryDetailCell1 cellWithTableView:tableView withIndexPath:indexPath];
//                    cell.queryTypeStr =self.queryTypeStr;
                    cell.goodsModel = self.sameArr[indexPath.section];
                    
                    cell.danweiBtn.tag =indexPath.section;
                    cell.countTF.placeholder =@"0.00";
                    cell.moreBtnBlock = ^{
                        
                        NSString*  state=[self.isOpenArr objectAtIndex:indexPath.section];
                        if ([state isEqualToString:@"open"]) {
                            state=@"close";
                        }else
                        {
                            state=@"open";
                        }
                        self.isOpenArr[indexPath.section]=state;
                        //    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:sender.tag];
                        //    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
                        [self.tableView reloadData];
                        
                    };
                    NSString*  state=[self.isOpenArr objectAtIndex:indexPath.section];
                    if ([state isEqualToString:@"open"])
                    {
                        cell.moreBtn.selected =YES;
                    }
                    else
                    {
                        cell.moreBtn.selected =NO;
                    }
                    return cell;
                }
                else
                {
                    CatgoryDetailCell *cell =[CatgoryDetailCell cellWithTableView:tableView];
                    cell.goodsModel =self.goodsModel;
                    NSString*  state=[self.isOpenArr objectAtIndex:indexPath.section];
                    cell.moreBtnBlock = ^{
                        
                        NSString*  state=[self.isOpenArr objectAtIndex:indexPath.section];
                        if ([state isEqualToString:@"open"]) {
                            state=@"close";
                        }else
                        {
                            state=@"open";
                        }
                        self.isOpenArr[indexPath.section]=state;
                        //    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:sender.tag];
                        //    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
                        [self.tableView reloadData];
                        
                    };
                    if ([state isEqualToString:@"open"])
                    {
                        cell.moreBtn.selected =YES;
                    }
                    else
                    {
                        cell.moreBtn.selected =NO;
                    }
                    return cell;
                }
            }else
            {
                CatgoryDetailCell4 *cell =[CatgoryDetailCell4 cellWithTableView:tableView];
                cell.cancelBlock = ^(NSInteger canceltag) {
                    [DRAppManager showLoginView];
                };
                cell.shopCarBlock = ^(NSInteger shopCartag) {
                    [DRAppManager showLoginView];
                };
                return cell;
            }
            
        }
        else if (indexPath.row==3)
        {
//
        }
    }
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier: SimpleTableIdentifier];
    }
    return cell;
}
//-(void)saveWithTag:(NSInteger)tag
//{
//
//}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSString*  state=[self.isOpenArr objectAtIndex:section];
    if ([state isEqualToString:@"open"])
    {
        DRFooterCell *cell =[DRFooterCell cellWithTableView:tableView];
        NSString *timestr;
        if ([self.sameArr[section].deliveryDay integerValue]>1) {
            timestr =[NSString stringWithFormat:@"预计发货时间：%@天",self.sameArr[section].deliveryDay];
        }else{
            timestr =@"预计发货时间：当天发货";
        }
        NSArray *titleArr =@[[NSString stringWithFormat:@"最小销售单位：%@",self.sameArr[section].saleUnitName],[NSString stringWithFormat:@"单规格起订量：%.3f%@",self.sameArr[section].minQuantity ,self.sameArr[section].saleUnitName],timestr];
        cell.danweiLab.text = titleArr[0];
        cell.qidingliangLab.text = titleArr[1];
        cell.timeLAb.text = titleArr[2];
        if (self.sameArr[section].drawing.length==0) {
            cell.lookIMGbTN.hidden =YES;
        }
        else
        {
            cell.lookIMGbTN.hidden =NO;
        }
        cell.lookIMGBtnBlock = ^{
            ZWPhotoPreviewDataModel *model1 = [[ZWPhotoPreviewDataModel alloc] init];
            model1.zw_photoURL = self.sameArr[section].drawing;
            model1.zw_photoTitle =nil;
            model1.zw_photoDesc = nil;
           
            ZWPhotoPreview *view = [ZWPhotoPreview zw_showPhotoPreview:@[model1]];
            view.showIndex = 0;
//            SKFPreViewNavController *imagePickerVc =[[SKFPreViewNavController alloc]initWithSelectedPhotoURLs:@[self.sameArr[section].drawing] index:0];
//
//            [self presentViewController:imagePickerVc animated:YES completion:nil];
//            //1.创建图片浏览器
//            MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
//
//            //2.告诉图片浏览器显示所有的图片
//            //            NSMutableArray *photos = [NSMutableArray array];
//
//            //传递数据给浏览器
//            MJPhoto *photo = [[MJPhoto alloc] init];
//            photo.url = [NSURL URLWithString:self.sameArr[section].drawing];
//            photo.srcImageView =cell.lookIMGbTN; //设置来源哪一个UIImageView
//
//
//            brower.photos = @[photo];
            
            //3.设置默认显示的图片索引
//            brower.currentPhotoIndex = recognizer.view.tag;
            
            //4.显示浏览器
//            [brower show];
//            TestImageView *showView = [[TestImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
//            [showView.imageView sd_setImageWithURL:[NSURL URLWithString:self.sameArr[section].drawing]];
//            showView.outsideFrame =CGRectMake(0, 0, ScreenW, ScreenH);
//            showView.insideFrame =CGRectMake(0, ScreenH/2-ScreenH/9, ScreenW, ScreenH/4.5);
//            [showView show];
        };
        //            [SNTool setTextColor:cell.textLabel FontNumber:DR_FONT(12) AndRange:NSMakeRange(7, cell.textLabel.text.length-7) AndColor:REDCOLOR];
        return cell;
        
    }
    return [UIView new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [self.navigationController pushViewController:[StoreVC new] animated:YES];
}

#pragma mark -- ShopTableViewCellSelectDelegate
/**
 *  cell的选择代理
 *
 *  @param sender 选中按钮
 */
//- (void)cellSelectBtnClick:(UIButton *)sender{
//    MyShopCarTableViewCell *cell = (MyShopCarTableViewCell *)[[sender superview] superview];
//    NSIndexPath *indexPath;
//    indexPath = [_tableView indexPathForCell:cell];
//
//    ShopCarDetailModel *bigModel = self.shopCarGoodsArray[indexPath.section];
//    CarDetailModel *cellModel = bigModel.goodsDetails[indexPath.row];
//    cellModel.selectState = sender.selected;
//    //设置段头的选择按钮选中状态
//    [self setHeaderViewSelectState:bigModel];
//    //设置底部选择按钮的选中状态
//    [self setBottomBtnSelectState];
//    //计算价格
//    [self calculateTotalMoney:[NSMutableArray arrayWithObject:cellModel] addOrReduc:sender.selected];
//
//    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:indexPath.section];
//    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//
//    //    [_tableView reloadData];
//
//}
///**
// *  修改商品数量
// *
// *  @param sender 1 减少  2 增加
// */
//- (void)changeShopCount:(UIButton *)sender{
//    switch (sender.tag) {
//        case 1:
//        {
//
//        }
//            break;
//        case 2:
//        {
//
//        }
//            break;
//        default:
//            break;
//    }
//}

-(void)selectBtnClick:(UIButton *)sender
{
    [CGXPickerView showStringPickerWithTitle:@"单位" DataSource:@[ @"袋",@"盒", @"箱"] DefaultSelValue:@"单位" IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
        [sender setTitle:selectValue forState:UIControlStateNormal];
        NSLog(@"%@",selectValue);
    }];
}
-(void)moreBtnClick:(UIButton *)sender
{
    sender.selected =!sender.selected;
    NSString*  state=[self.isOpenArr objectAtIndex:sender.tag];
    if ([state isEqualToString:@"open"]) {
        state=@"close";
    }else
    {
        state=@"open";
    }
    self.isOpenArr[sender.tag]=state;
    //    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:sender.tag];
    //    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView reloadData];
}
#pragma mark - 代理方法
- (void)dropMenu:(GHDropMenu *)dropMenu dropMenuTitleModel:(GHDropMenuModel *)dropMenuTitleModel {
    self.navigationItem.title = [NSString stringWithFormat:@"筛选结果: %@",dropMenuTitleModel.title];
}

- (void)dropMenu:(GHDropMenu *)dropMenu tagArray:(NSArray *)tagArray {
//    [self getStrWith:tagArray];
}

- (void)getStrWith: (NSArray *)tagArray {
    NSMutableString *string = [NSMutableString string];
    if (tagArray.count) {
        for (GHDropMenuModel *dropMenuTagModel in tagArray) {
            if (dropMenuTagModel.tagSeleted) {
                if (dropMenuTagModel.tagName.length) {
                    [string appendFormat:@"%@",dropMenuTagModel.tagName];
                }
            }
            if (dropMenuTagModel.maxPrice.length) {
                [string appendFormat:@"最大价格%@",dropMenuTagModel.maxPrice];
            }
            if (dropMenuTagModel.minPrice.length) {
                [string appendFormat:@"最小价格%@",dropMenuTagModel.minPrice];
            }
            if (dropMenuTagModel.singleInput.length) {
                [string appendFormat:@"%@",dropMenuTagModel.singleInput];
            }
            if (dropMenuTagModel.beginTime.length) {
                [string appendFormat:@"开始时间%@",dropMenuTagModel.beginTime];
            }
            if (dropMenuTagModel.endTime.length) {
                [string appendFormat:@"结束时间%@",dropMenuTagModel.endTime];
            }
        }
    }
   ;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

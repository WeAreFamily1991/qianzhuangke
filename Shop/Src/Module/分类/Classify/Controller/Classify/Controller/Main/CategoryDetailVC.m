
//
//  CategoryDetailVC.m
//  Shop
//
//  Created by BWJ on 2019/3/7.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "CategoryDetailVC.h"
#import "SYTypeButtonView.h"
#import "SecondCell.h"
#import "GoodsCell.h"
#import "CatgoryDetailCell.h"
#import "GHCountField.h"
#import "CGXPickerView.h"
#import "DCSildeBarView.h"
#import "LDYSelectivityAlertView.h"
#import "StoreVC.h"
#import "GoodsModel.h"
#import "CustomAlertView.h"
#import "DRNullShopModel.h"
#import "DRFooterCell.h"
#import "TestImageView.h"
#import "ZWPhotoPreviewDataModel.h"
#import "ZWPhotoPreview.h"
#import "DCFiltrateViewController.h"
#import "GHDropMenu.h"
#import "GHDropMenuModel.h"
#import "DRShopHomeVC.h"
#define DIC_EXPANDED @"expanded" //是否是展开 0收缩 1展开

#define DIC_ARARRY @"array" //存放数组

#define DIC_TITILESTRING @"title"

#define CELL_HEIGHT 50.0f
@interface CategoryDetailVC ()<GHCountFieldDelegate,LDYSelectivityAlertViewDelegate,GHDropMenuDelegate>
{
    int pageCount;
     NSMutableArray *DataArray;
    
}
@property (nonatomic , strong) GHDropMenu *dropMenu;
@property (nonatomic , strong) GHDropMenuModel *configuration;
@property(nonatomic,strong)NSMutableArray*   isOpenArr;
@property (nonatomic,retain)GoodsModel *goodsModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)SYTypeButtonView *buttonView;
@property (nonatomic,strong)NSMutableArray *MsgListArr,*selectNameArr,*selectCodeArr;
@property (assign,nonatomic)NSInteger selectYes;
@property (assign,nonatomic)NSInteger selectcode;
@property (strong , nonatomic)UIButton *selectBtn;
/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;

@property (strong , nonatomic)UIButton *shopCarButton;
@property (nonatomic,retain)DCUpDownButton *bgTipButton;
@property (nonatomic,strong) DCFiltrateViewController *filterView;//筛选视图
@end

@implementation CategoryDetailVC
-(NSMutableArray *)MsgListArr
{
    if (!_MsgListArr) {
        _MsgListArr =[NSMutableArray array];
    }
    return _MsgListArr;
}
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.bgTipButton];
    self.selectYes =NO;
     [self initDataSource];
    self.view.backgroundColor =BACKGROUNDCOLOR;
    //    self.tableView.frame =CGRectMake(0, 120, SCREEN_WIDTH, self.tableView.height - 120);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor =BACKGROUNDCOLOR;
    if ([self.queryTypeStr isEqualToString:@"history"])
    {
        self.title =@"购买记录";
    }else
    {
        self.title =@"产品列表";
    }
    
     [self setUpScrollToTopView];
    [self setUI];
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [_tableView registerClass:[SecondCell class] forCellReuseIdentifier:@"SecondCell"];
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakSelf.MsgListArr.count) {
            [weakSelf.MsgListArr removeAllObjects];
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
   
    //       self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
     [self.tableView.mj_header beginRefreshing];
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
        NSArray *keyArr =@[@"onlyqty",@"voucherType",@"categoryId",@"czid",@"materialId",@"diameterid",@"lengthId",@"levelId",@"surfaceId",@"brandid",@"toothdistanceid",@"toothformid"];
        for (int i=0; i<muIDArr.count; i++) {
            [_sendDataDictionary setObject:muIDArr[i] forKey:keyArr[i]];
        }

         [self.tableView.mj_header beginRefreshing];
    }
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"select" object:nil];
}
- (void)setUpScrollToTopView
{
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
   
    [_backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(ScreenW - 50, ScreenH - 180-DRTopHeight , 40, 40);
    _shopCarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_shopCarButton];
    [_shopCarButton addTarget:self action:@selector(shopCarButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [_shopCarButton setTitle:@"购物车" forState:UIControlStateNormal];
//    [_shopCarButton setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    [_shopCarButton setImage:[UIImage imageNamed:@"shopCar"] forState:UIControlStateNormal];
    
    _shopCarButton.hidden = YES;
     _shopCarButton.frame = CGRectMake(ScreenW - HScale(50), ScreenH - 90-DRTopHeight , HScale(40), HScale(40));
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
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    _backTopButton.hidden = (scrollView.contentOffset.y > ScreenH) ? NO : YES;//判断回到顶部按钮是否隐藏
    //    _topToolView.hidden = (scrollView.contentOffset.y < 0) ? YES : NO;//判断顶部工具View的显示和隐形
    
    if (scrollView.contentOffset.y > DRTopHeight) {
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
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}
-(void)getMsgList
{
    if (!_sendDataDictionary) {
        //queryType  normal(普通)  search （搜索） history（历史购买）
        //level1Id   标准头ID
       // level2Id   分类左边ID
        //categoryId   商品ID
        //serviceType 0:本地云仓 ，st：工厂库存——三铁配送  zf：工厂库存-工厂直发
        //sellerType  0自营 1月结卖家
        //containzy   是否包含自营 默认包含 0不包含
        //districtid  区域ID
        //onlyqty  是否显示有货 0或者1
        if ([self.queryTypeStr isEqualToString:@"history"]||[self.queryTypeStr isEqualToString:@"search"]||[self.queryTypeStr isEqualToString:@"searchbrand"]) {
//            NSArray *IDArr =[_classListStr componentsSeparatedByString:@","];
            NSLog(@"");
          
                _sendDataDictionary = [NSMutableDictionary dictionaryWithObjects:@[self.queryTypeStr,@"",@"",@"",@"",@"1",@"",@"",@"",@"",@"",[DRUserInfoModel sharedManager].locationCode?:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"0"] forKeys:@[@"queryType",@"keyword",@"level1Id",@"level2Id",@"cz",@"subType",@"categoryId",@"condition",@"serviceType",@"sellerType",@"containzy",@"districtid",@"orderBy",@"onlyqty",@"standardId",@"levelid",@"surfaceId",@"lengthId",@"materialId",@"toothdistanceid",@"toothformid",@"brandid",@"czid",@"diameterid",@"voucherType"]];
            if ([self.queryTypeStr isEqualToString:@"search"]||[self.queryTypeStr isEqualToString:@"searchbrand"]) {
               [ _sendDataDictionary setObject:self.keyWordStr forKey:@"keyword"];
            }
        }
        else if ([self.queryTypeStr isEqualToString:@"shopnull"])
        {
             _sendDataDictionary = [NSMutableDictionary dictionaryWithObjects:@[[DRUserInfoModel sharedManager].locationCode?:@"",self.nullShopModel.sellerId,self.queryTypeStr,@"",@"",@"",@"",@"1",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""] forKeys:@[@"districtId",@"sellerId",@"keyword",@"level1Id",@"level2Id",@"cz",@"subType",@"categoryId",@"condition",@"serviceType",@"sellerType",@"containzy",@"districtid",@"orderBy",@"onlyqty",@"standardId",@"levelId",@"surfaceId",@"lengthId",@"materialId",@"toothdistanceid",@"toothformid",@"brandid",@"czid",@"diameterid",@"voucherType"]];
        }
        else
        {
            //queryType  normal(普通)  search （搜索） history（历史购买）
            //level1Id   标准头ID
            // level2Id   分类左边ID
            //categoryId   商品ID
            //serviceType 0:本地云仓 ，st：工厂库存——三铁配送  zf：工厂库存-工厂直发
            //sellerType  0自营 1月结卖家
            //containzy   是否包含自营 默认包含 0不包含
            //districtid  区域ID
            //onlyqty  是否显示有货 0或者1
            NSArray *IDArr =[_classListStr componentsSeparatedByString:@","];
            NSLog(@"");
            if (IDArr.count>=3) {
                [GoodsShareModel sharedManager].level1Id =IDArr[0];
                [GoodsShareModel sharedManager].level2Id =IDArr[1];
                _sendDataDictionary = [NSMutableDictionary dictionaryWithObjects:@[self.queryTypeStr,@"",IDArr[0],IDArr[1],_czID?:@"",@"1",IDArr[2],@"",@"",@"",@"",[DRUserInfoModel sharedManager].locationCode?:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",_czID?:@"",@"",@""] forKeys:@[@"queryType",@"keyword",@"level1Id",@"level2Id",@"cz",@"subType",@"categoryId",@"condition",@"serviceType",@"sellerType",@"containzy",@"districtid",@"orderBy",@"onlyqty",@"standardId",@"levelId",@"surfaceId",@"lengthId",@"materialId",@"toothdistanceid",@"toothformid",@"brandid",@"czid",@"diameterid",@"voucherType"]];
            }
            
        }
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
    DRWeakSelf;
    [MBProgressHUD showMessage:@""];
    NSString *urlStr;
    if (self.shopStr.length!=0) {
        urlStr =@"mainPage/getSellerItem";
        [dictionary setObject:self.keyWordStr?:@"" forKey:@"keyword"];
        [dictionary setObject:@"false" forKey:@"saleSort"];
        [dictionary setObject:@"" forKey:@"jbcz"];
        [dictionary setObject:@"" forKey:@"containzy"];
        [dictionary setObject:@"" forKey:@"queryType"];
        [dictionary setObject:self.sellidStr?:@"" forKey:@"sellerId"];
    }
    else
    {
        urlStr =@"mainPage/getItem";
        
    }
    [dictionary setObject:@"false" forKey:@"saleSort"];
    [dictionary setObject:@"" forKey:@"storeid"];
    [dictionary setObject:@"" forKey:@"jbcz"];
    [dictionary setObject:@"" forKey:@"param"];
    [dictionary setObject:@"new" forKey:@"version"];
    [dictionary setObject:@"" forKey:@"onlyMonth"];
    [dictionary setObject:@"" forKey:@"onlyHshy"];
    
    if (dictionary) {
        [dic addEntriesFromDictionary:dictionary];
    }
    
    [SNAPI getWithURL:urlStr parameters:dic success:^(SNResult *result) {
        NSLog(@"data=%@",result.data[@"items"]);
        NSMutableArray*addArr=result.data[@"items"];
        NSMutableArray *modelArray =[GoodsModel mj_objectArrayWithKeyValuesArray:result.data[@"items"]];
        [weakSelf.MsgListArr addObjectsFromArray:modelArray];
        [self getItemWithArray:result.data[@"paramItemList"]];
        self.isOpenArr=[[NSMutableArray alloc] init];
        // self.dataDict=@{@"first":firstDataArr,@"second":secondArr,@"third":thirdArr};      
        //for (int i=0; i<self.dataDict.allKeys.count; i++) {
        for (int i=0; i<weakSelf.MsgListArr.count; i++) {
            NSString*  state=@"close";
            [self.isOpenArr addObject:state];
        }
        [self.tableView reloadData];
        if (addArr.count<10){
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

-(void)getItemWithArray:(NSArray*)array
{
     NSMutableDictionary *mudic =[NSMutableDictionary dictionaryWithObject:array forKey:@"data"];
    [mudic setObject:[DRUserInfoModel sharedManager].locationCode?:@"" forKey:@"districtId"];
    NSString *jsonStr=[SNTool jsontringData:mudic];
    [SNAPI postWithURL:@"mainPage/getItemParamToRestful" parametersWithData:[SNTool jsontringData:mudic] success:^(SNResult *result) {
        
    } failure:^(NSError *error) {
        
    } ];
//postWithURL:@"mainPage/getItemParamToRestful" parametersWithData:jsonStr success:^(SNResult *result) {

//    } failure:^(NSError *error) {
//
//    }];
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
//      //立即购买特殊处理
//      if ([[GoodsShareModel sharedManager].queryType isEqualToString:@"nowBuy"])
//      {
//          urlStr = @"burst/getBurstRelationCondition";
//          _typeDic = [NSMutableDictionary dictionaryWithObjects:@[[GoodsShareModel sharedManager].sellerId?:@"",[GoodsShareModel sharedManager].levelId?:@"",[GoodsShareModel sharedManager].surfaceId?:@"",[GoodsShareModel sharedManager].materialId?:@"",[GoodsShareModel sharedManager].standardId?:@""] forKeys:@[@"sellerId",@"levelId",@"surfaceId",@"materialId",@"standardId"]];
//      }
      if ([[GoodsShareModel sharedManager].queryType isEqualToString:@"history"]) {
          urlStr =@"/buyer/getHistoryBuyRelationCondition";
          _typeDic = [NSMutableDictionary dictionaryWithObjects:@[@"",@""] forKeys:@[@"type",@"standardId"]];
      }
      if ([[GoodsShareModel sharedManager].queryType isEqualToString:@"search"]||[[GoodsShareModel sharedManager].queryType isEqualToString:@"searchbrand"])
      {
          urlStr =@"/mainPage/getSearchRelationCondition";
           _typeDic = [NSMutableDictionary dictionaryWithObjects:@[@"init",self.keyWordStr?:@"",@"",@""] forKeys:@[@"type",@"keyword",@"condition",@"standardId"]];
          if ([[GoodsShareModel sharedManager].queryType isEqualToString:@"search"]) {
              [_typeDic setObject:@"item" forKey:@"searchtype"];
          }
          [_typeDic setObject:[DRUserInfoModel sharedManager].locationCode?:@"" forKey:@"district"];
      }
      if ([[GoodsShareModel sharedManager].queryType isEqualToString:@"promotion"])
      {
          NSArray *IDArr =[_classListStr componentsSeparatedByString:@","];
          NSLog(@"");
          if (IDArr.count>=3) {
              [GoodsShareModel sharedManager].level1Id =IDArr[0];
              [GoodsShareModel sharedManager].level2Id =IDArr[1];
              [GoodsShareModel sharedManager].categoryId =IDArr[2];
          }
          NSDictionary *dic =@{@"level1Id":[GoodsShareModel sharedManager].level1Id?:@"",@"level2Id":[GoodsShareModel sharedManager].level2Id?:@"",@"categoryId":[GoodsShareModel sharedManager].categoryId?:@"",@"cz":@"",@"type":@"",@"subType":@"1",@"districtId":[DRUserInfoModel sharedManager].locationCode?:@""};
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
            if (bigArr.count!=0) {
                configuration.titles = [configuration creaFilterDropMenuData:bigArr];
            }
          
        }
        /** 配置筛选菜单是否记录用户选中 默认NO */
        configuration.recordSeleted = YES;
        self.configuration = configuration;
        
    } failure:^(NSError *error) {
        
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
          DRWeakSelf;
            
          GHDropMenu *dropMenu = [GHDropMenu creatDropFilterMenuWidthConfiguration:self.configuration dropMenuTagArrayBlock:^(NSArray * _Nonnull tagArray) {
               [weakSelf getStrWith:tagArray];
               
          }];
            
//            [GoodsShareModel sharedManager].keyword =self.keyWordStr;
//            [GoodsShareModel sharedManager].queryType =self.queryTypeStr;
            
            dropMenu.selectedBlock = ^(GHDropMenuModel * _Nonnull selectModel, NSArray * _Nonnull dataArr) {
                NSArray * sectionArr  = selectModel.sections;
                for (GHDropMenuModel *model in sectionArr) {
                    if ([model.sectionHeaderTitle isEqualToString:@"标准"]) {
                        NSArray *modelArr =model.dataArray;
                        for (GHDropMenuModel *model2 in modelArr) {
                            if (model2.tagSeleted) {
                                [_sendDataDictionary setValue:model2.tagID forKey:@"standardId"];
                            }
                        }
                        
                    }
                    else if ([model.sectionHeaderTitle isEqualToString:@"级别"]) {
                        NSArray *modelArr =model.dataArray;
                        for (GHDropMenuModel *model2 in modelArr) {
                            if (model2.tagSeleted) {
                                [_sendDataDictionary setValue:model2.tagID forKey:@"levelId"];
                            }
                        }
                        
                    }
                    
                    else if ([model.sectionHeaderTitle isEqualToString:@"材质"]) {
                        NSArray *modelArr =model.dataArray;
                        for (GHDropMenuModel *model2 in modelArr) {
                            if (model2.tagSeleted) {
                                [_sendDataDictionary setValue:model2.tagID forKey:@"czid"];
                            }
                        }
                        
                    }
                    else if ([model.sectionHeaderTitle isEqualToString:@"材料"]) {
                        NSArray *modelArr =model.dataArray;
                        NSString *materialIdStr;
                        for (GHDropMenuModel *model2 in modelArr) {
                            if (model2.tagSeleted) {
                                materialIdStr =[materialIdStr stringByAppendingString:[model2.tagID stringByAppendingString:@","]];
                                [_sendDataDictionary setValue:materialIdStr forKey:@"materialId"];
                            }
                        }
                        
                    }
                    else if ([model.sectionHeaderTitle isEqualToString:@"直径"]) {
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
                    
                    else if ([model.sectionHeaderTitle isEqualToString:@"表面处理"]) {
                        NSArray *modelArr =model.dataArray;
                        NSString *materialIdStr;
                        for (GHDropMenuModel *model2 in modelArr) {
                            if (model2.tagSeleted) {
                                materialIdStr =[materialIdStr stringByAppendingString:[model2.tagID stringByAppendingString:@","]];
                                [_sendDataDictionary setValue:materialIdStr forKey:@"surfaceId"];
                            }
                        }
                        
                    }
                    
                    else if ([model.sectionHeaderTitle isEqualToString:@"品牌"]) {
                        NSArray *modelArr =model.dataArray;
                        NSString *materialIdStr;
                        for (GHDropMenuModel *model2 in modelArr) {
                            if (model2.tagSeleted) {
                                materialIdStr =[materialIdStr stringByAppendingString:[model2.tagID stringByAppendingString:@","]];
                                [_sendDataDictionary setValue:materialIdStr forKey:@"brandid"];
                            }
                        }
                        
                    }
                    else if ([model.sectionHeaderTitle isEqualToString:@"牙距"]) {
                        NSArray *modelArr =model.dataArray;
                        NSString *materialIdStr;
                        for (GHDropMenuModel *model2 in modelArr) {
                            if (model2.tagSeleted) {
                                materialIdStr =[materialIdStr stringByAppendingString:[model2.tagID stringByAppendingString:@","]];
                                [_sendDataDictionary setValue:materialIdStr forKey:@"toothdistanceid"];
                            }
                        }
                        
                    }
                    else if ([model.sectionHeaderTitle isEqualToString:@"牙型"]) {
                        NSArray *modelArr =model.dataArray;
                        NSString *materialIdStr;
                        for (GHDropMenuModel *model2 in modelArr) {
                            if (model2.tagSeleted) {
                                materialIdStr =[materialIdStr stringByAppendingString:[model2.tagID stringByAppendingString:@","]];
                                [_sendDataDictionary setValue:materialIdStr forKey:@"toothformid"];
                            }
                        }
                    }
                    else if ([model.sectionHeaderTitle isEqualToString:@"仓库"]) {
                        NSArray *modelArr =model.dataArray;
                        NSString *materialIdStr;
                        for (GHDropMenuModel *model2 in modelArr) {
                            if (model2.tagSeleted) {
                                materialIdStr =[materialIdStr stringByAppendingString:[model2.tagID stringByAppendingString:@","]];
                                [_sendDataDictionary setValue:materialIdStr forKey:@"storeid"];
                            }
                        }
                    }
                    else if ([model.sectionHeaderTitle isEqualToString:@"仓库"]) {
                        NSArray *modelArr =model.dataArray;
                        NSString *materialIdStr;
                        for (GHDropMenuModel *model2 in modelArr) {
                            if (model2.tagSeleted) {
                                materialIdStr =[materialIdStr stringByAppendingString:[model2.tagID stringByAppendingString:@","]];
                                [_sendDataDictionary setValue:materialIdStr forKey:@"storeid"];
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
}

-(void)multipleChoiceBlockDatas:(NSArray *)datas{
    
    NSLog(@"detail=%@",[datas componentsJoinedByString:@","]);
    [_sendDataDictionary setObject:[datas componentsJoinedByString:@","] forKey:@"serviceType"];
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
    self.bgTipButton.hidden = (_MsgListArr.count > 0) ? YES : NO;
    return self.MsgListArr.count;
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
             if (self.goodsModel.kpName.length!=0) {
                 return WScale(120);
             }
            return WScale(100);
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
    return WScale(10);
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
    if (self.MsgListArr.count!=0)
    {
        self.goodsModel =self.MsgListArr[indexPath.section];
        if (indexPath.row==0)
        {
            if (self.goodsModel.kpName.length!=0) {
                GoodsCell *cell =[GoodsCell cellWithTableView:tableView];
                
                cell.goodsModel =self.goodsModel;
                cell.selectShopBtnBlock = ^{
                    self.goodsModel =self.MsgListArr[indexPath.section];
                    DRShopHomeVC *detailVC = [DRShopHomeVC new];
                    if ([[DRUserInfoModel sharedManager].zyStoreId isEqualToString:self.goodsModel.sellerId]) {
                        detailVC.ycStr =@"1";
                    }
                    detailVC.sellerId=self.goodsModel.sellerId;
                    [self.navigationController pushViewController:detailVC animated:YES];
                    
                };
                return cell;
            }
            GoodsCell1 *cell =[GoodsCell1 cellWithTableView:tableView];
            cell.goodsModel =self.goodsModel;
            cell.selectShopBtnBlock = ^{
                 self.goodsModel =self.MsgListArr[indexPath.section];
                DRShopHomeVC *detailVC = [DRShopHomeVC new];
                if ([[DRUserInfoModel sharedManager].zyStoreId isEqualToString:self.goodsModel.sellerId]) {
                    detailVC.ycStr =@"1";
                }
                detailVC.sellerId=self.goodsModel.sellerId;
                [self.navigationController pushViewController:detailVC animated:YES];
            };
            return cell;
        }
        else if (indexPath.row==1)
        {
            SecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondCell"];
                    
            [cell.moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.goodsModel =self.goodsModel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else if (indexPath.row==2)
        {
        
            
            if ([User currentUser].isLogin) {
                if (self.goodsModel.qty!=0)
                {
                    CatgoryDetailCell1 *cell =[CatgoryDetailCell1 cellWithTableView:tableView withIndexPath:indexPath];
                    cell.goodsModel =self.goodsModel;
                    cell.danweiBtn.tag =indexPath.section;
                    cell.moreBtn.tag =indexPath.section;
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

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSString*  state=[self.isOpenArr objectAtIndex:section];
    if ([state isEqualToString:@"open"]) {
        self.goodsModel =self.MsgListArr[section];
        DRFooterCell *cell =[DRFooterCell cellWithTableView:tableView];
        NSString *timestr;
        if ([self.goodsModel.deliveryDay integerValue]>=1) {
            timestr =[NSString stringWithFormat:@"预计发货时间：%@天",self.goodsModel.deliveryDay];
        }else{
            timestr =@"预计发货时间：当天发货";
        }
        NSArray *titleArr =@[[NSString stringWithFormat:@"最小销售单位：%@",self.goodsModel.saleUnitName],[NSString stringWithFormat:@"单规格起订量：%.3f%@",self.goodsModel.minQuantity,self.goodsModel.saleUnitName],timestr];        
        cell.danweiLab.text = titleArr[0];
        cell.qidingliangLab.text = titleArr[1];
        cell.timeLAb.text = titleArr[2];
        if (self.goodsModel.drawing.length==0) {
            cell.lookIMGbTN.hidden =YES;
        }
        else
        {
            cell.lookIMGbTN.hidden =NO;
        }
        cell.lookIMGBtnBlock = ^{
            ZWPhotoPreviewDataModel *model1 = [[ZWPhotoPreviewDataModel alloc] init];
            model1.zw_photoURL = self.goodsModel.drawing;
            model1.zw_photoTitle =nil;
            model1.zw_photoDesc = nil;
            ZWPhotoPreview *view = [ZWPhotoPreview zw_showPhotoPreview:@[model1]];
            view.showIndex = 0;
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
    [self getStrWith:tagArray];
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
//    self.navigationItem.title = [NSString stringWithFormat:@"筛选结果: %@",string];
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

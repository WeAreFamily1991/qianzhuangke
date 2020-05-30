//
//  DRAirCloudShopVC.m
//  Shop
//
//  Created by rockding on 2019/12/25.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRAirCloudShopVC.h"
#import "GBTopScrollMenuView.h"
#import "DRCatoryShopVC.h"
#import "CXSearchViewController.h"
#import "DRShopCatoryVC.h"
@interface DRAirCloudShopVC ()<WJScrollerMenuDelegate>
@property (nonatomic,retain)NSMutableArray *leftIdArr;
@property (nonatomic,assign)NSInteger selectIndex;
@property (nonatomic,retain)DRCatoryShopVC *shopVC;
@end

@implementation DRAirCloudShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectIndex=0;
    self.title =@"云仓";
    self.view.backgroundColor =BACKGROUNDCOLOR;
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, DRTopHeight)];
    backView.backgroundColor =REDCOLOR;
    [self.view addSubview:backView];
    UIButton *leftBtn =[UIButton buttonWithImage:@"yuncang_ico_back" target:self action:@selector(leftBtnClick) showView:self.view];
    leftBtn.frame =CGRectMake(WScale(12), DRStatusBarHeight+WScale(12), WScale(12), WScale(20));
    
    UILabel *titleLab =[UILabel labelWithText:self.nameStr font:DR_FONT(18) textColor:WHITECOLOR backGroundColor:CLEARCOLOR textAlignment:1 superView:self.view];
    titleLab.frame =CGRectMake(SCREEN_WIDTH/4,DRStatusBarHeight, SCREEN_WIDTH/2, backView.dc_height-DRStatusBarHeight);
    
    UIButton *rightBtn =[UIButton buttonWithImage:@"yuncang_ico_search" target:self action:@selector(rightBtnClick) showView:self.view];
       rightBtn.frame =CGRectMake(SCREEN_WIDTH-WScale(32),DRStatusBarHeight +WScale(12.5), WScale(20), WScale(20));
//    self.navigationController.navigationBar.barTintColor =REDCOLOR;
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
//    NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:18]}];
//    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"yuncang_ico_back"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBtnClick)];
//
//    self.navigationItem.rightBarButtonItem =[UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"yuncang_ico_search"] WithSelected:[UIImage imageNamed:@"yuncang_ico_search"] Target:self action:@selector(rightBarButtonClick)];
//    if ([self.isAirCloud integerValue]==0) {
        
        [self testScrollMenuView];
//    }
//    else{
//         [self addCoustomView];
//    }
   
//    [self addInsertBtnView];
    // Do any additional setup after loading the view from its nib.
}
-(void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightBtnClick
{
    CXSearchViewController *searchViewController = [[CXSearchViewController alloc] init];
    searchViewController.SearTextBlock = ^(NSString * _Nonnull textBlock) {
        DRShopCatoryVC *goodSetVc =[[DRShopCatoryVC alloc] init];
        goodSetVc.sellidStr =self.sellerId;
        goodSetVc.isAirCloudYes =self.isAirCloud;
        goodSetVc.keyWordStr =textBlock;
        NSLog(@"zyStoreId=%@",[DRUserInfoModel sharedManager].zyStoreId);
        goodSetVc.searchTypeStr =@"search";
        goodSetVc.queryTypeStr =@"cloud";
        [self.navigationController pushViewController:goodSetVc animated:YES];
    };
    [self.navigationController pushViewController:searchViewController animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden =YES;
    [self ConfigLightStatusColor];
//    [self ConfigBlackStatusColor];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
     [self ConfigBlackStatusColor];
    self.navigationController.navigationBar.hidden =NO;
    
}
-(void)addInsertBtnView
{
    HCDragingView *dragView =[[HCDragingView alloc]initWithFrame:CGRectMake(ScreenW - WScale(50), ScreenH - WScale(120)-DRTopHeight , WScale(40), WScale(81)) containerView:self.view];
    dragView.dragImage =@"yuncang_label_jidiyuncang";
    dragView.didEventBlock = ^{
    };
    [dragView show];
}
-(void)leftBarButtonClick
{
}
-(void)rightBarButtonClick
{
    
}
- (void)testScrollMenuView{
   
    NSDictionary *dic =@{@"type":[self.isAirCloud boolValue]?@"local":@"base",@"districtId":[DEFAULTS objectForKey:@"code"]?:@"1243",@"cz":@"",@"cloudStoreId":[self.isAirCloud boolValue]?self.sellerId:@""};
    [SNAPI getWithURL:@"cloudStore/getCloudStore" parameters:dic.mutableCopy success:^(SNResult *result){
        NSArray *dataArr =result.data;
        NSMutableArray *titleArr =[NSMutableArray array];
        self.leftIdArr =[NSMutableArray array];
        BOOL isMoreArr=NO;
        if (dataArr.count>3) {
            isMoreArr =YES;
        }else
        {
            isMoreArr =NO;
        }
        GBTopScrollMenuView *topScrollView = [[GBTopScrollMenuView alloc] initWithFrame:CGRectMake(0, DRTopHeight, ScreenW, WScale(40)) showPopViewWithMoreButton:isMoreArr];
        topScrollView.userInteractionEnabled =YES;
          topScrollView.backgroundColor=[UIColor whiteColor];
        for (NSDictionary *dic in dataArr) {
            [titleArr addObject:dic[@"name"]];
            [self.leftIdArr addObject:dic[@"id"]];
        }
        [titleArr insertObject:@"全部" atIndex:0];
        [self.leftIdArr insertObject:@"" atIndex:0];
        topScrollView.myTitleArray=titleArr.mutableCopy;
          topScrollView.selectedColor=REDCOLOR;
          topScrollView.currentIndex=self.selectIndex;
          topScrollView.delegate =self;
          topScrollView.noSlectedColor=BLACKCOLOR;
          [self.view addSubview:topScrollView];
         [self addCoustomView];
    } failure:^(NSError *error) {
        
    }];
}
- (void)itemDidSelectedWithIndex:(NSInteger)index
{
    NSLog(@"index =%ld",(long)index);
    _selectIndex =index;
    NSDictionary *dic=@{@"sellerID":self.leftIdArr[self.selectIndex]};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"aircloudVC" object:nil userInfo:dic];
}

-(void)addCoustomView
{
    self.shopVC =[[DRCatoryShopVC alloc]init];
    self.shopVC .isAirCloudYes =self.isAirCloud;
    if ([self.isAirCloud integerValue]==1) {
        self.shopVC.sellerId =@"";
    }
    else
    {
        self.shopVC.sellerId =self.leftIdArr[self.selectIndex];
    }
    self.shopVC.view.frame=CGRectMake(0, DRTopHeight+WScale(50), SCREEN_WIDTH, SCREEN_HEIGHT-WScale(50)-DRTopHeight);
    [self addChildViewController:self.shopVC ];
    [self.view addSubview:self.shopVC.view];
    
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

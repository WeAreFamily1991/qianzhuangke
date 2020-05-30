//
//  CategoryViewController.m
//  jdmobile
//
//  Created by SYETC02 on 15/6/12.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "CategoryViewController.h"
#import "SearchBarView.h"
#import "CategoryMeunModel.h"
#import "MultilevelMenu.h"
#import "AppDelegate.h"
#import "REFrostedViewController.h"
#import "RightMenuTableViewController.h"
#import "MLSearchViewController.h"
#import "CategoryDetailVC.h"
#import "SYMoreButtonView.h"
#import "SendSourceModel.h"
#define Start_X 10.0f           // 第一个按钮的X坐标
#define Start_Y 84.0f           // 第一个按钮的Y坐标
#define Width_Space 5.0f        // 2个按钮之间的横间距
#define Height_Space 20.0f      // 竖间距
#define Button_Height 49.0f    // 高
#define Button_Width 60.0f      // 宽
//#import "JDNavigationController.h"
@interface CategoryViewController ()<SearchBarViewDelegate,SYMoreButtonDelegate>
{
    NSMutableArray * _list;
}
@property(nonatomic,strong)UIButton *fBtn;
@property (nonatomic,strong)SYMoreButtonView *bottomBtnView;
@property (nonatomic,strong)NSMutableArray *sendArr ,*nameArr;
@property (nonatomic,strong)SendSourceModel *souceModel;
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@end
@implementation CategoryViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BACKGROUNDCOLOR;
    //设置导航栏
    [self setupNavigationItem];
    //初始化数据
    [self initData];
    //初始化分类菜单
    [self initCategoryMenu];
}

- (void)viewWillAppear:(BOOL)animated;
{
     (( AppDelegate *) [UIApplication sharedApplication].delegate).avatar.hidden=YES;
}
- (void)setupNavigationItem {
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"ico_camera_7_gray" highBackgroudImageName:nil target:self action:@selector(cameraClick)];
    //将搜索条放在一个UIView上
    SearchBarView *searchView = [[SearchBarView alloc]initWithFrame:CGRectMake(0, 7, SCREEN_WIDTH-20, 30)];
    searchView.delegate=self;
     self.navigationItem.titleView = searchView;
}

- (void)cameraClick{
    
}
#pragma mark - 🔌 SearchBarViewDelegate Method
- (void)searchBarSearchButtonClicked:(SearchBarView *)searchBarView {
    DLog(@"11111");
    
    MLSearchViewController *vc = [[MLSearchViewController alloc] init];
    vc.tagsArray = @[@"卜卜芥", @"卜人参", @"卜卜人发", @"儿茶", @"八角", @"三卜七", @"广白", @"大黄", @"大黄", @"广卜卜卜丹"];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController pushViewController:vc animated:YES];
//    // 1.创建热门搜索
//    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
//    // 2. 创建控制器
//    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"输入关键词" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
//        // 开始搜索执行以下代码
//        // 如：跳转到指定控制器
////        [searchViewController.navigationController pushViewController:[[PYTempViewController alloc] init] animated:YES];
//    }];
//    // 3. 设置风格
//    // 选择历史搜索
//        searchViewController.hotSearchStyle = PYHotSearchStyleDefault; // 热门搜索风格为默认
//        searchViewController.searchHistoryStyle = 1; // 历史搜索风格根据选择
//
//    // 4. 设置代理
//    searchViewController.delegate = self;
//
//    searchViewController.searchViewControllerShowMode = PYSearchViewControllerShowModePush;
//    [self.navigationController pushViewController:searchViewController animated:YES];

}
- (void)searchBarAudioButtonClicked:(SearchBarView *)searchBarView {
    DLog(@"11111");
}
- (void)initData{

   
    
     _list=[NSMutableArray arrayWithCapacity:0];
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Category" ofType:@"plist"];
    NSArray *array=[NSArray arrayWithContentsOfFile:path];
    /**
     *  构建需要数据 2层或者3层数据 (ps 2层也当作3层来处理)
     */
   
    for (int i=0; i<[array count]; i++) {
      
        CategoryMeunModel * meun=[[CategoryMeunModel alloc] init];
        meun.menuName=[array objectAtIndex:i][@"menuName"];
        meun.nextArray=[array objectAtIndex:i][@"topMenu"];
        NSMutableArray * sub=[NSMutableArray arrayWithCapacity:0];
        
        for ( int j=0; j <[meun.nextArray count]; j++) {
            
            CategoryMeunModel * meun1=[[CategoryMeunModel alloc] init];
            meun1.menuName=[meun.nextArray objectAtIndex:j][@"topName"];
            meun1.nextArray=[meun.nextArray objectAtIndex:j][@"typeMenu"];
        
        
            
            NSMutableArray *zList=[NSMutableArray arrayWithCapacity:0];
            for ( int k=0; k <[meun1.nextArray count]; k++) {
                CategoryMeunModel * meun2=[[CategoryMeunModel alloc] init];
                meun2.menuName=[meun1.nextArray objectAtIndex:k][@"typeName"];
                meun2.urlName=[meun1.nextArray objectAtIndex:k][@"typeImg"];
                [zList addObject:meun2];
            }
            
            
            meun1.nextArray=zList;
            [sub addObject:meun1];
        }
        
        
        meun.nextArray=sub;
        [_list addObject:meun];
    }
}
-(void)addSelectedBtn:(UIView *)backView
{
    DRWeakSelf;
    [SNAPI getWithURL:@"mainPage/getCzList" parameters:nil success:^(SNResult *result) {
        NSDictionary *dic =@{@"id":@"",@"name":@"全部"};
        weakSelf.nameArr=[NSMutableArray arrayWithObject:@"全部"];
        for (NSDictionary *dic in result.data) {
            [weakSelf.nameArr addObject:dic[@"name"]];
        }
        weakSelf.sendArr=[[NSMutableArray alloc]initWithObjects:dic, nil];
        
        NSArray *sourceArr =[SendSourceModel mj_objectArrayWithKeyValuesArray:result.data];
        [weakSelf.sendArr addObjectsFromArray:sourceArr];
        weakSelf.bottomBtnView = [[SYMoreButtonView alloc] initWithFrame:CGRectMake(0.0, 0, ScreenW, backView.dc_height)];
        [backView addSubview:weakSelf.bottomBtnView];
        
        weakSelf.bottomBtnView.backgroundColor = [UIColor clearColor];
        weakSelf.bottomBtnView.titles = weakSelf.nameArr;
       
        weakSelf.bottomBtnView.showline = NO;
        weakSelf.bottomBtnView.showlineAnimation = NO;
        weakSelf.bottomBtnView.font = 14;
        weakSelf.bottomBtnView.indexSelected = 0;
        weakSelf.bottomBtnView.colorSelected = REDCOLOR;
        weakSelf.bottomBtnView.delegate = self;
        weakSelf.bottomBtnView.buttonClick = ^(NSInteger index) {
            NSLog(@"block click index = %@", @(index));
            [weakSelf.sendDataDictionary setObject:weakSelf.sendArr[index] forKey:@"id"];
        };
         [weakSelf.bottomBtnView reloadData];
        UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        lineView.backgroundColor =[UIColor lightGrayColor];
        [backView addSubview: lineView];
       
        
    } failure:^(NSError *error) {
        
        
    }];
 
}
-(NSMutableDictionary *)sendDataDictionary
{
    if (!_sendDataDictionary) {
        _sendDataDictionary =[NSMutableDictionary dictionary];
    }
    return _sendDataDictionary;
}
- (void)sy_buttonClick:(NSInteger)index
{
    
}

#pragma mark -- 按钮点击事件
-(void)btnClickMethod:(UIButton *)sender{
    
    NSLog(@"点击时间按钮:%ld",(long)[sender tag]);
    
    //点击的和上次是一样的
    if(_fBtn == sender) {
        
        //        //不做处理
        
        
    } else{
        
//        sender.backgroundColor = REDCOLOR;
        [sender setTitleColor:REDCOLOR forState:UIControlStateNormal];
        
//        _fBtn.backgroundColor = BLACKCOLOR;
        [_fBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    }
    
    _fBtn = sender;    
}
- (void)initCategoryMenu{
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, DRTopHeight, self.view.width,50)];
    backView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:backView];
    [self addSelectedBtn:backView];
    
    MultilevelMenu * view=[[MultilevelMenu alloc] initWithFrame:CGRectMake(0, DRTopHeight+50, self.view.width, self.view.height-DRTopHeight-50) WithData:_list withSelectIndex:^(NSInteger left, NSInteger right,CategoryMeunModel * info) {
        NSLog(@"点击的 菜单%@",info.menuName);
        [self.navigationController pushViewController:[CategoryDetailVC new] animated:YES];
//         JDNavigationController *navigationController = [[JDNavigationController alloc] initWithRootViewController:[[CommodityTableViewController alloc] init]];
//        
//        JDNavigationController *menuController = [[JDNavigationController alloc]  initWithRootViewController:[[RightMenuTableViewController alloc] init]];
//        REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
//        frostedViewController.direction = REFrostedViewControllerDirectionRight;
//        frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
//           [frostedViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
//        [self presentViewController:frostedViewController animated:YES completion:nil];
        
         //[self.navigationController pushViewController:frostedViewController animated:YES];
    }];
    
   view.needToScorllerIndex=0; //默认是 选中第一行
    view.leftSelectColor=REDCOLOR;//选中文字颜色
    view.leftSelectBgColor=[UIColor whiteColor];//选中背景颜色
    view.isRecordLastScroll=NO;//是否记住当前位置
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

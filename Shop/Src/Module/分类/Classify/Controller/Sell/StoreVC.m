
//
//  StoreVC.m
//  Shop
//
//  Created by BWJ on 2019/3/9.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "StoreVC.h"
#import "ShopHeaderView.h"
#import "StoreHomeDetailVC.h"
#import "ShopEvaluateVC.h"
#import "TakeawayShopView.h"
@interface StoreVC ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate,UIGestureRecognizerDelegate>
{
     __block BOOL     isVertical;//是否是垂直
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)ShopHeaderView *customheadView;
@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property (nonatomic,strong)UIView *backView;
@end

@implementation StoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubView];
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognizerAction:)];
//    pan.delegate = self;
//    [self.view addGestureRecognizer:pan];
//    [self settableViewHeaderView];
//
//    if (@available(iOS 11.0, *)) {
//
//        _tableView.estimatedRowHeight = 0;
//
//        _tableView.estimatedSectionHeaderHeight = 0;
//
//        _tableView.estimatedSectionFooterHeight = 0;
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }
//    self.tableView.separatorInset = UIEdgeInsetsMake(0, -10, 0, 0);
  
    // Do any additional setup after loading the view from its nib.
}
- (void)initSubView
{
    //在请求中携带店铺ID
    TakeawayShopView *shopView = [[TakeawayShopView alloc]initWithFrame:self.view.bounds withGroupID:_GroupID];
    [self.view addSubview:shopView];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
-(void)settableViewHeaderView
{
    self.backView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    self.customheadView = [[[NSBundle mainBundle] loadNibNamed:@"ShopHeaderView" owner:self options:nil] lastObject];
    self.customheadView.dc_height =HScale(200);
    [self.backView addSubview:self.customheadView];
    [self addsegentView];
    self.tableView.tableHeaderView =self.backView;
    
}
-(void)addsegentView
{//全部", @"已取消", @"待审核", @"待付款", @"待发货", @"待收货",@"已完成",@"退货中",@"已退货"
//    self.backView =[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 4)
    self.automaticallyAdjustsScrollViewInsets = NO;//,@"周三",@"周四",@"周五",@"周六",@"周日",
    NSMutableArray *titleArray = [[NSMutableArray alloc] initWithObjects:@"商品分类", @"店铺评价(10)" ,nil];
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0,self.customheadView.height,SCREEN_WIDTH,40) titles:titleArray delegate:self indicatorType:2];
   
    [self.backView addSubview:_titleView];
    
    ///线
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.customheadView.height+40-1,SCREEN_WIDTH,0.8)];
    lineLabel.backgroundColor = BACKGROUNDCOLOR;
    [self.titleView addSubview:lineLabel];
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    for (int i = 0; i<titleArray.count; i++)
    {
        if (i==1) {
            ShopEvaluateVC *VC = [[ShopEvaluateVC alloc] init];
            VC.status = i;
            [childVCs addObject:VC];
        }else
        {
            StoreHomeDetailVC *VC = [[StoreHomeDetailVC alloc] init];
            VC.status = i;
            [childVCs addObject:VC];
        }
    }
    self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0,self.customheadView.height+40, SCREEN_WIDTH,SCREEN_HEIGHT-DRTopHeight-40) childVCs:childVCs parentVC:self delegate:self];
    self.pageContentView.backgroundColor = [UIColor clearColor];
    [self.backView addSubview:_pageContentView];
    self.titleView.selectIndex = _num;
    self.pageContentView.contentViewCurrentIndex = _num;
}
//********************************  分段选择  **************************************
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.pageContentView.contentViewCurrentIndex = endIndex;
}
- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.titleView.selectIndex = endIndex;
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}
#pragma mark 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
            return 30;
            break;
        case 1:
            return 30;
            break;
        case 2:
            return UITableViewAutomaticDimension;
            break;
            
        case 3:
            return 40;
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
    return 0.01;
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    CGFloat sectionHeaderHeight = 60;
//    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y> 0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    }else
//        if(scrollView.contentOffset.y >= sectionHeaderHeight){
//
//            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//        }
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier: SimpleTableIdentifier];
    }
//    cell.textLabel.text = [_titleStr stringByAppendingString:[NSString stringWithFormat:@"-%d",(int)indexPath.row]];
    return cell;
    
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

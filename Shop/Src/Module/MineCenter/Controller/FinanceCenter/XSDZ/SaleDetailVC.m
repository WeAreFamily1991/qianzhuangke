//
//  BillingInformationVC.m
//  Shop
//
//  Created by BWJ on 2019/2/27.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "SaleDetailVC.h"
#import "SaleDetailChildVC.h"
@interface SaleDetailVC ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;

@end

@implementation SaleDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.fatherStatus==1) {
        self.title =@"费用对账详情";
    }
    else
    {
        self.title =@"订单对账详情";
    }
    [self addsegentView];
}
-(void)addsegentView
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;//,@"周三",@"周四",@"周五",@"周六",@"周日",
    NSMutableArray *titleArray =[NSMutableArray array];
    titleArray = [[NSMutableArray alloc] initWithObjects:@"所有订单", @"在线支付",@"额度支付",nil];
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,WScale(40)) titles:titleArray delegate:self indicatorType:2];

    [self.view addSubview:_titleView];
    
    ///线
    UILabel *linetLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,1,SCREEN_WIDTH,1)];
    linetLabel.backgroundColor = BACKGROUNDCOLOR;
    [self.titleView addSubview:linetLabel];
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, WScale(40)-1,SCREEN_WIDTH,0.8)];
    lineLabel.backgroundColor = BACKGROUNDCOLOR;
    [self.titleView addSubview:lineLabel];
    
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<titleArray.count; i++)
    {
        SaleDetailChildVC *VC = [[SaleDetailChildVC alloc] init];
        VC.fatherStatus =self.fatherStatus;
        VC.saleModel =self.saleModel;
        VC.status = i;
        [childVCs addObject:VC];
    }
    self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0,WScale(40), SCREEN_WIDTH,SCREEN_HEIGHT-WScale(40)-DRTopHeight) childVCs:childVCs parentVC:self delegate:self];
    self.pageContentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_pageContentView];
    
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
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

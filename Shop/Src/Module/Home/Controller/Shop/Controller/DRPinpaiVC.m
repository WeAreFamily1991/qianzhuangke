//
//  DRPinpaiVC.m
//  Shop
//
//  Created by BWJ on 2019/4/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRPinpaiVC.h"
#import "SegmentViewController.h"
#import "DRPinPaiDetailVC.h"
#import "RongYuVC.h"
#import "SYTypeButtonView.h"
#import "CGXPickerView.h"
static CGFloat const ButtonHeight = 40;
@interface DRPinpaiVC ()<UITextFieldDelegate,FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property (nonatomic,strong)SYTypeButtonView *buttonView;
@property (nonatomic,strong)DRPinPaiDetailVC *detailVC;
@property (nonatomic,strong)UITextField *orderTF;
@property (nonatomic,assign)NSInteger selectdex;

@end

@implementation DRPinpaiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"品牌资质";
    [self addsegentView];
    //    [self setUI];
    //
    // Do any additional setup after loading the view from its nib.
}



-(void)addsegentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;//,@"周三",@"周四",@"周五",@"周六",@"周日",
    NSMutableArray *titleArray = [[NSMutableArray alloc] initWithObjects:@"基本信息", @"荣誉资质",nil];
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,40) titles:titleArray delegate:self indicatorType:2];
    [self.view addSubview:_titleView];
    ///线
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40-1,SCREEN_WIDTH,0.8)];
    lineLabel.backgroundColor = BACKGROUNDCOLOR;
    [self.titleView addSubview:lineLabel];
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];    
    for (int i = 0; i<titleArray.count; i++)
    {
        if (i==0) {
            DRPinPaiDetailVC  *VC = [[DRPinPaiDetailVC alloc] init];
            VC.detailModel =_detailModel;
            VC.status = i;
            [childVCs addObject:VC];
        }else
        {
            RongYuVC  *VC = [[RongYuVC alloc] init];
            VC.detailModel =_detailModel;
            VC.status = i;
            [childVCs addObject:VC];
        }
        
    }
    self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0,40, SCREEN_WIDTH,SCREEN_HEIGHT-DRTopHeight-40) childVCs:childVCs parentVC:self delegate:self];
    self.pageContentView.backgroundColor = CLEARCOLOR;
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

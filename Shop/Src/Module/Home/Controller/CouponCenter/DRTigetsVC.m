//
//  DRTigetsVC.m
//  Shop
//
//  Created by BWJ on 2019/4/28.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRTigetsVC.h"
#import "SegmentViewController.h"
#import "DRTigetDetailVC.h"
#import "SYTypeButtonView.h"
#import <SDCycleScrollView.h>
#import "NewsModel.h"
#import "VoucherVC.h"
@interface DRTigetsVC ()<UITextFieldDelegate,FSPageContentViewDelegate,FSSegmentTitleViewDelegate,SDCycleScrollViewDelegate>
/* 轮播图 */
@property (strong , nonatomic)SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property (nonatomic,strong)SYTypeButtonView *buttonView;
@property (nonatomic,strong)DRTigetDetailVC *detailVC;
@property (nonatomic,strong)UITextField *orderTF;
@property (nonatomic,assign)NSInteger selectdex;
@property (nonatomic,retain) UILabel *titlLab;
@property (nonatomic,retain) UIButton *myBtn;
@property (nonatomic,retain)NSMutableArray *bannerArr;
@end

@implementation DRTigetsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BACKGROUNDCOLOR;
    self.title =@"领券中心";
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, WScale(140))];
//    backView.backgroundColor =REDCOLOR;
    [self.view addSubview:backView];
    UIImageView *backIMG =[[UIImageView alloc]initWithFrame:backView.bounds];
    backIMG.image =[UIImage imageNamed:@"personal_bg_image"];
    backIMG.contentMode =UIViewContentModeScaleToFill;
    backIMG.userInteractionEnabled =YES;
    [backView addSubview:backIMG];
    
    UIImageView *fontIMG =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"购物先领券·优惠享不断"]];
    fontIMG.contentMode =UIViewContentModeScaleToFill;
    fontIMG.frame =CGRectMake(WScale(15), WScale(25), WScale(255), WScale(25));
    [backView addSubview:fontIMG];
    UIView *myView =[[UIView alloc]initWithFrame:CGRectMake(DCMargin,WScale(74), ScreenW-2*DCMargin, WScale(50))];
    myView.backgroundColor =WHITECOLOR;
    myView.layer.masksToBounds =4;
    myView.layer.cornerRadius =4;
    myView.backgroundColor =WHITECOLOR;
    [backView addSubview:myView];
    _myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _myBtn.frame =CGRectMake(0, 0, WScale(100), myView.dc_height);
    _myBtn.backgroundColor =[UIColor whiteColor];
    _myBtn.titleLabel.font = DR_FONT(14);
    [_myBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
//    [_myBtn setImage:[UIImage imageNamed:@"news_ico"] forState:UIControlStateNormal];
    [_myBtn setTitle:@"我的抵用券" forState:UIControlStateNormal];
    [_myBtn addTarget:self action:@selector(myBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [myView addSubview:_myBtn];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame =CGRectMake(ScreenW-myView.dc_height-3*DCMargin, 0, myView.dc_height, myView.dc_height);
    
    [rightBtn setImage:[UIImage imageNamed:@"ico／more"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"查看" forState:UIControlStateNormal];
    rightBtn.titleLabel.font =DR_FONT(12);
    [rightBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(myBtnClick) forControlEvents:UIControlEventTouchUpInside];
   [rightBtn layoutButtonWithEdgeInsetsStyle:LXButtonEdgeInsetsStyleRight imageTitleSpace:10];
    [myView addSubview:rightBtn];
    [self addsegentViewWithView:backView];
    [self addScrollViewSource];
  
    // Do any additional setup after loading the view from its nib.
}
-(void)addScrollViewSource
{
 
    DRWeakSelf;
    NSDictionary *dic =@{@"advType":@"lqzx",@"pageNum":@"1",@"pageSize":@"10"};
    [SNAPI getWithURL:@"mainPage/getAdvList" parameters:[dic mutableCopy] success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            self.bannerArr=[NSMutableArray array];
            //             NSArray *sourceArr =result.data;
            NSArray *sourceArr =[NewsModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
            for (NewsModel *model in sourceArr) {
                [self.bannerArr addObject:model.img];
            }
            if (self.bannerArr.count!=0) {
                weakSelf.cycleScrollView.imageURLStringsGroup =self.bannerArr.copy;               
            }
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)addsegentViewWithView:(UIView *)myView
{
    self.automaticallyAdjustsScrollViewInsets = NO;//,@"周三",@"周四",@"周五",@"周六",@"周日",
    NSMutableArray *titleArray = [[NSMutableArray alloc] initWithObjects:@"全部精选", @"平台抵用券", @"店铺抵用券",nil];
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0,myView.dc_bottom,SCREEN_WIDTH,WScale(40)) titles:titleArray delegate:self indicatorType:2];

    
    [self.view addSubview:_titleView];    
    ///线
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.titleView.dc_bottom-1,SCREEN_WIDTH,0.8)];
    lineLabel.backgroundColor = BACKGROUNDCOLOR;
    [self.titleView addSubview:lineLabel];
    
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<titleArray.count; i++)
    {
        DRTigetDetailVC  *VC = [[DRTigetDetailVC alloc] init];
        VC.status = i;
        [childVCs addObject:VC];
    }
    self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0,self.titleView.dc_bottom, SCREEN_WIDTH,SCREEN_HEIGHT-DRTopHeight-40) childVCs:childVCs parentVC:self delegate:self];
    self.pageContentView.backgroundColor = BACKGROUNDCOLOR;
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
-(void)myBtnClick
{
  [self.navigationController pushViewController:[VoucherVC new] animated:YES];
}
#pragma mark - 点击广告跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd广告图",index);
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

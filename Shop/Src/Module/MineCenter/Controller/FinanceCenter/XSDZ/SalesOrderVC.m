//
//  ChangeOrderVC.m
//  Shop
//
//  Created by BWJ on 2019/2/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "SalesOrderVC.h"
#import "SegmentViewController.h"
#import "SalesOrderDetailVC.h"
#import "SYTypeButtonView.h"
#import "CHDatePickerMenu.h"
static CGFloat const ButtonHeight = 38;
@interface SalesOrderVC ()<UITextFieldDelegate,FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property (nonatomic,strong)SalesOrderDetailVC *detailVC;
@property (nonatomic,strong)SYTypeButtonView *buttonView;
@property (nonatomic,strong)UITextField *orderTF;
@property (nonatomic,strong)SalesOrderDetailVC  *VC;
@property (nonatomic,strong)NSMutableArray *childVCs;
@property (nonatomic,strong)NSMutableDictionary *muDic;
@property (nonatomic,strong)UILabel *titLab;
@end

@implementation SalesOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"销售对账";
    
    [self addsegentView];
    [self setUI];
    //
    // Do any additional setup after loading the view from its nib.
}
-(void)setUI
{
    DRWeakSelf;
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, WScale(40), SCREEN_WIDTH, WScale(10))];
    lineView.backgroundColor =BACKGROUNDCOLOR;
    [self.view addSubview:lineView];
    
    UILabel *titleLab =[UILabel labelWithText:@"对账时间" font:DR_FONT(14) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:0 superView:self.view];
    titleLab.frame =CGRectMake(WScale(20), WScale(50), WScale(60), WScale(45));
    
//    self.buttonView = [[SYTypeButtonView alloc] initWithFrame:CGRectMake(titleLab.dc_right+WScale(20), WScale(50), SCREEN_WIDTH-WScale(80), WScale(40)) view:self.view];
//    self.buttonView.backgroundColor = [UIColor whiteColor];
//
//    self.buttonView.buttonClick = ^(NSInteger index, BOOL isDescending){
//        NSLog(@"click index %ld, isDescending %d", index, isDescending);
//
//                [weakSelf selectDatePickViewWithIndex:0];
//    };
//    self.buttonView.titleColorNormal = RGBHex(0XC0C0C0);
//    self.buttonView.titleColorSelected = RGBHex(0XC0C0C0);
//    self.buttonView.titles = @[@"请选择对账时间"];
//    self.buttonView.enableTitles =  @[@"请选择对账时间"];
//    NSDictionary *dict01 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"ico／more"], keyImageNormal, [UIImage imageNamed:@"ico／more"], keyImageSelected, nil];
//
//    self.buttonView.imageTypeArray = @[dict01];
//    self.buttonView.selectedIndex = -1;
    
    UIButton *timeBtn=[UIButton buttonWithImage:nil target:self action:@selector(timeBtnClick) showView:self.view];
    timeBtn.frame =CGRectMake(WScale(70), WScale(50), ScreenW-WScale(70), WScale(45));

    self.titLab =[UILabel labelWithText:@"请选择对账时间" font:DR_FONT(14) textColor:RGBHex(0XC0C0C0) backGroundColor:CLEARCOLOR textAlignment:0 superView:self.view];
    self.titLab.frame =CGRectMake(WScale(90), WScale(50), SCREEN_WIDTH-WScale(110), WScale(45));
    
    UIButton *rightBtn =[UIButton buttonWithImage:@"ico／more" target:self action:@selector(timeBtnClick) showView:self.view];
    rightBtn.frame =CGRectMake(SCREEN_WIDTH-WScale(20), WScale(62.5), WScale(10), WScale(20));
    UIView *linebView =[[UIView alloc]initWithFrame:CGRectMake(0, WScale(95), SCREEN_WIDTH, WScale(1))];
    linebView.backgroundColor =BACKGROUNDCOLOR;
    [self.view addSubview:linebView];
    
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(WScale(10), WScale(105), WScale(270), WScale(30))];
    backView.backgroundColor =BACKGROUNDCOLOR;
    [self.view addSubview:backView];
    [DCSpeedy dc_chageControlCircularWith:backView AndSetCornerRadius:4 SetBorderWidth:0 SetBorderColor:0 canMasksToBounds:YES];
    
    UIImageView *backIMG =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_ico_search"]];
    backIMG.frame =CGRectMake(WScale(15),WScale(5), WScale(20),WScale(20));
    backIMG.userInteractionEnabled =YES;
    [backView addSubview:backIMG];
    self.orderTF =[[UITextField alloc]initWithFrame:CGRectMake(WScale(45), 0,backView.dc_width-WScale(45), WScale(30))];
    self.orderTF.placeholder =@"请输入对账单查询";
    self.orderTF.delegate =self;
    self.orderTF.font =DR_FONT(14);
    [backView addSubview:self.orderTF];
    UIButton *searchBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.layer.cornerRadius =4;
    searchBtn.layer.masksToBounds =4;
    searchBtn.backgroundColor =REDCOLOR;
    searchBtn.titleLabel.font =DR_FONT(14);
    [searchBtn setTitle:@"查询" forState:UIControlStateNormal];
    searchBtn.frame =CGRectMake(backView.dc_width+WScale(25),WScale(105),WScale(70), WScale(30));
    [searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
}
-(void)timeBtnClick
{
    DRWeakSelf;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM";
    __auto_type datePicker = [CHDatePickerMenu menuWithMode:CHDatePickerModeDateYM onSelectDate:^(NSDate * _Nonnull date) {
        //        self.selectedDateLabel.text = [formatter stringFromDate:date];
        weakSelf.titLab.text =[formatter stringFromDate:date];
        weakSelf.titLab.textColor =BLACKCOLOR;
        self.muDic =[NSMutableDictionary dictionary];
        [self.muDic setValue:[formatter stringFromDate:date] forKey:@"time"];
        [self.muDic setValue:@"1" forKey:@"index"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sale" object:nil userInfo:self.muDic];
        //        [self.VC setSourceWithDic:mudic withIndex:1];
        //        [weakSelf.VC.sourceDic setValue:[formatter stringFromDate:date] forKey:@"time"];
    }];
    datePicker.datePickerView.maximumDate = NSDate.date;
    
    [datePicker show];
}
-(void)searchBtnClick:(UIButton *)sender
{
    NSLog(@"textField==%@",self.orderTF.text);
    
//    [self.VC.sourceDic setValue:self.orderTF.text forKey:@"dzNo"];
   self.muDic =[NSMutableDictionary dictionary];
    [self.muDic setValue:self.orderTF.text forKey:@"dzNo"];
    [self.muDic setValue:@"2" forKey:@"index"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sale" object:nil userInfo:self.muDic];
//    [self.VC setSourceWithDic:mudic withIndex:2];
}
-(void)selectDatePickViewWithIndex:(NSInteger)selectIndex
{
   
}
-(void)addsegentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;//,@"周三",@"周四",@"周五",@"周六",@"周日",
    NSMutableArray *titleArray = [[NSMutableArray alloc] initWithObjects:@"订单对账", @"费用对账",nil];
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,WScale(40)) titles:titleArray delegate:self indicatorType:2];

    [self.view addSubview:_titleView];
    ///线
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, WScale(40)-1,SCREEN_WIDTH,1)];
    lineLabel.backgroundColor = BACKGROUNDCOLOR;
    [self.titleView addSubview:lineLabel];
    
    UILabel *linetLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,1,SCREEN_WIDTH,1)];
    linetLabel.backgroundColor = BACKGROUNDCOLOR;
    [self.titleView addSubview:linetLabel];
    self.childVCs = [[NSMutableArray alloc]init];
    for (int i = 0; i<titleArray.count; i++)
    {
        self.VC= [[SalesOrderDetailVC alloc] init];
        self.VC.status = i;
        [self.childVCs addObject:self.VC];
    }
    
    self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0,WScale(145), SCREEN_WIDTH,SCREEN_HEIGHT-WScale(145)-DRTopHeight) childVCs:self.childVCs parentVC:self delegate:self];
    self.pageContentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_pageContentView];
    self.titleView.selectIndex = _num;
    self.pageContentView.contentViewCurrentIndex = _num;
}
//********************************  分段选择  **************************************
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    SalesOrderDetailVC *detailVC= self.childVCs[endIndex];
    detailVC.sourceDic =self.muDic;
    detailVC.status =endIndex;
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
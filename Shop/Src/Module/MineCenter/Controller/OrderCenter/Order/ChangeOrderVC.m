//
//  ChangeOrderVC.m
//  Shop
//
//  Created by BWJ on 2019/2/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "ChangeOrderVC.h"
#import "SegmentViewController.h"
#import "DROrderDetailVC.h"
#import "SYTypeButtonView.h"
#import "CGXPickerView.h"

@interface ChangeOrderVC ()<UITextFieldDelegate,FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;

@property (nonatomic,strong)SYTypeButtonView *buttonView;
@property (nonatomic,strong)UITextField *orderTF;
@property (nonatomic,retain)NSMutableDictionary *mudic;
@property (nonatomic,strong)NSMutableArray *chileVCS;
@end

@implementation ChangeOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"交易订单";
    self.view.backgroundColor =[UIColor whiteColor];
    self.mudic=[NSMutableDictionary dictionary];
    self.chileVCS =[NSMutableArray array];
    [self addsegentView];
    [self setUI];
    //
    // Do any additional setup after loading the view from its nib.
}
-(void)setUI
{
    DRWeakSelf;
//    self.buttonView = [[SYTypeButtonView alloc] initWithFrame:CGRectMake(0.0, 40, CGRectGetWidth(self.view.bounds), 40) view:self.view];
//    self.buttonView.backgroundColor = [UIColor whiteColor];
//
//    self.buttonView.buttonClick = ^(NSInteger index, BOOL isDescending){
//        NSLog(@"click index %ld, isDescending %d", index, isDescending);
//        switch (index) {
//            case 0:
//            {
//                [weakSelf selectDatePickViewWithIndex:0];
//            }
//                break;
//            case 1:
//
//                [weakSelf selectDatePickViewWithIndex:1];
//                break;
//            case 2:
//            {
//                [CGXPickerView showStringPickerWithTitle:@"全部订单" DataSource:@[ @"全部订单",@"近一个月订单", @"近两个月订单", @"一年内订单"] DefaultSelValue:@"全部订单" IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
//                    NSLog(@"%@",selectValue);
//                    [weakSelf.buttonView setTitleButton:selectValue index:2];
//
//                    [self.mudic  setValue:[SNTool currenTime] forKey:@"endTime"];
//                    if ([selectRow intValue]!=0) {
//
//                        [self.buttonView setTitleButton:[SNTool currenTime] index:1];
//
//                        [self.buttonView setTypeButton:YES index:0];
//                        [self.buttonView setTypeButton:YES index:1];
//                    }
//                    NSLog(@"%@",selectValue);
//                    if ([selectRow intValue]==0) {
//                        [self.mudic  setValue:@"" forKey:@"startTime"];
//                        [self.mudic  setValue:@"" forKey:@"endTime"];
//                        [self.buttonView setTitleButton:@"起始时间" index:0];
//                        [self.buttonView setTitleButton:@"截止时间" index:1];
//                    }
//                    else if ([selectRow intValue]==1)
//                    {
//                        [self.mudic setValue:[SNTool ddpGetExpectTimestamp:0 month:-1 day:0]  forKey:@"startTime"];
//                        [self.buttonView setTitleButton:[SNTool ddpGetExpectTimestamp:0 month:-1 day:0] index:0];
//                    }
//                    else if ([selectRow intValue]==2)
//                    {
//                        [self.mudic setValue:[SNTool ddpGetExpectTimestamp:0 month:-2 day:0] forKey:@"startTime"];
//                        [self.buttonView setTitleButton:[SNTool ddpGetExpectTimestamp:0 month:-2 day:0] index:0];
//
//                    }
//                    else if ([selectRow intValue]==3)
//                    {
//                        [self.mudic setValue:[SNTool ddpGetExpectTimestamp:-1 month:0 day:0] forKey:@"startTime"];
//                        [self.buttonView setTitleButton:[SNTool ddpGetExpectTimestamp:-1 month:0 day:0] index:0];
//
//
//                    }
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeOrder" object:nil userInfo:self.mudic ];
//                }];
//
//            }
//                //                [buttonView setTitleButton:@"2019-02-27" index:2];
//                break;
//
//            default:
//                break;
//        }
//    };
//    self.buttonView.titleColorNormal = BLACKCOLOR;
//    self.buttonView.titleColorSelected = BLACKCOLOR;
//    self.buttonView.titles = @[@"起始时间", @"截止时间", @"全部订单"];
//    self.buttonView.enableTitles =  @[@"起始时间", @"截止时间", @"全部订单"];
//    NSDictionary *dict01 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"accessoryArrow_down"], keyImageNormal, [UIImage imageNamed:@"accessoryArrow_down"], keyImageSelected, nil];
//    NSDictionary *dict02 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"accessoryArrow_down"], keyImageNormal, [UIImage imageNamed:@"accessoryArrow_down"], keyImageSelected, nil];
//    NSDictionary *dict03 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"accessoryArrow_down"], keyImageNormal, [UIImage imageNamed:@"accessoryArrow_down"], keyImageSelected, nil];
//    self.buttonView.imageTypeArray = @[dict01, dict02, dict03];
//    self.buttonView.selectedIndex = -1;
    
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,WScale(45))];
    backView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:backView];
    
    UIView *linelView =[[UIView alloc]initWithFrame:CGRectMake(0, WScale(44), ScreenW, 1)];
    linelView.backgroundColor =LINECOLOR;
    [backView addSubview:linelView];
    UIImageView *backIMG =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_ico_search"]];
    backIMG.frame =CGRectMake(WScale(10), WScale(12.5), WScale(20), WScale(20));
    backIMG.userInteractionEnabled =YES;
    [backView addSubview:backIMG];
    self.orderTF =[[UITextField alloc]initWithFrame:CGRectMake(WScale(40), 0, SCREEN_WIDTH-WScale(100), WScale(45))];
    self.orderTF.placeholder =@"请输入订单编号进行查询";
    self.orderTF.font =DR_FONT(14);
    self.orderTF.borderStyle =UITextBorderStyleNone;
    self.orderTF.delegate =self;
    
    [self.view addSubview:self.orderTF];
    UIButton *searchBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//    searchBtn.backgroundColor =REDCOLOR;
    searchBtn.titleLabel.font =DR_FONT(14);
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:REDCOLOR forState:UIControlStateNormal];
    searchBtn.frame =CGRectMake(SCREEN_WIDTH-WScale(50),0, WScale(40), WScale(45));
    [searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:searchBtn];
}
-(void)searchBtnClick:(UIButton *)sender
{
    NSLog(@"textField==%@",self.orderTF.text);
    NSMutableDictionary *mudic =[NSMutableDictionary dictionary];
    [mudic setValue:self.orderTF.text forKey:@"dzNo"];
    [mudic setValue:@"3" forKey:@"index"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeOrder" object:nil userInfo:mudic];
}
-(void)selectDatePickViewWithIndex:(NSInteger)selectIndex
{
    DRWeakSelf;
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *nowStr = [fmt stringFromDate:now];

    [CGXPickerView showDatePickerWithTitle:selectIndex?@"截止时间":@"起始时间" DateType:UIDatePickerModeDate DefaultSelValue:nowStr MinDateStr:@"1900-01-01 00:00:00" MaxDateStr:nowStr IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
        if (selectIndex==0) {
            [self.mudic setValue:selectValue forKey:@"startTime"];
            
        }else
        {
            [self.mudic setValue:selectValue forKey:@"endTime"];
            
        }
        
        NSArray *allKeyArr =[self.mudic allKeys];
        if (allKeyArr.count==2) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeOrder" object:nil userInfo:self.mudic ];
        }
        NSLog(@"%@",selectValue);
        [weakSelf.buttonView setTitleButton:selectValue index:selectIndex];
    }];
}
-(void)addsegentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;//,@"周三",@"周四",@"周五",@"周六",@"周日",
    NSMutableArray *titleArray = [[NSMutableArray alloc] initWithObjects:@"全部", @"已取消", @"待审核", @"待付款", @"待发货", @"待收货",@"已完成",@"退货中",@"已退货" ,nil];
   self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0,WScale(45),SCREEN_WIDTH,WScale(40)) titles:titleArray delegate:self indicatorType:2];
    [self.view addSubview:_titleView];
    
    ///线
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, WScale(45)-1,SCREEN_WIDTH,0.8)];
    lineLabel.backgroundColor = BACKGROUNDCOLOR;
    [self.titleView addSubview:lineLabel];
    
    //    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<titleArray.count; i++)
    {
        DROrderDetailVC *VC = [[DROrderDetailVC alloc] init];
        VC.status = i;
        [self.chileVCS addObject:VC];
    }
    self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0,WScale(85), SCREEN_WIDTH,SCREEN_HEIGHT-DRTopHeight-WScale(85)) childVCs:self.chileVCS parentVC:self delegate:self];
    self.pageContentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_pageContentView];
    
    self.titleView.selectIndex = _num;
    self.pageContentView.contentViewCurrentIndex = _num;
//    [self addCustomBtn];
}
//-(void)addCustomBtn
//{
//    UIButton *button =[UIButton buttonWithImage:@"ico_dingdanxiangqing_more" target:self action:@selector(buttonClick) showView:self.view];
//    button.frame =CGRectMake(ScreenW-WScale(40), WScale(45), WScale(40), WScale(40));
////}
//-(void)buttonClick
//{
//    self.titleView.selectIndex =5;
//    self.pageContentView.contentViewCurrentIndex = 5;
//}
//********************************  分段选择  **************************************
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    DROrderDetailVC *VC = self.chileVCS[endIndex];
    VC.sendDataDictionary =self.mudic;
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

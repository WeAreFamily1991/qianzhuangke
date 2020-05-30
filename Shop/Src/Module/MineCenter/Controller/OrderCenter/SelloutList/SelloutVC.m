//
//  ChangeOrderVC.m
//  Shop
//
//  Created by BWJ on 2019/2/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "SelloutVC.h"
#import "SegmentViewController.h"
#import "SelloutDetailVC.h"
#import "SYTypeButtonView.h"
#import "CGXPickerView.h"
static CGFloat const ButtonHeight = 40;
@interface SelloutVC ()<UITextFieldDelegate,FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property (nonatomic,strong)SelloutDetailVC *detailVC;
@property (nonatomic,strong)SYTypeButtonView *buttonView;
@property (nonatomic,strong)UITextField *orderTF;
@property (nonatomic,retain)NSMutableDictionary *mudic;
@end

@implementation SelloutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"售后列表";
    self.mudic=[NSMutableDictionary dictionary];
    [self addsegentView];
    [self setUI];
    //
    // Do any additional setup after loading the view from its nib.
}
-(void)setUI
{
//    DRWeakSelf;
//    self.buttonView = [[SYTypeButtonView alloc] initWithFrame:CGRectMake(0.0, 40, CGRectGetWidth(self.view.bounds), heightTypeButtonView) view:self.view];
//    self.buttonView.backgroundColor = [UIColor whiteColor];
//
//    self.buttonView.buttonClick = ^(NSInteger index, BOOL isDescending){
//        NSLog(@"click index %ld, isDescending %d", index, isDescending);
//        switch (index) {
//            case 0:
//            {
//
//                [weakSelf selectDatePickViewWithIndex:0];
//
//            }
//                break;
//            case 1:
//
//                [weakSelf selectDatePickViewWithIndex:1];
//                break;
//            default:
//                break;
//        }
//    };
//    self.buttonView.titleColorNormal = BLACKCOLOR;
//    self.buttonView.titleColorSelected = REDCOLOR;
//    self.buttonView.titles = @[@"起始时间", @"截止时间"];
//    self.buttonView.enableTitles =  @[@"起始时间", @"截止时间"];
//    NSDictionary *dict01 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"accessoryArrow_down"], keyImageNormal, [UIImage imageNamed:@"accessoryArrow_down"], keyImageSelected, nil];
//    NSDictionary *dict02 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"accessoryArrow_down"], keyImageNormal, [UIImage imageNamed:@"accessoryArrow_down"], keyImageSelected, nil];
//
//    self.buttonView.imageTypeArray = @[dict01, dict02];
//    self.buttonView.selectedIndex = -1;
//
//    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 40)];
//    backView.backgroundColor =[UIColor whiteColor];
//    [self.view addSubview:backView];
//
//    UIImageView *backIMG =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_bg.png"]];
//    backIMG.frame =CGRectMake(15, 4, 3*SCREEN_WIDTH/5, 30);
//    backIMG.userInteractionEnabled =YES;
//    [backView addSubview:backIMG];
//    self.orderTF =[[UITextField alloc]initWithFrame:CGRectMake(10, 0, 3*SCREEN_WIDTH/5-20, 30)];
//    self.orderTF.placeholder =@"请输入订单编号";
//    self.orderTF.font =DR_FONT(14);
//    self.orderTF.delegate =self;
//    [backIMG addSubview:self.orderTF];
//    UIButton *searchBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//    searchBtn.layer.cornerRadius =15;
//    searchBtn.layer.masksToBounds =15;
//    searchBtn.backgroundColor =REDCOLOR;
//    searchBtn.titleLabel.font =DR_FONT(14);
//    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
//    searchBtn.frame =CGRectMake(3*SCREEN_WIDTH/5+30, 4, SCREEN_WIDTH-3*SCREEN_WIDTH/5-45, 30);
//    [searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [backView addSubview:searchBtn];
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
    searchBtn.layer.cornerRadius =15;
    searchBtn.layer.masksToBounds =15;
    //    searchBtn.backgroundColor =REDCOLOR;
    searchBtn.titleLabel.font =DR_FONT(14);
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:REDCOLOR forState:UIControlStateNormal];
    searchBtn.frame =CGRectMake(SCREEN_WIDTH-WScale(50),0, WScale(30), WScale(45));
    [searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:searchBtn];
}
-(void)searchBtnClick:(UIButton *)sender
{
    NSLog(@"textField==%@",self.orderTF.text);
    NSMutableDictionary *mudic =[NSMutableDictionary dictionary];
    [mudic setValue:self.orderTF.text forKey:@"dzNo"];
    [mudic setValue:@"3" forKey:@"index"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelloutVC" object:nil userInfo:mudic];
}
-(void)selectDatePickViewWithIndex:(NSInteger)selectIndex
{
    DRWeakSelf;
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *nowStr = [fmt stringFromDate:now];
    //    NSString *titleStr ;
    
    [CGXPickerView showDatePickerWithTitle:selectIndex?@"截止时间":@"起始时间" DateType:UIDatePickerModeDate DefaultSelValue:nil MinDateStr:@"1900-01-01 00:00:00" MaxDateStr:nowStr IsAutoSelect:YES Manager:nil ResultBlock:^(NSString *selectValue) {
        if (selectIndex==0) {
            [self.mudic setValue:selectValue forKey:@"startTime"];
            
        }else
        {
            [self.mudic setValue:selectValue forKey:@"endTime"];
            
        }
        
        NSArray *allKeyArr =[self.mudic allKeys];
        if (allKeyArr.count==2) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SelloutVC" object:nil userInfo:self.mudic ];
        }
        NSLog(@"%@",selectValue);
        [weakSelf.buttonView setTitleButton:selectValue index:selectIndex];
    }];
}
-(void)addsegentView
{
   
    self.automaticallyAdjustsScrollViewInsets = NO;//,@"周三",@"周四",@"周五",@"周六",@"周日",
    NSMutableArray *titleArray = [[NSMutableArray alloc] initWithObjects:@"全部", @"待审核", @"处理中" ,nil];
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0,WScale(46),SCREEN_WIDTH,WScale(40)) titles:titleArray delegate:self indicatorType:2];

    [self.view addSubview:_titleView];
    
    ///线
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, WScale(45)-1,SCREEN_WIDTH,0.8)];
      lineLabel.backgroundColor = BACKGROUNDCOLOR;
    [self.titleView addSubview:lineLabel];
    
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<titleArray.count; i++)
    {
        SelloutDetailVC *VC = [[SelloutDetailVC alloc] init];
        VC.status = i;
        [childVCs addObject:VC];
    }
    self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0,WScale(85), SCREEN_WIDTH,SCREEN_HEIGHT-DRTopHeight-WScale(85)) childVCs:childVCs parentVC:self delegate:self];
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

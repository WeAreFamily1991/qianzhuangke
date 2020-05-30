//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "DRShouKuanDetailVC.h"
#import "SaleOrderCell.h"
#import "DRShouKuanChildVC.h"

#import "SalesOrderModel.h"
#import "CHDatePickerMenu.h"
#import "SalesOrderVC.h"
@interface DRShouKuanDetailVC ()
{
    int pageCount;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic,assign)NSInteger selectIndex;
@property (nonatomic,strong)NSMutableArray *MsgListArr;
@property (nonatomic,strong)SalesOrderModel *saleModel;
@property (nonatomic,strong)NSArray *titleArr,*detailArr;
/* 暂无子账号提示 */
@property (strong , nonatomic)DCUpDownButton *bgTipButton;
@end

@implementation DRShouKuanDetailVC
- (instancetype)initWithIndex:(NSInteger)index title:(NSString *)title
{
    self = [super init];
    if (self) {
        _titleStr = title;
        NSLog(@"index=%ld",(long)index);
        _selectIndex =index;
        
    }
    return self;
}
-(NSMutableArray*)MsgListArr
{
    if (!_MsgListArr) {
        _MsgListArr =[NSMutableArray array];
    }
    return _MsgListArr;
}
-(void)selectWithIndex:(NSInteger)selectIndex
{
    NSLog(@"selectIndex=%ld",(long)selectIndex);
}
-(void)setSourceWithDic:(NSMutableDictionary *)dic withIndex:(NSInteger)index;
{
    if ([dic[@"index"] isEqualToString:@"1"]) {
        [_sendDataDictionary setObject:dic[@"time"]?:@"" forKey:@"startTime"];
        [_sendDataDictionary setObject:dic[@"time"]?:@"" forKey:@"endTime"];
    }
    else
    {
        [_sendDataDictionary setObject:dic[@"dzNo"]?:@"" forKey:@"dzNo"];
    }
    [self.tableView.mj_header beginRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bgTipButton];
    
    self.view.backgroundColor =BACKGROUNDCOLOR;
    self.titleArr =@[@"对账单号",@"生成日期",@"对账日期",@"对账数量",@"对账金额",@"运费",@"支付状态"];
    //    self.tableView.frame =CGRectMake(0, 40, SCREEN_WIDTH, self.tableView.height-80);
    self.tableView.tableFooterView =[UIView new];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {        
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"sale" object:nil];
}
-(void)setSourceDic:(NSMutableDictionary *)sourceDic
{
    _sourceDic =sourceDic;
    [self.tableView.mj_header beginRefreshing];
}
- (void)notificationHandler:(NSNotification *)notification {
    if ([notification.name isEqualToString:@"sale"]) {
        NSDictionary *dic =notification.userInfo;
        if ([dic[@"index"] isEqualToString:@"1"]) {
            [_sendDataDictionary setObject:dic[@"time"]?:@"" forKey:@"startTime"];
            [_sendDataDictionary setObject:dic[@"time"]?:@"" forKey:@"endTime"];
        }
        else
        {
            [_sendDataDictionary setObject:dic[@"dzNo"]?:@"" forKey:@"dzNo"];
        }
        [self.tableView.mj_header beginRefreshing];
    }
}
//   self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"sale" object:nil];
}
-(void)getMsgList
{
    if (!_sendDataDictionary) {
        _sendDataDictionary = [NSMutableDictionary dictionaryWithObjects:@[@"",@"",@""] forKeys:@[@"startTime",@"endTime",@"dzNo"]];
    }
    //    [MBProgressHUD showMessage:@""];
    [self loadDataSource:_sendDataDictionary withpagecount:[NSString stringWithFormat:@"%d",pageCount]];
}
-(void)loadDataSource:(NSMutableDictionary*)dictionary withpagecount:(NSString *)page
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *urlStr = @"buyer/wsOrderDz";
  
    if (page) {
        [dic setObject:page forKey:@"pageNum"];
        [dic setObject:@"10" forKey:@"pageSize"];
    }
    if (self.status==0) {
        [dic setObject:@"2" forKey:@"payStatus"];
    }else
    {
        [dic setObject:@"1" forKey:@"payStatus"];
    }
    if (dictionary) {
        [dic addEntriesFromDictionary:dictionary];
    }
    if (_sourceDic) {
        if ([_sourceDic[@"index"] isEqualToString:@"1"]) {
            [dic setObject:_sourceDic[@"time"]?:@"" forKey:@"startTime"];
            [dic setObject:_sourceDic[@"time"]?:@"" forKey:@"endTime"];
        }
        else
        {
            [dic setObject:_sourceDic[@"dzNo"]?:@"" forKey:@"dzNo"];
        }
    }
    DRWeakSelf;
    [SNAPI getWithURL:urlStr parameters:dic success:^(SNResult *result) {
        NSLog(@"data=%@",result.data[@"list"]);
        NSMutableArray*addArr=result.data[@"list"];
        if (addArr.count) {
            for (NSDictionary *dic in addArr) {
                weakSelf.saleModel =[SalesOrderModel mj_objectWithKeyValues:dic];
                [self.MsgListArr addObject:weakSelf.saleModel];
            }
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
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUD];
    }];
}
-(void)addCustomView
{
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, 2, SCREEN_WIDTH, 36)];
    backView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:backView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (DCUpDownButton *)bgTipButton
{
    if (!_bgTipButton) {
        _bgTipButton = [DCUpDownButton buttonWithType:UIButtonTypeCustom];
        [_bgTipButton setImage:[UIImage imageNamed:@"img_msg_biaodan"] forState:UIControlStateNormal];
        _bgTipButton.titleLabel.font = DR_FONT(13);
        [_bgTipButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_bgTipButton setTitle:@"暂无数据" forState:UIControlStateNormal];
        _bgTipButton.frame = CGRectMake(ScreenW * 1/4 , (ScreenH - ScreenW/2) * 1/2-150, ScreenW/2, ScreenW/2);
        _bgTipButton.adjustsImageWhenHighlighted = false;
    }
    return _bgTipButton;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    self.bgTipButton.hidden = (_MsgListArr.count > 0) ? YES : NO;
    return _MsgListArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WScale(40);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    return self.titleArr.count;
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
    return WScale(50);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if (self.MsgListArr.count!=0)
//    {
//        self.saleModel =self.MsgListArr[indexPath.row];
//        SaleOrderCell *cell =[SaleOrderCell cellWithTableView:tableView];
//
//        cell.shoukuanModel =self.saleModel;
//        cell.status =self.status;
//        cell.detailClickBlock = ^{
//            DRShouKuanChildVC *saleDetailVC =[[DRShouKuanChildVC alloc]init];
//            self.saleModel =self.MsgListArr[indexPath.row];
//            saleDetailVC.saleModel =self.saleModel;
//            saleDetailVC.fatherStatus =self.status;
//            [self.navigationController pushViewController:saleDetailVC animated:YES];
//        };
//        return cell;
//
//    }
    if (self.MsgListArr.count!=0)
    {
        static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
           UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                    SimpleTableIdentifier];
           if (cell == nil) {
               cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                             reuseIdentifier: SimpleTableIdentifier];
           }
           
           self.saleModel =self.MsgListArr[indexPath.section];
           NSString *payStr ;
           if ([self.saleModel.payStatus intValue]==1) {
               payStr  =@"已付款";
           }
           else
           {
               payStr = @"未付款";
           }
           self.detailArr =@[self.saleModel.dzNo,self.saleModel.createTime,self.saleModel.dzPeriod,self.saleModel.qty,[NSString stringWithFormat:@"￥%@",self.saleModel.totalOrderAmt],[NSString stringWithFormat:@"￥%@",self.saleModel.expressFeeTotal],payStr];
           cell.textLabel.text =self.titleArr[indexPath.row];
           cell.textLabel.font =DR_FONT(14);
           
           cell.detailTextLabel.text =self.detailArr[indexPath.row];
           cell.detailTextLabel.font =DR_FONT(14);
           if (self.status==0&indexPath.row==4||indexPath.row==5) {
               cell.detailTextLabel.textColor =REDCOLOR;
           }
           
           if (self.status==1&indexPath.row==2||indexPath.row==3) {
               cell.detailTextLabel.textColor =REDCOLOR;
           }
           //    cell.textLabel.text = [_titleStr stringByAppendingString:[NSString stringWithFormat:@"-%d",(int)indexPath.row]];
           return cell;
    }
    static NSString *SimpleTableIdentifier = @"Simple";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier: SimpleTableIdentifier];
    }
    return cell;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.saleModel =self.MsgListArr[indexPath.row];
   
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, WScale(50))];
    footerView.backgroundColor =WHITECOLOR;
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(10, 0, ScreenW-20, 1)];
    lineView.backgroundColor =BACKGROUNDCOLOR;
    [footerView addSubview:lineView];
    UIButton *footerBtn =[UIButton buttonWithTitle:@"查看详细" font:DR_FONT(14) titleColor:REDCOLOR backGroundColor:CLEARCOLOR buttonTag:section target:self action:@selector(footerBtnClick:) showView:footerView];
    footerBtn.frame =CGRectMake(WScale(285), WScale(10), WScale(80), WScale(30));
    footerBtn.layer.borderColor = REDCOLOR.CGColor;
    //设置边框宽度
    footerBtn.layer.borderWidth = 1.0f;
    //给按钮设置角的弧度
    footerBtn.layer.cornerRadius = 4.0f;
    
    footerBtn.layer.masksToBounds =YES;
    
    return footerView;
}
-(void)footerBtnClick:(UIButton *)sender
{
    self.saleModel =self.MsgListArr[sender.tag];
    DRShouKuanChildVC *saleDetailVC =[[DRShouKuanChildVC alloc]init];
    saleDetailVC.saleModel =self.saleModel;
    saleDetailVC.fatherStatus =self.status;
    [self.navigationController pushViewController:saleDetailVC animated:YES];
   
}
@end

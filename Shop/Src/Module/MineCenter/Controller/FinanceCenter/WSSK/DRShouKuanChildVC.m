//
//  DRShouKuanChildVC.m
//  Shop
//
//  Created by BWJ on 2019/7/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRShouKuanChildVC.h"
#import "SalesOrderModel.h"
#import "SellerChildModel.h"
#import "SaleOrderCell.h"
#import "DetailOrdervc.h"
#import "DRDetailSelloutVC.h"
#import "WeiShuiHeaderView.h"
#import "CountPayVC.h"
@interface DRShouKuanChildVC ()<UITableViewDelegate,UITableViewDataSource>
{
    int pageCount;
}
@property (weak, nonatomic) IBOutlet UIView *bootView;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UIButton *zhifuBtn;
@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (nonatomic,strong)NSMutableArray *MsgListArr;
@property (nonatomic,strong)SellerChildModel *detailModel;
@property (nonatomic,strong)SelleModel *listMOdel;
@property (nonatomic,strong)WeiShuiHeaderView *headView;
@end
@implementation DRShouKuanChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"未税收款详情";
    [self loadTableView];
    [self orderDzInfo];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadTableView
{
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-DRTopHeight) style:UITableViewStylePlain];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor =BACKGROUNDCOLOR;
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    self.headView = [[[NSBundle mainBundle] loadNibNamed:@"WeiShuiHeaderView" owner:self options:nil] lastObject]; // lastObject 可改为 firstObject，该数组只有一个元素，写哪个都行，看个人习惯。
    self.headView.countPayBtn.layer.borderColor =RGBHex(0XE5E5E5).CGColor;
    self.headView.countPayBtn.layer.borderWidth =0.5;
    self.headView.countPayBtn.layer.cornerRadius =12.5;
    self.headView.countPayBtn.layer.masksToBounds =12.5;
    self.headView.allPayBtn.layer.cornerRadius =12.5;
    self.headView.allPayBtn.layer.masksToBounds =12.5;
    if (self.fatherStatus==1) {
        self.headView.countPayBtn.hidden =YES;
        self.headView.allPayBtn.hidden=YES;
//        self.headView.waitPayLab.text =self.saleModel
    }else
    {
        self.headView.countPayBtn.hidden =NO;
        self.headView.allPayBtn.hidden=NO;
        [self.headView.countPayBtn addTarget:self action:@selector(countPayBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.headView.allPayBtn addTarget:self action:@selector(allPayBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    self.tableView.tableHeaderView =self.headView ;
}
-(void)countPayBtnClick
{
    [self.navigationController pushViewController:[CountPayVC new] animated:YES];
}
-(void)allPayBtnClick
{
    
}
    
-(void)orderDzInfo
{
    //    DRWeakSelf;
   

   
    NSString *urlStr =@"buyer/wsOrderDzInfo";
  
//    NSString * stateStr;
//    stateStr =@"0";
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObjects:@[self.saleModel.sale_id] forKeys:@[@"dzId"]];
    [SNAPI getWithURL:urlStr parameters:dic success:^(SNResult *result) {
         
        self.MsgListArr =[NSMutableArray array];
        self.countLab.text =[NSString stringWithFormat:@"账单金额：%@",result.data[@"totalAmt"]];
        [SNTool setTextColor:self.countLab FontNumber:DR_FONT(14) AndRange:NSMakeRange(5, self.countLab.text.length-5) AndColor:REDCOLOR];
        self.headView.waitPayLab.text =[NSString stringWithFormat:@"￥%.2f",[result.data[@"leftAmt"] doubleValue]];
        self.headView.orderPayLab.text =[NSString stringWithFormat:@"￥%.2f",[result.data[@"totalOrderAmt"] doubleValue]];
        self.headView.payedLab.text =[NSString stringWithFormat:@"￥%.2f",[result.data[@"paidAmt"] doubleValue]];
    
//        if ([[NSString stringWithFormat:@"%@",result.data[@"payStatus"]] isEqualToString:@"2"]) {
//            [self.zhifuBtn setTitle:@"立即支付" forState:UIControlStateNormal];
//            self.zhifuBtn.backgroundColor =REDCOLOR;
//            self.zhifuBtn.enabled =YES;
//        }
//        else
//        {
//            [self.zhifuBtn setTitle:@"已支付" forState:UIControlStateNormal];
//            self.zhifuBtn.backgroundColor =[UIColor lightGrayColor];
//            self.zhifuBtn.enabled =NO;
//        }
        NSArray *resultArr =result.data[@"sellerList"];
        NSMutableArray *modelArray = [SellerChildModel mj_objectArrayWithKeyValuesArray:resultArr];
        [self.MsgListArr addObjectsFromArray:modelArray];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WScale(330);
}
#pragma mark 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.MsgListArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.detailModel =self.MsgListArr[section];
    return self.detailModel.list.count;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.detailModel = self.MsgListArr[indexPath.section];
    self.listMOdel =[SelleModel mj_objectWithKeyValues:self.detailModel.list[indexPath.row]];
    //    if (self.fatherStatus==0) {
    SaleOrderCell4 *cell =[SaleOrderCell4 cellWithTableView:tableView];
    if ([self.listMOdel.billType intValue]==1) {
        cell.orderLab.text =@"销售订单";
    }else
    {
        cell.orderLab.text =@"退货订单";
    }
    
    cell.getTimeLab.text =[NSString stringWithFormat:@"%@",[SNTool StringTimeFormat:[NSString stringWithFormat:@"%ld",self.listMOdel.addTime]]];
    
    cell.saleTimeLab.text =[NSString stringWithFormat:@"%@",[SNTool StringTimeFormat:[NSString stringWithFormat:@"%ld",self.listMOdel.inAccountTime]]];
    
    cell.duizhangCountLab.text =[NSString stringWithFormat:@"￥%.2f",self.listMOdel.orderAmt];
    cell.saleCountLab.text =[NSString stringWithFormat:@"￥%.2f",self.listMOdel.orderAmt];
    cell.saleCountLab.textColor =REDCOLOR;
    cell.payLab.text =[self.listMOdel.payType boolValue]?@"在线支付":@"额度支付";
    cell.yunfeiLab.text=[NSString stringWithFormat:@"￥%ld",(long)self.listMOdel.orderExpressPrice];
    cell.detailClickBlock = ^{
        self.detailModel = self.MsgListArr[indexPath.section];
        self.listMOdel =[SelleModel mj_objectWithKeyValues:self.detailModel.list[indexPath.row]];
        if ([self.listMOdel.billType intValue]==1) {
            
            DetailOrdervc *detailVC =[[DetailOrdervc alloc]init];
            detailVC.orderID =self.listMOdel.orderId;
            [self.navigationController pushViewController:detailVC animated:YES];
        }else
        {
            DRDetailSelloutVC *sellOutVc =[[DRDetailSelloutVC alloc]init];
            
            sellOutVc.returnId =self.listMOdel.orderId;
            [self.navigationController pushViewController:sellOutVc animated:YES];
        }
        
    };
    return cell;
 
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.detailModel =self.MsgListArr[section];
    
    UIView*  headView=[[UIView alloc] initWithFrame:CGRectMake(0, WScale(0), SCREEN_WIDTH, WScale(60))];
    headView.backgroundColor=WHITECOLOR;
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, WScale(0), ScreenW, WScale(10))];
    lineView.backgroundColor =BACKGROUNDCOLOR;
    [headView addSubview:lineView];
    UIButton*  button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(10, WScale(25), WScale(50), WScale(20))];
    button.titleLabel.font =DR_FONT(12);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if ([self.detailModel.compType intValue]==0) {
        [button setImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
        //        [self.santieBtn setTitle:@"自营" forState:UIControlStateNormal];
        
    }else if ([self.detailModel.compType intValue]==1)
    {
        [button setImage:[UIImage imageNamed:@"分类购买_08"] forState:UIControlStateNormal];
        //        [self.santieBtn setTitle:@"厂家" forState:UIControlStateNormal];
        
    }
    else if ([self.detailModel.compType intValue]==2)
    {
        [button setImage:[UIImage imageNamed:@"blue-bg"] forState:UIControlStateNormal];
        //        [self.santieBtn setTitle:@"批发商" forState:UIControlStateNormal];
        
    }
    button.selected =[self.detailModel.compType boolValue];
    [headView addSubview:button];
    UILabel *headLab =[[UILabel alloc]initWithFrame:CGRectMake(button.dc_right+10, WScale(15), 2*ScreenW/3,  WScale(40))];
    headLab.font =DR_FONT(14);
    headLab.textColor =BLACKCOLOR;
    headLab.textAlignment = 0;
    headLab.text=self.detailModel.sellerName;
    [headView addSubview:headLab];
    return headView;
    
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return WScale(60);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.01;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)zhifuBtnClick:(id)sender {
    
}

@end

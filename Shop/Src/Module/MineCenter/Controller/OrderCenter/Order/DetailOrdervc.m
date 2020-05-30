//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "DetailOrdervc.h"
#import "ThirdCell.h"
#import "CollectionCell.h"
#import "DetailHeadView.h"
#import "CustomFooterView.h"
#import "HeadView.h"
#import "AskSellOutVC.h"
#import "ApplicationSaleAfterVC.h"
#import "LSXAlertInputView.h"
#import "DRShopHomeVC.h"
#import "ZWPhotoPreviewDataModel.h"
#import "ZWPhotoPreview.h"
#import "PayDetailCell.h"
@interface DetailOrdervc ()<UITableViewDelegate,UITableViewDataSource,HeadViewDelegate>
{
    int pageCount;
}
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (nonatomic,strong)NSMutableArray *MsgListArr;
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)UITableView*  tableView;
@property (weak, nonatomic) IBOutlet UIButton *saleOutBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *againBuyBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic,retain)UIButton *footBtn;

@property(nonatomic,strong)NSDictionary* dataDict;
@property(nonatomic,strong)NSArray*  dataArr;
@property(nonatomic,strong)NSMutableArray*   isOpenArr;
@property(nonatomic,strong)NSArray* sectionNameArr;
@property(nonatomic,strong)NSMutableArray * messageArr;
@property(nonatomic,strong)NSMutableArray * resoverArr;
@property(nonatomic,strong)NSMutableArray * peisongArr;
@property(nonatomic,strong)NSMutableArray * payArr,*payrRightArr;

@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic,retain)DetailHeadView *customHeadView;
@property (nonatomic,retain)GoodsListModel *goodListModel;
@end

@implementation DetailOrdervc

- (IBAction)btnClick:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"订单详情";
    [self loadSource];
    self.view.backgroundColor =BACKGROUNDCOLOR;
}
-(void)loadTableView
{
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-50-DRTopHeight) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor =BACKGROUNDCOLOR;
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.separatorColor =LINECOLOR;
       if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
       {
           [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, WScale(10), 0, WScale(10))];
       }
//    _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[ThirdCell class] forCellReuseIdentifier:@"ThirdCell"];
    [_tableView registerClass:[PayDetailCell class] forCellReuseIdentifier:@"PayDetailCell"];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    self.saleOutBtn.layer.borderColor =REDCOLOR.CGColor;
    self.saleOutBtn.layer.borderWidth =0.5;
    self.saleOutBtn.layer.cornerRadius =4;
    self.saleOutBtn.layer.masksToBounds =4;
    
    self.cancelBtn.layer.borderColor =REDCOLOR.CGColor;
    self.cancelBtn.layer.borderWidth =0.5;
    self.cancelBtn.layer.cornerRadius =4;
    self.cancelBtn.layer.masksToBounds =4;
    
    self.againBuyBtn.layer.borderColor =REDCOLOR.CGColor;
    self.againBuyBtn.layer.borderWidth =0.5;
    self.againBuyBtn.layer.cornerRadius =4;
    self.againBuyBtn.layer.masksToBounds =4;
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).offset(-50);
    }];
}
-(void)loadSource
{
//    _sectionNameArr=@[@"客厅"];
    self.isOpenArr=[[NSMutableArray alloc] init];
    // self.dataDict=@{@"first":firstDataArr,@"second":secondArr,@"third":thirdArr};
    //    self.dataArr=@[firstDataArr];
    //for (int i=0; i<self.dataDict.allKeys.count; i++) {

    [self.isOpenArr addObject:@"close"];
    [self loadTableView];
    [self addHeadView];    
    [self getMsgList];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
}
-(void)addHeadView
{
    self.customHeadView = [[[NSBundle mainBundle] loadNibNamed:@"DetailHeadView" owner:self options:nil] lastObject];
   
    self.tableView.tableHeaderView =self.customHeadView;
   
   
}
-(void)getMsgList
{
    DRWeakSelf;
    NSDictionary *muDIC =[NSDictionary dictionary];
    if (self.orderID.length!=0) {
        
        muDIC =@{@"id":self.orderID};
    }else
    {
         muDIC =@{@"id":self.orderModel.order_id};
    }
    [SNAPI getWithURL:@"buyer/orderDetails" parameters:muDIC.mutableCopy success:^(SNResult *result) {
        NSArray *statusArr =@[@"已取消", @"待审核", @"待付款", @"待发货", @"待收货",@"已完成",@"退货中",@"已退货"];
        weakSelf.orderModel =[OrderModel mj_objectWithKeyValues:result.data];
        weakSelf.messageArr=[NSMutableArray arrayWithObject:@"备注"];
        weakSelf.resoverArr=[NSMutableArray array];
        weakSelf.peisongArr=[NSMutableArray arrayWithObject:@"配送信息"];
        weakSelf.payArr=[NSMutableArray arrayWithObject:@"支付信息"];
        weakSelf.payrRightArr =[NSMutableArray arrayWithObject:@""];
        if (weakSelf.orderModel.message.length!=0) {
            [weakSelf.messageArr addObject:weakSelf.orderModel.message];
        }
        if (weakSelf.orderModel.status==0) {
            self.saleOutBtn.hidden =YES;
            self.cancelBtn.hidden =YES;
        }
        else  if (weakSelf.orderModel.status==1) {
            self.saleOutBtn.hidden =YES;
            self.cancelBtn.hidden =NO;
        }
        else  if (weakSelf.orderModel.status==2) {
            self.saleOutBtn.hidden =NO;
            self.cancelBtn.hidden =NO;
            [self.saleOutBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [self.saleOutBtn setTitleColor:RGBHex(0X888888) forState:UIControlStateNormal];
            self.saleOutBtn.layer.borderColor =RGBHex(0X888888).CGColor;
            self.saleOutBtn.layer.borderWidth =0.5;
            [self.cancelBtn setTitle:@"去付款" forState:UIControlStateNormal];
            [self.cancelBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
            self.cancelBtn.backgroundColor =REDCOLOR;
        }
        else  if (weakSelf.orderModel.status==3) {
            self.saleOutBtn.hidden =YES;
            self.cancelBtn.hidden =YES;
            
        }
        else  if (weakSelf.orderModel.status==4) {
            self.saleOutBtn.hidden =NO;
            self.cancelBtn.hidden =NO;
            [self.saleOutBtn setTitle:@"整单申请售后" forState:UIControlStateNormal];
            [self.cancelBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            [self.cancelBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
            self.cancelBtn.backgroundColor =REDCOLOR;
        }
        else  if (weakSelf.orderModel.status==5) {
            self.saleOutBtn.hidden =NO;
            self.cancelBtn.hidden =NO;
            [self.saleOutBtn setTitle:@"整单申请售后" forState:UIControlStateNormal];
            [self.cancelBtn setTitle:@"去评价" forState:UIControlStateNormal];
            [self.cancelBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
            self.cancelBtn.backgroundColor =REDCOLOR;
        }
        else  if (weakSelf.orderModel.status==6) {
            self.saleOutBtn.hidden =YES;
            self.cancelBtn.hidden =NO;
            [self.cancelBtn setTitle:@"取消退货" forState:UIControlStateNormal];
            [self.cancelBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
            self.cancelBtn.backgroundColor =REDCOLOR;
        }
        else  if (weakSelf.orderModel.status==7) {
            self.saleOutBtn.hidden =YES;
            self.cancelBtn.hidden =YES;
        }
        if (self.orderModel.isReturn==1) {
            self.saleOutBtn.hidden =YES;
            self.cancelBtn.hidden =YES;
        }
        if (weakSelf.orderModel.status==101) {
            self.saleOutBtn.hidden =YES;
            self.cancelBtn.hidden =YES;
        }
        if (weakSelf.orderModel.status ==5) {
            self.saleOutBtn.hidden = !weakSelf.orderModel.orderPayType;
            self.cancelBtn.hidden = !weakSelf.orderModel.orderPayType;
            
            [self.saleOutBtn setTitle:@"整单申请售后" forState:UIControlStateNormal];
            [self.cancelBtn setTitle:@"去评价" forState:UIControlStateNormal];
            [self.cancelBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
            self.cancelBtn.backgroundColor =REDCOLOR;
        }
        if (weakSelf.orderModel.check&&weakSelf.orderModel.status ==5) {
            self.cancelBtn.hidden =!weakSelf.orderModel.check;
            [self.cancelBtn setTitle:@"整单申请售后" forState:UIControlStateNormal];
            self.saleOutBtn.hidden =YES;
        }
        
        NSString *mobileStr =[NSString stringWithFormat:@"%@",self.orderModel.mobile?:@""];
        NSString *phoneStr =[NSString stringWithFormat:@"%@",self.orderModel.phone?:@""];
        NSArray * resArr =@[[NSString stringWithFormat:@"%@  %@%@",self.orderModel.consignee?:@"",mobileStr?:@"",phoneStr?:@""],[NSString stringWithFormat:@"%@",self.orderModel.address?:@""]];
        for (NSString *str in resArr) {
            if (![str isEqualToString:@""]) {
                [weakSelf.resoverArr addObject:str];
            }
        }
        NSArray *peititleArr =[NSArray array];
        if ([self.orderModel.expressType intValue]!=2) {
            if ( [self.orderModel.sellerExpressType intValue]==1)
            {
                peititleArr=@[@"配送方式：",@"自提地址：",@"运费：",@"预计到货时间："];
                NSString *titleStr;
                if ([ self.orderModel.orderservicetype isEqualToString:@"st"]) {
                    titleStr =@"三铁配送";
                }
                else if ([ self.orderModel.orderservicetype isEqualToString:@"wl"]) {
                    titleStr =@"物流配送";
                }
                else if ([ self.orderModel.orderservicetype isEqualToString:@"zt"]) {
                    titleStr =@"自己提取";
                }
                else
                {
                    titleStr =@"";
                }
                NSArray *peisongArr =@[[NSString stringWithFormat:@"%@%@",peititleArr[0],titleStr],[NSString stringWithFormat:@"%@%@",peititleArr[1],self.orderModel.ztAddress?:@""],[NSString stringWithFormat:@"%@%@",peititleArr[2],self.orderModel.expressPrice?:@""],[NSString stringWithFormat:@"%@%@",peititleArr[3],[SNTool StringTimeFormat:self.orderModel.sellerEstDd]?:@""]];
                for (NSString *str in peisongArr)
                {
                    NSArray *titArr =[str componentsSeparatedByString:@"："];
                    if (![titArr[1] isEqualToString:@""])
                    {
                        [weakSelf.peisongArr addObject:str];
                    }
                }
            }
            else
            {
                peititleArr=@[@"物流公司：",@"物流单号：",@"预计发货时间："];
                NSArray *peisongArr =@[[NSString stringWithFormat:@"%@%@",peititleArr[0],self.orderModel.expressCompany?:@""],[NSString stringWithFormat:@"%@%@",peititleArr[1],self.orderModel.expressNo?:@""],[NSString stringWithFormat:@"%@%@",peititleArr[2],[SNTool StringTimeFormat:[NSString stringWithFormat:@"%ld",(long)self.orderModel.estDd]]?:@""]];
                for (NSString *str in peisongArr) {
                    NSArray *titArr =[str componentsSeparatedByString:@"："];
                    if (![titArr[1] isEqualToString:@""]) {
                        [weakSelf.peisongArr addObject:str];
                    }
                }
            }
        }
        else
        {
            peititleArr=@[@"配送方式：",@"预计发货时间：",@"物流公司：",@"物流单号："];
            NSString *titleStr;
            if ([ self.orderModel.orderservicetype isEqualToString:@"st"]) {
                titleStr =@"三铁配送";
            }
            else if ([ self.orderModel.orderservicetype isEqualToString:@"wl"]) {
                titleStr =@"物流配送";
            }
            else if ([ self.orderModel.orderservicetype isEqualToString:@"zt"])
            {
                titleStr =@"自提";
            }
            else
            {
                titleStr =@"";
            }
            NSArray *peisongArr =@[[NSString stringWithFormat:@"%@%@",peititleArr[0],titleStr],[NSString stringWithFormat:@"%@%@",peititleArr[1],[SNTool StringTimeFormat:[NSString stringWithFormat:@"%ld",(long)self.orderModel.estDd]]?:@""],[NSString stringWithFormat:@"%@%@",peititleArr[2],self.orderModel.expressCompany?:@""],[NSString stringWithFormat:@"%@%@",peititleArr[3],self.orderModel.expressNo?:@""]];
            for (NSString *str in peisongArr)
            {
                NSArray *titArr =[str componentsSeparatedByString:@"："];
                if (![titArr[1] isEqualToString:@""])
                {
                    [weakSelf.peisongArr addObject:str];
                }
            }            
        }
        if (self.orderModel.logphone.length!=0) {
            [self.peisongArr addObject:[NSString stringWithFormat:@"物流联系方式：%@",self.orderModel.logphone]];
        }
        NSArray *paytittleArr =@[@"付款方式：",@"数量总计：",@"订单总额："];
        //,,@"实付总额："[NSString stringWithFormat:@"%@%@",payt          ittleArr[4],[NSString stringWithFormat:@"%.3f",self.orderModel.realAmt]?:@""]
        NSString *payStr;
        if ([self.orderModel.payType intValue]==1) {
            payStr =@"在线支付";
        }
        else if ([self.orderModel.payType intValue]==0)
        {
            payStr =@"线下支付";
        }
        else
        {
            payStr =@"货到付款";
        }
        NSArray *paArr =@[[NSString stringWithFormat:@"%@",payStr],[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%.3f",self.orderModel.totalqty]?:@""],[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"￥%.3f",self.orderModel.orderAmt]?:@""]];
        if (self.orderModel.kpName.length!=0) {
            [weakSelf.payArr addObject:@"开票方："];
            [weakSelf.payrRightArr addObject:self.orderModel.kpName];
        }
        [weakSelf.payArr addObjectsFromArray:paytittleArr];
        [weakSelf.payrRightArr addObjectsFromArray:paArr];
        
        NSString *payTimeStr;
        if (self.orderModel.payTime.length!=0)
        {
            [weakSelf.payArr addObject:@"付款时间："];
            payTimeStr=[SNTool StringTimeFormat:self.orderModel.payTime];
            [weakSelf.payrRightArr insertObject:[NSString stringWithFormat:@"%@",payTimeStr] atIndex:2];
        }
        if ([self.orderModel.isDf intValue]==1) {
            [weakSelf.payArr addObject:@"运费："];
            [weakSelf.payrRightArr addObject:@"到付"];
        }else if ([self.orderModel.orderExpressPrice doubleValue]>0)
        {
            [weakSelf.payArr addObject:@"运费："];
            [weakSelf.payrRightArr addObject:[NSString stringWithFormat:@"￥%.3f",[self.orderModel.orderExpressPrice doubleValue]]];
           
        }
        if (self.orderModel.voucheroff>0) {
            [weakSelf.payArr addObject:@"抵用券："];
            [weakSelf.payrRightArr addObject:[NSString stringWithFormat:@"￥%.0f",self.orderModel.voucheroff]];
        }
        if (self.orderModel.moneyoff>0) {
             [weakSelf.payArr addObject:@"满减："];
            [weakSelf.payrRightArr addObject:[NSString stringWithFormat:@"￥%.0f",self.orderModel.moneyoff]];
        }
        [weakSelf.payArr addObject:@"实付总额："];
        [weakSelf.payrRightArr addObject:[NSString stringWithFormat:@"￥%@",[NSString stringWithFormat:@"%.2f",self.orderModel.realAmt+[self.orderModel.orderExpressPrice doubleValue]]?:@""]];
        
       
        self.customHeadView.orderLab.text =[NSString stringWithFormat:@"订单号：%@",self.orderModel.orderNo];
        self.customHeadView.timeLab.text =[NSString stringWithFormat:@"下单时间：%@",[SNTool StringTimeFormat:[NSString stringWithFormat:@"%ld",(long)self.orderModel.createTime]]];
        NSArray *contentArr =@[@"尊敬的用户，您的订单已取消！",@"尊敬的用户，请耐心等待审核！", @"尊敬的用户，您的订单未付款，请您先付款！", @"尊敬的用户，您的订单已经审核成功，请您耐心等待发货！", @"尊敬的用户，您的订单已经出库，请您耐心等待！",@"尊敬的用户，您的订单已完成！",@"尊敬的用户，您的订单已经审核成功，请您耐心等待发货！",@"尊敬的用户，您的商品已经退货！"];
        NSArray *imgArr =@[@"personal_bg_yiquxiao daishenghe", @"personal_bg_yiquxiao daishenghe", @"personal_bg_daifukuan", @"personal_bg_daifahuo tuihuozhong", @"personal_bg_daishouhuo",@"personal_bg_yiwancheng yishouhuo",@"personal_bg_daifahuo tuihuozhong",@"personal_bg_yiwancheng yishouhuo"];
        if (weakSelf.orderModel.status==101) {
            self.customHeadView.statusLab.text =@"已支付";
            self.customHeadView.contentLab.text =@"尊敬的用户，您的订单已付款！";
            self.customHeadView.iconIMG.image =[UIImage imageNamed:@"yizhifu"];
        }else
        {
            self.customHeadView.contentLab.text =contentArr[self.orderModel.status];
            self.customHeadView.statusLab.text =statusArr[weakSelf.orderModel.status];
            self.customHeadView.iconIMG.image =[UIImage imageNamed:imgArr[self.orderModel.status]];
        }
        if (weakSelf.orderModel.isReturn==1) {
            self.customHeadView.statusLab.text=@"退货中";
        }
        
        
        if (self.orderModel.status==0) {
            //                [SNTool compareOneDay: [SNTool dateFromString:[NSString stringWithFormat:@"%ld",(long)self.orderModel.confirmTime]] withAnotherDay:[SNTool dateFromString:[SNTool ddpGetExpectTimestamp:0 month:0 day:-1]]];
            //                NSLog(@"111%@222%@333%@444%@",[SNTool dateFromString:[NSString stringWithFormat:@"%ld",(long)self.orderModel.confirmTime]],[SNTool dateFromString:[NSString stringWithFormat:@"%ld",(long)self.orderModel.confirmTime]],[SNTool ddpGetExpectTimestamp:0 month:0 day:-1],[SNTool dateFromString:[SNTool ddpGetExpectTimestamp:0 month:0 day:-1]]);
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}
- (IBAction)saleOutBtnClick:(id)sender {
    if ([self.saleOutBtn.titleLabel.text isEqualToString:@"整单申请售后"])
    {
        AskSellOutVC *outVC =[[AskSellOutVC alloc]init];
        outVC.senderDic =[NSMutableDictionary dictionaryWithObjects:@[self.orderModel.order_id,@"",@"1"] forKeys:@[@"orderId",@"orderGoodsId",@"type"]];
        outVC.refreshSourceBlock = ^{
            [self getMsgList];
            !_detailSourceBlock?:_detailSourceBlock();
        };
        [self.navigationController pushViewController:outVC animated:YES];
    }
    else if ([self.saleOutBtn.titleLabel.text isEqualToString:@"取消订单"]) {
        LSXAlertInputView * alert=[[LSXAlertInputView alloc]initWithTitle:@"取消原因" PlaceholderText:@"请输入取消原因" WithKeybordType:LSXKeyboardTypeDefault CompleteBlock:^(NSString *contents) {
            NSLog(@"-----%@",contents);
            NSDictionary *dic =@{@"cancelReason":contents,@"orderId":self.orderModel.order_id};
            [SNAPI postWithURL:@"buyer/cancelOrder" parameters:dic.mutableCopy success:^(SNResult *result) {
                [MBProgressHUD showSuccess:@"取消成功"];
                [self performSelector:@selector(laterClick) withObject:self afterDelay:1];
            } failure:^(NSError *error) {
                
            }];
        }];
        [alert show];
    }
    
}
- (IBAction)cancelBtnClick:(id)sender {
    if ([self.cancelBtn.titleLabel.text isEqualToString:@"取消订单"]) {
        LSXAlertInputView * alert=[[LSXAlertInputView alloc]initWithTitle:@"取消原因" PlaceholderText:@"请输入取消原因" WithKeybordType:LSXKeyboardTypeDefault CompleteBlock:^(NSString *contents) {
            NSLog(@"-----%@",contents);
            NSDictionary *dic =@{@"cancelReason":contents,@"orderId":self.orderModel.order_id};
            [SNAPI postWithURL:@"buyer/cancelOrder" parameters:dic.mutableCopy success:^(SNResult *result) {
                [MBProgressHUD showSuccess:@"取消成功"];
               
            } failure:^(NSError *error) {
                
            }];
        }];
        [alert show];
    }
    else if ([self.cancelBtn.titleLabel.text isEqualToString:@"确认收货"]) {
        NSDictionary *dic =@{@"orderId":self.orderModel.order_id};
        [SNAPI postWithURL:@"buyer/sureOrder" parameters:dic.mutableCopy success:^(SNResult *result) {
            [MBProgressHUD showSuccess:@"确认成功"];
             [self performSelector:@selector(laterClick) withObject:self afterDelay:1];
        } failure:^(NSError *error) {
        }];
    }
    else if ([self.cancelBtn.titleLabel.text isEqualToString:@"整单申请售后"])
    {
        AskSellOutVC *outVC =[[AskSellOutVC alloc]init];
        outVC.senderDic =[NSMutableDictionary dictionaryWithObjects:@[self.orderModel.order_id,@"",@"1"] forKeys:@[@"orderId",@"orderGoodsId",@"type"]];
        outVC.refreshSourceBlock = ^{
            [self getMsgList];
            !_detailSourceBlock?:_detailSourceBlock();
        };
        [self.navigationController pushViewController:outVC animated:YES];
    }    
}
-(void)laterClick
{
    [self.navigationController popViewControllerAnimated:YES];
    !_detailSourceBlock?:_detailSourceBlock();
}
- (IBAction)againBuyBtnClick:(id)sender {

    NSDictionary *dic =@{@"sourceType":@"Wechat",@"orderId":self.orderModel.order_id};
    [SNAPI postWithURL:@"buyer/buyOrderAgain" parameters:dic.mutableCopy success:^(SNResult *result) {
        self.tabBarController.selectedIndex =3;
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
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

#pragma mark 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
#pragma mark 表的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return self.resoverArr.count;
            break;
        case 1:
        {
            NSString*  state=[self.isOpenArr objectAtIndex:section-1];
            if ([state isEqualToString:@"open"])
            {
                // NSString*  key=[self.dataDict.allKeys objectAtIndex:section];
                //   NSArray*  arr=[self.dataDict objectForKey:key];
//                NSArray*  arr=[self.dataArr objectAtIndex:section];
                return self.orderModel.goodsList.count+1;
            }
            return 2;
        }
            break;
       
        case 2:
            return self.peisongArr.count;
            break;
        case 3:
            return self.payArr.count;
            break;
        case 4:
            return self.messageArr.count;
            break;
                  
        default:
            break;
    }
    return 0;
}
#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1&&indexPath.row==0) {
        return WScale(60);
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
    
    
    if (section==4) {
         if (self.orderModel.message.length==0) {
             return 0.01;
         }
    }
    return WScale(10);
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==1&&self.orderModel.goodsList.count>1) {
        return WScale(45);
    }
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        switch (indexPath.row) {
            case 0:
            {
                CollectionCell7 *cell =[CollectionCell7 cellWithTableView:tableView];
                 cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.orderModel =self.orderModel;
                cell.selectBtnClickBlock = ^{
                    NSLog(@"%ld",(long)indexPath.section);
                    DRShopHomeVC *detailVC = [DRShopHomeVC new];
                    detailVC.sellerId=self.orderModel.sellerId;
                    [self.navigationController pushViewController:detailVC animated:YES];
                };
                return cell;
            }
                break;
            default:
            {
                self.goodListModel =[GoodsListModel mj_objectWithKeyValues:self.orderModel.goodsList[indexPath.row-1]];
                ThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThirdCell"];
                cell.goodListModel =self.goodListModel;
                cell.orderModel =self.orderModel;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.saleOutClickBlock = ^{
                    
                    AskSellOutVC *outVC =[[AskSellOutVC alloc]init];
                    outVC.senderDic =[NSMutableDictionary dictionaryWithObjects:@[self.orderModel.order_id,self.goodListModel.good_id,@"2"] forKeys:@[@"orderId",@"orderGoodsId",@"type"]];
                    [self.navigationController pushViewController:outVC animated:YES];          
                };
                return cell;
            }
                break;
        }
    }
    if (indexPath.section==3) {
        PayDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayDetailCell"];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        if (indexPath.row==0) {
             cell.leftLab.textColor =BLACKCOLOR;
        }
        if (indexPath.row==1||indexPath.row==2)
        {
            cell.leftLab.textColor =RGBHex(0X888888);
            cell.rightLab.textColor =RGBHex(0X888888);;
        }
        cell.leftLab.text =self.payArr[indexPath.row];
        cell.rightLab.text =self.payrRightArr[indexPath.row];
        //        long  count =self.payArr.count-2;
        if (indexPath.row==self.payArr.count-1) {
            [SNTool setTextColor:cell.leftLab FontNumber:DR_FONT(14) AndRange:NSMakeRange(0, cell.leftLab.text.length) AndColor:REDCOLOR];
             [SNTool setTextColor:cell.rightLab FontNumber:DR_FONT(14) AndRange:NSMakeRange(0, cell.rightLab.text.length) AndColor:REDCOLOR];
        }
        else if (indexPath.row==self.payArr.count-2||indexPath.row==self.payArr.count-3)
        {
            [SNTool setTextColor:cell.leftLab FontNumber:DR_FONT(14) AndRange:NSMakeRange(0, cell.leftLab.text.length) AndColor:BLACKCOLOR];
             [SNTool setTextColor:cell.rightLab FontNumber:DR_FONT(14) AndRange:NSMakeRange(0, cell.rightLab.text.length) AndColor:BLACKCOLOR];
        }
        return cell;
    }
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier: SimpleTableIdentifier];
       
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section==4&&self.messageArr.count!=0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.messageArr[0]];
    }
   
    if (indexPath.section==0) {
       
        cell.textLabel.text = self.resoverArr[indexPath.row];
    }
    if (indexPath.section==2) {
        
        cell.textLabel.text = self.peisongArr[indexPath.row];
    }
   
    cell.textLabel.numberOfLines =0;
    cell.textLabel.font =DR_FONT(14);
    if (indexPath.row ==0) {
        cell.textLabel.textColor =BLACKCOLOR;
        cell.detailTextLabel.textColor =BLACKCOLOR;
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.detailTextLabel.textAlignment=2;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *bgView = [[UIView alloc] init];
//    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HScale(35));
//    bgView.backgroundColor = BACKGROUNDCOLOR;
//    UILabel *label = [[UILabel alloc] init];
//    label.frame = CGRectMake(15, 0, SCREEN_WIDTH/2-16, bgView.frame.size.height);
//    NSArray *titleArray =[NSArray array];
//    if (self.orderModel.message.length!=0) {
//    titleArray =  @[@"收货信息",@"",@"配送信息",@"支付信息",@"订单留言"];
//    }else
//    {
//        titleArray =  @[@"收货信息",@"",@"",@"配送信息",@"支付信息"];
//    }
//
//    label.text =titleArray[section];
//    label.font =DR_BoldFONT(15);
//    label.textColor = BLACKCOLOR;
//    [bgView addSubview:label];
//    UIButton *detailBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//    detailBtn.frame =CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2-15, HScale(35));
//    [detailBtn setTitle:@"查看运单图片" forState:UIControlStateNormal];
//    detailBtn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
//    detailBtn.titleLabel.font =DR_FONT(15);
//    [detailBtn setTitleColor:REDCOLOR forState:UIControlStateNormal];
//    [detailBtn addTarget:self action:@selector(detailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:detailBtn];
//
//    if (self.orderModel.expressImg.length!=0&&section==3) {
//        detailBtn.hidden =NO;
//    }
//    else
//    {
//        detailBtn.hidden =YES;
//    }
//    return bgView;
//}
-(void)detailBtnClick:(UIButton *)sender
{
    ZWPhotoPreviewDataModel *model1 = [[ZWPhotoPreviewDataModel alloc] init];
    model1.zw_photoURL = self.orderModel.expressImg;
    model1.zw_photoTitle =nil;
    model1.zw_photoDesc = nil;
    
    ZWPhotoPreview *view = [ZWPhotoPreview zw_showPhotoPreview:@[model1]];
    view.showIndex = 0;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==1&&self.orderModel.goodsList.count>1) {
        UIView*  sectionBackView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, WScale(45))];
        sectionBackView.backgroundColor=[UIColor whiteColor];
        UIButton*  button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, ScreenW, WScale(45))];
        button.tag=section;
        button.titleLabel.font =[UIFont systemFontOfSize:14];
        [button setTitleColor:REDCOLOR forState:UIControlStateNormal];
        if ([[_isOpenArr objectAtIndex:section-1] isEqualToString:@"open"]) {
            [button setImage:[UIImage imageNamed:@"arrow_right_grey"] forState:UIControlStateNormal];
            [button setTitle:[NSString stringWithFormat:@"收起全部(%lu)件商品",(unsigned long)self.orderModel.goodsList.count] forState:UIControlStateNormal];
        }
        else if ([[_isOpenArr objectAtIndex:section-1] isEqualToString:@"close"]) {
            [button setImage:[UIImage imageNamed:@"arrow_down_grey"] forState:UIControlStateNormal];
              [button setTitle:[NSString stringWithFormat:@"查看全部(%lu)件商品",(unsigned long)self.orderModel.goodsList.count] forState:UIControlStateNormal];
        }
        
         [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:3];
        [button addTarget:self action:@selector(ClickSection:) forControlEvents:UIControlEventTouchUpInside];
        [sectionBackView addSubview:button];
        return sectionBackView;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WScale(10))];
    //自定义颜色
    view.backgroundColor = BACKGROUNDCOLOR;
    return view;
}
-(void)ClickSection:(UIButton*)sender
{
    NSString*  state=[self.isOpenArr objectAtIndex:sender.tag-1];
    if ([state isEqualToString:@"open"]) {
        state=@"close";
    }else
    {
        state=@"open";
    }
    self.isOpenArr[sender.tag-1]=state;
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:sender.tag];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end

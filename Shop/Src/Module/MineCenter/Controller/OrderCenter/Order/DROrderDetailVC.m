//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "DROrderDetailVC.h"
#import "LabelCell.h"
#import "CollectionCell.h"
#import "DetailOrdervc.h"
#import "AskSellOutVC.h"
#import "OrderModel.h"
#import "LSXAlertInputView.h"
#import "DRShopHomeVC.h"
@interface DROrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    int pageCount;
}
@property (nonatomic,strong)NSMutableArray *MsgListArr;

//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,retain)DCUpDownButton *bgTipButton;
@property (nonatomic,retain)OrderModel *orderModel;
@property (nonatomic,retain)GoodsListModel *goodListModel;
@property (nonatomic, copy) NSString *titleStr;
@end

@implementation DROrderDetailVC
-(NSMutableArray *)MsgListArr
{
    if (!_MsgListArr) {
        _MsgListArr =[NSMutableArray array];
    }
    return _MsgListArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BACKGROUNDCOLOR;
    [self.view addSubview:self.bgTipButton];
//    _sendDataDictionary = [NSMutableDictionary dictionaryWithObjects:@[self.sendDataDictionary[@"startTime"]?:@"",self.sendDataDictionary[@"endTime"]?:@"",self.sendDataDictionary[@"dzNo"]?:@"",@""] forKeys:@[@"startTime",@"endTime",@"orderNo",@"evaluateType"]];
    _sendDataDictionary =[NSMutableDictionary dictionary];
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"ChangeOrder" object:nil];
    //       self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;
}
///表
-(UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:self
                      .view.bounds style:UITableViewStyleGrouped];
        self.tableView.dc_height = self.tableView.dc_height - DRTopHeight -WScale(85);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            
            _tableView.estimatedRowHeight = 0;
            
            _tableView.estimatedSectionHeaderHeight = 0;
            
            _tableView.estimatedSectionFooterHeight = 0;
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _tableView.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor =[UIColor clearColor];
         [_tableView registerClass:[LabelCell class] forCellReuseIdentifier:@"cell"];
//        [_tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"FirstTableViewCell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)notificationHandler:(NSNotification *)notification {
    if ([notification.name isEqualToString:@"ChangeOrder"]) {
        NSDictionary *dic =notification.userInfo;
        
        if ([dic[@"index"] intValue]==3) {
            [_sendDataDictionary setObject:dic[@"dzNo"]?:@"" forKey:@"orderNo"];
            
        }else
        {
            [_sendDataDictionary setObject:dic[@"startTime"]?:@"" forKey:@"startTime"];
            [_sendDataDictionary setObject:dic[@"endTime"]?:@"" forKey:@"endTime"];
            
        }
        [self.tableView.mj_header beginRefreshing];
    }
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ChangeOrder" object:nil];
}
-(void)getMsgList
{
    
    //    [MBProgressHUD showMessage:@""];
    [self loadDataSource:_sendDataDictionary withpagecount:[NSString stringWithFormat:@"%d",pageCount]];
}
-(void)loadDataSource:(NSMutableDictionary*)dictionary withpagecount:(NSString *)page
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.status==0) {
        [dic setObject:@"" forKey:@"orderStatus"];
    }
    else if (self.status==7)
    {
        [dic setObject:@"8" forKey:@"orderStatus"];
    }
    else if (self.status==8)
    {
        [dic setObject:@"7" forKey:@"orderStatus"];
    }
    else
    {
        [dic setObject:[NSString stringWithFormat:@"%ld",self.status-1] forKey:@"orderStatus"];
    }
    if (page) {
        [dic setObject:page forKey:@"pageNum"];
        [dic setObject:@"10" forKey:@"pageSize"];
    }
    if (dictionary) {
        [dic addEntriesFromDictionary:dictionary];
    }
    NSMutableDictionary *mudic =[NSMutableDictionary dictionaryWithObject:[SNTool convertToJsonData:dic] forKey:@"orderCondition"];
    DRWeakSelf;
    [SNAPI getWithURL:@"buyer/orderList" parameters:mudic success:^(SNResult *result) {
        
        NSLog(@"data=%@",result.data[@"list"]);
        NSMutableArray*addArr=result.data[@"list"];
        NSMutableArray *modelArray =[OrderModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
        [weakSelf.MsgListArr addObjectsFromArray:modelArray];
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
        [_bgTipButton setTitle:@"暂无订单" forState:UIControlStateNormal];
        _bgTipButton.frame = CGRectMake((ScreenW - 150) * 1/2 , (ScreenH - 150) * 1/2-DRTopHeight, 150, 150);
        _bgTipButton.adjustsImageWhenHighlighted = false;
    }
    return _bgTipButton;
}
#pragma mark 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    self.bgTipButton.hidden = (_MsgListArr.count > 0) ? YES : NO;
    return _MsgListArr.count;
}
#pragma mark 表的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.orderModel =self.MsgListArr[section];
    return self.orderModel.goodsList.count;
}
#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WScale(101);
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     self.orderModel = self.MsgListArr[section];
    if (self.orderModel.kpName.length!=0) {
        return WScale(156);
    }
    return WScale(126);
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return WScale(100);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.MsgListArr.count!=0) {
        LabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        if (!cell) {
            cell =[[LabelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        self.orderModel = self.MsgListArr[indexPath.section];
        
        self.goodListModel =[GoodsListModel mj_objectWithKeyValues:self.orderModel.goodsList[indexPath.row]];
         cell.goodListModel =self.goodListModel;
        
        cell.selectionStyle = 0;
        return cell;
//        FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstTableViewCell"];
//        self.orderModel = self.MsgListArr[indexPath.section];
//        
//        self.goodListModel =[GoodsListModel mj_objectWithKeyValues:self.orderModel.goodsList[indexPath.row]];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.goodListModel =self.goodListModel;
//        //        cell.dataDict =@{};
//        return cell;
    }
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier: SimpleTableIdentifier];
    }
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.MsgListArr.count!=0) {
        
        self.orderModel = self.MsgListArr[section];
        if (self.orderModel.kpName.length!=0) {
            CollectionCell2 *headView =[CollectionCell2 cellWithTableView:tableView];
            headView.companyClickBlock = ^{
                DRShopHomeVC *detailVC = [DRShopHomeVC new];
                self.orderModel = self.MsgListArr[section];
                detailVC.sellerId=self.orderModel.sellerId;
                [self.navigationController pushViewController:detailVC animated:YES];
            };
            headView.orderModel =self.orderModel;
            return headView;
            
        }
        CollectionCell11 *headView =[CollectionCell11 cellWithTableView:tableView];
        headView.companyClickBlock = ^{
            DRShopHomeVC *detailVC = [DRShopHomeVC new];
            self.orderModel = self.MsgListArr[section];
            detailVC.sellerId=self.orderModel.sellerId;
            [self.navigationController pushViewController:detailVC animated:YES];
        };
        headView.orderModel =self.orderModel;
        return headView;
    }
    return [UIView new];
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.MsgListArr.count!=0) {
        self.orderModel = self.MsgListArr[section];
        CollectionCell4 *footerView =[CollectionCell4 cellWithTableView:tableView];
        footerView.orderModel =self.orderModel;
        
        //    CollectionCell4 *cell =[CollectionCell4 cellWithTableView:tableView];
        footerView.BtnBlock = ^(NSInteger btnag,NSString *titleStr) {
            if ([titleStr isEqualToString:@"取消订单"]) {
                 [self.tableView.mj_header beginRefreshing];
            }else
            {
                switch (btnag) {
                    case 1:
                    {
                        self.orderModel = self.MsgListArr[section];
                        NSDictionary *dic =@{@"sourceType":@"Wechat",@"orderId":self.orderModel.order_id};
                        [SNAPI postWithURL:@"buyer/buyOrderAgain" parameters:dic.mutableCopy success:^(SNResult *result) {
                            self.tabBarController.selectedIndex =3;
                            [self.navigationController popToRootViewControllerAnimated:YES];
                            
                        } failure:^(NSError *error) {
                            
                        }];
                    }
                        break;
                    case 2:
                    {
                        if ([titleStr isEqualToString:@"确认收货"]) {
                            self.orderModel = self.MsgListArr[section];
                            NSDictionary *dic =@{@"orderId":self.orderModel.order_id};
                            [SNAPI postWithURL:@"buyer/sureOrder" parameters:dic.mutableCopy success:^(SNResult *result) {
                                [MBProgressHUD showSuccess:@"确认成功"];
                                [self.tableView.mj_header beginRefreshing];
                            } failure:^(NSError *error) {
                            }];
                        }else if ([titleStr isEqualToString:@"取消退货"])
                        {
                            ///初始化提示框
                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                                     message:@"确定取消退货吗？"                                                                                          preferredStyle:UIAlertControllerStyleAlert];
                            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定"
                                                                              style:UIAlertActionStyleDefault
                                                                            handler:^(UIAlertAction * _Nonnull action)
                                                      {
                                                          self.orderModel = self.MsgListArr[section];
                                                          NSDictionary *dic =@{@"returnId":self.orderModel.returnId};
                                                          [SNAPI postWithURL:@"buyer/cancelReturnOrder" parameters:dic.mutableCopy success:^(SNResult *result) {
                                                              [MBProgressHUD showSuccess:@"取消成功"];
                                                              [self.tableView.mj_header beginRefreshing];
                                                          } failure:^(NSError *error) {
                                                          }];
                                                      }];
                            [alertController addAction:action1];
                            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消"
                                                                              style:UIAlertActionStyleCancel
                                                                            handler:nil];
                            //            [action2 setValue:HQColorRGB(0xFF8010) forKey:@"titleTextColor"];
                            [alertController addAction:action2];
                            
                            dispatch_async(dispatch_get_main_queue(),^{
                                [self presentViewController:alertController animated:YES completion:nil];
                            });
                            
                        }
                        else if ([titleStr isEqualToString:@"去付款"])
                        {
                             self.orderModel = self.MsgListArr[section];
                            if ([self.orderModel.expressType isEqualToString:@"2"]&&self.orderModel.sellerExpressType.length!=0) {
                                NSString *severStr;
                                if ([self.orderModel.severType intValue]==0) {
                                    severStr =@"自己提取";
                                }else if ([self.orderModel.severType intValue]==1)
                                {
                                     severStr =@"物流配送";
                                }else if ([self.orderModel.severType intValue]==2)
                                {
                                     severStr =@"三铁配送";
                                }
                                NSString *messageStr;
                                if ([self.orderModel.expressPrice floatValue]>0.f) {
                                    
                                messageStr =[NSString stringWithFormat:@"卖家配送方式：%@/n运费：%@（到付）/n预计到货时间：%@",severStr,self.orderModel.expressPrice,[SNTool StringTimeFormat:self.orderModel.sellerEstDd]];
                                }else
                                {
                                     messageStr =[NSString stringWithFormat:@"卖家配送方式：%@/n预计到货时间：%@",severStr,[SNTool StringTimeFormat:self.orderModel.sellerEstDd]];
                                }
                                ///初始化提示框
                                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"配送信息"
                                                                                                         message:messageStr                  preferredStyle:UIAlertControllerStyleAlert];
                                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定"
                                                                                  style:UIAlertActionStyleDefault
                                                                                handler:^(UIAlertAction * _Nonnull action)
                                                          {
                                                              
                                                          }];
                                [alertController addAction:action1];
                                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拒绝"
                                                                                  style:UIAlertActionStyleCancel
                                                                                handler:nil];
                                //            [action2 setValue:HQColorRGB(0xFF8010) forKey:@"titleTextColor"];
                                [alertController addAction:action2];
                                
                                dispatch_async(dispatch_get_main_queue(),^{
                                    [self presentViewController:alertController animated:YES completion:nil];
                                });
                            }else
                            {
                                [MBProgressHUD showError:@"敬请期待"];
                            }
                            
                        }
                        else
                        {
                            [self.tableView.mj_header beginRefreshing];
                        }
                    }
                        break;
                    case 3:
                    {
                        self.orderModel = self.MsgListArr[section];
                        AskSellOutVC *outVC =[[AskSellOutVC alloc]init];
                        outVC.refreshSourceBlock = ^{
                            [self.tableView.mj_header beginRefreshing];
                        };
                        outVC.senderDic =[NSMutableDictionary dictionaryWithObjects:@[self.orderModel.order_id,@"",@"1"] forKeys:@[@"orderId",@"orderGoodsId",@"type"]];
                        [self.navigationController pushViewController:outVC animated:YES];
                    }
                        
                        break;
                        
                    default:
                    {
                        self.orderModel = self.MsgListArr[section];
                        DetailOrdervc *detailVC =[[DetailOrdervc alloc]init];
                        detailVC.orderModel =self.orderModel;
                        [self.navigationController pushViewController:detailVC animated:YES];
                    }
                        break;
                }
            }
          
            
        };
        return footerView;
    }
    return [UIView new];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.section);
    self.orderModel = self.MsgListArr[indexPath.section];
    DetailOrdervc *detailVC =[[DetailOrdervc alloc]init];
    detailVC.orderModel =self.orderModel;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}
@end

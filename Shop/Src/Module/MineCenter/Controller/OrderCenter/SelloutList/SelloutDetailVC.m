//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "SelloutDetailVC.h"
#import "FirstTableViewCell.h"
#import "CollectionCell.h"
#import "DRSellAfterModel.h"
#import "LSXAlertInputView.h"
#import "DRDetailSelloutVC.h"
#import "DRShopHomeVC.h"
@interface SelloutDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    int pageCount;
}
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (nonatomic,strong)NSMutableArray *MsgListArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain)DCUpDownButton *bgTipButton;
@property (nonatomic,retain)DRSellAfterModel *sellAfterModel;
@property (nonatomic,retain)GoodsList *ListModel;
@property (nonatomic, copy) NSString *titleStr;
@end

@implementation SelloutDetailVC
-(NSMutableArray *)MsgListArr
{
    if (!_MsgListArr) {
        _MsgListArr =[NSMutableArray array];
    }
    return _MsgListArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _sendDataDictionary = [NSMutableDictionary dictionaryWithObjects:@[self.sendDataDictionary[@"startTime"]?:@"",self.sendDataDictionary[@"endTime"]?:@"",self.sendDataDictionary[@"dzNo"]?:@""] forKeys:@[@"startTime",@"endTime",@"orderNo"]];
    self.view.backgroundColor =BACKGROUNDCOLOR;
//    self.tableView.frame =CGRectMake(0, 80, SCREEN_WIDTH, self.tableView.height - 80);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor =BACKGROUNDCOLOR;
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [_tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"FirstTableViewCell"];
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
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"SelloutVC" object:nil];
    //   self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;
}
- (void)notificationHandler:(NSNotification *)notification {
    if ([notification.name isEqualToString:@"SelloutVC"]) {
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SelloutVC" object:nil];
}
-(void)getMsgList
{
//    if (!_sendDataDictionary) {
//        _sendDataDictionary = [[NSMutableDictionary alloc] init];
//    }
    //    [MBProgressHUD showMessage:@""];
    [self loadDataSource:_sendDataDictionary withpagecount:[NSString stringWithFormat:@"%d",pageCount]];
}
-(void)loadDataSource:(NSMutableDictionary*)dictionary withpagecount:(NSString *)page
{
     NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (page) {
        [dic setObject:page forKey:@"pageNum"];
        [dic setObject:@"10" forKey:@"pageSize"];
    }
    if (self.status==0) {
         [dic setObject:@"" forKey:@"status"];
    }else
    {
        [dic setObject:[NSString stringWithFormat:@"%ld",self.status] forKey:@"status"];
    }
    if (dictionary) {
        [dic addEntriesFromDictionary:dictionary];
    }
//    NSMutableDictionary *mudic =[NSMutableDictionary dictionaryWithObject:[SNTool convertToJsonData:dic] forKey:@"orderCondition"];    
    DRWeakSelf;
    [SNAPI getWithURL:@"buyer/afterSaleList" parameters:dic.mutableCopy success:^(SNResult *result) {
        
        NSLog(@"data=%@",result.data[@"list"]);
        NSMutableArray*addArr=result.data[@"list"];
        NSMutableArray *modelArray =[DRSellAfterModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
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
        [_bgTipButton setImage:[UIImage imageNamed:@"MG_Empty_dizhi"] forState:UIControlStateNormal];
        _bgTipButton.titleLabel.font = DR_FONT(13);
        [_bgTipButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_bgTipButton setTitle:@"暂无数据" forState:UIControlStateNormal];
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
    self.sellAfterModel =self.MsgListArr[section];
    return self.sellAfterModel.goodsList.count;
}

#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return WScale(156);
}

//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return WScale(50);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.MsgListArr.count!=0) {
         FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstTableViewCell"];
        self.sellAfterModel = self.MsgListArr[indexPath.section];
        
        self.ListModel =[GoodsList mj_objectWithKeyValues:self.sellAfterModel.goodsList[indexPath.row]];
        cell.goodSellOutModel =self.ListModel;
        
        cell.selectionStyle = 0;
        return cell;

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
       self.sellAfterModel = self.MsgListArr[section];
       CollectionCell2 *headView =[CollectionCell2 cellWithTableView:tableView];
       headView.selloutModel =self.sellAfterModel;
       headView.companyClickBlock = ^{
           self.sellAfterModel = self.MsgListArr[section];
           DRShopHomeVC *detailVC = [DRShopHomeVC new];
           detailVC.sellerId=self.sellAfterModel.sellerId;
           [self.navigationController pushViewController:detailVC animated:YES];
       };
       return headView;
   }
    return [UIView new];
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.MsgListArr.count!=0) {
        self.sellAfterModel = self.MsgListArr[section];
        CollectionCell10 *footerView =[CollectionCell10 cellWithTableView:tableView];
        footerView.selloutModel =self.sellAfterModel;
        
        //    CollectionCell4 *cell =[CollectionCell4 cellWithTableView:tableView];
        footerView.BtnBlock = ^(NSInteger btnag,NSString *titleStr) {
            switch (btnag) {
                case 0:
                {
                    ///初始化提示框
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                             message:@"确定取消退货吗？"                                                                                          preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定"
                                                                      style:UIAlertActionStyleDefault
                                                                    handler:^(UIAlertAction * _Nonnull action)
                                              {
                                                  self.sellAfterModel = self.MsgListArr[section];
                                                  NSDictionary *dic =@{@"returnId":self.sellAfterModel.returnOrderId};
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
                    break;
                case 1:
                {
                    DRDetailSelloutVC *sellOutVc =[[DRDetailSelloutVC alloc]init];
                    self.sellAfterModel = self.MsgListArr[section];
                    sellOutVc.returnId =self.sellAfterModel.returnOrderId;
                    sellOutVc.cancelBtnBlock = ^{
                        [self.tableView.mj_header beginRefreshing];
                    };
                    [self.navigationController pushViewController:sellOutVc animated:YES];
                }
                    break;
                default:
                {
                    self.sellAfterModel = self.MsgListArr[section];
//                    DetailOrdervc *detailVC =[[DetailOrdervc alloc]init];
//                    detailVC.orderModel =self.orderModel;
//                    [self.navigationController pushViewController:detailVC animated:YES];
                }
                    break;
            }
            
        };
        return footerView;
    }
    return [UIView new];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.section);
   
}
@end

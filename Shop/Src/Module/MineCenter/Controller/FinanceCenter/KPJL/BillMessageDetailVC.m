//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//
#import "DRMessageDetailView.h"
#import "BillMessageDetailVC.h"
#import "FirstTableViewCell.h"
#import "SaleOrderCell.h"
#import "BillMessageDetailChildVC.h"
#import "BillMessageModel.h"
@interface BillMessageDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    int pageCount;
}

@property (nonatomic,strong)NSMutableArray *MsgListArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic,retain)DCUpDownButton *bgTipButton;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic,retain)BillMessageModel *MessageModel;
@end

@implementation BillMessageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BACKGROUNDCOLOR;
    [self.view addSubview:self.bgTipButton];
    _sendDataDictionary = [NSMutableDictionary dictionaryWithObjects:@[self.sendDataDictionary[@"startTime"]?:@"",self.sendDataDictionary[@"endTime"]?:@"",self.sendDataDictionary[@"dzNo"]?:@"",[NSString stringWithFormat:@"%ld",(long)self.status-1]] forKeys:@[@"startTime",@"endTime",@"keyWord",@"status"]];
    
    //    self.tableView.frame =CGRectMake(0, 80, SCREEN_WIDTH, self.tableView.height - 120-DRTopHeight);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor =BACKGROUNDCOLOR;
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
     self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
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
    //   self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;
//    [self CustomView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"message" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"yinCanZheGai" object:nil];
    
    //       self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;
}
-(NSMutableArray *)MsgListArr
{
    if (!_MsgListArr) {
        _MsgListArr =[NSMutableArray array];
    }
    return _MsgListArr;
}
- (void)notificationHandler:(NSNotification *)notification {
    if ([notification.name isEqualToString:@"message"]) {
        NSDictionary *dic =notification.userInfo;
        if ([dic[@"index"] intValue]==3) {
            [_sendDataDictionary setObject:dic[@"dzNo"]?:@"" forKey:@"keyWord"];
            
        }else
        {
            [_sendDataDictionary setObject:dic[@"startTime"]?:@"" forKey:@"startTime"];
            [_sendDataDictionary setObject:dic[@"endTime"]?:@"" forKey:@"endTime"];
            
        }
        [self.tableView.mj_header beginRefreshing];
    }
    else if ([notification.name isEqualToString:@"yinCanZheGai"])
    {
//        [self hideZheGaiBtn];
    }
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"yinCanZheGai" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"message" object:nil];
}

//通知回调
//- (void)hideZheGaiBtn{
////    self.backView.hidden = !self.backView.hidden;
//}

-(void)getMsgList
{
    
    
    //    [MBProgressHUD showMessage:@""];
    [self loadDataSource:_sendDataDictionary withpagecount:[NSString stringWithFormat:@"%d",pageCount]];
}
-(void)loadDataSource:(NSMutableDictionary*)dictionary withpagecount:(NSString *)page
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *urlStr =@"buyer/invoiceRecord" ;
    if (page) {
        [dic setObject:page forKey:@"pageNum"];
        [dic setObject:@"10" forKey:@"pageSize"];
    }
    if (dictionary) {
        [dic addEntriesFromDictionary:dictionary];
    }
    if (self.status==0) {
        [dic setObject:@"" forKey:@"status"];
    }
    DRWeakSelf;
    [SNAPI getWithURL:urlStr parameters:dic success:^(SNResult *result) {
        NSLog(@"data=%@",result.data[@"list"]);
        NSMutableArray*addArr=result.data[@"list"];
        NSMutableArray *modelArray =[BillMessageModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
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
        [_bgTipButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_bgTipButton setTitle:@"暂无数据" forState:UIControlStateNormal];
        _bgTipButton.frame = CGRectMake((ScreenW - 150) * 1/2 , (ScreenH - 150) * 1/2-150, 150, 150);
        _bgTipButton.adjustsImageWhenHighlighted = false;
    }
    return _bgTipButton;
}



#pragma mark 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   self.bgTipButton.hidden = (_MsgListArr.count > 0) ? YES : NO;
   return self.MsgListArr.count;
//    return 4;
}
#pragma mark 表的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return SCREEN_HEIGHT/25;
            break;
        case 1:
        case 2:
            return SCREEN_HEIGHT/30;
            break;
            
        case 3:
            return HScale(35);
            break;
            
            
        default:
            break;
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
    return 0.01;
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.MsgListArr.count!=0) {
        self.MessageModel =self.MsgListArr[indexPath.section];
        NSArray *titleArr =@[[NSString stringWithFormat:@"申请单号：%@",self.MessageModel.applyNo],[NSString stringWithFormat:@"开票方：%@",self.MessageModel.kpName],[NSString stringWithFormat:@"金额：%.2f",self.MessageModel.invoiceAmt]];
        switch (indexPath.row) {
            case 0:
            {
                static NSString *SimpleTableIdentifier = @"cell1";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                         SimpleTableIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier: SimpleTableIdentifier];
                    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
                        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
                    }
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
                }
                cell.textLabel.text =titleArr[indexPath.row];
                cell.textLabel.textColor =REDCOLOR;
                cell.textLabel.font =DR_BoldFONT(14);
                return cell;
            }
                break;
            case 1:
            {
                static NSString *SimpleTableIdentifier = @"cell2";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                         SimpleTableIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:1
                                                  reuseIdentifier: SimpleTableIdentifier];
                   cell.selectionStyle =UITableViewCellSelectionStyleNone;
                }
                
                cell.textLabel.text =titleArr[indexPath.row];
                cell.textLabel.textColor =BLACKCOLOR;
                cell.textLabel.font =DR_BoldFONT(12);
                NSArray *titleArr =@[@"待审核", @"已通过", @"未通过" ,@"已开票",@"已作废",@"已撤回"];
                if (self.MessageModel.status<=5) {
                    
                    cell.detailTextLabel.text = titleArr[self.MessageModel.status];
                }
                cell.detailTextLabel.textColor =REDCOLOR;
                cell.detailTextLabel.font =DR_FONT(14);
                
                return cell;
                
            }
                break;
                
            case 2:
            {
                static NSString *SimpleTableIdentifier = @"cell3";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                         SimpleTableIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:1
                                                  reuseIdentifier: SimpleTableIdentifier];
                    cell.selectionStyle =UITableViewCellSelectionStyleNone;
                }
                
                cell.textLabel.text =titleArr[indexPath.row];
                cell.textLabel.textColor =BLACKCOLOR;
                cell.textLabel.font =DR_FONT(12);
                cell.detailTextLabel.text =self.MessageModel.applyTime;
                cell.detailTextLabel.textColor =[UIColor lightGrayColor];
                cell.detailTextLabel.font =DR_FONT(14);
                
                return cell;
            }
                break;
                
            case 3:
                
            {
                SaleOrderCell2 *cell =[SaleOrderCell2 cellWithTableView:tableView];
                
                if (self.MessageModel.status==0||self.MessageModel.status==1||self.MessageModel.status==2||self.MessageModel.status==3) {
                    if (self.MessageModel.status==0) {
                        cell.returnBackBtn.selected =NO;
                    }
                    else
                    {
                        cell.returnBackBtn.selected =YES;
                    }
                    cell.returnBackBtn.hidden =NO;
                    
                }else
                {
                    cell.returnBackBtn.hidden =YES;
                }
                cell.BtntagBlock = ^(NSInteger Btntag) {
                    
                    [self BtnClickWithTag:Btntag withIndexPath:indexPath withBtn:cell.returnBackBtn];
                };
                return cell;
            }
                break;
                
            default:
                break;
        }
    }
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier: SimpleTableIdentifier];
    }
    cell.textLabel.text = [_titleStr stringByAppendingString:[NSString stringWithFormat:@"-%d",(int)indexPath.row]];
    return cell;
}
-(void)BtnClickWithTag:(NSInteger)tag withIndexPath:(NSIndexPath *)indexPath withBtn:(UIButton *)button
{
    self.MessageModel =self.MsgListArr[indexPath.section];
    switch (tag) {
        case 100:
        {
            if (button.selected==YES) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                         message:@"确定作废改发票吗？"
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定"
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * _Nonnull action)
                                          {
                                              
                                              NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjects:@[self.MessageModel.message_id] forKeys:@[@"id"]];
                                              [SNAPI postWithURL:@"buyer/cancelInvoice" parameters:dic success:^(SNResult *result) {
                                                  [self.tableView.mj_header beginRefreshing];
                                              } failure:^(NSError *error) {
                                                  [MBProgressHUD showError:error.domain];
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
            }else
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                         message:@"确定撤回开票申请吗？"
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定"
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * _Nonnull action)
                                          {
                                              
                                              NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjects:@[self.MessageModel.message_id] forKeys:@[@"id"]];
                                              [SNAPI postWithURL:@"buyer/recall" parameters:dic success:^(SNResult *result) {
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
           
          
           
        }
            break;
        case 200:
        {
            NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjects:@[self.MessageModel.message_id] forKeys:@[@"id"]];
            [SNAPI getWithURL:@"buyer/invoiceApplyDetail" parameters:dic success:^(SNResult *result) {
                if (result.state==200) {
                    
                    DRMessageDetailView *detailVC = [[[NSBundle mainBundle] loadNibNamed:@"DRMessageDetailView" owner:self options:nil] lastObject];
                    detailVC.frame =CGRectMake(0, 0, ScreenW, ScreenH);
                 detailVC.MessageModel =[BillMessageModel mj_objectWithKeyValues:result.data];
                    detailVC.closeBtnBlock = ^{
                        [detailVC removeFromSuperview];
                    };
                    detailVC.backBtnBlock = ^{
                        [detailVC removeFromSuperview];
                        
                    };
                    [[[UIApplication  sharedApplication ]keyWindow ] addSubview : detailVC ] ;

                }

            } failure:^(NSError *error) {
                [MBProgressHUD showError:error.domain];
            }];
        }
            break;
        case 300:
        {
           
            BillMessageDetailChildVC *childVC =[[BillMessageDetailChildVC alloc]init];
            childVC.MessageModel =self.MsgListArr[indexPath.section];
            childVC.changeInfo = ^{
                [self.tableView.mj_header beginRefreshing];
            };
            [self.navigationController pushViewController:childVC animated:YES];
            
        }
            
        default:
            break;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}
@end

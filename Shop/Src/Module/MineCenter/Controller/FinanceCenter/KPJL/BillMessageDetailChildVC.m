//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "BillMessageDetailChildVC.h"
#import "FirstTableViewCell.h"
#import "CollectionCell.h"
#import "UIViewExt.h"
#import "ShoppingCarCell.h"
//#import "BillApplicationModel.h"
#import "BillMessageDetailModel.h"
#import "BillDetailCell.h"
#import "MessageChildCell.h"
#import "DetailOrdervc.h"
#import "OrderModel.h"
@interface BillMessageDetailChildVC ()<UITableViewDelegate,UITableViewDataSource,ShoppingCarCellDelegate>
{
    int pageCount;
}

@property (nonatomic,strong)NSMutableArray *MsgListArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain)BillMessageDetailModel *detailModel;
@property (nonatomic,retain)DetailListModel *listModel;
@property (nonatomic,retain)NSArray *titleArr;

@end

@implementation BillMessageDetailChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"开票记录详情";
    self.view.backgroundColor =BACKGROUNDCOLOR;
    self.tableView.backgroundColor =BACKGROUNDCOLOR;
    if (@available(iOS 11.0, *)) {
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    //    self.navigationController.navigationBar.barTintColor = REDCOLOR;
    //    [self.navigationController.navigationBar setTitleTextAttributes:
    //     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
    [self getMsgList];
    //       self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;
}
-(NSMutableArray*)MsgListArr
{
    if (!_MsgListArr) {
        _MsgListArr =[NSMutableArray array];
    }
    return _MsgListArr;
}
-(void)getMsgList
{
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjects:@[self.MessageModel.message_id] forKeys:@[@"id"]];
    [SNAPI getWithURL:@"buyer/invoiceRecordInfo" parameters:dic success:^(SNResult *result) {
       
            self.detailModel =[BillMessageDetailModel mj_objectWithKeyValues:result.data];
            if ([self.detailModel.invoiceType intValue]==0) {
                self.titleArr =@[[NSString stringWithFormat:@"发票类型：%@",[self.MessageModel.invoiceType intValue]?@"增值税专用发票":@"增值税普通发票"],[NSString stringWithFormat:@"发票抬头：%@",self.detailModel.title],[NSString stringWithFormat:@"税号：%@",self.detailModel.taxNo],[NSString stringWithFormat:@"注册地址：%@",self.detailModel.invoiceAddress],[NSString stringWithFormat:@"注册电话：%@",self.detailModel.invoiceTel],];
            }
            else
            {
                self.titleArr =@[[NSString stringWithFormat:@"发票类型：%@",[self.MessageModel.invoiceType intValue]?@"增值税专用发票":@"增值税普通发票"],[NSString stringWithFormat:@"发票抬头：%@",self.detailModel.title],[NSString stringWithFormat:@"税号：%@",self.detailModel.taxNo],[NSString stringWithFormat:@"注册地址：%@",self.detailModel.invoiceAddress],[NSString stringWithFormat:@"注册电话：%@",self.detailModel.invoiceTel],[NSString stringWithFormat:@"开户行：%@",self.detailModel.bankName],[NSString stringWithFormat:@"银行账户：%@",self.detailModel.bankAccount]];
            }
            [self.tableView reloadData];
       
    } failure:^(NSError *error) {
        [MBProgressHUD showError:error.domain];
    }];
}
-(void)loadDataSource:(NSMutableDictionary*)dictionary withpagecount:(NSString *)page
{
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}
/**
 * 初始化假数据
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return self.titleArr.count;
            break;
        case 2:
            return 3;
            break;
        case 3:
            return self.detailModel.list.count;
            break;
        default:
            break;
    }
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        MessageChildCell *cell = [MessageChildCell cellWithTableView:tableView];
        cell.orderLab.text =[NSString stringWithFormat:@"申请单号：%@",self.detailModel.applyNo];
        cell.kpfangLab.text =[NSString stringWithFormat:@"开票方：%@",self.detailModel.kpName];
        cell.timeLab.text =[NSString stringWithFormat:@"申请时间：%@",[SNTool StringTimeFormat:[NSString stringWithFormat:@"%ld",(long)self.detailModel.applyTime]]];
        cell.timeLab.text =[NSString stringWithFormat:@"申请时间：%@",[SNTool StringTimeFormat:self.detailModel.applyTime]];
        
       
        cell.moneyCountLab.text =[NSString stringWithFormat:@"金额：%.2f",self.detailModel.invoiceAmt];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.detailModel.status==0||self.detailModel.status==1||self.detailModel.status==2||self.detailModel.status==3) {
              cell.backBtn.hidden =NO;
            if (self.detailModel.status==0) {
                
                [cell.backBtn setTitle:@"撤回" forState:UIControlStateNormal];
            }else
            {
                [cell.backBtn setTitle:@"作废" forState:UIControlStateNormal];
            }
        }else
        {
             cell.backBtn.hidden =YES;
        }
        cell.cancelBtnBlock = ^{
            if ([cell.backBtn.titleLabel.text isEqualToString:@"已撤回"]) {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                         message:@"确定撤回开票申请吗？"
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定"
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * _Nonnull action)
                                          {
                                              
                                              NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjects:@[self.detailModel.detail_id] forKeys:@[@"id"]];
                                              [SNAPI postWithURL:@"buyer/recall" parameters:dic success:^(SNResult *result) {
                                                  if (_changeInfo) {
                                                      _changeInfo();
                                                  }
                                                  [self.navigationController popViewControllerAnimated:YES];
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
            }else
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                         message:@"确定作废改发票吗？"
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定"
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * _Nonnull action)
                                          {
                                              
                                              NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjects:@[self.detailModel.detail_id] forKeys:@[@"id"]];
                                              [SNAPI postWithURL:@"buyer/cancelInvoice" parameters:dic success:^(SNResult *result) {
                                                  if (_changeInfo) {
                                                      _changeInfo();
                                                  }
                                                  [self.navigationController popViewControllerAnimated:YES];
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
            }
            
        };
        return cell;
    }
    NSArray *titleArr =[NSArray array];
    if (indexPath.section<3&&indexPath.section!=0) {
        static NSString *index =@"cell";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:index];
        if (cell==nil) {
            cell =[[UITableViewCell alloc]initWithStyle:1 reuseIdentifier:index];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
        }
        if (indexPath.section==0) {
           
            titleArr =@[[NSString stringWithFormat:@"开票方：%@",self.detailModel.kpName],[NSString stringWithFormat:@"申请时间：%@",self.detailModel.applyTime],[NSString stringWithFormat:@"金额：%.2f",self.detailModel.invoiceAmt]];
            cell.textLabel.text =titleArr[indexPath.row];
            cell.textLabel.textColor =BLACKCOLOR;
            cell.textLabel.font =DR_FONT(14);
        }else if (indexPath.section==1)
        {
           
            cell.textLabel.text =self.titleArr[indexPath.row];
            cell.textLabel.textColor =BLACKCOLOR;
            cell.textLabel.font =DR_FONT(14);
        }
        else if (indexPath.section==2)
        {
            titleArr =@[[NSString stringWithFormat:@"收票人：%@",self.detailModel.receiverName],[NSString stringWithFormat:@"详细地址：%@",self.detailModel.receiverAddress],[NSString stringWithFormat:@"联系电话：%@",self.detailModel.receiverPhone]];
            cell.textLabel.text =titleArr[indexPath.row];
            cell.textLabel.textColor =BLACKCOLOR;
            cell.textLabel.font =DR_FONT(14);
        }
        return cell;
    }
    self.listModel =[DetailListModel mj_objectWithKeyValues:self.detailModel.list[indexPath.row]];
    BillDetailCell *cell = [BillDetailCell cellWithTableView:tableView];
    cell.listModel = self.listModel;
    cell.detailClickBlock = ^{
        self.listModel =[DetailListModel mj_objectWithKeyValues:self.detailModel.list[indexPath.row]];
        DetailOrdervc *detailVC =[[DetailOrdervc alloc]init];
        detailVC.orderID =self.listModel.orderId;
        [self.navigationController pushViewController:detailVC animated:YES];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)detailBtnClick:(UIButton *)sender
{
    NSLog(@"sender=%ld",(long)sender.tag);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==3) {
        return WScale(220);
    }
    if (indexPath.section==0) {
        return WScale(110);
    }
    return HScale(30);
}
//单元格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==3&&indexPath.row==5) {
        NSLog(@"点点点");
    }   
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HScale(35));
    bgView.backgroundColor = WHITECOLOR;
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15, 0, SCREEN_WIDTH-16, bgView.frame.size.height);
    NSArray *titleArray=  @[@"",@"开票信息",@"收票信息",@"订单信息"];
    label.text =titleArray[section];
    label.font =DR_BoldFONT(14);
    label.textColor = BLACKCOLOR;
    [bgView addSubview:label];
    if (section==0) {
        UILabel *detaillabel = [[UILabel alloc] init];
        detaillabel.frame = CGRectMake(ScreenW/2, 0, SCREEN_WIDTH/2-15, bgView.frame.size.height);
         NSArray *detailArr =@[@"待审核", @"已通过", @"未通过" ,@"已开票",@"已作废",@"已撤回"];
        detaillabel.text =detailArr[self.detailModel.status];
        detaillabel.font =DR_FONT(14);
        detaillabel.textAlignment =2;
        detaillabel.textColor = REDCOLOR;
        [bgView addSubview:detaillabel];
    }
    return bgView;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.01;
    }
   return HScale(35);
}

//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return WScale(10);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
@end

//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "DRDetailSelloutVC.h"
#import "FifthCell.h"
#import "CollectionCell.h"
#import "CustomFooterView.h"
#import "HeadView.h"
#import "AskSellOutVC.h"
#import "ApplicationSaleAfterVC.h"
#import "LSXAlertInputView.h"
#import "AfterSellInfoModel.h"
#import "SellAfterFooterView.h"
#import "PhotoTableViewCell.h"
#import "BSTakePhotoView.h"
#import "GetPicture.h"
#import "InfoTableViewCell.h"
#import "CGXPickerView.h"
#import "ACSelectMediaView.h"
#import "DRShopHomeVC.h"
@interface DRDetailSelloutVC ()<UITableViewDelegate,UITableViewDataSource,HeadViewDelegate>
{
    NSMutableArray *photoArray;  ///<相册数组
    NSMutableArray *selectMuArr;
    NSMutableArray *photoUrlArr;
    NSMutableArray *imgs;  ///<相册数组
    NSString *muIDStr;
    int pageCount;
    BOOL _selectYes;
}
@property(nonatomic,strong)NSMutableArray *images;
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (nonatomic,strong)NSMutableArray *MsgListArr;
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)UITableView*  tableView;
@property (nonatomic,retain)UIButton *footBtn;

@property(nonatomic,strong)NSDictionary* dataDict;
@property(nonatomic,strong)NSArray*  dataArr;
@property(nonatomic,strong)NSMutableArray*   isOpenArr;
@property(nonatomic,strong)NSArray* sectionNameArr,*thirdArr;
@property(nonatomic,strong)NSMutableArray * buyFirstArr;
@property(nonatomic,strong)NSMutableArray * sellFirtArr;
@property(nonatomic,strong)NSMutableArray * buySecondArr,*buyContentArr;
@property(nonatomic,strong)NSMutableArray * sellSecondArr;
@property(nonatomic,strong)NSMutableArray * logisticsArr;

@property (nonatomic, copy) NSString *titleStr,*selectValueStr;
@property (nonatomic,retain)CustomFooterView *customHeadView;
@property (nonatomic,retain)SellAfterFooterView *customfooterView;
@property (nonatomic,retain)AfterSellInfoModel *infoModel;
@property (nonatomic,retain)AfterSellList *goodListModel;

@end

@implementation DRDetailSelloutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"售后进度";
    [self loadSource];
    self.view.backgroundColor =BACKGROUNDCOLOR;
}
-(void)loadTableView
{
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-DRTopHeight-kIPhoneXBottomHeight) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor =BACKGROUNDCOLOR;
    if (@available(iOS 11.0, *)) {
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    //    _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[FifthCell class] forCellReuseIdentifier:@"FifthCell"];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
}
-(void)loadSource
{
    _selectYes =NO;
    photoArray = [[NSMutableArray alloc] init];
    selectMuArr = [[NSMutableArray alloc] init];
    photoUrlArr =[NSMutableArray array];
    _sendDataDictionary =[NSMutableDictionary dictionary];
    //    _sectionNameArr=@[@"客厅"];
    self.isOpenArr=[[NSMutableArray alloc] init];
    // self.dataDict=@{@"first":firstDataArr,@"second":secondArr,@"third":thirdArr};
    //    self.dataArr=@[firstDataArr];
    //for (int i=0; i<self.dataDict.allKeys.count; i++) {
    [self.isOpenArr addObject:@"close"];
    
    [self loadTableView];
    [self addHeadView];
    [self addFooterView];
    [self getMsgList];
    [self getLogistics];
}

/*
 获取物流列表
public static final String BUYER_GETLOGISTICS = Url_Head + "buyer/getLogistics";
提交物流信息
public static final String BUYER_BUYERBACKSEND = Url_Head + "buyer/buyerBackSend";
 */
-(void)getLogistics
{
    [SNAPI getWithURL:@"buyer/getLogistics" parameters:nil success:^(SNResult *result) {
        NSArray *titleArr =result.data;
    
        self.logisticsArr =[NSMutableArray array];
        [self.logisticsArr addObjectsFromArray:titleArr];
//        [self.logisticsArr addObject:@"其他"];
    } failure:^(NSError *error) {
        
    }];
}

-(void)addHeadView
{
    self.customHeadView = [[[NSBundle mainBundle] loadNibNamed:@"CustomFooterView" owner:self options:nil] lastObject];
    self.customHeadView.seleectTypeBtnBlock = ^{
        DRShopHomeVC *detailVC = [DRShopHomeVC new];
       
        detailVC.sellerId=self.infoModel.sellerId;
        [self.navigationController pushViewController:detailVC animated:YES];
    };
    self.tableView.tableHeaderView =self.customHeadView;
}

-(void)addFooterView
{
    
    self.customfooterView = [[[NSBundle mainBundle] loadNibNamed:@"SellAfterFooterView" owner:self options:nil] lastObject];
    DRWeakSelf;
    self.customfooterView.submitBtnBlock = ^{
        if ([weakSelf.sendDataDictionary[@"1"] isEqualToString:@""]) {
            [MBProgressHUD showError:@"请选择或输入物流公司"];
            return ;
        }
        if ([weakSelf.sendDataDictionary[@"2"] isEqualToString:@""]) {
            [MBProgressHUD showError:@"请输入物流单号"];
            return ;
        }
        if ([weakSelf.sendDataDictionary[@"3"] isEqualToString:@""]) {
            [MBProgressHUD showError:@"请输入备注"];
            return ;
        }
        if ([weakSelf.sendDataDictionary[@"4"] isEqualToString:@""]) {
            [MBProgressHUD showError:@"请上传图片"];
            return ;
        }
        NSDictionary *dic =@{@"returnId":self.infoModel.returnOrderId,@"expressComp":self.sendDataDictionary[@"1"],@"expressNo":self.sendDataDictionary[@"2"],@"expressRemark":self.sendDataDictionary[@"3"],@"expressImg":self.sendDataDictionary[@"4"]};
        [SNAPI postWithURL:@"buyer/buyerBackSend" parameters:dic.mutableCopy success:^(SNResult *result) {
            !_cancelBtnBlock?:_cancelBtnBlock();
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            [MBProgressHUD showError:error.domain];
        }];
      
//[4]    (null)    @"expressImg" : @"http://file.cross.echosite.cn/group1/M00/00/20/wKgfhV0R3S-AIfdvAAGYSdt6UlE263.jpg?token=0b8eacf723dfefd8a41b025e9ba58c81&ts=1561451823,http://file.cross.echosite.cn/group1/M00/00/20/wKgfhV0R3S-APCQOAAG-MREvSPw943.jpg?token=cf9cb789d859e746353c300b62210c52&ts=1561451823,http://file.cross.echosite.cn/group1/M00/00/20/wKgfhV0R3S-APOtmAAGOLdDmXaY407.jpg?token=e926900708deff7de2419f405d2a61ac&ts=1561451823"
    };
    self.customfooterView.cancelBtnBlock = ^{
        ///初始化提示框
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"确认取消？"                            preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action)
                                  {                                     
                                      NSDictionary *dic =@{@"returnId":self.infoModel.returnOrderId};
                                      [SNAPI postWithURL:@"buyer/cancelReturnOrder" parameters:dic.mutableCopy success:^(SNResult *result) {
                                          [MBProgressHUD showSuccess:@"取消成功"];
                                          !_cancelBtnBlock?:_cancelBtnBlock();
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
        
    };
   self.tableView.tableFooterView =self.customfooterView;
}

-(void)getMsgList
{
    DRWeakSelf;
    NSDictionary *muDIC =@{@"returnId":self.returnId};
    
    [SNAPI getWithURL:@"buyer/afterSaleInfo" parameters:muDIC.mutableCopy success:^(SNResult *result) {
        
//        if (result.state==200) {
//            NSArray *statusArr =@[@"已取消", @"待审核", @"待付款", @"待发货", @"待收货",@"已完成",@"退货中",@"已退货"];
            weakSelf.infoModel =[AfterSellInfoModel mj_objectWithKeyValues:result.data];
        if ([weakSelf.infoModel.compType intValue]==0) {
            [self.customHeadView.compTypeBtn setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
            [self.customHeadView.compTypeBtn setTitle:@"自营" forState:UIControlStateNormal];
        }else if ([weakSelf.infoModel.compType intValue]==1)
        {
            [self.customHeadView.compTypeBtn setBackgroundImage:[UIImage imageNamed:@"分类购买_08"] forState:UIControlStateNormal];
            [self.customHeadView.compTypeBtn setTitle:@"厂家" forState:UIControlStateNormal];
        }
        else if ([weakSelf.infoModel.compType intValue]==2)
        {
            [self.customHeadView.compTypeBtn setBackgroundImage:[UIImage imageNamed:@"blue-bg"] forState:UIControlStateNormal];
            [self.customHeadView.compTypeBtn setTitle:@"批发商" forState:UIControlStateNormal];
        }
        self.customHeadView.companyLab.text =weakSelf.infoModel.sellerName;
        NSArray *expressTypeArr =@[@"自提",@"物流配送",@"三铁配送"];
        self.customHeadView.contentlAB.text =[NSString stringWithFormat:@"%@  %@  %@",weakSelf.infoModel.storeName,weakSelf.infoModel.orderPayType?@"月结":@"现金",expressTypeArr[[weakSelf.infoModel.expressType intValue]]];
        [SNTool setTextColor:self.customHeadView.contentlAB FontNumber:DR_FONT(12) AndRange:NSMakeRange(weakSelf.infoModel.storeName.length, self.customHeadView.contentlAB.text.length-weakSelf.infoModel.storeName.length) AndColor:REDCOLOR];
        if (self.infoModel.returnOrderStatus==4||self.infoModel.returnOrderStatus==6||self.infoModel.returnOrderStatus==7||self.infoModel.returnOrderStatus==9||self.infoModel.returnOrderStatus==1||self.infoModel.returnOrderStatus==99) {
            self.customfooterView.submitBtn.hidden =YES;
        }
        if (self.infoModel.returnOrderStatus==6||self.infoModel.returnOrderStatus==7||self.infoModel.returnOrderStatus==9) {
            self.customfooterView.cancelBtn.hidden =YES;
        }
            weakSelf.buyFirstArr=[NSMutableArray array];
            weakSelf.sellFirtArr=[NSMutableArray array];
            weakSelf.buySecondArr=[NSMutableArray array];
            weakSelf.buyContentArr=[NSMutableArray array];
            weakSelf.sellSecondArr=[NSMutableArray array];
        NSArray *firstArr=@[[NSString stringWithFormat:@"申请时间：%@",[SNTool StringTimeFormat:weakSelf.infoModel.createTime]?:@""],@"售后类型：申请退货",[NSString stringWithFormat:@"退货原因：%@",weakSelf.infoModel.reason?:@""],[NSString stringWithFormat:@"问题描述：%@",weakSelf.infoModel.message?:@""]];
        [weakSelf.buyFirstArr addObjectsFromArray:firstArr];
        
        NSArray *secondArr =[NSArray array];
        if (self.infoModel.returnOrderStatus!=7) {
            secondArr =@[[NSString stringWithFormat:@"审核时间：%@",[SNTool StringTimeFormat:weakSelf.infoModel.auditTime]?:@""],[NSString stringWithFormat:@"审核说明：%@",weakSelf.infoModel.auditRemark?:@""],[NSString stringWithFormat:@"退货地址：%@",weakSelf.infoModel.returnAddress?:@""],[NSString stringWithFormat:@"联系人：%@",weakSelf.infoModel.returnContacts?:@""],[NSString stringWithFormat:@"联系电话：%@",weakSelf.infoModel.returnPhone?:@""]];
        }
        else
        {
            secondArr =@[[NSString stringWithFormat:@"审核时间：%@",[SNTool StringTimeFormat:weakSelf.infoModel.auditTime]?:@""],[NSString stringWithFormat:@"审核说明：%@",weakSelf.infoModel.auditRemark?:@""]];
        }
        [weakSelf.sellFirtArr addObjectsFromArray:secondArr];
        NSArray *threeArr=@[@"选择物流",@"物流单号",@"备注",@"图片上传"];
        [weakSelf.sendDataDictionary setObject:self.infoModel.expressComp?:@"" forKey:@"1"];
        [weakSelf.sendDataDictionary setObject:self.infoModel.expressNo?:@"" forKey:@"2"];
        [weakSelf.sendDataDictionary setObject:self.infoModel.expressRemark?:@"" forKey:@"3"];
        [weakSelf.sendDataDictionary setObject:self.infoModel.expressImg?:@"" forKey:@"4"];
        [weakSelf.buySecondArr addObjectsFromArray:threeArr];
        if (self.infoModel.returnOrderStatus==99) {
            [weakSelf.sellSecondArr addObject:@"系统提示：请耐心等待物流上门取件！"];
        }
        else
        {
            [weakSelf.sellSecondArr addObject:@"温馨提示：卖家确认收货后，三个工作日，退款退回原支付账户，请注意查收！"];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
    }];
}
-(void)laterClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
    if (self.infoModel.returnOrderStatus==1||self.infoModel.returnOrderStatus==9) {
        return 2;
    }
    if (self.infoModel.returnOrderStatus==7) {
        return 3;
    }
    if (self.infoModel.returnOrderStatus==2||self.infoModel.returnOrderStatus==3||self.infoModel.returnOrderStatus==5||self.infoModel.returnOrderStatus==8) {
        return 4;
    }
    return 5;
}
#pragma mark 表的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.infoModel.returnOrderStatus==1||self.infoModel.returnOrderStatus==9) {
        switch (section) {
            case 0:
            {
                return self.infoModel.goodsList.count;
            }
                break;
            case 1:
                return self.buyFirstArr.count;
                break;
            default:
                break;
        }
    }
    else if (self.infoModel.returnOrderStatus==7) {
        switch (section) {
            case 0:
            {
                return self.infoModel.goodsList.count;
            }
                break;
            case 1:
                return self.buyFirstArr.count;
                break;
            case 2:
                return self.sellFirtArr.count;
                break;
           
            default:
                break;
        }
    }
    else
    {
        switch (section) {
            case 0:
            {
                return self.infoModel.goodsList.count;
            }
                break;
            case 1:
                return self.buyFirstArr.count;
                break;
            case 2:
                return self.sellFirtArr.count;
                break;
            case 3:
                if (self.infoModel.returnOrderStatus==99) {
                    return 0;
                }
                if (self.infoModel.returnOrderStatus==6) {
                    if (self.infoModel.orderReturnWay==2) {
                        return 0;
                    }
                }
                return self.buySecondArr.count;
                break;
            case 4:
                return self.sellSecondArr.count;
                break;
            default:
                break;
        }
    }
    return 0;
}
#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.infoModel.returnOrderStatus==99&&indexPath.section==3) {
        return 0;
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
    if (section==0) {
        return 0.01;
    }
    if (self.infoModel.returnOrderStatus==99&&section==3) {
        return 0.01;
    }
    return WScale(60);
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==1) {
        return WScale(80);
    }
    if (self.infoModel.returnOrderStatus==2||self.infoModel.returnOrderStatus==3||self.infoModel.returnOrderStatus==5||self.infoModel.returnOrderStatus==6||self.infoModel.returnOrderStatus==8)
    {
        if (section==3) {
            if (self.infoModel.orderReturnWay==2) {
                return 5;
            }
            
            return HScale(100);
        }
    }
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        FifthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FifthCell"];
        self.goodListModel =[AfterSellList mj_objectWithKeyValues:self.infoModel.goodsList[indexPath.row]];
        cell.goodModel =self.goodListModel;
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        cell.selectionStyle = 0;
        return cell;
    }
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier: SimpleTableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
   self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    if (indexPath.section==1) {
            cell.textLabel.textColor =BLACKCOLOR;
            cell.textLabel.text = self.buyFirstArr[indexPath.row];
    }
    if (self.infoModel.returnOrderStatus!=1) {
        if (self.infoModel.returnOrderStatus==7) {
            if (indexPath.section==2) {
                cell.textLabel.textColor =BLACKCOLOR;
                cell.textLabel.text = self.sellFirtArr[indexPath.row];
            }
        }
        else
        {
            if (indexPath.section==2) {
                cell.textLabel.textColor =BLACKCOLOR;
                cell.textLabel.text = self.sellFirtArr[indexPath.row];
            }
            if (indexPath.section==3) {
                if (self.infoModel.returnOrderStatus==4||self.infoModel.returnOrderStatus==7||self.infoModel.returnOrderStatus==9||self.infoModel.returnOrderStatus==1)
                {
                    cell.textLabel.text = self.buySecondArr[indexPath.row];
                    cell.textLabel.textColor =BLACKCOLOR;
                }
                else
                {
                    if (self.infoModel.returnOrderStatus==6&&self.infoModel.orderReturnWay==2) {
                        cell.textLabel.text = self.buySecondArr[indexPath.row];
                        cell.textLabel.textColor =BLACKCOLOR;
                    }else
                    {
                        NSArray *titleArray =[NSArray array];
                        NSArray *placeholdArray=[NSArray array];
                        titleArray = @[@"退货数量：",@"退货金额：",@"售后类型：",@"退货原因：",@"问题描述：",@"图片上传"];
                        placeholdArray= @[@"请输入退货数量",@"请输入退货金额",@"请选择售后类型",@"请选择退货原因",@"请描述具体问题",@"*请上传您的图片，能帮助您更好的解决问题"];
                        InfoTableViewCell *cell = [InfoTableViewCell cellWithTableView:tableView];
                        if (indexPath.row==0) {
                            if ([self.selectValueStr isEqualToString:@"其他"]) {
                                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                                cell.contentTF.text =_sendDataDictionary[[NSString stringWithFormat:@"%ld",indexPath.row]]?:@"";
                                cell.contentTF.placeholder = [NSString stringWithFormat:@"请输入%@",self.buySecondArr[indexPath.row]];
                                cell.contentTF.enabled = NO;
                                
                            }else
                            {
                             
                                if (indexPath.row==1) {
                                    cell.accessoryType=UITableViewCellAccessoryNone;
                                     cell.contentTF.enabled = YES;
                                }else
                                {
                                     cell.contentTF.enabled = NO;
                                    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                                }
                                 cell.contentTF.text =_sendDataDictionary[[NSString stringWithFormat:@"%ld",indexPath.row+1]]?:@"";
                            }
                            cell.contentTF.placeholder = [NSString stringWithFormat:@"请输入%@",self.buySecondArr[indexPath.row]];
                        }
                        else if (indexPath.row==self.buySecondArr.count-1)
                        {
                            if (self.infoModel.returnOrderStatus==2||self.infoModel.returnOrderStatus==3||self.infoModel.returnOrderStatus==5||self.infoModel.returnOrderStatus==8||self.infoModel.returnOrderStatus==99)
                            {
                                
                                cell.contentTF.placeholder =@"*请上传图片，能帮助您更好的解决问题";
                            }
                            cell.contentTF.enabled = NO;
                        }else
                        {
                            if ([self.selectValueStr isEqualToString:@"其他"]) {
                                cell.contentTF.text =_sendDataDictionary[[NSString stringWithFormat:@"%ld",indexPath.row]]?:@"";
                                cell.contentTF.placeholder = [NSString stringWithFormat:@"请输入%@",self.buySecondArr[indexPath.row]];
                            }else
                            {
                                cell.contentTF.text =_sendDataDictionary[[NSString stringWithFormat:@"%ld",indexPath.row+1]]?:@"";
                                cell.contentTF.placeholder = [NSString stringWithFormat:@"请输入%@",self.buySecondArr[indexPath.row]];
                            }
                           
                            //                cell.contentTF.text =_sendDataDictionary[@"logistic"]?:@"";
                        }
                        if (self.infoModel.returnOrderStatus==4||self.infoModel.returnOrderStatus==7||self.infoModel.returnOrderStatus==9||self.infoModel.returnOrderStatus==6) {
                            cell.contentTF.enabled =NO;
                            cell.accessoryType=UITableViewCellAccessoryNone;
                        }
                        cell.contentTF.tag = indexPath.row;
                        cell.contentTF.font =DR_FONT(13);
                        cell.titleLabel.text = self.buySecondArr[indexPath.row];
                        [cell.contentTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        return cell;
                    }
                }
            }
            if (indexPath.section==4) {
                cell.textLabel.text =self.sellSecondArr[indexPath.row];
                cell.textLabel.textColor =[UIColor greenColor];
            }            
        }
    }
    cell.textLabel.numberOfLines =0;
    cell.textLabel.font =DR_FONT(12);
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, WScale(60));
    bgView.backgroundColor = WHITECOLOR;
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15, 0, SCREEN_WIDTH/4, bgView.frame.size.height);
    NSArray *titleArray =[NSArray array];
    if (self.infoModel.returnOrderStatus==1||self.infoModel.returnOrderStatus==9) {
        titleArray =  @[@"",@"买家"];
    }
    else if (self.infoModel.returnOrderStatus==7)
    {
        titleArray =  @[@"",@"买家",@"卖家"];
    }
    else if (self.infoModel.returnOrderStatus==99)
    {
        titleArray =  @[@"",@"买家",@"卖家",@"",@"卖家"];
    }
    else if (self.infoModel.returnOrderStatus==6) {
        if (self.infoModel.orderReturnWay==2) {
            titleArray =  @[@"",@"买家",@"卖家",@"卖家",@"卖家"];
        }
        else
        {
            titleArray =  @[@"",@"买家",@"卖家",@"买家",@"卖家"];
        }
    }
    else
    {
        titleArray =  @[@"",@"买家",@"卖家",@"买家",@"卖家"];
    }
    label.text =titleArray[section];
    label.font =DR_BoldFONT(15);
    label.textColor = BLACKCOLOR;
    [bgView addSubview:label];
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.frame = CGRectMake(SCREEN_WIDTH/4, 0,3*SCREEN_WIDTH/4-DCMargin, bgView.frame.size.height);
    NSArray *detailArr =[NSArray array];
    if (self.infoModel.returnOrderStatus==1||self.infoModel.returnOrderStatus==9) {
        detailArr =  @[@"",@"您申请了售后"];
    }
    else if (self.infoModel.returnOrderStatus==7)
    {
        detailArr =  @[@"",@"您申请了售后",@"审核不通过"];
    }
    else if (self.infoModel.returnOrderStatus==99)
    {
        detailArr =@[@"",@"您申请了售后",@"卖家同意了申请售后",@"",@"上门取件"];
    }
    else if (self.infoModel.returnOrderStatus==6) {
        if (self.infoModel.orderReturnWay==2) {
          detailArr =@[@"",@"您申请了售后",@"卖家同意了申请售后",@"上门取件",@"卖家确认收货"];
        }
        else
        {
            NSString*secondDetailStr;
            if (self.infoModel.auditTime.length==0) {
                secondDetailStr =@"";
            }
            else
            {
                secondDetailStr =@"卖家同意了申请售后";
            }
            NSString*thirdDetailStr;
            if (self.infoModel.expressTime.length==0) {
                thirdDetailStr =@"";
            }
            else
            {
                thirdDetailStr =[NSString stringWithFormat:@"回寄时间：%@",[SNTool StringTimeFormat:self.infoModel.expressTime]?:@""];
            }
            NSString*fourDetailStr;
            if (self.infoModel.returnOrderStatus>=6) {
                fourDetailStr =@"卖家确认收货";
            }
            else
            {
                fourDetailStr =@"";
            }
            detailArr =  @[@"",@"您申请了售后",secondDetailStr,thirdDetailStr,fourDetailStr];
        }
    }
    else
    {
        NSString*secondDetailStr;
        if (self.infoModel.auditTime.length==0) {
            secondDetailStr =@"";
        }
        else
        {
            secondDetailStr =@"卖家同意了申请售后";
        }
        NSString*thirdDetailStr;
        if (self.infoModel.expressTime.length==0) {
            thirdDetailStr =@"";
        }
        else
        {
            thirdDetailStr =[NSString stringWithFormat:@"回寄时间：%@",[SNTool StringTimeFormat:self.infoModel.expressTime]?:@""];
        }
        NSString*fourDetailStr;
        if (self.infoModel.returnOrderStatus>=6) {
            fourDetailStr =@"卖家确认收货";
        }
        else
        {
            fourDetailStr =@"";
        }
        detailArr =  @[@"",@"您申请了售后",secondDetailStr,thirdDetailStr,fourDetailStr];
    }
    detailLabel.text =detailArr[section];
    detailLabel.font =DR_BoldFONT(14);
    detailLabel.textColor = REDCOLOR;
    detailLabel.textAlignment =NSTextAlignmentRight;
    [bgView addSubview:detailLabel];
    return bgView;
}
//
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==1) {
     
        UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, WScale(80))];
   
        backView.backgroundColor =WHITECOLOR;

     
        NSArray *imgArrCount = [self.infoModel.imgs componentsSeparatedByString:@","];
        
        if (imgArrCount.count!=0) {
            for (int i=0; i<imgArrCount.count; i++) {
                UIImageView *iconIMG =[[UIImageView alloc]initWithFrame:CGRectMake(WScale(15)+(WScale(60)+WScale(15))*i, WScale(10), WScale(60), WScale(50))];
                [iconIMG sd_setImageWithURL:[NSURL URLWithString:imgArrCount[i]]];
//                [iconIMG sd_setImageWithURL:[NSURL URLWithString:imgArrCount[i]] placeholderImage:[UIImage imageNamed:@"comm_loading_01"]];
//                UIButton * imgBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//
//                imgBtn.frame=CGRectMake(WScale(15)+(WScale(60)+WScale(15))*i,WScale(10), WScale(60), WScale(60));
//                [imgBtn sd_setBackgroundImageWithURL:  forState:UIControlStateNormal];
//                imgBtn.enabled =NO;
                [backView addSubview:iconIMG];
                
            }
        }
        return backView;
    }    
   if (self.infoModel.returnOrderStatus==2||self.infoModel.returnOrderStatus==3||self.infoModel.returnOrderStatus==5||self.infoModel.returnOrderStatus==8){
       if (section==3) {
           CGFloat height = [ACSelectMediaView defaultViewHeight];
           UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, height)];
           //2、初始化
           ACSelectMediaView *mediaView = [[ACSelectMediaView alloc] initWithFrame:CGRectMake(0, 0, bgView.frame.size.width, bgView.frame.size.height)];
           //3、随时获取新的布局高度
            NSString *fourStr =self.sendDataDictionary[@"4"];
           if (fourStr.length!=0) {
                mediaView.defaultIMGArr =[self.sendDataDictionary[@"4"] componentsSeparatedByString:@","].mutableCopy;
           }
           [mediaView observeViewHeight:^(CGFloat value) {
               bgView.height = value;
           }];
           //4、随时获取已经选择的媒体文件
           [mediaView observeSelectedMediaArray:^(NSArray<ACMediaModel *> *list) {
               //有问题，在数据有图片的时候，修改图片有问题
               NSMutableArray *imageArr =[NSMutableArray array];
               NSMutableArray *sourceimageArr =[NSMutableArray array];
             muIDStr=[NSString string];
               for (ACMediaModel *model in list) {
                   NSLog(@"%@",model);
                   if (model.sourceImage.length==0) {
                       [imageArr addObject:model.image];
                   }else
                   {
                        [sourceimageArr addObject:model.sourceImage];
                        muIDStr =[muIDStr stringByAppendingString:[model.sourceImage stringByAppendingString:@","]];
                   }
               }
               if (imageArr.count!=0) {
                   [SNAPI uploadAvatar:imageArr nickName:nil success:^(SNResult *result) {
                       if (muIDStr.length!=0) {
                           
                           muIDStr =[muIDStr stringByAppendingString:[result.data[@"src"] stringByAppendingString:@","]];
                           [self.sendDataDictionary setObject:muIDStr forKey:@"4"];
                       }else
                       {
                           
                           [self.sendDataDictionary setObject:result.data[@"src"] forKey:@"4"];
                       }
//                       [self.tableView reloadData];
                       //                [self.tableView reloadData];
                   } failure:^(NSError *error) {
                       
                   }];
               }else
               {
                   [self.sendDataDictionary setObject:@"" forKey:@"4"];
               }
               
               if (sourceimageArr.count!=0) {

                   [self.sendDataDictionary setObject:muIDStr forKey:@"4"];
               }
           }];
           [bgView addSubview:mediaView];
           return bgView;
       }
   } else
   {
       if (section==3) {
           UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScale(100))];
           backView.backgroundColor =WHITECOLOR;
           NSArray *imgArr =[self.sendDataDictionary[@"4"] componentsSeparatedByString:@","];
           float width = (SCREEN_WIDTH - 5*WScale(15))/4;
           float space = WScale(15);
           for (int i=0; i<imgArr.count; i++) {
               UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(space+(width+space)*i, WScale(15), width, width)];
               [imageView sd_setImageWithURL:[NSURL URLWithString:imgArr[i]]];
               [backView addSubview:imageView];
           }
           return backView;
       }
   }
        return [UIView new];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.infoModel.returnOrderStatus==2||self.infoModel.returnOrderStatus==3||self.infoModel.returnOrderStatus==5||self.infoModel.returnOrderStatus==6||self.infoModel.returnOrderStatus==8||self.infoModel.returnOrderStatus==99)
    {
        if (indexPath.section==3) {
            if (indexPath.row==0&&self.logisticsArr.count!=0) {
                NSMutableArray *nameArr =[NSMutableArray array];
                for (NSDictionary *dic  in self.logisticsArr) {
                    [nameArr addObject:dic[@"name"]];
                }
                [nameArr addObject:@"其他"];
                [CGXPickerView showStringPickerWithTitle:@"选择物流" DataSource:nameArr DefaultSelValue:[nameArr firstObject] IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
                    NSLog(@"%@",selectValue);
                    if ([selectValue isEqualToString:@"其他"]) {
                        
                        if (![self.buySecondArr containsObject:@"物流名称"]) {
                            
                            [self.buySecondArr insertObject:@"物流名称" atIndex:1];
                        }
                         [self.sendDataDictionary setObject:selectValue forKey:@"0"];
                        
                    }else
                    {
                        
                        if ([self.buySecondArr containsObject:@"物流名称"]) {
                            
                            [self.buySecondArr removeObjectAtIndex:1];
                        }
                        [self.sendDataDictionary setObject:selectValue forKey:@"1"];
                    }
                    self.selectValueStr =selectValue;
                    [self.tableView reloadData];
                    
                }];
                
            }
            
        }
    }
}

-(void)textFieldChangeAction:(UITextField *)textField
{
    [_sendDataDictionary setValue:textField.text forKey:[NSString stringWithFormat:@"%ld",textField.tag+1]];
}
-(void)ClickSection:(UIButton*)sender
{
    NSString*  state=[self.isOpenArr objectAtIndex:sender.tag-100];
    if ([state isEqualToString:@"open"]) {
        state=@"close";
    }else
    {
        state=@"open";
    }
    self.isOpenArr[sender.tag-100]=state;
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:sender.tag-100];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}


@end

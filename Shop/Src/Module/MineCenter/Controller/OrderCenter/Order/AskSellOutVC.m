//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "AskSellOutVC.h"
#import "FourthCell.h"
#import "CollectionCell.h"
#import "DetailHeadView.h"
#import "CustomFooterView.h"
#import "HeadView.h"
#import "InfoTableViewCell.h"
#import "CGXPickerView.h"
#import "SelectPhotoView.h"
#import "PhotoTableViewCell.h"
#import "BSTakePhotoView.h"
#import "GetPicture.h"
#import "ACSelectMediaView.h"
#import "DRShopHomeVC.h"
#import "ReturnRuleVC.h"
@interface AskSellOutVC ()<UITableViewDelegate,UITableViewDataSource,HeadViewDelegate>
{
    NSMutableArray *photoArray;  ///<相册数组
    NSMutableArray *photoUrlArr;
    
    float height;
     int pageCount;
}
@property(nonatomic,strong)NSMutableArray *images;
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (nonatomic,strong)NSMutableArray *MsgListArr;
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)UITableView*  tableView;
@property (weak, nonatomic) IBOutlet UIButton *saleOutBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *againBuyBtn;
@property (nonatomic,retain)UIButton *footBtn;
@property (nonatomic,retain)UIButton *pZBtn;
@property (nonatomic,retain)UIButton *fPZBtn;
@property (strong, nonatomic) SelectPhotoView *footerView;
@property (weak, nonatomic) IBOutlet UIView *nomelView;
@property (weak, nonatomic) IBOutlet UIView *fPZView;
@property (weak, nonatomic) IBOutlet UIView *pZView;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UILabel *returnFPZLab;
@property(nonatomic,strong)NSDictionary* dataDict;
@property(nonatomic,strong)NSArray*  dataArr;
@property(nonatomic,strong)NSMutableArray*   isOpenArr;
@property(nonatomic,strong)NSArray* sectionNameArr;
@property(nonatomic,strong)NSMutableArray * messageArr;
@property(nonatomic,strong)NSMutableArray * resoverArr;
@property(nonatomic,strong)NSMutableArray * peisongArr;
@property(nonatomic,strong)NSMutableArray * payArr;
@property(nonatomic,strong)NSMutableArray * numCountArr,*sourcemuArr,*returnResionArr;

@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic,retain)DetailHeadView *customHeadView;
@property (nonatomic,retain)GoodModel *goodModel;
@property (nonatomic,retain)NSString *allCountStr,*allMoneyCountStr,*isSourTypeStr,*isReturnStr;
@property(nonatomic,assign) float  allPrice,allNumber;
@end

@implementation AskSellOutVC
-(NSMutableDictionary *)sendDataDictionary
{
    if (!_sendDataDictionary) {
        _sendDataDictionary =[NSMutableDictionary dictionaryWithObject:@"Wechat" forKey:@"sourceType"];
    }
    return _sendDataDictionary;
}

- (IBAction)btnClick:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"申请售后";
    photoArray = [[NSMutableArray alloc] init];
    photoUrlArr =[NSMutableArray array];
    _numCountArr =[NSMutableArray array];
    _returnResionArr =[NSMutableArray array];
    [self loadSource];
    self.view.backgroundColor =BACKGROUNDCOLOR;
}
-(void)loadTableView
{
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-DRTopHeight-kIPhoneXBottomHeight) style:UITableViewStyleGrouped];
    
    self.tableView.backgroundColor =BACKGROUNDCOLOR;
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor =LINECOLOR;
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, WScale(10), 0, WScale(10))];
    }
    [_tableView registerClass:[FourthCell class] forCellReuseIdentifier:@"FourthCell"];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    [self addfooterView];
//    self.commitBtn.layer.cornerRadius =self.commitBtn.dc_height/2;
//     self.tableView.tableFooterView =self.footerView;
    
}
-(void)addfooterView
{
    self.footerView = [[[NSBundle mainBundle] loadNibNamed:@"SelectPhotoView" owner:self options:nil] lastObject];
    [SNTool setTextColor:self.footerView.contentLab FontNumber:DR_FONT(12) AndRange:NSMakeRange(self.footerView.contentLab.text.length-7, 7) AndColor:BLACKCOLOR];
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [self.footerView.contentLab addGestureRecognizer:tap];
    [tap addTarget:self action:@selector(clickcontentLab:)];
    DRWeakSelf;
    self.footerView.commitBtnBlock = ^{
        NSString *str =weakSelf.sendDataDictionary[@"isQuality"];
        if (str.length==0) {
            [MBProgressHUD showError:@"请选择售后类型"];
            return;
        }
        
        NSString *Resonstr =weakSelf.sendDataDictionary[@"reason"];
        if (Resonstr.length==0) {
            [MBProgressHUD showError:@"请选择退货原因"];
            return;
        }
        NSString *messagestr =weakSelf.sendDataDictionary[@"message"];
        if (messagestr.length==0) {
            [MBProgressHUD showError:@"请描述具体原因"];
            return;
        }
        NSString *urlStr =weakSelf.sendDataDictionary[@"imgUrl"];
        if (urlStr.length==0) {
            [MBProgressHUD showError:@"请上传至少一张图片"];
            return;
        }
        NSMutableArray *listArr =[NSMutableArray array];
        for (NSDictionary *dict in weakSelf.sellOutModel.goodsList) {
            NSDictionary *dic =@{@"orderGoodsId":dict[@"orderGoodsId"]?:@"",@"qty":[NSString stringWithFormat:@"%@",dict[@"qty"]]?:@""};
            [listArr addObject:dic];
        }
        NSDictionary *dic =@{@"orderId":weakSelf.sellOutModel.orderId?:@"",@"ruleId":weakSelf.sendDataDictionary[@"reason"]?:@"",@"isQuality":weakSelf.sendDataDictionary[@"isQuality"]?:@"",@"message":weakSelf.sendDataDictionary[@"message"]?:@"",@"imgs":weakSelf.sendDataDictionary[@"imgUrl"]?:@""};
        
        NSMutableDictionary *mudic =[NSMutableDictionary dictionaryWithObject:[SNTool jsontringData:listArr] forKey:@"goodsArray"];
        [mudic addEntriesFromDictionary:dic];
        
        ///初始化提示框
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"申请退货可能会产生额外的扣费，您确定要申请吗？"                                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action)
                                  {
            [SNAPI postWithURL:@"buyer/applyAfterSale" parameters:mudic success:^(SNResult *result) {
                if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
                    [MBProgressHUD showSuccess:@"申请成功"];
                    [self.tableView.mj_header beginRefreshing];
                    [self performSelector:@selector(back) withObject:self afterDelay:1];
                }
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
    self.tableView.tableFooterView =self.footerView;
   
   
}
- (void)clickcontentLab:(UITapGestureRecognizer *)tap
{
    [self.navigationController pushViewController:[ReturnRuleVC new] animated:YES];
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
    [self getReturnListSource:@"1"];
   
}
-(void)getReturnListSource:(NSString *)typeStr
{
    NSMutableDictionary *mudic =[NSMutableDictionary dictionaryWithObjects:@[self.senderDic[@"orderId"],typeStr] forKeys:@[@"orderId",@"categoryId"]];
    [SNAPI getWithURL:@"buyer/getReturnOrderRuleList" parameters:mudic success:^(SNResult *result) {
        self.returnResionArr =result.data;
        
    } failure:^(NSError *error) {
        
    }];
}
-(void)addHeadView
{
    self.customHeadView = [[[NSBundle mainBundle] loadNibNamed:@"DetailHeadView" owner:self options:nil] lastObject];    
    self.tableView.tableHeaderView =self.customHeadView;
}
-(void)getMsgList
{
    DRWeakSelf;
//    NSDictionary *muDIC =@{@"id":self.sellOutModel.order_id,@"orderGoodsId":self.sellOutModel.goodsList};
    [SNAPI getWithURL:@"buyer/applyAfterSaleInfo" parameters:self.senderDic success:^(SNResult *result) {
        
      
            NSArray *statusArr =@[@"已取消", @"待审核", @"待付款", @"待发货", @"待收货",@"已完成",@"退货中",@"已退货"];
            weakSelf.sellOutModel =[AskSellOutModel mj_objectWithKeyValues:result.data];
             _sourcemuArr =[NSMutableArray array];
            NSArray *modelArr =[GoodModel mj_objectArrayWithKeyValuesArray:self.sellOutModel.goodsList];
            [_sourcemuArr addObjectsFromArray:modelArr];
            [weakSelf.sendDataDictionary setObject:weakSelf.sellOutModel.orderId forKey:@"orderId"];
            
            NSMutableDictionary *mudic =[NSMutableDictionary dictionary];
            NSMutableArray *muArr =[NSMutableArray array];
            for (NSDictionary *dic in weakSelf.sellOutModel.goodsList) {
                [mudic setObject:dic[@"id"] forKey:@"orderGoodsId"];
                [mudic setObject:[NSString stringWithFormat:@"%@",dic[@"qty"]] forKey:@"qty"];
                [muArr addObject:mudic];
            }
            [weakSelf.sendDataDictionary setObject:muArr forKey:@"goodsArray"];
            
            self.customHeadView.statusLab.text =statusArr[weakSelf.sellOutModel.status];
            if (self.sellOutModel.status==0) {
//                self.customHeadView.statusLab.textColor =REDCOLOR;
            }
            else
            {
//                self.customHeadView.statusLab.textColor =RGBHex(0x00cd00);
            }
            self.customHeadView.orderLab.text =[NSString stringWithFormat:@"订单号：%@",self.sellOutModel.orderNo];
            self.customHeadView.timeLab.text =[NSString stringWithFormat:@"下单时间：%@",[SNTool StringTimeFormat:[NSString stringWithFormat:@"%ld",(long)self.sellOutModel.createTime]]];
            
        NSArray *contentArr =@[@"尊敬的用户，您的订单已取消！",@"尊敬的用户，请耐心等待审核！", @"尊敬的用户，您的订单未付款，请您先付款！", @"尊敬的用户，您的订单已经审核成功，请您耐心等待发货！", @"尊敬的用户，您的订单已经出库，请您耐心等待！",@"尊敬的用户，您的订单已完成！",@"尊敬的用户，您的订单已经审核成功，请您耐心等待发货！",@"尊敬的用户，您的商品已经退货！"];
        NSArray *imgArr =@[@"personal_bg_yiquxiao daishenghe", @"personal_bg_yiquxiao daishenghe", @"personal_bg_daifukuan", @"personal_bg_daifahuo tuihuozhong", @"personal_bg_daishouhuo",@"personal_bg_yiwancheng yishouhuo",@"personal_bg_daifahuo tuihuozhong",@"personal_bg_yiwancheng yishouhuo"];
            self.customHeadView.contentLab.text =contentArr[self.sellOutModel.status];
            self.customHeadView.iconIMG.image =[UIImage imageNamed:imgArr[self.sellOutModel.status]];
            if (self.sellOutModel.status==0) {
                
                //                [SNTool compareOneDay: [SNTool dateFromString:[NSString stringWithFormat:@"%ld",(long)self.sellOutModel.confirmTime]] withAnotherDay:[SNTool dateFromString:[SNTool ddpGetExpectTimestamp:0 month:0 day:-1]]];
                //                NSLog(@"111%@222%@333%@444%@",[SNTool dateFromString:[NSString stringWithFormat:@"%ld",(long)self.sellOutModel.confirmTime]],[SNTool dateFromString:[NSString stringWithFormat:@"%ld",(long)self.sellOutModel.confirmTime]],[SNTool ddpGetExpectTimestamp:0 month:0 day:-1],[SNTool dateFromString:[SNTool ddpGetExpectTimestamp:0 month:0 day:-1]]);
                
            }
            for (int i =0; i<self.sourcemuArr.count;i++) {
                self.goodModel =self.sourcemuArr[i];
                self.goodModel.numModelStr =[NSString stringWithFormat:@"%.3f",self.goodModel.canReturnQty];
            }
            [self CalculationPriceAndCountNumber];
            [self.tableView reloadData];
       
    } failure:^(NSError *error) {
        
    }];
}
-(void)CalculationPriceAndCountNumber
{
    self.allCountStr=nil;
    self.allMoneyCountStr=nil;
    self.allNumber =0.000f;
    self.allPrice = 0.000f;
    for (int i =0; i<self.sourcemuArr.count;i++) {
       self.goodModel =self.sourcemuArr[i];
        self.allNumber =self.allNumber +[self.goodModel.numModelStr doubleValue];
        self.allPrice =self.allPrice +self.goodModel.realPrice*[self.goodModel.numModelStr doubleValue];
        
        
    }
    self.allCountStr =[NSString stringWithFormat:@"%.3f", self.allNumber];
    self.allMoneyCountStr=[NSString stringWithFormat:@"￥%.3f",self.allPrice];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:1 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath,indexPath1] withRowAnimation:UITableViewRowAnimationNone];
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
    if (section==0) {
        NSString*  state=[self.isOpenArr objectAtIndex:section];
        if ([state isEqualToString:@"open"])
        {
            // NSString*  key=[self.dataDict.allKeys objectAtIndex:section];
            //   NSArray*  arr=[self.dataDict objectForKey:key];
            //                NSArray*  arr=[self.dataArr objectAtIndex:section];
            return self.sourcemuArr.count+1;
        }
        return 2;
    }
    else if (section==1)
    {
        return 7;
    }
    return 0;
}
#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        return WScale(40);
    }
    if (indexPath.section==1&&indexPath.row==5) {
        return WScale(80);
    }
    if (indexPath.section==2) {
        return HScale(80);
    }
    
    //    if (indexPath.section==1||indexPath.section==3||indexPath.section==4) {
    //        return HScale(25);
    //    }
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section==0) {
//        return 0.01;
//    }
//    if (section==1) {
//        if (self.sellOutModel.message.length==0) {
//            return 0.01;
//        }
//    }
//    return HScale(35);
    return WScale(10);
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0&&self.sourcemuArr.count>1) {
        return 40;
    }
    if (section==1) {
        return HScale(100);
    }
    if (section==0) {
        return 10;
    }
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        NSString*  state=[self.isOpenArr objectAtIndex:indexPath.section];
        if (indexPath.row==0) {
            CollectionCell8 *cell =[CollectionCell8 cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.sellOutModel =self.sellOutModel;
            return cell;
        }
        else
        {
            if ([state isEqualToString:@"open"])
            {
                self.goodModel =self.sourcemuArr[indexPath.row-1];
                self.goodModel.numModelStr =[NSString stringWithFormat:@"%.3f",self.goodModel.canReturnQty];
            }
            else
            {
                self.goodModel =self.sourcemuArr[0];
                self.goodModel.numModelStr =[NSString stringWithFormat:@"%.3f",self.goodModel.canReturnQty];
            }
            FourthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FourthCell"];
            cell.selectRow =indexPath.row;
            if (self.sourcemuArr.count!=0) {
                
                cell.goodModel =self.goodModel;
                cell.sellOutModel =self.sellOutModel;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.numberBlock = ^(NSString * _Nonnull numberStr, NSInteger selectRow){
                
                self.goodModel =self.sourcemuArr[indexPath.row-1];
                self.goodModel.numModelStr =numberStr;
                [self CalculationPriceAndCountNumber];
            };
            cell.saleOutClickBlock = ^{
                
            };
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }
    
    else
    {
        if (indexPath.row==5) {
            InfoTableViewCell8 *cell =[InfoTableViewCell8 cellWithTableView:tableView];
            return cell;
        }
        NSArray *titleArray =[NSArray array];
        NSArray *placeholdArray=[NSArray array];
        titleArray = @[@"退货数量：",@"退货金额：",@"售后类型：",@"退货类型",@"退货原因",@"",@"图片上传"];
        placeholdArray= @[@"请输入退货数量",@"请输入退货金额",@"请选择售后类型",@"请选择退货类型",@"请选择退货原因",@"",@"*请上传您的图片，能帮助您更好的解决问题"];
        InfoTableViewCell *cell = [InfoTableViewCell cellWithTableView:tableView];
        if (indexPath.row==2||indexPath.row==4) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row==0||indexPath.row==1||indexPath.row==2||indexPath.row==3||indexPath.row==4||indexPath.row==6) {
            cell.contentTF.enabled = NO;
            if (indexPath.row==0||indexPath.row==1||indexPath.row==2||indexPath.row==4) {
                NSArray *countArr=@[self.allCountStr?:@"",self.allMoneyCountStr?:@"",self.isSourTypeStr?:@"",@"",self.isReturnStr?:@""];
                cell.contentTF.textColor =REDCOLOR;
                cell.contentTF.text =countArr[indexPath.row];
            }
            if (indexPath.row==2||indexPath.row==4) {
                cell.contentTF.textColor =BLACKCOLOR;
               
                
            }
            
        }
        
        
        cell.titleLabel.text = titleArray[indexPath.row];
        cell.titleLabel.font = DR_FONT(14);
        cell.contentTF.textAlignment =2;
        cell.contentTF.placeholder = placeholdArray[indexPath.row];
        cell.contentTF.tag = indexPath.row;
        cell.contentTF.font =DR_FONT(14);
        if (indexPath.row==6) {
            
            cell.contentTF.text = self.sendDataDictionary[@"message"];
        }
        if (indexPath.row==3) {
            cell.contentTF.text =@"";
            cell.contentTF.placeholder =@"";
            
            self.pZBtn =[UIButton buttonWithLeftImage:@"login_ico_ check_default" title:@"品质类" font:DR_FONT(14) titleColor:BLACKCOLOR backGroundColor:CLEARCOLOR target:self action:@selector(pinzhiBtnClick:) showView:cell.contentView];
            self.pZBtn.tag =1;
            [self.pZBtn setImage:[UIImage imageNamed:@"login_ico_ check_click"] forState:UIControlStateSelected];
            self.pZBtn.frame =CGRectMake(ScreenW/2-10, 0, ScreenW/4, WScale(40));
            self.pZBtn.selected =YES;
            [self.pZBtn layoutButtonWithEdgeInsetsStyle:LXButtonEdgeInsetsStyleLeft imageTitleSpace:WScale(7)];
            self.fPZBtn =[UIButton buttonWithLeftImage:@"login_ico_ check_default" title:@"非品质类" font:DR_FONT(14) titleColor:BLACKCOLOR backGroundColor:CLEARCOLOR target:self action:@selector(pinzhiBtnClick:) showView:cell.contentView];
            self.fPZBtn.tag =0;
            [self.fPZBtn setImage:[UIImage imageNamed:@"login_ico_ check_click"] forState:UIControlStateSelected];
            self.fPZBtn.frame =CGRectMake(3*ScreenW/4-10, 0, ScreenW/4, WScale(40));
            [self.fPZBtn layoutButtonWithEdgeInsetsStyle:LXButtonEdgeInsetsStyleLeft imageTitleSpace:WScale(7)];
        }
        
        [cell.contentTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
}
-(void)pinzhiBtnClick:(UIButton *)sender
{
    if (sender ==self.pZBtn) {
        self.pZBtn.selected =YES;
        self.fPZBtn.selected =NO;
    }
    else
    {
        self.pZBtn.selected =NO;
        self.fPZBtn.selected =YES;
    }
    [self getReturnListSource:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
}
///cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            NSLog(@"%ld",(long)indexPath.section);
            DRShopHomeVC *detailVC = [DRShopHomeVC new];
            detailVC.sellerId=self.sellOutModel.sellerId;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
    }
    if (indexPath.section==1) {
        if (indexPath.row==2)
        {
            
            [CGXPickerView showStringPickerWithTitle:@"售后类型" DataSource:@[@"退货"] DefaultSelValue:@"退货" IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                [_sendDataDictionary setObject:@"0" forKey:@"isQuality"];
                self.isSourTypeStr =@"退货";
                 [self.tableView reloadRow:2 inSection:1 withRowAnimation:UITableViewRowAnimationNone];
                
            }];
        }
        else if (indexPath.row==4)
        {
         
            NSMutableArray *titleArr =[NSMutableArray array];
            for (NSDictionary *dic in self.returnResionArr) {
                [titleArr addObject:dic[@"reason"]];
            }
            DRWeakSelf;
            [CGXPickerView showStringPickerWithTitle:@"退货原因" DataSource:titleArr.copy DefaultSelValue:[titleArr firstObject] IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                NSString *selectID =self.returnResionArr[[selectRow integerValue]][@"id"];
                [weakSelf.sendDataDictionary setObject:selectID forKey:@"reason"];
                self.isReturnStr =selectValue;
                
                 [self.tableView reloadRow:4 inSection:1 withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
        
    }

}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==0&&self.sellOutModel.goodsList.count>1) {
        UIView*  sectionBackView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        sectionBackView.backgroundColor=[UIColor whiteColor];
        UIButton*  button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        button.tag=100+section;
        button.titleLabel.font =[UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        if ([[_isOpenArr objectAtIndex:section] isEqualToString:@"open"]) {
            [button setImage:[UIImage imageNamed:@"arrow_right_grey"] forState:UIControlStateNormal];
            [button setTitle:[NSString stringWithFormat:@"收起全部(%lu)",(unsigned long)self.sellOutModel.goodsList.count] forState:UIControlStateNormal];
        }
        else if ([[_isOpenArr objectAtIndex:section] isEqualToString:@"close"]) {
            [button setImage:[UIImage imageNamed:@"arrow_down_grey"] forState:UIControlStateNormal];
            [button setTitle:[NSString stringWithFormat:@"查看全部(%lu)",(unsigned long)self.sellOutModel.goodsList.count] forState:UIControlStateNormal];
        }
        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
        [button addTarget:self action:@selector(ClickSection:) forControlEvents:UIControlEventTouchUpInside];
        [sectionBackView addSubview:button];
        return sectionBackView;
    }
    if (section==1) {
        CGFloat height = [ACSelectMediaView defaultViewHeight];
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, height)];
        //2、初始化
        ACSelectMediaView *mediaView = [[ACSelectMediaView alloc] initWithFrame:CGRectMake(0, 0, bgView.frame.size.width, bgView.frame.size.height)];
        //3、随时获取新的布局高度
        [mediaView observeViewHeight:^(CGFloat value) {
            bgView.height = value;
        }];
        //4、随时获取已经选择的媒体文件
        [mediaView observeSelectedMediaArray:^(NSArray<ACMediaModel *> *list) {
            NSMutableArray *imageArr =[NSMutableArray array];
            for (ACMediaModel *model in list) {
                NSLog(@"%@",model);
                [imageArr addObject:model.image];
            }            
            if (imageArr.count!=0) {
                
                [SNAPI uploadAvatar:imageArr nickName:nil success:^(SNResult *result) {
                    [self.sendDataDictionary setObject:result.data[@"src"] forKey:@"imgUrl"];
                    //                [self.tableView reloadData];
                } failure:^(NSError *error) {
                    
                }];
            }else
            {
                 [self.sendDataDictionary removeObjectForKey:@"imgUrl"];
            }
        }];
        [bgView addSubview:mediaView];
        return bgView;
    }
    return nil;
}

#pragma mark 拍照按钮的点击事件
-(void)photoBtnClick:(UIButton *)button
{
    [self.view endEditing:YES];
    [[GetPicture sharedInstance] initPhotePickerWithController:[UIApplication sharedApplication].delegate.window.rootViewController selectMaxNum:3 containArr:@[] keyTag:@"" delegate:self];
}
#pragma mark 图片删除按钮的点击事件
-(void)deleteButtonClick2:(UIButton *)button
{
    [photoArray removeObjectAtIndex:button.tag];
//NSArray *imgArr = [[self.sendDataDictionary objectForKey:@"imgUrl"] componentsSeparatedByString:@","];
//    
//    [self.sendDataDictionary removeObjectForKey:@"imgUrl"]
    
    // [photo_upArray removeObjectAtIndex:button.tag];
    NSMutableArray *ImgArr =[self.sendDataDictionary[@"imgUrl"] componentsSeparatedByString:@","].mutableCopy;
    [ImgArr removeObjectAtIndex:button.tag];
    NSString *selectName= @"";
    for (NSString *urlStr in ImgArr) {
        selectName = [selectName stringByAppendingString:[NSString stringWithFormat:@"%@,",urlStr]];
    }
    [self.sendDataDictionary setObject:selectName forKey:@"imgUrl"];
    [self.tableView reloadData];
}

#pragma mark - 获取图片
- (void)getPictureResult:(NSArray *)pictureArr keyTag:(NSString *)keyTag
{
    self.images = [[NSMutableArray  alloc] init];
    for (int i = 0; i< pictureArr.count; i++) {
        
        UIImage* headImg = pictureArr[i][1];
        [photoArray addObject:headImg];
        
        NSData *imgData = UIImageJPEGRepresentation(headImg, 0.2f);
        NSString *imgStr = [imgData base64EncodedStringWithOptions:0];
        [self.images addObject:imgStr];
    }
    if (photoArray.count >3) {
        photoArray = [[photoArray subarrayWithRange:NSMakeRange(0, 3)] mutableCopy];
    }
    
    NSData *imgData = UIImageJPEGRepresentation(pictureArr[0][1], 0.2f);
    
    NSString *imgsStr;
    for (NSString *Str in photoArray) {
        imgsStr =[NSString stringWithFormat:@"%@,%@",imgsStr?:@"",Str];
    }
    [_sendDataDictionary setObject:imgsStr forKey:@"imgs"];
    [self.tableView reloadData];
    [SNAPI uploadAvatar:photoArray nickName:nil success:^(SNResult *result) {
         [self.sendDataDictionary setObject:result.data[@"src"] forKey:@"imgUrl"];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
    
        
    }];
   
    
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
-(void)textFieldChangeAction:(UITextField *)textField
{
    [self.sourDic setValue:textField.text forKey:[NSString stringWithFormat:@"%ld",textField.tag]];
    if (textField.tag==4) {
        [_sendDataDictionary setObject:textField.text forKey:@"message"];
    }
}

-(void)back
{
    !_refreshSourceBlock?:_refreshSourceBlock();
    [self.navigationController popViewControllerAnimated:YES];
}

@end

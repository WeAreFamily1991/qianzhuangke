//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "BillApplicationDetailVC.h"
#import "FirstTableViewCell.h"
#import "CollectionCell.h"
#import "UIViewExt.h"
#import "ShoppingCarCell.h"
#import "BillApplicationModel.h"
#import "OrderModel.h"
#import "DetailOrdervc.h"
#import "ShoopingCartBottomView.h"
#import "SaleOrderCell.h"
@interface BillApplicationDetailVC ()<UITableViewDelegate,UITableViewDataSource,ShoopingCartBottomViewDelegate,ShoppingCarCellDelegate>
{
    int pageCount;
    NSString *idStr;
}
@property (nonatomic,strong)NSMutableArray *MsgListArr,*smallArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic,strong) UIButton *selectAllBtn;//全选按钮
@property (nonatomic,strong) UIButton *jieSuanBtn;//结算按钮
@property (nonatomic,strong) UILabel *totalMoneyLab;//合计（元）
@property (nonatomic,retain)BillApplicationModel *applicationModel;
@property (nonatomic,retain)ShoppingModel *model;
@property(nonatomic,assign) float allPrice;
@property (nonatomic,retain)DCUpDownButton *bgTipButton ;
@property (nonatomic, strong) NSMutableArray *selectedShop;//选中的商品数组
@property (nonatomic, strong) ShoopingCartBottomView *bottomView;
@end
@implementation BillApplicationDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BACKGROUNDCOLOR;
    [self.view addSubview:self.bgTipButton];
    
   _sendDataDictionary = [NSMutableDictionary dictionaryWithObjects:@[self.sendDataDictionary[@"startTime"]?:@"",self.sendDataDictionary[@"endTime"]?:@"",self.sendDataDictionary[@"dzNo"]?:@""] forKeys:@[@"startTime",@"endTime",@"keyWord"]];
//    self.tableView.frame =CGRectMake(0, 80, SCREEN_WIDTH, self.tableView.height - 120-DRTopHeight);
//    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor =BACKGROUNDCOLOR;
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.MsgListArr = [[NSMutableArray alloc]init];
    
//    self.navigationController.navigationBar.barTintColor = REDCOLOR;
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.allPrice = 0.00;
    if (self.status==0) {
        self.tableView.height =self.tableView.height-60;
       

    }
  
    [self getMsgList];
    [_tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"FirstTableViewCell"];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"record" object:nil];
//       self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;
}
- (void)notificationHandler:(NSNotification *)notification {
    if ([notification.name isEqualToString:@"record"]) {
        NSDictionary *dic =notification.userInfo;
        
        if ([dic[@"index"] intValue]==3) {
            [_sendDataDictionary setObject:dic[@"dzNo"]?:@"" forKey:@"keyWord"];
            
        }else
        {
            [_sendDataDictionary setObject:dic[@"startTime"]?:@"" forKey:@"startTime"];
            [_sendDataDictionary setObject:dic[@"endTime"]?:@"" forKey:@"endTime"];
            
        }
        [self getMsgList];
    }
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"record" object:nil];
}
-(void)getMsgList
{
    //    [MBProgressHUD showMessage:@""];
    [self loadDataSource:_sendDataDictionary withpagecount:[NSString stringWithFormat:@"%d",pageCount]];
}

-(void)loadDataSource:(NSMutableDictionary*)dictionary withpagecount:(NSString *)page
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *urlStr ;
    if (self.status == 0 || self.status == 3) {
        urlStr = @"buyer/invoiceAbleList";
        if (self.status==0) {
            
            [dic setObject:@"0" forKey:@"status"];
        }
        else
        {
            [dic setObject:@"1" forKey:@"status"];
        }
    }
    else
    {
        if (self.status==1) {
            
            [dic setObject:@"0" forKey:@"status"];
        }
        else
        {
            [dic setObject:@"3" forKey:@"status"];
        }
        urlStr = @"buyer/inReviewInvoice";
    }
    if (page) {
        [dic setObject:@"1" forKey:@"pageNum"];
        [dic setObject:@"10" forKey:@"pageSize"];
    }
    if (dictionary) {
        [dic addEntriesFromDictionary:dictionary];
    }
    DRWeakSelf;
    [MBProgressHUD showMessage:@""];
    [SNAPI getWithURL:urlStr parameters:dic success:^(SNResult *result) {
        NSLog(@"data=%@",result.data[@"list"]);
        NSArray *listArr =result.data[@"list"];
        weakSelf.MsgListArr =[NSMutableArray array];
        weakSelf.smallArr =[NSMutableArray array];
        NSMutableArray *shoppingCartArray = [[NSMutableArray alloc] init];
        for (NSDictionary *shop in listArr) {
           BillApplicationModel *aModel =[[BillApplicationModel alloc]init];
            aModel.compId =shop[@"sellerId"];
             aModel.compType =shop[@"compType"];
             aModel.sellerName =shop[@"sellerName"];
             aModel.kpName =shop[@"kpName"];
            NSArray *orderListArr =shop[@"list"];
            //存储商品模型的数组
            NSMutableArray *goosArray = [[NSMutableArray alloc] init];
            for (NSDictionary *goodsDict in orderListArr)
            {
                ShoppingModel *goodsModel = [[ShoppingModel alloc] init];
                goodsModel.orderNo = goodsDict[@"orderNo"];
                goodsModel.createTime = [goodsDict[@"createTime"] integerValue];
                goodsModel.orderAmt = [goodsDict[@"orderAmt"] doubleValue];
                goodsModel.returnedAmt = goodsDict[@"returnedAmt"];
                 goodsModel.realAmt = goodsDict[@"realAmt"];
                goodsModel.canReturnAmt = [goodsDict[@"canReturnAmt"] doubleValue];
                goodsModel.isSelected = [goodsDict[@"isSelected"] integerValue];
                goodsModel.application_id =goodsDict[@"id"];
                goodsModel.orderId =goodsDict[@"orderId"];
                [goosArray addObject:goodsModel];
            }
            
            aModel.orderList = goosArray;
            [shoppingCartArray addObject:aModel];
        }
      [weakSelf.MsgListArr addObjectsFromArray:shoppingCartArray];
        [weakSelf.tableView reloadData];
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    self.bgTipButton.hidden = (_MsgListArr.count > 0) ? YES : NO;
    return self.MsgListArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.applicationModel =self.MsgListArr[section];
    return self.applicationModel.orderList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    self.applicationModel =self.MsgListArr[indexPath.section];
    self.model =self.applicationModel.orderList[indexPath.row];
    if (self.status==0) {
        static NSString *cellStr = @"ShopCarCell";
        ShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if(!cell)
        {
            cell = [[ShoppingCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
            cell.delegate = self;
        }
        cell.indexPath = indexPath;
        //    cell.detailBtn.tag =indexPath.section;
        cell.selectClickBlock = ^{
            NSLog(@"sender=%ld",(long)indexPath.section);
            self.applicationModel =self.MsgListArr[indexPath.section];
            self.model =self.applicationModel.orderList[indexPath.row];
            DetailOrdervc *detailVC =[[DetailOrdervc alloc]init];
            detailVC.orderID =self.model.orderId;
            [self.navigationController pushViewController:detailVC animated:YES];
        };
        //    [cell.detailBtn addTarget:self action:@selector(detailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.shoppingModel = self.model;
        NSArray *typeArr =@[@"可开票",@"审核中",@"已开票",@"已过期"];
        cell.typeRightLab.text =typeArr[self.status];
        if (self.status==1||self.status==2) {
            cell.orderPriceLab.text = [NSString stringWithFormat:@"单据金额：%.2f",self.model.orderAmt];
            NSString *longStr =[NSString stringWithFormat:@"%.2f",self.model.orderAmt];
            [SNTool setTextColor:cell.orderPriceLab FontNumber:DR_FONT(12) AndRange:NSMakeRange(5,longStr.length) AndColor:REDCOLOR];
        }else
        {
            cell.orderPriceLab.text = [NSString stringWithFormat:@"单据金额：%.2f",[self.model.realAmt doubleValue]];
            NSString *longStr =[NSString stringWithFormat:@"%.2f",[self.model.realAmt doubleValue]];
            [SNTool setTextColor:cell.orderPriceLab FontNumber:DR_FONT(12) AndRange:NSMakeRange(5,longStr.length) AndColor:REDCOLOR];
        }
        
        [self caculatePrice:self.model];
        if (self.status==0) {
            cell.selectBtn.hidden =NO;
        }
        else
        {
            cell.selectBtn.hidden =YES;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    SaleOrderCell5 *cell =[SaleOrderCell5 cellWithTableView:tableView];
    cell.shoppingModel =self.model;
    NSArray *typeArr =@[@"可开票",@"审核中",@"已开票",@"已过期"];
    cell.orderStstus.text =typeArr[self.status];
    cell.detailClickBlock = ^{
               NSLog(@"sender=%ld",(long)indexPath.section);
               self.applicationModel =self.MsgListArr[indexPath.section];
               self.model =self.applicationModel.orderList[indexPath.row];
               DetailOrdervc *detailVC =[[DetailOrdervc alloc]init];
               detailVC.orderID =self.model.orderId;
               [self.navigationController pushViewController:detailVC animated:YES];
           };
    return cell;
    
    
}
-(void)rightbuttonClick:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://4006185027"]];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.status==0) {
        return WScale(167);
    }
    return WScale(300);
}
//单元格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
   
}
#pragma mark - ShoopingCartBottomViewDelegate
//全选
- (void)allGoodsIsSelected:(BOOL)selccted withButton:(UIButton *)btn {
    //修改数据源数据，刷新列表
    [self.selectedShop removeAllObjects];
    
        
    
    for (BillApplicationModel *shopModel in self.MsgListArr) {
        shopModel.isSelected = selccted;
        for (ShoppingModel *goodsModel in shopModel.orderList) {
            goodsModel.isSelected = selccted;
            if (selccted) {
                
                [self.selectedShop addObject:goodsModel];
            }
        }
    }
    
    
    [self.tableView reloadData];
}
//结算
- (void)paySelectedGoods:(UIButton *)btn {
    NSLog(@"结算，选中的商品有：\n ");
   
    NSMutableArray *muArr =[NSMutableArray array];
    for (ShoppingModel *goods in self.selectedShop) {
       
        [muArr addObject:goods.application_id];
    }
    idStr=nil;
    idStr = [muArr componentsJoinedByString:@","];
   
    NSDictionary *dic =@{@"ids":idStr};
    [SNIOTTool postWithURL:@"buyer/applyInvoice" parameters:[dic mutableCopy] success:^(SNResult *result) {
        
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            [self.selectedShop removeAllObjects];
            [MBProgressHUD showSuccess:@"申请成功"];
            [self performSelector:@selector(late) withObject:self afterDelay:1];
           
        }
        
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:error.domain];
    }];
}
-(void)late
{
     [self getMsgList];
}
#pragma mark - ShoppingCartCellDelegate
-(void)cell:(ShoppingCarCell *)cell selected:(BOOL)isSelected indexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section:%ld row:%ld isSelected:%d",indexPath.section,indexPath.row,isSelected);
    //更新选中cell的section下的数据
    self.applicationModel = self.MsgListArr[indexPath.section];
    ShoppingModel *goodsModel = self.applicationModel.orderList[indexPath.row];
    goodsModel.isSelected = isSelected;
    //判断整个section是不是全被选中
    BOOL sectionSelected = YES;
    for (ShoppingModel *goodsModel in self.applicationModel.orderList) {
        if (!goodsModel.isSelected) {
            sectionSelected = NO;
        }
    }
    self.applicationModel.isSelected = sectionSelected;
    NSLog(@"all section selected:%d",sectionSelected);
    
    //#warning 数据源多的时候，刷新section时，页面会出现bug
    //    NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:indexPath.section];
    //    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView reloadData];
}
#pragma mark - 自定义
- (void)caculatePrice:(ShoppingModel *)goodsModel{
    @synchronized (self.selectedShop)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (goodsModel.isSelected) {
                if (![self.selectedShop containsObject:goodsModel]) {
                    [self.selectedShop addObject:goodsModel];
                }
            }
            else {
                if ([self.selectedShop containsObject:goodsModel]) {
                    [self.selectedShop removeObject:goodsModel];
                }
            }
            
            NSDecimalNumber *allPriceDecimal = [NSDecimalNumber zero];
            for (ShoppingModel *goods in self.selectedShop) {
                NSString *orderAmt =[NSString stringWithFormat:@"%.2f",goods.canReturnAmt];
                NSDecimalNumber *decimalPrice = [NSDecimalNumber decimalNumberWithString:orderAmt];
                allPriceDecimal = [allPriceDecimal decimalNumberByAdding:decimalPrice];
            }
            NSString *allPriceStr = [allPriceDecimal stringValue];
            NSLog(@"合计（元）：%@",allPriceStr);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([allPriceStr floatValue]>0) {
                    [self.bottomView setPayEnable:YES];
                    self.bottomView.allPriceLabel.text = [NSString stringWithFormat:@"合计（元）：￥%@",[allPriceDecimal stringValue]];
                } else {
                    [self.bottomView setPayEnable:NO];
                    self.bottomView.allPriceLabel.text = @"合计（元）：￥0.00";
                    
                }
                [SNTool setTextColor:self.bottomView.allPriceLabel FontNumber:DR_FONT(15) AndRange:NSMakeRange(4, self.bottomView.allPriceLabel.text.length-4) AndColor:REDCOLOR];
            });
        });
    }
}

//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HScale(60);
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.applicationModel = self.MsgListArr[section];
    CollectionCell3 *cell =[CollectionCell3 cellWithTableView:tableView];
    cell.applicationModel =self.applicationModel;
    return cell;
   
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
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
- (NSMutableArray *)selectedShop {
    if (!_selectedShop) {
        _selectedShop = [[NSMutableArray alloc] init];
    }
    return _selectedShop;
}
#pragma mark - set/get
- (ShoopingCartBottomView *)bottomView {
    if (!_bottomView) {
//        if (self.status==0) {
//            self.tableView.height =self.tableView.height-60;
//        }
        _bottomView = [[ShoopingCartBottomView alloc] initWithFrame:CGRectMake(0, self.tableView.height, ScreenW, 50)];
        _bottomView.delegate = self;
         [self.view addSubview:self.bottomView];
    }
    NSLog(@"%d",kIPhoneXBottomHeight);
    return _bottomView;
}
@end

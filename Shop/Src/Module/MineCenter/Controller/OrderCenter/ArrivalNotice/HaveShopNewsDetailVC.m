//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "HaveShopNewsDetailVC.h"
#import "CollectionCell.h"
#import "SixCell.h"
#import "CatgoryDetailCell.h"
#import "DRShopHomeVC.h"
@interface HaveShopNewsDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    int pageCount;
}
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (nonatomic,strong)NSMutableArray *MsgListArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic,assign)NSInteger selectIndex;
@property (nonatomic,retain)GoodsModel *goodsModel;


@property (nonatomic,retain)DCUpDownButton *bgTipButton;
@end

@implementation HaveShopNewsDetailVC
-(NSMutableArray *)MsgListArr
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"到货通知";
    self.view.backgroundColor =BACKGROUNDCOLOR;
    [self.view addSubview:self.bgTipButton];
//    self.tableView.frame =CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.height );
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
       self.tableView.separatorColor =LINECOLOR;
     if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
     {
         [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, WScale(10), 0, WScale(10))];
     }
    [_tableView registerClass:[SixCell class] forCellReuseIdentifier:@"SixCell"];
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
}
-(void)getMsgList
{
    if (!_sendDataDictionary) {
        _sendDataDictionary = [[NSMutableDictionary alloc] init];
    }
    //    [MBProgressHUD showMessage:@""];
    [self loadDataSource:_sendDataDictionary withpagecount:[NSString stringWithFormat:@"%d",pageCount]];
}
-(void)loadDataSource:(NSMutableDictionary*)dictionary withpagecount:(NSString *)page
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *urlStr;
    urlStr =@"buyer/getItem";
    if (page) {
        [dic setObject:page forKey:@"pageNum"];
        [dic setObject:@"10" forKey:@"pageSize"];
    }
    [dic setObject:@"arrival_notice" forKey:@"queryType"];
    DRWeakSelf;
    [MBProgressHUD showMessage:@""];
    [SNAPI getWithURL:urlStr parameters:dic success:^(SNResult *result) {
            NSLog(@"data=%@",result.data[@"list"]);
            NSMutableArray*addArr=result.data[@"list"];
            NSMutableArray *modelArray =[GoodsModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
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
    return self.MsgListArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return WScale(60);
            break;
        case 1:
            if (self.MsgListArr.count!=0) {
                
                self.goodsModel=self.MsgListArr[indexPath.section];
                if (_goodsModel.kpName.length==0) {
                    return 0;
                }
            }
            return 0;
            break;
        
        case 2:
            return UITableViewAutomaticDimension;
            break;
            
        case 3:
            return WScale(50);
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
    return WScale(10);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WScale(10))];
    //自定义颜色
    view.backgroundColor = BACKGROUNDCOLOR;
    return view;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.MsgListArr.count!=0) {
        self.goodsModel=self.MsgListArr[indexPath.section];
        switch (indexPath.row) {
          
            case 0:
                
            {
                 CollectionCell3 *cell =[CollectionCell3 cellWithTableView:tableView];
                 cell.goodsModel =self.goodsModel;
                 return cell;
            }
                break;
            case 2:
                
            {
                SixCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SixCell"];

                cell.haveShopModel =self.goodsModel;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
                break;
            case 3:                
            {
                CatgoryDetailCell3 *cell =[CatgoryDetailCell3 cellWithTableView:tableView];
                cell.goodsModel =self.goodsModel;
                cell.daohuoTongzhiStr =@"1";
                cell.shoucangStr =@"1";
                cell.cancelBtn.hidden =NO;
                cell.cancelBlock = ^(NSInteger canceltag) {
                    NSMutableDictionary *mudic =[NSMutableDictionary dictionaryWithObject:self.goodsModel.arrivalNoticeId forKey:@"id"];
                    [SNIOTTool deleteWithURL:@"buyer/deleteArrivalNotice" parameters:mudic success:^(SNResult *result) {
                        if (result.state==200) {
                            [self.tableView.mj_header beginRefreshing];
                        }
                        
                    } failure:^(NSError *error) {
                        
                    }];
                };
                cell.shoucangBlock = ^(NSInteger shoucangtag) {
                    NSDictionary *dic =@{@"id":self.goodsModel.goods_id};
                    [SNIOTTool deleteWithURL:@"buyer/cancelItemFavorite" parameters:[dic mutableCopy] success:^(SNResult *result) {
                        [MBProgressHUD showSuccess:result.data];
                        [self.tableView.mj_header beginRefreshing];
                    } failure:^(NSError *error) {
                    
                    }];                    
                };
                cell.shopCarBlock = ^(NSInteger shopCartag) {
                    [self.tableView.mj_header beginRefreshing];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.section);
    if (indexPath.row==0) {
        DRShopHomeVC *detailVC = [DRShopHomeVC new];
        self.goodsModel=self.MsgListArr[indexPath.section];
        detailVC.sellerId=self.goodsModel.sellerId;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}
@end

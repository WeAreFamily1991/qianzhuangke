//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "CollectionDetailVC.h"
#import "CollectionCell.h"
#import "SixCell.h"
#import "GoodsModel.h"
#import "CatgoryDetailCell.h"
#import "DRAddShopModel.h"
#import "DRShopHomeVC.h"
#import "DRNullGoodModel.h"
#import "ShopCollectCell.h"
@interface CollectionDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    int pageCount;
}
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (nonatomic,strong)NSMutableArray *MsgListArr;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic,assign)NSInteger selectIndex;
@property (nonatomic,retain)GoodsModel *goodsModel;
@property (nonatomic,retain)FavoriteModel *favoriModel;
@property (nonatomic,retain)DRAddShopModel *addShopModel;

@property (nonatomic,retain)DCUpDownButton *bgTipButton;
@end

@implementation CollectionDetailVC

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
    self.title =self.status?@"店铺收藏":@"商品收藏";
    [self.view addSubview:self.bgTipButton];
//    self.tableView.frame =CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.height);
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
    self.tableView.separatorStyle  =UITableViewCellSeparatorStyleSingleLine;
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
-(void)getSingleItem
{
    NSMutableDictionary *mudic =[NSMutableDictionary dictionaryWithObjects:@[self.goodsModel.sellerId,self.goodsModel.goods_id,self.goodsModel.storeId] forKeys:@[@"sellerId",@"id",@"storeId"]];
    [SNAPI getWithURL:@"mainPage/getSingleItem" parameters:mudic success:^(SNResult *result) {
        
    } failure:^(NSError *error) {
        
    }];
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
    NSString *urlStr ;
        
    if (self.status==0) {
        urlStr =@"buyer/getItem";
        if (page) {
            [dic setObject:page forKey:@"pageNum"];
            [dic setObject:@"10" forKey:@"pageSize"];
        }
         [dic setObject:@"favorite" forKey:@"queryType"];
    }
    else
    {
         urlStr =@"buyer/favoriteSellerList";
        if (page) {
            [dic setObject:page forKey:@"pageNum"];
            [dic setObject:@"10" forKey:@"pageSize"];
        }
        [dic setObject:@"" forKey:@"name"];
    }
    if (dictionary) {
        [dic addEntriesFromDictionary:dictionary];
    }
    DRWeakSelf;
//    [MBProgressHUD showMessage:@""];
    [SNAPI getWithURL:urlStr parameters:dic success:^(SNResult *result) {
        if (self.status==0) {
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
        }else
        {
            NSLog(@"data=%@",result.data[@"list"]);
            NSMutableArray*addArr=result.data[@"list"];
            NSMutableArray *modelArray =[FavoriteModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
            [weakSelf.MsgListArr addObjectsFromArray:modelArray];
            [self.tableView reloadData];
            if (addArr.count<10){
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            else{
                [self.tableView.mj_footer endRefreshing];
            }
        }
        [self.tableView.mj_header endRefreshing];
//        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
//        [MBProgressHUD hideHUD];
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
        [_bgTipButton setImage:[UIImage imageNamed:@"quesheng_zanwushiyongjilu"] forState:UIControlStateNormal];
        _bgTipButton.titleLabel.font = DR_FONT(13);
        [_bgTipButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_bgTipButton setTitle:@"暂无数据" forState:UIControlStateNormal];
        _bgTipButton.frame = CGRectMake((ScreenW - 150) * 1/2 , (ScreenH - 150) * 1/2-100, 150, 150);
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
    if (self.status==1) {
        return WScale(110);
    }
    switch (indexPath.row) {
        case 0:
            if ([self.goodsModel.sellerTypeCode intValue]==0)
            {
                 return WScale(60);
            }else
            {
                return WScale(60);
            }
           
            break;
        case 1:
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
    return WScale(10);
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.status==1) {
        return 1;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.MsgListArr.count!=0) {
        
        if (self.status==1) {

            ShopCollectCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ShopCollectCell"];
            if (!cell) {
                cell =  [[NSBundle mainBundle]loadNibNamed:@"ShopCollectCell" owner:self options:nil].firstObject;
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
            }
            cell.favorteModel =self.MsgListArr[indexPath.section];
            cell.cancelBlock = ^{
                [SNTool alertViewWithTitle:@"确定取消收藏店铺" withMessage:nil withSureBtn:@"确定" withCancelBtn:@"取消" withViewController:self success:^(UIAlertAction * _Nonnull action) {
                    self.favoriModel=self.MsgListArr[indexPath.section];
                    NSDictionary *dic =@{@"id":self.favoriModel.favorite_id};
                    [SNIOTTool deleteWithURL:@"buyer/cancelSellerFavorite" parameters:[dic mutableCopy] success:^(SNResult *result) {
                        [MBProgressHUD showSuccess:@"取消成功"];
                    } failure:^(NSError *error) {
                        
                    }];
                    [self.tableView.mj_header beginRefreshing];
                } failure:^(UIAlertAction * _Nonnull action) {
                    
                }];
            };
            return cell;
        }
        self.goodsModel=self.MsgListArr[indexPath.section];
        switch (indexPath.row) {
            case 0:                
            {
                self.goodsModel=self.MsgListArr[indexPath.section];
                //                 if ([self.goodsModel.sellerTypeCode intValue]==0)
                //                 {
                CollectionCell3 *cell =[CollectionCell3 cellWithTableView:tableView];
                cell.goodsModel =self.goodsModel;
                return cell;
                //                 }else
                //                 {
                //                     CollectionCell7 *cell =[CollectionCell7 cellWithTableView:tableView];
                //                     cell.goodsModel =self.goodsModel;
                //                     return cell;
                //                 }
               
            }
                break;
          
            case 2:
                
            {
                SixCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SixCell"];
                cell.goodsModel =self.goodsModel;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
                break;
            case 3:
                
            {
                CatgoryDetailCell3 *cell =[CatgoryDetailCell3 cellWithTableView:tableView];
                self.goodsModel=self.MsgListArr[indexPath.section];
                cell.goodsModel =self.goodsModel;
                cell.shoucangStr =@"1";
                cell.cancelBlock = ^(NSInteger shoucangtag) {
                    [SNTool alertViewWithTitle:@"确定取消收藏商品" withMessage:nil withSureBtn:@"确定" withCancelBtn:@"取消" withViewController:self success:^(UIAlertAction * _Nonnull action) {
                        self.goodsModel=self.MsgListArr[indexPath.section];
                        NSDictionary *dic =@{@"id":self.goodsModel.favouriteId};
                        [SNIOTTool deleteWithURL:@"buyer/cancelItemFavorite" parameters:[dic mutableCopy] success:^(SNResult *result) {
                            [MBProgressHUD showSuccess:@"取消成功"];
                            
                        } failure:^(NSError *error) {
                            
                        }];
                        [self.tableView.mj_header beginRefreshing];
                    } failure:^(UIAlertAction * _Nonnull action) {
                    
                    }];
                  
                };
                cell.shopCarBlock = ^(NSInteger shopCartag) {
              
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WScale(10))];
    //自定义颜色
    view.backgroundColor = BACKGROUNDCOLOR;
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.section);
    if (self.status==1) {
        DRShopHomeVC *detailVC = [DRShopHomeVC new];
        self.favoriModel=self.MsgListArr[indexPath.section];
        detailVC.sellerId=self.favoriModel.sellerId;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else
    {
        if (indexPath.row==0) {
            DRShopHomeVC *detailVC = [DRShopHomeVC new];
            self.goodsModel=self.MsgListArr[indexPath.section];
            detailVC.sellerId=self.goodsModel.sellerId;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
    }
   
}

@end

//
//  DRSameLookVC.m
//  Shop
//
//  Created by BWJ on 2019/5/5.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRSameLookMoreVC.h"
#import "MoreDropDownMenu.h"
#import "SecondCell.h"
#import "GoodsCell.h"
#import "CatgoryDetailCell.h"
#import "DRNullGoodModel.h"
#import "DRSameModel.h"
#import "DRShopHomeVC.h"
@interface DRSameLookMoreVC ()<MoreDropDownMenuDataSource,MoreDropDownMenuDelegate>
{
    int pageCount;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray               *cates;
@property (nonatomic, strong) NSMutableArray               *catesID;

@property (nonatomic, strong) NSMutableArray               *states;
@property (nonatomic, strong) NSMutableArray               *statesID;
@property (nonatomic, strong) NSMutableArray               *sorts;
@property (nonatomic, strong) MoreDropDownMenu       *menu;
@property (nonatomic,retain)DCUpDownButton *bgTipButton;
@property (nonatomic,strong)NSMutableArray <DRSameModel *> *sameArr;
@property (weak, nonatomic) IBOutlet UIImageView *headerIMG;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@end

@implementation DRSameLookMoreVC
- (void)viewDidLoad {
    [super viewDidLoad];
    _sameArr =[NSMutableArray array];
    _sendDataDictionary = [NSMutableDictionary dictionaryWithObjects:@[@"wechat",[DRUserInfoModel sharedManager].locationCode?:@"",@"2",@"",self.nullGoodModel.levelId?:@"",self.nullGoodModel.surfaceId?:@"",self.nullGoodModel.materialId?:@"",self.nullGoodModel.lengthId?:@"",@"",self.nullGoodModel.standardId?:@"",@""] forKeys:@[@"sourceType",@"districtId",@"burstType",@"sellerId",@"levelId",@"surfaceId",@"materialId",@"lengthId",@"diameterId",@"standardId",@"dcType"]];
    [self.view addSubview:self.bgTipButton];
    self.title =@"更多相似";
    //    [self addSegentView];
    [self getBurstRelationCondition];
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    _tableView.backgroundColor =BACKGROUNDCOLOR;
    [_tableView registerClass:[SecondCell class] forCellReuseIdentifier:@"SecondCell"];
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakSelf.sameArr.count) {
            [weakSelf.sameArr removeAllObjects];
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
    [self addTableViewHeaderView];
}
-(void)getBurstRelationCondition
{
    NSDictionary *dic =@{@"sellerId":self.nullGoodModel.sellerId,@"levelId":self.nullGoodModel.levelId?:@"",@"surfaceId":self.nullGoodModel.surfaceId?:@"",@"materialId":self.nullGoodModel.materialId?:@"",@"standardId":self.nullGoodModel.standardId?:@"",@"burstType":@"1"};
    [SNAPI getWithURL:@"burst/getBurstRelationCondition" parameters:[dic mutableCopy] success:^(SNResult *result) {
        
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            self.cates =[NSMutableArray arrayWithObject:@"直径"];
            self.catesID =[NSMutableArray arrayWithObject:@""];
            self.states =[NSMutableArray arrayWithObject:@"长度"];
            self.statesID =[NSMutableArray arrayWithObject:@""];
            NSArray *zjListArr =result.data[@"zjList"];
            if (zjListArr.count) {
                
                for (NSDictionary *dic in result.data[@"zjList"])
                {
                    [self.cates addObject:dic[@"name"]];
                    [self.catesID addObject:dic[@"id"]];
                }
            }
            NSArray *cdListArr =result.data[@"cdList"];
            if (cdListArr.count) {
                
                for (NSDictionary *dic in result.data[@"cdList"])
                {
                    [self.states addObject:dic[@"name"]];
                    [self.statesID addObject:dic[@"id"]];
                }
            }
            
            _menu = [[MoreDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:40];
            _menu.delegate = self;
            _menu.dataSource = self;
            //当下拉菜单收回时的回调，用于网络请求新的数据
            [self.view addSubview:_menu];
            _menu.finishedBlock=^(MoreIndexPath *indexPath){
                if (indexPath.item >= 0) {
                    NSLog(@"收起:点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
                }else {
                    
                    if (indexPath.column==0) {
                        [_sendDataDictionary setObject:self.catesID[indexPath.row] forKey:@"diameterId"];
                    }
                    else
                    {
                        [_sendDataDictionary setObject:self.statesID[indexPath.row] forKey:@"lengthId"];
                    }
                    
                    [self.tableView.mj_header beginRefreshing];
                    NSLog(@"收起:点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
                }
            };
            //            [_menu selectIndexPath:[MoreIndexPath indexPathWithCol:1 row:1]];
            [self.headerIMG sd_setImageWithURL:[NSURL URLWithString:self.nullGoodModel.img]];
            self.titleLab.text =self.nullGoodModel.itemName;
            self.contentLab.text =[NSString stringWithFormat:@"%@ %@",_nullGoodModel.levelName?:@"",_nullGoodModel.surfaceName?:@""];
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)addSegentView
{
    self.cates = @[@"全部",@"服饰",@"搭配",@"数码",@"餐厨",@"出行",@"文具",@"居家",@"品牌",@"全部",@"服饰",@"搭配",@"数码",@"餐厨",@"出行",@"文具",@"居家",@"品牌",];
    self.states = @[@"预热中",@"预售中",@"预售失败",@"成功结束"];
    //    self.sorts = @[@""];
    
    _menu = [[MoreDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:40];
    _menu.delegate = self;
    _menu.dataSource = self;
    //当下拉菜单收回时的回调，用于网络请求新的数据
    [self.view addSubview:_menu];
    _menu.finishedBlock=^(MoreIndexPath *indexPath){
        if (indexPath.item >= 0) {
            NSLog(@"收起:点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
        }else {
            NSLog(@"收起:点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
        }
    };
    [_menu selectIndexPath:[MoreIndexPath indexPathWithCol:1 row:1]];
    [self.headerIMG sd_setImageWithURL:[NSURL URLWithString:self.nullGoodModel.img]];
    self.titleLab.text =self.nullGoodModel.brandName;
    self.contentLab.text =[NSString stringWithFormat:@"%@ %@",_nullGoodModel.levelName?:@"",_nullGoodModel.surfaceName?:@""];
}
-(void)addTableViewHeaderView
{
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    backView.backgroundColor =WHITECOLOR;
//    UILabel *titleLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
//    titleLab.textColor =REDCOLOR;
//    titleLab.textAlignment =1;
//    titleLab.font =DR_BoldFONT(15);
//    titleLab.text =@"————  相似产品推荐  ————";
//    [backView addSubview:titleLab];
    UIView *topLineView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 1)];
    topLineView.backgroundColor =BACKGROUNDCOLOR;
    [backView addSubview:topLineView];
    UIImageView *iconIMG =[[UIImageView alloc]initWithFrame:CGRectMake(DCMargin, 19-HScale(15)/2,HScale(15),HScale(15))];
    iconIMG.image =[UIImage imageNamed:@"店铺"];
    [backView addSubview:iconIMG];
    UILabel *comLab =[[UILabel alloc]initWithFrame:CGRectMake(iconIMG.dc_right+5, 1,ScreenW/2, 38)];
    comLab.textColor =BLACKCOLOR;
    comLab.textAlignment =0;
    comLab.font =DR_BoldFONT(14);
    comLab.text =self.sameModel.kpName;
    [backView addSubview:comLab];
    UIButton *buttonBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    buttonBtn.frame =CGRectMake(ScreenW-DCMargin-WScale(60), 1, WScale(60), 38);
    buttonBtn.titleLabel.font =DR_FONT(13);
    [buttonBtn setTitle:@"进入店铺" forState:UIControlStateNormal];
    buttonBtn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
    [buttonBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [buttonBtn addTarget:self action:@selector(buttonBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:buttonBtn];
    self.tableView.tableHeaderView =backView;
    UIView *bottomLineView =[[UIView alloc]initWithFrame:CGRectMake(0, 39, ScreenW, 1)];
    bottomLineView.backgroundColor =BACKGROUNDCOLOR;
    [backView addSubview:bottomLineView];
}
-(void)buttonBtnClick
{
    DRShopHomeVC *detailVC = [DRShopHomeVC new];
  
    detailVC.sellerId=self.nullGoodModel.sellerId;
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void)dismiss{
    //self.classifys = @[@"美食",@"今日新单",@"电影"];
    [_menu hideMenu];
}
-(void)getMsgList
{
    
    //    [MBProgressHUD showMessage:@""];
    [self loadDataSource:_sendDataDictionary withpagecount:[NSString stringWithFormat:@"%d",pageCount]];
}

-(void)loadDataSource:(NSMutableDictionary*)dictionary withpagecount:(NSString *)page
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (page) {
        [dic setObject:page forKey:@"pageNum"];
        [dic setObject:@"20" forKey:@"pageSize"];
        
    }
    if (dictionary) {
        [dic addEntriesFromDictionary:dictionary];
    }
    DRWeakSelf;
    [MBProgressHUD showMessage:@""];
    [SNAPI getWithURL:@"burst/findSimilarity" parameters:dic success:^(SNResult *result) {
        
        
        NSArray *modelArray=[DRSameModel mj_objectArrayWithKeyValuesArray:result.data[@"items"]];
        [weakSelf.sameArr addObjectsFromArray:modelArray];
        [self.tableView reloadData];
        if (modelArray.count<10){
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
#pragma mark - MoreDropDownMenuDataSource and MoreDropDownMenuDelegate
- (NSInteger)numberOfColumnsInMenu:(MoreDropDownMenu *)menu{
    
    return 2;
}

- (NSInteger)menu:(MoreDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column{
    if (column == 0) {
        
        return self.cates.count;
    }else if (column == 1){
        
        return self.states.count;
    }else {
        return self.sorts.count;
    }
}

- (NSString *)menu:(MoreDropDownMenu *)menu titleForRowAtIndexPath:(MoreIndexPath *)indexPath{
    if (indexPath.column == 0) {
        return self.cates[indexPath.row];
    } else if (indexPath.column == 1){
        return self.states[indexPath.row];
    } else {
        return self.sorts[indexPath.row];
    }
}
- (NSArray *)menu:(MoreDropDownMenu *)menu arrayForRowAtIndexPath:(MoreIndexPath *)indexPath{
    if (indexPath.column == 0) {
        return self.cates;
    } else if (indexPath.column == 1){
        return self.states;
    } else {
        return self.sorts;
    }
}

- (void)menu:(MoreDropDownMenu *)menu didSelectRowAtIndexPath:(MoreIndexPath *)indexPath{
    if (indexPath.item >= 0) {
        NSLog(@"点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
    }else {
        NSLog(@"点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
    }
}

- (void)didTapMenu:(MoreDropDownMenu *)menu{
    //    if (self.moveScroll) {
    //        self.moveScroll(self.tableView);
    //    }
    
    NSLog(@"点击了菜单");
}
#pragma mark 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    self.bgTipButton.hidden = (self.sameArr.count > 0) ? YES : NO;
    return self.sameArr.count;
}
#pragma mark 表的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    if (self.selectYes) {
    //        return 7;
    //    }
    return 4;
}
#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (self.selectYes) {
    //        if (indexPath.row==4||indexPath.row==5||indexPath.row==6) {
    //            return HScale(20);
    //        }
    //    }
    switch (indexPath.row) {
        case 0:
            return 0;
            break;
        case 1:
            return UITableViewAutomaticDimension;
            break;
        case 2:
            if (self.sameArr.count!=0) {
                
                if (self.sameArr[indexPath.section].qty==0) {
                    return 40;
                }
                
            }
            return 80;
        case 3:
            return 0;
            break;
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
    return 2;
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DRWeakSelf;
    if (self.sameArr.count!=0)
    {
        if (indexPath.row==0) {
            static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                     SimpleTableIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:1
                                              reuseIdentifier: SimpleTableIdentifier];
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
        
       else  if (indexPath.row==1)
        {
            SecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondCell"];
            cell.sameModel =self.sameArr[indexPath.section];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else if (indexPath.row==2)
        {
            if ( self.sameArr[indexPath.section].qty!=0)
            {
                CatgoryDetailCell2 *cell =[CatgoryDetailCell2 cellWithTableView:tableView withIndexPath:indexPath];
                
                cell.sameModel = self.sameArr[indexPath.section];
                cell.danweiBtn.tag =indexPath.section;
                
                cell.countTF.placeholder =@"0.00";
                
                
                return cell;
            }else
            {
                CatgoryDetailCell *cell =[CatgoryDetailCell cellWithTableView:tableView];
                cell.sameModel = self.sameArr[indexPath.section];
                cell.titleStr =@"爆品";
                
                cell.shoucangBlock = ^(NSInteger shoucangtag) {
                    
                };
                cell.shopCarBlock = ^(NSInteger shopCartag) {
                    //                    [SNAPI postWithURL:urlStr parameters:mudic success:^(SNResult *result) {
                    //                        if (result.state==200) {
                    //                            NSLog(@"result=%@",result.data);
                    //
                    //
                    //                            //                                [self.tableView reloadData];
                    //                        }
                    //                    } failure:^(NSError *error) {
                    //
                    //                    }];
                    
                    
                };
                
                cell.noticeBlock = ^(NSInteger noticeTag) {
                    
                    
                    
                };
                return cell;
            }
        }
        
        else
        {
//            CatgoryDetailCell *cell =[CatgoryDetailCell cellWithTableView:tableView];
//            cell.sameModel =self.sameArr[indexPath.section];
//            cell.shopCarBlock = ^(NSInteger shopCartag) {
//                //                    [SNAPI postWithURL:urlStr parameters:mudic success:^(SNResult *result) {
//                //                        if (result.state==200) {
//                //                            NSLog(@"result=%@",result.data);
//                //
//                //
//                //                            //                                [self.tableView reloadData];
//                //                        }
//                //                    } failure:^(NSError *error) {
//                //
//                //                    }];
//
//
//            };
//
//            cell.noticeBlock = ^(NSInteger noticeTag) {
//
//
//
//            };
//            return cell;
        }
    }
    //    }
    //    if (self.selectYes)
    //    {
    //        if (indexPath.row==4||indexPath.row==5||indexPath.row==6)
    //        {
    //            static NSString *SimpleTableIdentifier = @"selectCell";
    //            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
    //                                     SimpleTableIdentifier];
    //            if (cell == nil)
    //            {
    //                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault                                              reuseIdentifier: SimpleTableIdentifier];
    //            }
    //            NSString *timestr;
    //            if ([self.goodsModel.deliveryDay intValue]>1) {
    //                timestr =[NSString stringWithFormat:@"预计发货时间：%d天",[self.goodsModel.deliveryDay intValue]];
    //            }else{
    //                timestr =@"预计发货时间：当天发货";
    //            }
    //            NSArray *titleArr =@[[NSString stringWithFormat:@"最小销售单位：%@",self.goodsModel.saleUnitName],[NSString stringWithFormat:@"单规格起订量：%f%@",[self.goodsModel.minQuantity doubleValue],self.goodsModel.saleUnitName],timestr];
    //            cell.textLabel.text = titleArr[indexPath.row-4];
    //            [SNTool setTextColor:cell.textLabel FontNumber:DR_FONT(12) AndRange:NSMakeRange(7, cell.textLabel.text.length-7) AndColor:REDCOLOR];
    //            cell.textLabel.font =DR_FONT(12);
    //            return cell;
    //        }
    //    }
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier: SimpleTableIdentifier];
    }
    return cell;
}
//-(void)saveWithTag:(NSInteger)tag
//{
//
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [se
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

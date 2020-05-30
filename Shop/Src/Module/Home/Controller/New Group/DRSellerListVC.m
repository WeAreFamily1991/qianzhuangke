//
//  DRLocationVC.m
//  Shop
//
//  Created by BWJ on 2019/4/27.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRSellerListVC.h"
#import <SDCycleScrollView.h>
#import "DRLocationCell.h"
#import "NewsModel.h"
#import "DRLocationModel.h"
#import "DRFactoryModel.h"
#import "DCSildeBarView.h"

#import "DRShopHomeVC.h"
@interface DRSellerListVC ()<UITextFieldDelegate,SDCycleScrollViewDelegate>
{
    int pageCount;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/* 轮播图 */
@property (strong , nonatomic)SDCycleScrollView *cycleScrollView;
@property (strong,nonatomic)NSMutableDictionary *sendDataDictionary;

@property (nonatomic,retain)UITextField *shopTF;
@property (nonatomic,retain)NSMutableArray *bannerArr;
@property (nonatomic,retain)NSMutableArray *MsgListArr;
/* 暂无子账号提示 */
@property (strong , nonatomic)DCUpDownButton *bgTipButton;
@end

@implementation DRSellerListVC
-(NSMutableArray *)MsgListArr
{
    if (!_MsgListArr) {
        _MsgListArr =[NSMutableArray array];
    }
    return _MsgListArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"店铺列表";
    [self.view addSubview:self.bgTipButton];
    UIImageView *backIMG =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_bg.png"]];
    backIMG.frame =CGRectMake(15, 5, 3.5*SCREEN_WIDTH/5, 30);
    backIMG.userInteractionEnabled =YES;
    [self.view addSubview:backIMG];
    self.shopTF =[[UITextField alloc]initWithFrame:CGRectMake(10, 0, 3.5*SCREEN_WIDTH/5-20, 30)];
    self.shopTF.placeholder =@"请输入店铺名称搜索";
    self.shopTF.font =DR_FONT(14);
    self.shopTF.delegate =self;
    [backIMG addSubview:self.shopTF];
    UIButton *searchBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.layer.cornerRadius =15;
    searchBtn.layer.masksToBounds =15;
    searchBtn.backgroundColor =REDCOLOR;
    searchBtn.titleLabel.font =DR_FONT(14);
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    searchBtn.frame =CGRectMake(3.5*SCREEN_WIDTH/5+30, 4, SCREEN_WIDTH-3.5*SCREEN_WIDTH/5-45, 30);
    [searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    //    self.tableView.frame =CGRectMake(0, 40, ScreenW, ScreenH-40-DRTopHeight);
//    [self addHeadTablView];
//    [self getAddBannerSource];
    if (@available(iOS 11.0, *)) {
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
     self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
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
}
#pragma TextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    [_sendDataDictionary setObject:textField.text forKey:@"keyWord"];
//    [self.tableView.mj_header beginRefreshing];
}
-(void)getMsgList
{
    if (!_sendDataDictionary) {
        _sendDataDictionary = [NSMutableDictionary dictionaryWithObjects:@[self.keywordStr,[DRUserInfoModel sharedManager].locationCode?:@"",@"0"] forKeys:@[@"keyWord",@"districtId",@"voucherType"]];
    }
    [self loadDataSource:_sendDataDictionary withpagecount:[NSString stringWithFormat:@"%d",pageCount]];
}
-(void)loadDataSource:(NSMutableDictionary*)dictionary withpagecount:(NSString *)page
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (page) {
        [dic setObject:page forKey:@"pageNum"];
        [dic setObject:@"10" forKey:@"pageSize"];
    }
    if (dictionary) {
        [dic addEntriesFromDictionary:dictionary];
    }
    NSString *UrlStr;
    [MBProgressHUD showMessage:@""];   
        UrlStr =@"mainPage/searchSellerList";
    DRWeakSelf;
    [SNAPI getWithURL:UrlStr parameters:dic success:^(SNResult *result) {
        
        NSLog(@"data=%@",result.data[@"list"]);
        NSMutableArray*addArr=result.data[@"list"];
        NSMutableArray *modelArray =[DRLocationModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
        [weakSelf.MsgListArr addObjectsFromArray:modelArray];
        [self.tableView reloadData];
        if (addArr.count<10){
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        else
        {
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
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"select" object:nil];
}
- (DCUpDownButton *)bgTipButton
{
    if (!_bgTipButton) {
        
        _bgTipButton = [DCUpDownButton buttonWithType:UIButtonTypeCustom];
        [_bgTipButton setImage:[UIImage imageNamed:@"MG_Empty_dizhi"] forState:UIControlStateNormal];
        _bgTipButton.titleLabel.font = DR_FONT(13);
        [_bgTipButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_bgTipButton setTitle:@"暂无店铺" forState:UIControlStateNormal];
        _bgTipButton.frame = CGRectMake((ScreenW - 150) * 1/2 , (ScreenH - 150) * 1/2-150, 150, 150);
        _bgTipButton.adjustsImageWhenHighlighted = false;
    }
    return _bgTipButton;
}
-(void)searchBtnClick:(UIButton *)sender
{
//    [GoodsShareModel sharedManager].queryType =@"StoreList";
//    [DCSildeBarView dc_showSildBarViewController];
    [_sendDataDictionary setObject:self.shopTF.text forKey:@"keyWord"];
    [self.tableView.mj_header beginRefreshing];
}
-(void)getAddBannerSource
{
    DRWeakSelf;
    NSDictionary *dic =@{@"advType":self.advType,@"pageNum":@"1",@"pageSize":@"10"};
    [SNAPI getWithURL:@"mainPage/getAdvList" parameters:[dic mutableCopy] success:^(SNResult *result) {
    
            self.bannerArr=[NSMutableArray array];
            //             NSArray *sourceArr =result.data;
            NSArray *sourceArr =[NewsModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
            for (NewsModel *model in sourceArr) {
                [self.bannerArr addObject:model.img];
            }
            if (self.bannerArr.count!=0) {
                weakSelf.cycleScrollView.imageURLStringsGroup =self.bannerArr.copy;
                weakSelf.tableView.tableHeaderView =weakSelf.cycleScrollView;
            }
       
    } failure:^(NSError *error) {
        
    }];
}
//-(void)GETlISTwithType:(NSString *)HomeStr
//{
//    NSDictionary *dic =[NSDictionary dictionary];
//    NSString *urlStr;
//    if ([HomeStr isEqualToString:@"1"]) {
//         _sendDataDictionary = [NSMutableDictionary dictionaryWithObjects:@[@"Wechat",@"normal",@"",IDArr[0],IDArr[1],_czID,@"1",IDArr[2],@"",@"",@"",@"",[DRUserInfoModel sharedManager].locationCode?:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",_czID,@"",@""] forKeys:@[@"type",@"keyword",@"level1Id",@"level2Id",@"cz",@"subType",@"categoryId",@"condition",@"serviceType",@"sellerType",@"containzy",@"districtid",@"orderBy",@"onlyqty",@"standardId",@"levelId",@"surfaceId",@"lengthId",@"materialId",@"toothdistanceid",@"toothformid",@"brandid",@"czid",@"diameterid",@"voucherType"]];
//        urlStr =@"mainPage/marketSellerList";
//        dic =@{@"advType":self.advTypeDic[@"advType"],@"pageNum":@"1",@"pageSize":@"10"};
//    }else
//    {
//        urlStr =@"mainPage/factorySellerList";
//         dic =@{@"advType":self.advTypeDic[@"advType"],@"pageNum":@"1",@"pageSize":@"10"};
//    }
//    [SNAPI getWithURL:urlStr parameters:[dic mutableCopy] success:^(SNResult *result) {
//        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
//            self.bannerArr=[NSMutableArray array];
//            //             NSArray *sourceArr =result.data;
//            NSArray *sourceArr =[NewsModel mj_objectArrayWithKeyValuesArray:result.data];
//
//        }
//    } failure:^(NSError *error) {
//
//    }];
//}
-(void)addHeadTablView
{
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW, HScale(100)) delegate:self placeholderImage:nil];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    _cycleScrollView.currentPageDotColor =WHITECOLOR;
    _cycleScrollView.pageDotColor =[UIColor grayColor];
}
#pragma mark 表的行数

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    self.bgTipButton.hidden = (self.MsgListArr.count > 0) ? YES : NO;
    return self.MsgListArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WScale(150);
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.MsgListArr.count!=0) {
        DRLocationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DRLocationCell"];
        if (!cell) {
            cell =  [[NSBundle mainBundle]loadNibNamed:@"DRLocationCell" owner:self options:nil].firstObject;
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
        }
        cell.locationModel =self.MsgListArr[indexPath.section];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DRLocationModel *locationModel =self.MsgListArr[indexPath.section];
    DRShopHomeVC *detailVC = [DRShopHomeVC new];
    detailVC.sellerId=locationModel.sellerId;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 点击广告跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd广告图",index);
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

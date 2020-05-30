//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "DRShopQuanVC.h"
#import "CollectionCell.h"
#import "VoucherModel.h"
#import "DCRecommendItem.h"
@interface DRShopQuanVC ()
{
    int pageCount;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (nonatomic,strong)NSMutableArray *MsgListArr;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic,assign)NSInteger selectIndex;
@property (nonatomic,retain)VoucherModel *VouchModel;
@property (nonatomic,retain)DCUpDownButton *bgTipButton;
@property (nonatomic,retain)NSMutableArray *openArr;
/* 推荐商品属性 */
@property (strong , nonatomic)NSArray<DCRecommendItem *> *youLikeItem;
@end

@implementation DRShopQuanVC
- (void)viewDidLoad {
    [super viewDidLoad];
    _MsgListArr=[NSMutableArray array];
    [self.view addSubview:self.bgTipButton];
    self.view.backgroundColor =BACKGROUNDCOLOR;
    //    self.tableView.frame =CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.height);
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor =CLEARCOLOR;
//    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(ScreenH-WScale(40));
//    }];
    [self sellerVoucher];
  
    //   self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;
}
-(void)sellerVoucher
{
    NSDictionary *dic =@{@"sellerId":self.sellerId?:@"",@"pageNum":@"1",@"pageSize":@"10000"};
    DRWeakSelf;
    [SNAPI getWithURL:@"seller/sellerVoucher" parameters:[dic mutableCopy] success:^(SNResult *result) {
        NSMutableArray *modelArray =[VoucherModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
        [weakSelf.MsgListArr addObjectsFromArray:modelArray];
        weakSelf.openArr = [NSMutableArray array];
        for (int i = 0; i < weakSelf.MsgListArr.count; i++) {
            NSString *state = @"close";
            [ weakSelf.openArr addObject:state];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
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
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewAutomaticDimension;
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return WScale(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return WScale(105);
}
- (DCUpDownButton *)bgTipButton
{
    if (!_bgTipButton) {
        _bgTipButton = [DCUpDownButton buttonWithType:UIButtonTypeCustom];
        [_bgTipButton setImage:[UIImage imageNamed:@"quesheng_zanwudiyongquan"] forState:UIControlStateNormal];
        _bgTipButton.titleLabel.font = DR_FONT(13);
        [_bgTipButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_bgTipButton setTitle:@"暂无抵用券" forState:UIControlStateNormal];
        _bgTipButton.frame = CGRectMake((ScreenW - 150) * 1/2 , (ScreenH - 150) * 1/2-150, 150, 150);
        _bgTipButton.adjustsImageWhenHighlighted = false;
    }
    return _bgTipButton;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    self.bgTipButton.hidden = (_MsgListArr.count > 0) ? YES : NO;
    return self.MsgListArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell1 *cell =[CollectionCell1 cellWithTableView:tableView];
    self.VouchModel =self.MsgListArr[indexPath.section];
    cell.vouchModel =self.VouchModel;
    if (self.VouchModel.topicType==0) {
        //                cell.iconBackIMG.image =[UIImage imageNamed:@"平台抵用券"];
        cell.statusBtn.selected =NO;
    }else
    {
        cell.statusBtn.selected =YES;
    }
    [cell.statusBtn setTitle:@"去使用" forState:UIControlStateNormal];
    cell.hidenBtn.hidden =YES;
      DRWeakSelf;
    cell.detailBtnBlock = ^{
        NSString *state = self.openArr[indexPath.section];
        if ([state isEqualToString:@"open"]) {
            state = @"close";
        }else{
            state = @"open";
        }
        [weakSelf.openArr replaceObjectAtIndex:indexPath.section withObject:state];
        cell.detailBtn.selected =!cell.detailBtn.selected;
        [weakSelf.tableView reloadData];
    };
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView*  sectionBackView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, WScale(150))];
    sectionBackView.backgroundColor=BACKGROUNDCOLOR;
    sectionBackView.layer.cornerRadius =4;
    sectionBackView.layer.masksToBounds=4;
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(WScale(10), WScale(10), ScreenW-WScale(20), WScale(130))];
    backView.backgroundColor =WHITECOLOR;
    [sectionBackView addSubview:backView];
    self.VouchModel =self.MsgListArr[section];
    if ([[_openArr objectAtIndex:section] isEqualToString:@"open"]) {
        sectionBackView.frame =CGRectMake(0, 0, ScreenW, WScale(150));
        UILabel *timeLab =[UILabel labelWithText:[NSString stringWithFormat:@"发放时间：       ￥%@",self.VouchModel.addTime] font:DR_FONT(12) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:0 superView:backView];
        timeLab.frame =CGRectMake(WScale(10), WScale(10), ScreenW/2, WScale(12));
        
        UILabel *contentLab =[UILabel labelWithText:[NSString stringWithFormat:@"描述：     ￥%@",self.VouchModel.descriptionStr] font:DR_FONT(12) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:0 superView:backView];
        contentLab.frame =CGRectMake(timeLab.dc_x, timeLab.dc_bottom+WScale(7), ScreenW/2, WScale(12));
        
        
        UILabel *ruleLab =[UILabel labelWithText:[NSString stringWithFormat:@"使用规则：    ￥%@",self.VouchModel.descriptionStr] font:DR_FONT(12) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:0 superView:backView];
        ruleLab.frame =CGRectMake(timeLab.dc_x, contentLab.dc_bottom+WScale(7), ScreenW/2, WScale(12));
        
        UILabel *pinpaiLab =[UILabel labelWithText:[NSString stringWithFormat:@"指定品牌：    %@",self.VouchModel.descriptionStr] font:DR_FONT(12) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:0 superView:backView];
        pinpaiLab.frame =CGRectMake(timeLab.dc_x, ruleLab.dc_bottom+WScale(7), ScreenW/2, WScale(12));
        
        UILabel *cangkuLab =[UILabel labelWithText:[NSString stringWithFormat:@"指定仓库：    %@",self.VouchModel.descriptionStr] font:DR_FONT(12) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:0 superView:backView];
        cangkuLab.frame =CGRectMake(timeLab.dc_x, pinpaiLab.dc_bottom+WScale(7), ScreenW/2, WScale(12));

        UILabel *peisongLab =[UILabel labelWithText:[NSString stringWithFormat:@"指定配送方式：    %@",self.VouchModel.descriptionStr] font:DR_FONT(12) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:0 superView:backView];
        peisongLab.frame =CGRectMake(timeLab.dc_x, cangkuLab.dc_bottom+WScale(7), ScreenW/2, WScale(12));
            
           
    }
    else if ([[self.openArr objectAtIndex:section] isEqualToString:@"close"]) {
        sectionBackView.frame =CGRectMake(0, WScale(5), ScreenW, WScale(0));
        
       
    }
    
    return sectionBackView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSString*  state=[self.openArr objectAtIndex:section];
    if ([state isEqualToString:@"open"]) {
        return WScale(150);
    }
    return 0.01;
}

@end

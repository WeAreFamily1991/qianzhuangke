//
//  CartViewController.m
//  CartDemo
//
//  Created by Artron_LQQ on 16/2/18.
//  Copyright © 2016年 Artup. All rights reserved.
//

#import "MessageVC.h"
#import "CartTableViewCell.h"

#import "MessageDetailVC.h"
#define  TAG_BACKGROUNDVIEW 100


@interface MessageVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
    //全选按钮
    UIButton *selectAll;
    //展示数据源数组
//    NSMutableArray *self.dataArray;
    //是否全选
    BOOL isSelect;
    
    //已选的商品集合
    NSMutableArray *selectGoods;
    
    UILabel *priceLabel;
}
@property (strong,nonatomic)NSMutableArray *dataArray;
@property (strong,nonatomic)CartModel *model;
@property (retain,nonatomic)UITableView *tableView;
/* 暂无站内短信提示 */
@property (strong , nonatomic)DCUpDownButton *bgTipButton;
@end

@implementation MessageVC

-(void)viewWillAppear:(BOOL)animated
{
    //每次进入购物车的时候把选择的置空
    [selectGoods removeAllObjects];
    isSelect = NO;
    //    [self networkRequest];
    selectAll.selected = NO;
    [self creatData];
    
}

/**
 *  @author LQQ, 16-02-18 11:02:16
 *
 *  计算已选中商品金额
 */
//-(void)countPrice
//{
//    double totlePrice = 0.0;
//
//    for (CartModel *model in selectGoods) {
//
//        double price = [model.price doubleValue];
//
//        totlePrice += price*model.number;
//    }
//    priceLabel.text = [NSString stringWithFormat:@"￥%.2f",totlePrice];
//}

/**
 *  @author LQQ, 16-02-18 11:02:32
 *
 *  创建测试数据源
 */
-(void)creatData
{
    DRWeakSelf;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjects:@[@"1",@"1000000"] forKeys:@[@"page",@"pageSize"]];
    [SNAPI getWithURL:@"buyer/buyerMessageList" parameters:dic success:^(SNResult *result) {
        
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            weakSelf.dataArray =[NSMutableArray array];
            NSArray *sourArr =result.data[@"list"];
            if (sourArr.count!=0) {
                for (NSDictionary *dic in sourArr) {
                    weakSelf.model =[CartModel mj_objectWithKeyValues:dic];
                    [weakSelf.dataArray addObject:weakSelf.model];
                }
            }
            for (CartModel *model in self.self.dataArray) {
                [selectGoods addObject:model];
            }
            [weakSelf.tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
//    for (int i = 0; i < 10; i++) {
//        CartModel *model = [[CartModel alloc]init];
//
//        model.nameStr = @"测试数据";
//        model.price = @"100.00";
//        model.number = 1;
//        model.image = [UIImage imageNamed:@"aaa.jpg"];
//        model.dateStr = @"2016.02.18";
//        model.sizeStr = @"18*20cm";
//
//        [self.dataArray addObject:model];
//    }
   
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBCOLOR(245, 246, 248);
    selectGoods = [[NSMutableArray alloc]init];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bgTipButton];
    [self setupBottomView];
    self.title = @"站内短信";
}
-(void)selectAllBtnClick:(UIButton*)button
{
    //点击全选时,把之前已选择的全部删除
    [selectGoods removeAllObjects];
    button.selected = !button.selected;
    isSelect = button.selected;
    if (isSelect) {
        for (CartModel *model in self.self.dataArray) {
            [selectGoods addObject:model];
        }
    }
    else
    {
        [selectGoods removeAllObjects];
    }
    [self.tableView reloadData];
//    [self countPrice];
}
//提交订单
-(void)goPayBtnClick
{
//    if (selectGoods.count==0)
//    {
//        [MBProgressHUD showError:@"未选中任何项"];
//        return;
//    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:@"此操作将永久删除该消息, 是否继续?"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action)
                              {
                                  NSString *idStr ;
                                  
                                  for (CartModel *carmodel in selectGoods) {
                                      idStr=[NSString stringWithFormat:@"%@,%@",carmodel.message_id,idStr];
                                  }
//
                                  NSDictionary *dic =@{@"id":idStr};
                                  
                                  [SNIOTTool deleteWithURL:@"buyer/deleteMessage" parameters:[dic mutableCopy] success:^(SNResult *result) {
                                      [self creatData];
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

#pragma mark - 设置底部视图
-(void)setupBottomView
{
    //底部视图的 背景
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - WScale(50)-DRTopHeight-kIPhoneXBottomHeight, SCREEN_WIDTH, WScale(50))];
    bgView.backgroundColor =BACKGROUNDCOLOR;
    [self.view addSubview:bgView];
    
//    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
//    line.backgroundColor = kUIColorFromRGB(0xD5D5D5);
//    [bgView addSubview:line];
    
//    //全选按钮
//    selectAll = [UIButton buttonWithType:UIButtonTypeCustom];
//    selectAll.titleLabel.font = [UIFont systemFontOfSize:15];
//    [selectAll setTitle:@" 全选" forState:UIControlStateNormal];
//    [selectAll setImage:[UIImage imageNamed:@"cart_unSelect_btn"] forState:UIControlStateNormal];
//    [selectAll setImage:[UIImage imageNamed:@"cart_selected_btn"] forState:UIControlStateSelected];
//    [selectAll setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
//    [selectAll addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:selectAll];
//
//    //合计
//    UILabel *label = [[UILabel alloc]init];
//    label.text = @"合计: ";
//    label.font = [UIFont systemFontOfSize:15];
//    label.textAlignment = NSTextAlignmentRight;
//    [bgView addSubview:label];
//
//    //价格
//    priceLabel = [[UILabel alloc]init];
//    priceLabel.text = @"￥0.00";
//    priceLabel.font = [UIFont boldSystemFontOfSize:16];
//    priceLabel.textColor = BASECOLOR_RED;
//    [bgView addSubview:priceLabel];
    
    //结算按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor =WHITECOLOR;
    [btn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    btn.frame =bgView.bounds;
    [btn setTitle:@"清空消息" forState:UIControlStateNormal];
    btn.titleLabel.font =DR_FONT(18);
    [btn addTarget:self action:@selector(goPayBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn];
    
#pragma mark -- 底部视图添加约束
//    //全选按钮
//    [selectAll mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(bgView).offset(10);
//        make.top.mas_equalTo(@10);
//        make.bottom.mas_equalTo(bgView).offset(-10);
//        make.width.mas_equalTo(@60);
//
//    }];
    
    //结算按钮
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.right.bottom.left.mas_equalTo(bgView);
//
//
//    }];
}

#pragma mark - 设置主视图

-(UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-DRTopHeight-WScale(50)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =BACKGROUNDCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.tableFooterView.hidden = YES;
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.tableView.tableFooterView = [[UIView alloc] init];
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
-(void)goToMainmenuView
{
    NSLog(@"去首页");
}
#pragma mark - tableView 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.bgTipButton.hidden = (_dataArray.count > 0) ? YES : NO;
    return self.self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return WScale(100);
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[CartTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.isSelected = isSelect;
     [cell reloadDataWith:[self.dataArray objectAtIndex:indexPath.row]];
//    是否被选中
    if ([selectGoods containsObject:[self.self.dataArray objectAtIndex:indexPath.row]]) {
        cell.isSelected = YES;
    }
    
    //选择回调
    cell.cartBlock = ^(BOOL isSelec){
        
        if (isSelec) {
            [selectGoods addObject:[self.dataArray objectAtIndex:indexPath.row]];
        }
        else
        {
            [selectGoods removeObject:[self.dataArray objectAtIndex:indexPath.row]];
        }
        
        if (selectGoods.count == self.dataArray.count) {
            selectAll.selected = YES;
        }
        else
        {
            selectAll.selected = NO;
        }
        
//        [self countPrice];
    };
  
    
   
    return cell;
}

-(void)reloadTable
{
    [self.tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.model =self.dataArray[indexPath.row];
    MessageDetailVC *detailVC =[[MessageDetailVC alloc]init];
    detailVC.model =self.model;
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        [self.dataArray removeObjectAtIndex:indexPath.row];
        //    删除
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //延迟0.5s刷新一下,否则数据会乱
        [self performSelector:@selector(reloadTable) withObject:nil afterDelay:0.5];
    }
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
        [_bgTipButton setTitle:@"暂无消息" forState:UIControlStateNormal];
        _bgTipButton.frame = CGRectMake((ScreenW - 150) * 1/2 , (ScreenH - 150) * 1/2-DRTopHeight, 150, 150);
        _bgTipButton.adjustsImageWhenHighlighted = false;
    }
    return _bgTipButton;
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

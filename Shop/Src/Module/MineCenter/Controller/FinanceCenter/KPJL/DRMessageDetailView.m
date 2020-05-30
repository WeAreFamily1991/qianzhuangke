//
//  DRMessageDetailView.m
//  Shop
//
//  Created by BWJ on 2019/6/17.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRMessageDetailView.h"
@interface DRMessageDetailView ()<UITableViewDataSource,UITableViewDelegate>\
@property (weak, nonatomic) IBOutlet UIView *backVIew;
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)NSArray *titleArr;
@end
@implementation DRMessageDetailView

- (IBAction)backBtnClick:(id)sender {
    !_backBtnBlock?:_backBtnBlock();
}
- (IBAction)closeBtnClick:(id)sender {
    !_closeBtnBlock?:_closeBtnBlock();
}
-(void)layoutSubviews
{
    [self setUpUI];
}
-(void)setMessageModel:(BillMessageModel *)MessageModel
{
    _MessageModel =MessageModel;
    if ([MessageModel.invoiceType intValue]==0) {
        
        self.titleArr =@[[NSString stringWithFormat:@"发票类型：%@",[self.MessageModel.invoiceType intValue]?@"增值税专用发票":@"增值税普通发票"],[NSString stringWithFormat:@"发票抬头：%@",self.MessageModel.title],[NSString stringWithFormat:@"税号：%@",self.MessageModel.taxNo],[NSString stringWithFormat:@"注册地址：%@",self.MessageModel.invoiceAddress],[NSString stringWithFormat:@"注册电话：%@",self.MessageModel.invoiceTel],];
    }
    else
    {
        self.titleArr =@[[NSString stringWithFormat:@"发票类型：%@",[self.MessageModel.invoiceType intValue]?@"增值税专用发票":@"增值税普通发票"],[NSString stringWithFormat:@"发票抬头：%@",self.MessageModel.title],[NSString stringWithFormat:@"税号：%@",self.MessageModel.taxNo],[NSString stringWithFormat:@"注册地址：%@",self.MessageModel.invoiceAddress],[NSString stringWithFormat:@"注册电话：%@",self.MessageModel.invoiceTel],[NSString stringWithFormat:@"开户行：%@",self.MessageModel.bankName],[NSString stringWithFormat:@"银行账户：%@",self.MessageModel.bankAccount]];
    }
    [self.tableView reloadData];
}
-(void)setUpUI
{
    self.tableView=[[UITableView alloc] initWithFrame:self.backVIew.bounds style:UITableViewStyleGrouped];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor =BACKGROUNDCOLOR;
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    //    _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
//    [_tableView registerClass:[ThirdCell class] forCellReuseIdentifier:@"ThirdCell"];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.backVIew addSubview:self.tableView];
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-10, 40)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:view.frame];
    NSArray *titleArr =@[@"开票信息",@"收票信息"];
    titleLabel.text = titleArr[section];
    titleLabel.font = [UIFont systemFontOfSize:14];
    //    [titleLabel sizeToFit];
    [view addSubview:titleLabel];
   
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HScale(40);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
#pragma mark 表的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return self.titleArr.count;
    }
    return 3;
}
#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HScale(35);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    NSArray *detailTitleArr =@[[NSString stringWithFormat:@"收票人：%@",self.MessageModel.receiverName],[NSString stringWithFormat:@"详细地址：%@",self.MessageModel.receiverAddress],[NSString stringWithFormat:@"联系电话：%@",self.MessageModel.receiverPhone]];
    
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier: SimpleTableIdentifier];
        cell.textLabel.font =[UIFont systemFontOfSize:12];
    }
    if (indexPath.section==0)
    {
        cell.textLabel.text =self.titleArr[indexPath.row];
    }
    else
    {
        cell.textLabel.text =detailTitleArr[indexPath.row];
    }
    return cell;
    
}
@end

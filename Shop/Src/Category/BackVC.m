//
//  BackVC.m
//  Shop
//
//  Created by BWJ on 2019/2/28.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "BackVC.h"
#import "YCWindow.h"
@interface BackVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@end

@implementation BackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled =NO;
    self.closeBtn.layer.cornerRadius =self.closeBtn.dc_height/2;
    self.closeBtn.layer.masksToBounds =self.closeBtn.dc_height/2;
    
    // Do any additional setup after loading the view.
}
static YCWindow *ycWindow = nil;
//弹出window,选择商品尺寸，型号
- (void)show{
    if(!ycWindow){
        ycWindow = [[YCWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        ycWindow.windowLevel = UIWindowLevelAlert;
    }
    ycWindow.rootViewController = self;
    ycWindow.hidden = NO;
    [ycWindow makeKeyAndVisible];
}
//遮盖按钮点击，隐藏控制器的遮盖view
- (IBAction)zheGaiBtnClick:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"yinCanZheGai" object:nil];
    [ycWindow resignKeyWindow];
    ycWindow = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 40;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
#pragma mark 表的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 7;
    }
    return 3;
}
#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *titleArr =@[[NSString stringWithFormat:@"发票类型：%@",self.MessageModel.invoiceType?@"增值税专用发票":@"增值税普通发票"],[NSString stringWithFormat:@"发票抬头：%@",self.MessageModel.title],[NSString stringWithFormat:@"税号：%@",self.MessageModel.taxNo],[NSString stringWithFormat:@"注册地址：%@",self.MessageModel.invoiceAddress],[NSString stringWithFormat:@"注册电话：%@",self.MessageModel.invoiceTel],[NSString stringWithFormat:@"开户行：%@",self.MessageModel.bankName],[NSString stringWithFormat:@"银行账户：%@",self.MessageModel.bankAccount]];
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
        cell.textLabel.text =titleArr[indexPath.row];
    }
    else
    {
        cell.textLabel.text =detailTitleArr[indexPath.row];
    }
    return cell;
    
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

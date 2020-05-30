//
//  LDYSelectivityAlertView.m
//  LDYSelectivityAlertView
//
//  Created by 李东阳 on 2018/8/15.
//

#define kScreen_Width   [[UIScreen mainScreen] bounds].size.width
#define kScreen_Height  [[UIScreen mainScreen] bounds].size.height

#import "LDYSelectivityAlertView.h"
#import "UIColor+LDY.h"
#import "UIFont+LDY.h"
//#import "LDYSelectivityTableViewCell.h"
#import "SelectCell.h"
@interface LDYSelectivityAlertView () {
    float alertViewHeight;//弹框整体高度，默认250
    float buttonHeight;//按钮高度，默认40
}

@property (nonatomic, strong) NSArray *datas,*contentDatas;//数据源
@property (nonatomic, assign) BOOL ifSupportMultiple;//是否支持多选功能
@property (nonatomic, strong) UILabel *titleLabel;//标题label
@property (nonatomic, strong) UIView *alertView;//弹框视图
@property (nonatomic, strong) UITableView *selectTableView;//选择列表
@property (nonatomic, strong) UIButton *confirmButton;//确定按钮
@property (nonatomic, strong) UIButton *cancelButton;//取消按钮

@property (nonatomic, assign) NSIndexPath *selectIndexPath;//选择项的下标(单选)
@property (nonatomic, strong) NSMutableArray *selectArray;//选择项的下标数组(多选)


@end

@implementation LDYSelectivityAlertView

-(instancetype)initWithdatas:(NSArray *)datas
                        contentDatas:(NSArray*)contentDatas selectDatas:(NSMutableArray*)selectDatas
           ifSupportMultiple:(BOOL)ifSupportMultiple{
    if (self = [super init]) {
//        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
        
        alertViewHeight = HScale(200);
        buttonHeight = HScale(40);
        self.selectArray = [NSMutableArray array];
        
        self.alertView = [[UIView alloc] initWithFrame:CGRectMake(0, DRTopHeight+41, kScreen_Width, alertViewHeight)];
        self.alertView.backgroundColor = [UIColor whiteColor];
//        self.alertView.layer.cornerRadius = 8;
//        self.alertView.layer.masksToBounds = YES;
        [self addSubview:self.alertView];

//        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.alertView.frame.size.width, buttonHeight)];
//        self.titleLabel.text = title;
//        self.titleLabel.backgroundColor = [UIColor ldyBase_colorWithHexadecimal:0xeeeeee];
//        self.titleLabel.textColor = BLACKCOLOR;
//        self.titleLabel.font = [UIFont ldy_boldFontFor2xPixels:26];
//        self.titleLabel.textAlignment = NSTextAlignmentCenter;
//        [self.alertView addSubview:self.titleLabel];
        
        self.selectTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, self.alertView.bounds.size.height-buttonHeight) style:UITableViewStylePlain];
        self.selectTableView.delegate = self;
        
        self.selectTableView.dataSource = self;
        self.datas = datas;
        self.contentDatas =contentDatas;
        self.ifSupportMultiple = ifSupportMultiple;
        [self.alertView addSubview:self.selectTableView];
//        [self.selectTableView registerClass:[SelectCell class] forCellReuseIdentifier:@"SelectCell"];
        
        if (self.ifSupportMultiple == YES){
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
            [self.selectTableView addGestureRecognizer:tap];
            [tap addTarget:self action:@selector(clickTableView:)];
        }
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cancelButton.frame = CGRectMake(0,CGRectGetMaxY(self.selectTableView.frame), self.alertView.frame.size.width/2, buttonHeight);
        self.cancelButton.backgroundColor = [UIColor whiteColor];
        [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
        self.cancelButton.titleLabel.font = [UIFont ldy_fontFor2xPixels:22];
        [self.cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:self.cancelButton];
        
        
        self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.confirmButton.frame = CGRectMake(CGRectGetMaxX(self.cancelButton.frame),CGRectGetMaxY(self.selectTableView.frame), self.alertView.frame.size.width/2, buttonHeight);
        self.confirmButton.backgroundColor = REDCOLOR;
        [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.confirmButton.titleLabel.font = [UIFont ldy_fontFor2xPixels:22];
        [self.confirmButton addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:self.confirmButton];
        UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.selectTableView.frame)+buttonHeight+DRTopHeight+40, SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(self.selectTableView.frame)-buttonHeight-DRTopHeight-40)];
        backView.backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
        [self addSubview:backView];
    }
    return self;
}

-(void)show{
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.alertView.alpha = 0.0;
    [UIView animateWithDuration:0.05 animations:^{
        self.alertView.alpha = 1;
    }];
}

//手势事件
- (void)clickTableView:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self.selectTableView];
    NSIndexPath *indexPath = [self.selectTableView indexPathForRowAtPoint:point];
    if (indexPath == nil) {
        return;
    }
    
    if ([self.selectArray containsObject:@(indexPath.row)]) {
        [self.selectArray removeObject:@(indexPath.row)];
    }else {
        [self.selectArray addObject:@(indexPath.row)];
    }
    
    //按照数据源下标顺序排列
    [self.selectArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    [self.selectTableView reloadData];
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return HScale(80);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectCell *cell =[SelectCell cellWithTableView:tableView];
    if (self.ifSupportMultiple == NO) {
        if (self.selectIndexPath == indexPath) {
            cell.selectIMG.image = [UIImage imageNamed:@"select"];
        }else{
            cell.selectIMG.image = [UIImage imageNamed:@"noselect"];
        }
    }else{
        if ([self.selectArray containsObject:@(indexPath.row)]) {
            cell.selectIMG.image = [UIImage imageNamed:@"select"];
        }else {
            cell.selectIMG.image = [UIImage imageNamed:@"noselect"];
        }
    }
    cell.titleLab.text = _datas[indexPath.row];
    cell.contentLab.text =_contentDatas[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  SelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectCell"];
    if (self.ifSupportMultiple == NO) {
        self.selectIndexPath = indexPath;
        [tableView reloadData];
    }else{
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

//点击空白处
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    if (!CGRectContainsPoint([self.alertView frame], pt)) {
        [self cancelAction];
    }
}

//点击确定
- (void)confirmAction{
    if (self.ifSupportMultiple == NO) {
        NSString *data = self.datas[self.selectIndexPath.row];
        if (_delegate && [_delegate respondsToSelector:@selector(singleChoiceBlockData:)])
        {
            [_delegate singleChoiceBlockData:data];
        }
    }else{
        NSMutableArray *dataAr = [NSMutableArray array];
        [self.selectArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSNumber *data = obj;
            int row = [data intValue];
            NSArray *idArr =@[@"0",@"zf"];
            [dataAr addObject:idArr[row]];
        }];

        NSArray *datas = [NSArray arrayWithArray:dataAr];
        if (_delegate && [_delegate respondsToSelector:@selector(multipleChoiceBlockDatas:)])
        {
            
            [_delegate multipleChoiceBlockDatas:datas];
        }
    }
    [self cancelAction];
}

//点击取消
- (void)cancelAction {
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end

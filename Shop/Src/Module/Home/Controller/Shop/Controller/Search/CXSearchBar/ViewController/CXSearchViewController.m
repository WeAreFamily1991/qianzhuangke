//
//  CXSearchViewController.m
//  CXShearchBar_Example
//
//  Created by caixiang on 2019/4/29.
//  Copyright © 2019年 caixiang305621856. All rights reserved.
//
#import "CXSearchViewController.h"
#import "CXSearchModel.h"
#import "CXSearchCollectionViewCell.h"
#import "CXSearchCollectionReusableView.h"
#import "CXSearchLayout.h"
#import "CXDBTool.h"

@interface CXSearchViewController ()<UICollectionReusableViewButtonDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate
>

@property (weak, nonatomic) IBOutlet UICollectionView *searchCollectionView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIView *searchBGView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *searchDataSource;
@property (strong, nonatomic) CXSearchLayout *searchLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;

@end

 NSString *const kHistoryKey = @"kHistoryKey";
const CGFloat kMinimumInteritemSpacing = 10;
const CGFloat kFirstitemleftSpace = 20;

@implementation CXSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [DCSpeedy dc_chageControlCircularWith:_searchBGView AndSetCornerRadius:4 SetBorderWidth:0 SetBorderColor:CLEARCOLOR canMasksToBounds:YES];
    [self setUpdata];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self setUpUI];
    [self ConfigBlackStatusColor];
}
- (void)setUpUI {
//    self.navigationController.navigationBarHidden = YES;
    [self hideNavigationBar];
//    self.searchCollectionView.alwaysBounceVertical = YES;
//    self.searchCollectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
//    
    _searchTextField.returnKeyType = UIReturnKeySearch;//变为搜索按钮
    self.searchTextField.delegate = self;
//    self.searchCollectionView.dataSource = self;
//    self.searchCollectionView.delegate = self;
//    
//    [self.searchCollectionView setCollectionViewLayout:self.searchLayout animated:YES];
//    [self.searchCollectionView registerClass:[CXSearchCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([CXSearchCollectionReusableView class])];
//    [self.searchCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CXSearchCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([CXSearchCollectionViewCell class])];
}

- (void)setUpdata {
//    NSArray *datas = @[@"化妆棉",@"面膜",@"口红",@"眼霜",@"洗面奶",@"防晒霜",@"补水",@"香水",@"眉笔"];
//    [datas enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        CXSearchModel *searchModel = [[CXSearchModel alloc] initWithName:obj searchId:[NSString stringWithFormat:@"%u",idx + 1]];
//        [self.dataSource addObject:searchModel];
//    }];
//    //去数据库取数据
//    NSArray *dbDatas =  [CXDBTool statusesWithKey:kHistoryKey];
//    if (dbDatas.count > 0) {
//        [self.searchDataSource setArray:dbDatas];
//    }
}


- (UIAlertController *)showAlertWithTitle:(NSString *)title {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
    return alertController;
}

#pragma mark - textField
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        return NO;
    }
    /***  每搜索一次   就会存放一次到历史记录，但不存重复的*/
    __block BOOL isExist = NO;
    [self.searchDataSource enumerateObjectsUsingBlock:^(CXSearchModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([textField.text isEqualToString:obj.content]) {
            isExist = YES;
            *stop = YES;
        }
    }];
    [self.dataSource enumerateObjectsUsingBlock:^(CXSearchModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([textField.text isEqualToString:obj.content]) {
            isExist = YES;
            *stop = YES;
        }
    }];
    if (!isExist) {
        [self reloadData:textField.text];
    }
    return isExist;
}
- (void)reloadData:(NSString *)textString {
    NSLog(@"%@",textString);
    if (_SearTextBlock) {
        _SearTextBlock(textString);
    }
//    CXSearchModel *searchModel = [[CXSearchModel alloc] initWithName:textString searchId:@""];
//    [self.searchDataSource addObject:searchModel];
//    //存数据
//    [CXDBTool saveStatuses:[self.searchDataSource copy] key:kHistoryKey];
//    [self.searchCollectionView reloadData];
//    self.searchTextField.text = @"";
}
- (IBAction)cancleClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
}
#pragma mark - UICollectionReusableViewButtonDelegate
- (void)deleteDatas:(CXSearchCollectionReusableView *)view {
    [self.searchDataSource removeAllObjects];
    [self.searchCollectionView reloadData];
    [CXDBTool saveStatuses:@[] key:kHistoryKey];
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)searchDataSource {
    if (!_searchDataSource) {
        _searchDataSource = [NSMutableArray array];
    }
    return _searchDataSource;
}

- (CXSearchLayout *)searchLayout{
    if (!_searchLayout) {
        _searchLayout = [[CXSearchLayout alloc] init];
        _searchLayout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, WScale(30));
        _searchLayout.minimumInteritemSpacing = kMinimumInteritemSpacing;
        _searchLayout.minimumLineSpacing = kMinimumInteritemSpacing;
        _searchLayout.listItemSpace = kMinimumInteritemSpacing;
        _searchLayout.sectionInset = UIEdgeInsetsMake(20, kFirstitemleftSpace, 0, kFirstitemleftSpace);
    }
    return _searchLayout;
}

@end

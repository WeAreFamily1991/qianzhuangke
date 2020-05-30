
//
//  DRCuXiaoHeaderView.m
//  Shop
//
//  Created by BWJ on 2019/4/28.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRCuXiaoHeaderView.h"
#import "TFDropDownMenuView.h"
@interface DRCuXiaoHeaderView ()<TFDropDownMenuViewDelegate>
@property (nonatomic, strong) NSArray *classifys;
@property (nonatomic, strong) NSArray *cates;
@property (nonatomic, strong) NSArray *movices;
@property (nonatomic, strong) NSArray *hostels;
@property (nonatomic, strong) NSArray *areas;
@property (nonatomic,strong) TFDropDownMenuView *menu;
@property (nonatomic, strong) NSArray *sorts;
@end
@implementation DRCuXiaoHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {

//        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = REDCOLOR;
    NSMutableArray *array1 = [NSMutableArray arrayWithObjects:@"面积最大", @"面积最小", @"价格最高", @"价格最低", nil];
    NSMutableArray *array2 = [NSMutableArray arrayWithObjects:@"热门推荐", @"美食", @"影院", @"自助餐", @"景区", @"汽车", @"网吧", @"游戏", nil];
    
    NSMutableArray *data1 = [NSMutableArray arrayWithObjects:array1, array2, @[@"自定义"], nil];
    NSMutableArray *data2 = [NSMutableArray arrayWithObjects:@[], @[], @[], @[], nil];
    self.menu = [[TFDropDownMenuView alloc] initWithFrame:self.bounds firstArray:data1 secondArray:data2];
    self.menu.delegate = self;
    self.menu.userInteractionEnabled =YES;
    self.menu.cellSelectBackgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.menu.ratioLeftToScreen = 0.35;
//    [self addSubview:self.menu ];
    
    /*副标*/
    NSMutableArray *detail1 = [NSMutableArray arrayWithObjects:@"21", @"22", @"23", @"24", nil];
    NSMutableArray *detail2 = [NSMutableArray arrayWithObjects:@"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", nil];
    NSMutableArray *detail3 = [NSMutableArray arrayWithObjects:@"31", @"32", @"33", @"34", @"35", @"36", @"37", @"38", nil];
    NSArray *detail21 = @[
                          @[@"111", @"112", @"113", @"114", @"115"],
                          @[@"121",@"122", @"123", @"125", @"125"],
                          @[@"131", @"132", @"133", @"134", @"135", @"136"],
                          @[@"141", @"142", @"143", @"144", @"145"],
                          @[@"151", @"152", @"153", @"154", @"155", @"156"],
                          @[@"161", @"162", @"163", @"164", @"165"],
                          @[@"171", @"172"],
                          @[@"181", @"182", @"183", @"184", @"185"]
                          ];
    self.menu .firstRightArray = [NSMutableArray arrayWithObjects:detail1, detail2, detail3, nil];
    self.menu .secondRightArray = [NSMutableArray arrayWithObjects:@[], detail21, nil];
    /*风格*/
    self.menu .menuStyleArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithInteger:TFDropDownMenuStyleTableView], [NSNumber numberWithInteger:TFDropDownMenuStyleTableView], [NSNumber numberWithInteger:TFDropDownMenuStyleCollectionView], [NSNumber numberWithInteger:TFDropDownMenuStyleCustom], nil];
    
    /*自定义视图*/
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 300)];
    label.text = @"我是自定义视图\n我是自定义视图\n我是自定义视图\n我是自定义视图\n我是自定义视图\n我是自定义视图\n我是自定义视图\n我是自定义视图";
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = REDCOLOR;
    self.menu .customViews = [NSMutableArray arrayWithObjects:[NSNull null], [NSNull null], [NSNull null], label, nil];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)menuView:(TFDropDownMenuView *)menu selectIndex:(TFIndexPatch *)index {
    NSLog(@"index: %@", index);
}
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
//    UIView *view =[super hitTest:<#point#> withEvent:<#event#>]
    UIView*view = [super hitTest:point withEvent:event];
    if(view ==nil)
    {
        for(UIView *subView in self.subviews)
        {
            CGPoint myPoint = [subView convertPoint:point fromView:self];
            if(CGRectContainsPoint(subView.bounds,myPoint))
            {
                return subView;
            }
        }
    }
    return view;
}
//// 在自定义UITabBar中重写以下方法，其中self.button就是那个希望被触发点击事件的按钮
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *view = [super hitTest:point withEvent:event];
//    if (view == nil) {
//        // 转换坐标系
//        CGPoint newPoint = [self.menu  convertPoint:point fromView:self];
//        // 判断触摸点是否在button上
//        if (CGRectContainsPoint(self.menu .bounds, newPoint)) {
//            view = self.menu;
//        }
//    }
//    return view;
//}
- (void)menuView:(TFDropDownMenuView *)menu tfColumn:(NSInteger)column {
    NSLog(@"column: %ld", column);
}
@end

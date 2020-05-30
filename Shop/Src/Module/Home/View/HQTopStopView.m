//
//  HQTopStopView.m
//  HQCollectionViewDemo
//
//  Created by Mr_Han on 2018/10/10.
//  Copyright © 2018年 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
// 

#import "HQTopStopView.h"
#import "DRCollectionViewCell.h"
#import "DRCollectionModel.h"
#import "GSFilterView.h"
#import "GSMacros.h"
#import "UIButton+BackgroundColor.h"
#define NeedWidth   self.frame.size.width  // 需求总宽度
#define NeedHeight  self.frame.size.height // 需求总高度
#define NeedStartMargin 10   // 首列起始间距
#define NeedFont 13   // 需求文字大小
#define NeedBtnHeight 27   // 按钮高度
#define NeediPhoneXMargin    (NeedHeight == 812.0 ? 88 : 64) //首行起始距离

@interface HQTopStopView ()
@property(nonatomic,strong) NSMutableArray *selectArr;
@property (nonatomic, strong) UIButton * btn;
@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic,strong) GSFilterView *filterView;
@property (nonatomic,strong) DKFilterModel *clickModel;

@end
@implementation HQTopStopView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
//        [self setUpUI];
    }
    return self;
}
-(void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex =selectIndex;
}
-(void)setBigCartporyArr:(NSArray *)bigCartporyArr
{
    _bigCartporyArr =bigCartporyArr;
    //初始行_列的X、Y值设置
    float butX = NeedStartMargin;
    float butY =10;
    for(int i = 0; i < self.bigCartporyArr.count; i++){
        //宽度自适应计算宽度
        NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:NeedFont]};
        CGRect frame_W = [self.bigCartporyArr[i][@"name"] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
        //宽度计算得知当前行不够放置时换行计算累加Y值
        if (butX+frame_W.size.width+NeedStartMargin*2>SCREEN_WIDTH-NeedStartMargin) {
            butX = NeedStartMargin;
            butY += (WScale(27)+WScale(5));//Y值累加，具体值请结合项目自身需求设置 （值 = 按钮高度+按钮间隙）
        }
        //设置计算好的位置数值
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(butX, butY, WScale(85), WScale(27))];
        //设置内容
        [btn setTitle:self.bigCartporyArr[i][@"name"] forState:UIControlStateNormal];
        //设置文字状态颜色
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_xuanzhong_white"] forState:UIControlStateNormal];
         [btn setBackgroundImage:[UIImage imageNamed:@"btn_xuanzhong_red"] forState:UIControlStateSelected];
        
        
        
        [btn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
        [btn setTitleColor:REDCOLOR forState:UIControlStateSelected];
//        [btn setTitleColor:REDCOLOR forState:UIControlStateHighlighted];
        //设置背景状态颜色，这里用到了一个工具类UIButton+BackgroundColor
//        [btn setBackgroundColor:WHITECOLOR forState:UIControlStateNormal] ;
//        [btn setBackgroundColor:WHITECOLOR forState:UIControlStateSelected];
//        [btn setBackgroundColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateHighlighted];
        //文字大小
        btn.titleLabel.font = DR_FONT(13);
        //裁圆角
//        btn.layer.cornerRadius = 2;
//        btn.clipsToBounds = YES ;
//        //设置边框
//        btn.layer.borderWidth = 1 ;
//        btn.layer.borderColor = [UIColor grayColor].CGColor ;
        //设置角标
        btn.tag = i;
        //添加事件
        [btn addTarget:self action:@selector(SelBtn:) forControlEvents:UIControlEventTouchUpInside];
        //添加按钮
        [self addSubview:btn];
        //一个按钮添加之后累加X值后续计算使用
        NSLog(@"%f",CGRectGetMaxX(btn.frame));
        butX = CGRectGetMaxX(btn.frame)+WScale(5);
        if (i==_selectIndex) {//默认选中第一个
            [self SelBtn:btn];
//            [self SelBtn:btn];
        }
    }
//    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, self.dc_height-2, SCREEN_WIDTH, 2)];
//    lineView.backgroundColor =BACKGROUNDCOLOR;
//    [self addSubview:lineView];
}
#pragma mark--点击事件
-(void)SelBtn:(UIButton *)sender{
    self.currentSelectedBtn.selected = NO ;
    sender.selected = YES ;
    self.currentSelectedBtn = sender ;
    NSLog(@"点击 %ld--%@",sender.tag,self.bigCartporyArr[sender.tag][@"name"]);
//    NSDictionary *dic=@{@"tag":[NSString stringWithFormat:@"%d",sender.tag]};
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"HQTopStopView" object:nil userInfo:dic];
    if (_SelectbuttonClickBlock) {
        _SelectbuttonClickBlock(sender,sender.tag);
    }
}
-(void)setPATH:(NSInteger)selectIndex withBtn:(UIButton *)sender
{
    self.currentSelectedBtn.selected = NO ;
    sender.selected = YES ;
    self.currentSelectedBtn = sender ;
      
}
- (NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray arrayWithCapacity:0];
    }
    return _array;
}
//- (UIView *)topView {
//    if (!_topView) {
//        _topView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
//        _topView.backgroundColor =[UIColor whiteColor];
//        [self addSubview:_topView];
//    }
//    return _topView;
//}
-(void)buttonBtnClick:(UIButton *)sender
{
    self.buttonBtn.selected = NO ;
    sender.selected = YES ;
    self.buttonBtn = sender ;
    
    NSLog(@"点击 %ld",sender.tag) ;
}


@end

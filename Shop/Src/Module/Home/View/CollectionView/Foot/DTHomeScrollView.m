//
//  DTHomeScrollView.m
//  DTcollege
//
//  Created by 信达 on 2018/7/24.
//  Copyright © 2018年 ZDQK. All rights reserved.
//

#import "DTHomeScrollView.h"
#import "DTHomePageControl.h"

@interface DTHomeScrollView ()<UIScrollViewDelegate>
{
    NSInteger targetIndex;
    NSInteger allCount;
}
@property (nonatomic, strong) NSArray *views;
@property (nonatomic, strong) DTHomePageControl *pageControl;
@property (nonatomic, strong) UIScrollView *upScrollView;
@property (nonatomic,strong)NSTimer *timer;
@end


@implementation DTHomeScrollView

-(instancetype)initWithFrame:(CGRect)frame viewsArray:(NSArray *)views{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.views = views;
        self.maxCount = 6;
        [self createSubViews];
        [self startScroll];
    }
    
    return self;
}

-(void)startScroll

{
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    _timer = timer;
    
}
-(void)timerFired:(NSTimer *)timer
{
//    int currentIndex = [self currentIndex];
    targetIndex+=1;
    if (targetIndex>=allCount) {
        targetIndex=0;
    }
    NSLog(@"targetIndex=%ld",(long)targetIndex);
    [self scrollToIndex:targetIndex];
}
-(void)stopScroll

{
    [self.timer invalidate];
    
    self.timer = nil;
    
}
-(void)dealloc
{
    [self stopScroll];
}
- (void)scrollToIndex:(NSInteger)targetIndex
{
    CGFloat pointX = self.bounds.size.width * (targetIndex);
//    self.upScrollView.contentOffset = CGPointMake(pointX, 0);
     [self.upScrollView setContentOffset:CGPointMake(pointX, 0) animated:YES];
    NSInteger index = _upScrollView.contentOffset.x / self.frame.size.width;  //计算这是第几页
    self.pageControl.currentPage = index;
}

- (void)createSubViews{
    self.userInteractionEnabled = YES;
    self.clipsToBounds = YES;
    _pageControl = [[DTHomePageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 20,self.frame.size.width, 20)];
    _pageControl.currentPage = 0;
   
    _pageControl.numberOfPages = (self.views.count - 1) / self.maxCount + 1;
    NSLog(@"numberOfPages=%ld",(long)_pageControl.numberOfPages);
    allCount =_pageControl.numberOfPages;
    _pageControl.currentPageIndicatorTintColor = REDCOLOR;
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    [self addSubview:_pageControl];
    
    _upScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - _pageControl.frame.size.height)];
    _upScrollView.delegate = self;
    _upScrollView.pagingEnabled = YES;
    _upScrollView.showsVerticalScrollIndicator = NO;
    _upScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_upScrollView];
    
    for (int i = 0; i < (self.views.count - 1) / self.maxCount + 1; i++) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, _upScrollView.frame.size.height)];
        NSInteger index = self.maxCount;
        if ((self.views.count - i*6) <self.maxCount) {
            index = (self.views.count - i*self.maxCount);            
        }
        NSLog(@"allCount =%ld",index);
        for (int j = 0; j <index; j++) {
            int row = j/3;
            int col = j % 3;
            NSLog(@"row = %d",row);
            NSLog(@"col = %d",col);
            NSLog(@"btnHieght = %f",(bgView.frame.size.height / 2));
            UIView *btnView = self.views[i*self.maxCount+j];
            btnView.frame = CGRectMake(col * (self.frame.size.width / 2), row * bgView.frame.size.height , (self.frame.size.width/ 2), bgView.frame.size.height);
            btnView.tag = 100000 + i * self.maxCount + j;
//            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:btnView];
        }
        [_upScrollView addSubview:bgView];
        
    }
     _upScrollView.contentSize = CGSizeMake(self.frame.size.width * ((self.views.count - 1) / self.maxCount + 1), _upScrollView.frame.size.height);
    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / self.frame.size.width;  //计算这是第几页
    self.pageControl.currentPage = index;
    
    targetIndex =index;
}


- (void)btnAction:(UIButton *)btn{
    NSInteger index = btn.tag - 100000;
    if ([self.delegate respondsToSelector:@selector(buttonUpInsideWithView:withIndex:withView:)]) {
        [self.delegate buttonUpInsideWithView:btn withIndex:index withView:self];
    }
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView

{
    
    [self stopScroll];
    
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate

{
    
    [self startScroll];
    
}


@end

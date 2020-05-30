//
//  HeadView.m
//  KCB
//
//  Created by haozp on 16/1/6.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "HeadView.h"
#import "ProblemTitleModel.h"

@interface HeadView()
{
    UIButton *_bgButton;
    UILabel *_numLabel;
}
@end

@implementation HeadView

+ (instancetype)headViewWithTableView:(UITableView *)tableView
{
    static NSString *headIdentifier = @"header";
    
    HeadView *headView;
    if (headView == nil) {
        headView = [[HeadView alloc] initWithReuseIdentifier:headIdentifier];
    }
    
    return headView;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier])
    {
        
        UIButton *fooBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        fooBtn.frame =self.bounds;
        fooBtn.titleLabel.font =DR_FONT(14);
        [fooBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [fooBtn setTitle:@"查看全部" forState:UIControlStateNormal];
        [fooBtn setImage:[UIImage imageNamed:@"arrow_right_grey"] forState:UIControlStateNormal];
        [fooBtn setTitle:@"收起全部" forState:UIControlStateSelected];
        [fooBtn setImage:[UIImage imageNamed:@"arrow_down_grey"] forState:UIControlStateSelected];
        [fooBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:15];
        [fooBtn addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:fooBtn];
        _bgButton = fooBtn;
        
    }
    return self;
}
- (void)headBtnClick
{
    _titleGroup.opened = !_titleGroup.isOpened;
    if ([_delegate respondsToSelector:@selector(clickHeadView)]) {
        [_delegate clickHeadView];
    }
}
- (void)setTitleGroup:(ProblemTitleModel *)titleGroup{
    _titleGroup = titleGroup;

    [_bgButton setTitle:titleGroup.title forState:UIControlStateNormal];
}


- (void)didMoveToSuperview
{
    _bgButton.imageView.transform = _bgButton.selected ? CGAffineTransformMakeRotation(M_PI_2*2) : CGAffineTransformMakeRotation(0);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _bgButton.frame = self.bounds;
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
}



@end

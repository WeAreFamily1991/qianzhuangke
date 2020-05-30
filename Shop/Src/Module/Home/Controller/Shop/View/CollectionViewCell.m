//
//  CollectionViewCell.m
//  Shop
//
//  Created by BWJ on 2019/4/26.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI
{
    _backImage =[[UIImageView alloc]initWithFrame:self.bounds];
//    _backImage.contentMode =UIViewContentModeScaleAspectFill;
    
    [self addSubview:_backImage];
}
@end

//
//  AddImageCell.m
//  Shop
//
//  Created by BWJ on 2019/3/20.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "AddImageCell.h"

@implementation AddImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        
    }
    return self;
}
-(void)setUpUI
{
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

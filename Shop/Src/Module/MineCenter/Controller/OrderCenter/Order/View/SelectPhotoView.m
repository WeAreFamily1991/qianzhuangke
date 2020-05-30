//
//  SelectPhotoView.m
//  Shop
//
//  Created by BWJ on 2019/4/16.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "SelectPhotoView.h"

@implementation SelectPhotoView
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self greatUI];
    }
    return self;
}
-(void)greatUI
{
   
    
}
- (IBAction)commitBtnClick:(id)sender {
    !_commitBtnBlock?:_commitBtnBlock();
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

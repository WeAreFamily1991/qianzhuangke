
//
//  DRComView.m
//  Shop
//
//  Created by BWJ on 2019/6/14.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRComView.h"

@implementation DRComView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)closeBtnClick:(id)sender {
    !_closeBtnBlock ? :_closeBtnBlock();
}

@end

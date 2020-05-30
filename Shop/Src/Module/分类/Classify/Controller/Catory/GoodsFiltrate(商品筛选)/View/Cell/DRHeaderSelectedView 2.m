//
//  DRHeaderSelectedView.m
//  Shop
//
//  Created by BWJ on 2019/5/6.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRHeaderSelectedView.h"

@implementation DRHeaderSelectedView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)SelectBtnClick:(id)sender {
     !_sectionClick ? : _sectionClick();
}

@end

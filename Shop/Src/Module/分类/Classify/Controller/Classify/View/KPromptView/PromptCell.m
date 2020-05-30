//
//  PromptCell.m
//  云阙普惠
//
//  Created by a on 2019/3/28.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "PromptCell.h"

@implementation PromptCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.titleLab.font =[UIFont boldSystemFontOfSize:16];
}
- (IBAction)selectAction:(UIButton *)sender {
 
    
    
    if ([self.delegate respondsToSelector:@selector(selectRowStr:indexPath:)]) {
        [_delegate selectRowStr:self.titleLab.text indexPath:self.selectedIndexPath];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
   

    // Configure the view for the selected state
}

@end

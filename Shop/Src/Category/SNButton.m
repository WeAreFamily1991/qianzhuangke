//
//  SNButton.m
//  TemplateProject-iOS
//
//  Created by Felix on 2017/4/18.
//  Copyright © 2017年 Scinan. All rights reserved.
//

#import "SNButton.h"

@implementation SNButton

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setup];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self.normalBackgroundColor = RGBHex(0x005CB9);
    self.highlightBackgroundColor = RGBHex(0x004A94);
    
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self setTitleColor:RGBHex(0xFFFFFF) forState:UIControlStateNormal];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundColor = self.normalBackgroundColor;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    self.backgroundColor = highlighted ? self.highlightBackgroundColor : self.normalBackgroundColor;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    self.backgroundColor = selected ? self.highlightBackgroundColor : self.normalBackgroundColor;
}


@end

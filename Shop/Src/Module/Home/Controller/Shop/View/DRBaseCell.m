//
//  DRBaseCell.m
//  Shop
//
//  Created by BWJ on 2019/4/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRBaseCell.h"

@implementation DRBaseCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *cellIdentifier = [NSString stringWithFormat:@"%@-Identifier", NSStringFromClass(self)];
    DRBaseCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        for (UIView *view in self.subviews) {
            if([view isKindOfClass:[UIScrollView class]]) {
                ((UIScrollView *)view).delaysContentTouches = NO; // Remove touch delay for iOS 7
                break;
            }
        }
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundView.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        [self setupViews];
    }
    return self;
}

- (void)prepareForReuse {
    // ignore
    [super prepareForReuse];
}

- (void)setupViews {}


@end

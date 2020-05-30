//
//  CRTableViewCell.m
//  SCMoments
//
//  Created by roger wu on 02/06/2017.
//  Copyright © 2017 cocoaroger. All rights reserved.
//

#import "CRTableViewCell.h"

@implementation CRTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *cellIdentifier = [NSString stringWithFormat:@"%@-Identifier", NSStringFromClass(self)];
    CRTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
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

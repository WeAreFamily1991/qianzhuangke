#import "CustomCollectionViewCell.h"
#import "UIView+SDExtension.h"

@implementation CustomCollectionViewCell

#pragma mark - 懒加载
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.layer.borderColor = [REDCOLOR CGColor];
        _imageView.layer.borderWidth = 0;
        _imageView.hidden = YES;
    }
    return _imageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"新闻";
        _titleLabel.textColor = REDCOLOR;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.backgroundColor = [UIColor yellowColor];
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.layer.cornerRadius = 5;
        _titleLabel.layer.borderColor = REDCOLOR.CGColor;
        _titleLabel.layer.borderWidth = 1.f;
    }
    return _titleLabel;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.text = @"我是label的内容";
        _contentLabel.textColor = BLACKCOLOR;
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:12];
    }
    return _contentLabel;
}
#pragma mark - 页面初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

#pragma mark - 添加子控件
- (void)setupViews {
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
}

#pragma mark - 布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    _titleLabel.frame = CGRectMake(15, 10, 45, 20);
    _contentLabel.frame = CGRectMake(15 + 45 + 15, 10, 200, 20);
}
@end

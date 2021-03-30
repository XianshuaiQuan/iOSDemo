//
//  MMCTableViewHeaderView.m
//  MTRecommendAroundApp
//
//  Created by 全先帅 on 2021/3/30.
//

#import "MMCTableViewHeaderView.h"
#import <Masonry/Masonry.h>

@interface MMCTableViewHeaderView()

@property (nonatomic, strong) UILabel *headerTitle;

@end

@implementation MMCTableViewHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.headerTitle];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    [self.headerTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
    }];
    self.headerTitle.text = _title;
}

#pragma mark - lazy
- (UILabel *)headerTitle {
    if (!_headerTitle) {
        _headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _headerTitle.font = [UIFont systemFontOfSize:20];
//        _headerTitle.backgroundColor = [UIColor systemGray5Color];
    }
    return _headerTitle;
}

@end

//
//  MMCTableViewCell.m
//  MTRecommendAroundApp
//
//  Created by 全先帅 on 2021/3/30.
//

#import "MMCTableViewCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>

@interface MMCTableViewCell()

@property (nonatomic, strong) UIImageView *imageUrlView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel2;
@property (nonatomic, strong) UILabel *topRightInfoLabel;
@property (nonatomic, strong) UILabel *mainMessageLabel;

@end

@implementation MMCTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    [self addSubview:self.imageUrlView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subTitleLabel];
    [self addSubview:self.subTitleLabel2];
    [self addSubview:self.topRightInfoLabel];
    [self addSubview:self.mainMessageLabel];
}

- (void)setDataDictionary:(NSDictionary *)dataDictionary {
    _dataDictionary = dataDictionary;
    
    [self.imageUrlView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 80));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.mas_left).offset(10);
    }];
    NSURL *url = [NSURL URLWithString:_dataDictionary[@"imageUrl"]];
    [self.imageUrlView sd_setImageWithURL:url];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(20);
            make.left.mas_equalTo(self.imageUrlView.mas_right).offset(10);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(20);
    }];
    self.titleLabel.text = _dataDictionary[@"title"];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(self.imageUrlView.mas_right).offset(100);
            make.height.mas_equalTo(20);
    }];
    self.subTitleLabel.text = _dataDictionary[@"subTitle"];
    
    [self.subTitleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(self.subTitleLabel.mas_right).offset(10);
            make.height.mas_equalTo(20);
    }];
    self.subTitleLabel2.text = _dataDictionary[@"subTitle2"];
    
    [self.topRightInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(self.subTitleLabel2.mas_right).offset(10);
            make.height.mas_equalTo(20);
    }];
    self.topRightInfoLabel.text = _dataDictionary[@"topRightInfo"];
    
    [self.mainMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.subTitleLabel2.mas_bottom).offset(10);
            make.left.mas_equalTo(self.imageUrlView.mas_right).offset(10);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-20);
    }];
    self.mainMessageLabel.text = _dataDictionary[@"mainMessage"];
    
}


#pragma mark - lazy
- (UIImageView *)imageUrlView {
    if (!_imageUrlView) {
        _imageUrlView = [[UIImageView alloc] init];
    }
    return _imageUrlView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _subTitleLabel;
}

- (UILabel *)subTitleLabel2 {
    if (!_subTitleLabel2) {
        _subTitleLabel2 = [[UILabel alloc] init];
        _subTitleLabel2.font = [UIFont systemFontOfSize:14];
    }
    return _subTitleLabel2;
}

- (UILabel *)topRightInfoLabel {
    if (!_topRightInfoLabel) {
        _topRightInfoLabel = [[UILabel alloc] init];
        _topRightInfoLabel.font = [UIFont systemFontOfSize:14];
    }
    return _topRightInfoLabel;
}

- (UILabel *)mainMessageLabel {
    if (!_mainMessageLabel) {
        _mainMessageLabel = [[UILabel alloc] init];
        _mainMessageLabel.font = [UIFont systemFontOfSize:14];
    }
    return _mainMessageLabel;
}
@end

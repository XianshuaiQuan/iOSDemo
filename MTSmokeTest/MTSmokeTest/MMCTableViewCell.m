//
//  MMCSmokeTestTableView.m
//  MTSmokeTest
//
//  Created by 全先帅 on 2021/3/21.
//

#import "MMCTableViewCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>


@interface MMCTableViewCell()

@property (nonatomic, strong) UIImageView *frontImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *poiidLabel;
@property (nonatomic, strong) UILabel *channelNameLabel;
@property (nonatomic, strong) UILabel *channelLabel;
@property (nonatomic, strong) UILabel *latAndLngLabel;
@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UILabel *adressLabel;
@property (nonatomic, strong) UILabel *overseasLabel;
@property (nonatomic, strong) UILabel *zoomLevelLabel;

@end

@implementation MMCTableViewCell
#pragma mark - init
- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubViews];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadSubViews];
    }
    return self;
}

#pragma mark - loadSubViews
- (void)loadSubViews {
    [self.contentView addSubview:self.frontImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.poiidLabel];
    [self.contentView addSubview:self.channelNameLabel];
    [self.contentView addSubview:self.channelLabel];
    [self.contentView addSubview:self.latAndLngLabel];
    [self.contentView addSubview:self.cityLabel];
    [self.contentView addSubview:self.adressLabel];
    [self.contentView addSubview:self.overseasLabel];
    [self.contentView addSubview:self.zoomLevelLabel];
}

#pragma mark - masnoryLayout
- (void) setItemsDictionary:(NSDictionary *)itemsDictionary {
    _itemsDictionary = itemsDictionary;
    
    [self.frontImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    self.frontImageView.layer.cornerRadius = 50;
    self.frontImageView.layer.masksToBounds = YES;
    self.frontImageView.layer.borderColor = [UIColor greenColor].CGColor;
    self.frontImageView.layer.borderWidth = 1.0f;
    if ([itemsDictionary objectForKey:@"frontImg"]) {
        NSURL *imageUrl = [NSURL URLWithString:itemsDictionary[@"frontImg"]];
        [self.frontImageView sd_setImageWithURL:imageUrl];
    }
    else {
        self.frontImageView.image = [UIImage imageNamed:@"meituan"];
    }
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top).offset(20);
            make.left.mas_equalTo(self.frontImageView.mas_right).offset(10);
            make.right.mas_equalTo(self.contentView.mas_right);
    }];
    if ([itemsDictionary objectForKey:@"name"]) {
        self.nameLabel.text = itemsDictionary[@"name"];
    }
    else {
        self.nameLabel.text = @"";
    }
   
    [self.poiidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(self.frontImageView.mas_right).offset(10);
            make.right.mas_equalTo(self.contentView.mas_right);
    }];
    if ([itemsDictionary objectForKey:@"poiid"]) {
        self.poiidLabel.text = [NSString stringWithFormat:@"poiid: %@",itemsDictionary[@"poiid"]];
    }
    else {
        self.poiidLabel.text = [NSString stringWithFormat:@"poiid: %@",@""];
    }
        
    [self.channelNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.poiidLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(self.frontImageView.mas_right).offset(10);
            make.right.mas_equalTo(self.contentView.mas_right);
    }];
    if ([itemsDictionary objectForKey:@"channelname"]) {
        self.channelNameLabel.text = [NSString stringWithFormat:@"渠道名: %@",itemsDictionary[@"channelname"]];
    }
    else {
        self.channelNameLabel.text = [NSString stringWithFormat:@"渠道名: %@",@""];
    }
    
    [self.channelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.channelNameLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(self.frontImageView.mas_right).offset(10);
            make.right.mas_equalTo(self.contentView.mas_right);
    }];
    if ([itemsDictionary objectForKey:@"channel"]) {
        self.channelLabel.text = [NSString stringWithFormat:@"mapsource: %@",itemsDictionary[@"channel"]];
    }
    else {
        self.channelLabel.text = [NSString stringWithFormat:@"mapsourece: %@",@""];
    }
    
    [self.latAndLngLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.channelLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(self.frontImageView.mas_right).offset(10);
            make.right.mas_equalTo(self.contentView.mas_right);
    }];
    if ([itemsDictionary objectForKey:@"lat"] && [itemsDictionary objectForKey:@"lng"]) {
        NSString *latAndLng =[NSString stringWithFormat:@"%@, %@",itemsDictionary[@"lat"],itemsDictionary[@"lng"]];
        self.latAndLngLabel.text = [NSString stringWithFormat:@"经纬度: %@",latAndLng];
    }
    else {
        self.latAndLngLabel.text = [NSString stringWithFormat:@"经纬度: %@",@""];
    }
    
    [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.latAndLngLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(self.frontImageView.mas_right).offset(10);
            make.right.mas_equalTo(self.contentView.mas_right);
    }];
    if ([itemsDictionary objectForKey:@"city"]) {
        self.cityLabel.text = [NSString stringWithFormat:@"城市: %@",itemsDictionary[@"city"]];
    }
    else {
        self.cityLabel.text = [NSString stringWithFormat:@"城市: %@",@""];
    }
    
    [self.adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.cityLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(self.frontImageView.mas_right).offset(10);
            make.right.mas_equalTo(self.contentView.mas_right);
    }];
    if ([itemsDictionary objectForKey:@"address"]) {
        self.adressLabel.text = [NSString stringWithFormat:@"地址: %@",itemsDictionary[@"address"]];
    }
    else {
        self.adressLabel.text = [NSString stringWithFormat:@"地址: %@",@""];
    }
    
    [self.overseasLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.adressLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(self.frontImageView.mas_right).offset(10);
            make.right.mas_equalTo(self.contentView.mas_right);
    }];
    if ([itemsDictionary objectForKey:@"overseas"]) {
        self.overseasLabel.text = [NSString stringWithFormat:@"海外: %@",itemsDictionary[@"overseas"]];
    }
    else {
        self.overseasLabel.text = [NSString stringWithFormat:@"海外: %@",@""];
    }
    
    [self.zoomLevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.overseasLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(self.frontImageView.mas_right).offset(10);
            make.right.mas_equalTo(self.contentView.mas_right);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    if ([itemsDictionary objectForKey:@"zoomLevel"]) {
        self.zoomLevelLabel.text = [NSString stringWithFormat:@"zoomLevel: %@",itemsDictionary[@"zoomLevel"]];
    }
    else {
        self.zoomLevelLabel.text = [NSString stringWithFormat:@"zoomLevel: %@",@""];
    }
    
}


#pragma mark - lazy
- (UIImageView *)frontImageView {
    if (!_frontImageView) {
        _frontImageView = [[UIImageView alloc] init];
    }
    return _frontImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    return _nameLabel;
}

- (UILabel *)poiidLabel {
    if (!_poiidLabel) {
        _poiidLabel = [[UILabel alloc] init];
        _poiidLabel.font = [UIFont systemFontOfSize:16];
    }
    return _poiidLabel;
}

- (UILabel *)channelLabel {
    if (!_channelLabel) {
        _channelLabel = [[UILabel alloc] init];
        _channelLabel.font = [UIFont systemFontOfSize:16];
    }
    return _channelLabel;
}

- (UILabel *)channelNameLabel {
    if (!_channelNameLabel) {
        _channelNameLabel = [[UILabel alloc] init];
        _channelNameLabel.font = [UIFont systemFontOfSize:16];
    }
    return _channelNameLabel;
}

- (UILabel *)latAndLngLabel {
    if (!_latAndLngLabel) {
        _latAndLngLabel = [[UILabel alloc] init];
        _latAndLngLabel.font = [UIFont systemFontOfSize:16];
    }
    return _latAndLngLabel;
}

- (UILabel *)cityLabel {
    if (!_cityLabel) {
        _cityLabel = [[UILabel alloc] init];
        _cityLabel.font = [UIFont systemFontOfSize:16];
    }
    return _cityLabel;
}

- (UILabel *)adressLabel {
    if (!_adressLabel) {
        _adressLabel = [[UILabel alloc] init];
        _adressLabel.font = [UIFont systemFontOfSize:16];
    }
    return _adressLabel;
}

- (UILabel *)overseasLabel {
    if (!_overseasLabel) {
        _overseasLabel = [[UILabel alloc] init];
        _overseasLabel.font = [UIFont systemFontOfSize:16];
    }
    return _overseasLabel;
}

- (UILabel *)zoomLevelLabel {
    if (!_zoomLevelLabel) {
        _zoomLevelLabel = [[UILabel alloc] init];
        _zoomLevelLabel.font = [UIFont systemFontOfSize:16];
    }
    return _zoomLevelLabel;
}

@end

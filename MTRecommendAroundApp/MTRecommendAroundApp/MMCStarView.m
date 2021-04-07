//
//  MMCStarView.m
//  MTRecommendAroundApp
//
//  Created by 全先帅 on 2021/3/31.
//

#import "MMCStarView.h"

@interface MMCStarView()

@property (nonatomic, strong) UIView *foreView;
@property (nonatomic, strong) UIView *backView;

@end

@implementation MMCStarView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backView];
    }
    return self;
}

- (void)setScore:(CGFloat)score {
    _score = score;
    
    CGFloat foreWidth = score / 5 * self.frame.size.width;
    self.foreView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, foreWidth, 20)];
    self.foreView.clipsToBounds = YES;
    for (NSInteger i=0; i<5; i++) {
        UIImageView *foreImage = [[UIImageView alloc] initWithFrame:CGRectMake(i * 20, 0, 20, 20)];
        foreImage.image = [UIImage imageNamed:@"yellow"];
        [self.foreView addSubview:foreImage];
    }
    [self addSubview:self.foreView];
}


#pragma mark - lazy
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        for (NSInteger i=0; i<5; i++) {
            UIImageView *foreImage = [[UIImageView alloc] initWithFrame:CGRectMake(i * 20, 0, 20, 20)];
            foreImage.image = [UIImage imageNamed:@"gray"];
            [_backView addSubview:foreImage];
        }
    }
    return _backView;
}


@end

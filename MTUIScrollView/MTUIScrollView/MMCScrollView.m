//
//  MMCScrollView.m
//  MTUIScrollView
//
//  Created by 全先帅 on 2021/3/15.
//

#import "MMCScrollView.h"
#import "MMCFuncPublic.h"

#define SCROLLVIEW_WIDTH self.frame.size.width
#define SCROLLVIEW_HEIGHT self.frame.size.height

static CGFloat const imageChangeTime = 1.5f;
static NSInteger currentImage = 1;

@interface MMCScrollView()<UIScrollViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;//图片描述

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *centerImageView;
@property (nonatomic, strong) UIImageView *rightImageView;

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *centerLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) NSTimer *moveTime;
@property (nonatomic, assign) BOOL isTimeUp;//系统滚动yes，人为滚动为no

@end

@implementation MMCScrollView

#pragma mark - initWithFrame
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //设置scrollView属性
        self.contentSize = CGSizeMake(SCROLLVIEW_WIDTH * 3, SCROLLVIEW_HEIGHT - 64);//滚动范围
        self.bounces = NO;//不许拖出边界
        self.pagingEnabled = YES;//是否支持分页
        self.contentOffset = CGPointMake(SCROLLVIEW_WIDTH, 0);//内容原点距scrollview左上角偏移//此处默认显示中间图片
        self.delegate = self;
        
        //加载视图
        [self loadSubViews];
        
        //时间
        self.moveTime = [NSTimer scheduledTimerWithTimeInterval:imageChangeTime repeats:YES block:^(NSTimer * _Nonnull timer) {
            //计时器倒计时，系统滚动图片
            [self setContentOffset:CGPointMake(SCROLLVIEW_WIDTH * 2, 0) animated:YES];
            self.isTimeUp = YES;
            [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:YES];
        }];
        self.isTimeUp = NO;
    }
    return self;
}

#pragma mark - 重写set方法
- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;

    self.leftImageView.image = [UIImage imageNamed:imageArray[0]];
    self.centerImageView.image = [UIImage imageNamed:imageArray[1]];
    self.rightImageView.image = [UIImage imageNamed:imageArray[2]];
}

- (void)setPageControlShowStyle:(UIPageControlShowStyle)pageControlShowStyle {
    if (pageControlShowStyle == UIPageControlShowStyleNone) {
        return;
    }
    self.pageControl.numberOfPages = self.imageArray.count;
    
    if (pageControlShowStyle == UIPageControlShowStyleLeft) {
        self.pageControl.frame = CGRectMake(10, CGRectGetMaxY(self.frame) - 20, 20 * self.pageControl.numberOfPages, 20);
    }
    else if (pageControlShowStyle == UIPageControlShowStyleCenter) {
        self.pageControl.frame = CGRectMake(0, 0, 20 * self.pageControl.numberOfPages, 20);
        self.pageControl.center = CGPointMake(SCROLLVIEW_WIDTH / 2, CGRectGetMaxY(self.frame) - 10);
    }
    else {
        self.pageControl.frame = CGRectMake(100, 100, 20*_pageControl.numberOfPages, 20);
    }
    
    self.pageControl.currentPage = 0;
    self.pageControl.enabled = NO;
    [self performSelector:@selector(addPageControl) withObject:nil afterDelay:0.1f];
    
}

- (void)addPageControl {
    [[self superview] addSubview:self.pageControl];
}

#pragma mark - 图片停止时调用函数复用滚动时视图
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.contentOffset.x == 0) {
        currentImage = (currentImage - 1) % self.imageArray.count;
        self.pageControl.currentPage = (self.pageControl.currentPage - 1) % self.imageArray.count;
    }
    else if (self.contentOffset.x == SCROLLVIEW_WIDTH * 2) {
        currentImage = (currentImage + 1) % self.imageArray.count;
        self.pageControl.currentPage = (self.pageControl.currentPage + 1) % self.imageArray.count;
    }
    else {
        return;
    }
    
    //赋值
    self.leftImageView.image = [UIImage imageNamed:self.imageArray[(currentImage-1)%self.imageArray.count]];
    self.leftLabel.text = self.titleArray[(currentImage-1)%self.imageArray.count];
    self.centerImageView.image = [UIImage imageNamed:self.imageArray[(currentImage)%self.imageArray.count]];
    self.centerLabel.text = self.titleArray[(currentImage)%self.imageArray.count];
    self.rightImageView.image = [UIImage imageNamed:self.imageArray[(currentImage+1)%self.imageArray.count]];
    self.rightLabel.text = self.titleArray[(currentImage+1)%self.imageArray.count];
    
    self.contentOffset = CGPointMake(SCROLLVIEW_WIDTH, 0);
    
    //保存信息
    NSString *imageArrayCountStr = [NSString stringWithFormat:@"%lu",self.imageArray.count];
    NSString *currentImageStr = [NSString stringWithFormat:@"%ld",currentImage-1];
    
    [MMCFuncPublic SaveDefaultInfo:imageArrayCountStr andKey:@"imageArrayCount"];
    [MMCFuncPublic SaveDefaultInfo:currentImageStr andKey:@"currentImage"];
    
    //手动控制时，关闭计时器
    if (!self.isTimeUp) {
        [self.moveTime setFireDate:[NSDate dateWithTimeIntervalSinceNow:imageChangeTime]];
    }
    _isTimeUp = NO;
}

#pragma mark - setTitleArray
- (void)setTitleArray:(NSArray *)titleArray withShowStyle:(TitleShowStyle)titleShowStyle {
    _titleArray = titleArray;
    
    if (titleShowStyle == TitleShowStyleNone) {
        return;
    }
    
    [self.leftImageView addSubview:self.leftLabel];
    [self.rightImageView addSubview:self.rightLabel];
    [self.centerImageView addSubview:self.centerLabel];
    
    [self.leftImageView addSubview:self.titleLabel];
    [self.centerImageView addSubview:self.titleLabel];
    [self.rightImageView addSubview:self.titleLabel];
    
    if (titleShowStyle == TitleShowStyleLeft) {
        self.leftLabel.textAlignment = NSTextAlignmentLeft;
        self.centerLabel.textAlignment = NSTextAlignmentLeft;
        self.rightLabel.textAlignment = NSTextAlignmentLeft;
    }else if (titleShowStyle == TitleShowStyleCenter){
        self.leftLabel.textAlignment = NSTextAlignmentCenter;
        self.centerLabel.textAlignment = NSTextAlignmentCenter;
        self.rightLabel.textAlignment = NSTextAlignmentCenter;
    }else{
        self.leftLabel.textAlignment = NSTextAlignmentRight;
        self.centerLabel.textAlignment = NSTextAlignmentRight;
        self.rightLabel.textAlignment = NSTextAlignmentRight;
    }
    
    self.leftLabel.text = titleArray[0];
    self.centerLabel.text = titleArray[1];
    self.rightLabel.text = titleArray[2];

}

#pragma mark - 添加手势
- (void)addTapToScrollViewWithObject:(id)object andSEL:(SEL)sel {
    self.centerImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:nil action:sel];
    [self.centerImageView addGestureRecognizer:tap];
}

#pragma mark - loadSubViews
- (void)loadSubViews {
    [self addSubview:self.centerImageView];
    [self addSubview:self.leftImageView];
    [self addSubview:self.rightImageView];
}

#pragma mark - lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCROLLVIEW_HEIGHT - 100, SCROLLVIEW_WIDTH, 40)];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCROLLVIEW_WIDTH, SCROLLVIEW_HEIGHT)];
    }
    return _leftImageView;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCROLLVIEW_WIDTH * 2, 0, SCROLLVIEW_WIDTH, SCROLLVIEW_HEIGHT)];
    }
    return _rightImageView;
}

- (UIImageView *)centerImageView {
    if (!_centerImageView) {
        _centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCROLLVIEW_WIDTH, 0, SCROLLVIEW_WIDTH, SCROLLVIEW_HEIGHT)];
        
    }
    return _centerImageView;
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, SCROLLVIEW_HEIGHT-40, SCROLLVIEW_WIDTH-20, 20)];
    }
    return _leftLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, SCROLLVIEW_HEIGHT-40, SCROLLVIEW_WIDTH-20, 20)];
    }
    return _rightLabel;
}

- (UILabel *)centerLabel {
    if (!_centerLabel) {
        _centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, SCROLLVIEW_HEIGHT-40, SCROLLVIEW_WIDTH-20, 20)];
    }
    return _centerLabel;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = [UIColor redColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    }
    return _pageControl;
}
@end

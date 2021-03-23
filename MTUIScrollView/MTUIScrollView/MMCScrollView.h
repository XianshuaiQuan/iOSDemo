//
//  MMCScrollView.h
//  MTUIScrollView
//
//  Created by 全先帅 on 2021/3/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, UIPageControlShowStyle) {
    UIPageControlShowStyleNone,
    UIPageControlShowStyleLeft,
    UIPageControlShowStyleCenter,
    UIPageControlShowStyleRight
};

typedef NS_ENUM(NSInteger, TitleShowStyle) {
    TitleShowStyleNone,
    TitleShowStyleLeft,
    TitleShowStyleCenter,
    TitleShowStyleRight
};

@interface MMCScrollView : UIScrollView

@property (nonatomic, copy) NSArray *imageArray;
@property (nonatomic, copy) NSArray *titleArray;

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) UIPageControlShowStyle pageControlShowStyle;
@property (nonatomic, assign) TitleShowStyle titleShowStyle;

- (void)setTitleArray:(NSArray * _Nonnull)titleArray withShowStyle:(TitleShowStyle)titleShowStyle;
- (void)addTapToScrollViewWithObject:(id)object andSEL:(SEL)sel;

@end

NS_ASSUME_NONNULL_END

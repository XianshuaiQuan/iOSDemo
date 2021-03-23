//
//  ViewController.m
//  MTUIScrollView
//
//  Created by 全先帅 on 2021/3/15.
//

#import "ViewController.h"
#import "MMCScrollView.h"
#import "MMCDataModel.h"
#import "MMCFuncPublic.h"

#define UISCREEN_HEIGHT self.view.bounds.size.height
#define UISCREEN_WIDTH self.view.bounds.size.width


@interface ViewController ()

@property (nonatomic, assign) NSInteger currentImageView;

@property (nonatomic, strong) MMCScrollView *scrollView;
@property (nonatomic, strong) MMCDataModel *dataModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationController];

    [self createScrollView];
}

#pragma mark - createScrollView
- (void)createScrollView {
    self.scrollView.imageArray = self.dataModel.imageArray;
    self.scrollView.pageControlShowStyle = UIPageControlShowStyleRight;
    
    [self.scrollView setTitleArray:self.dataModel.titleArray withShowStyle:TitleShowStyleLeft];
    [self.scrollView addTapToScrollViewWithObject:self andSEL:@selector(tapSEL)];
    
    [self.view addSubview:self.scrollView];
}

-(void)tapSEL{
    NSString *imageArrayCountStr = [MMCFuncPublic GetDefaultInfo:@"imageArrayCount"];
    NSString *currentImageStr = [MMCFuncPublic GetDefaultInfo:@"currentImage"];
    NSInteger imageArrayCount = [imageArrayCountStr integerValue];
    NSInteger currentImage = [currentImageStr integerValue];
    
    if (currentImage < 0) {
        currentImage = imageArrayCount-1;
    }
    
    NSLog(@"手势跳转%ld",(long)currentImage);
}

#pragma mark - 设置navigationController
- (void)setNavigationController {
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.backgroundColor = [UIColor greenColor];//导航栏着色
//    self.navigationController.navigationBar.tintColor = [UIColor yellowColor];//内容颜色
//    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];//整个bar着色
    self.navigationItem.title = @"UIScrollView";
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"左边按钮" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonClick)];
    self.navigationItem.leftBarButtonItem =leftButton;
    
}

- (void)leftBarButtonClick {
    
}

#pragma mark - lazy
- (MMCScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[MMCScrollView alloc] initWithFrame:CGRectMake(0, 64, UISCREEN_WIDTH, UISCREEN_HEIGHT - 64)];
    }
    return _scrollView;
}

- (MMCDataModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MMCDataModel alloc] initWithImageNameAndTitle];
    }
    return _dataModel;
}

@end

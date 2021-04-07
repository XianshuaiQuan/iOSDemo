//
//  ViewController.m
//  MTLotteryMachine
//
//  Created by 全先帅 on 2021/4/7.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *num1Label;
@property (nonatomic, strong) UILabel *num2Label;
@property (nonatomic, strong) UILabel *num3Label;
@property (nonatomic, strong) UIButton *actionButton;

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationController];
    [self loadSubViews];
}

#pragma mark - navigationController
- (void)setNavigationController {
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationItem.title = @"摇奖机";
}

#pragma mark - loadSubViews
- (void)loadSubViews {
    [self.view addSubview:self.num1Label];
    [self.view addSubview:self.num2Label];
    [self.view addSubview:self.num3Label];
    [self.view addSubview:self.actionButton];
}

#pragma mark - beginAction
- (void)beginAction {
    if (self.operationQueue.operationCount == 0) {
        self.operationQueue.suspended = NO;
        [self.operationQueue addOperationWithBlock:^{
            [self createRandNumber];
        }];
        [self.actionButton setTitle:@"暂停" forState:UIControlStateNormal];
    }
    else {
        //会继续执行当前未完成的任务，然后暂停后面的任务
        self.operationQueue.suspended = YES;
        [self.actionButton setTitle:@"开始" forState:UIControlStateNormal];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"任务数：%zd",self.operationQueue.operationCount);
}

//产生随机数
- (void)createRandNumber {
    //耗时操作，在子线程
    while (!self.operationQueue.isSuspended) {
        [NSThread sleepForTimeInterval:0.1];
        //产生随机数[0-10)
        int num1 = arc4random_uniform(10);
        int num2 = arc4random_uniform(10);
        int num3 = arc4random_uniform(10);
        
        //赋值 （刷新UI只能在主线程）
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.num1Label.text = [NSString stringWithFormat:@"%d",num1];
            self.num2Label.text = [NSString stringWithFormat:@"%d",num2];
            self.num3Label.text = [NSString stringWithFormat:@"%d",num3];
        }];
    }
}

#pragma mark - lazy
- (UILabel *)num1Label {
    if (!_num1Label) {
        _num1Label = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 100, 100)];
        _num1Label.text = @"0";
        _num1Label.font = [UIFont systemFontOfSize:25];
        _num1Label.textAlignment = NSTextAlignmentCenter;
    }
    return _num1Label;
}

- (UILabel *)num2Label {
    if (!_num2Label) {
        _num2Label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.num1Label.frame) + 20, 200, 100, 100)];
        _num2Label.text = @"0";
        _num2Label.font = [UIFont systemFontOfSize:25];
        _num2Label.textAlignment = NSTextAlignmentCenter;
    }
    return _num2Label;
}

- (UILabel *)num3Label {
    if (!_num3Label) {
        _num3Label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.num2Label.frame) + 20, 200, 100, 100)];
        _num3Label.text = @"0";
        _num3Label.font = [UIFont systemFontOfSize:25];
        _num3Label.textAlignment = NSTextAlignmentCenter;
    }
    return _num3Label;
}

- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.num2Label.frame) - 100 , CGRectGetMaxX(self.num2Label.frame) + 100, 200, 100)];
        [_actionButton setTitle:@"开始" forState:UIControlStateNormal];
        [_actionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _actionButton.titleLabel.font = [UIFont systemFontOfSize:30];
        
        [_actionButton addTarget:self action:@selector(beginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionButton;
}

- (NSOperationQueue *)operationQueue {
    if (!_operationQueue) {
        _operationQueue = [[NSOperationQueue alloc] init];
    }
    return _operationQueue;
}

@end

//
//  ViewController.m
//  MTRunLoopDemos
//
//  Created by 全先帅 on 2021/3/26.
//

#import "ViewController.h"
#import "MMCViewController2.h"
#import "MMCThread.h"

@interface ViewController ()

@property (nonatomic, strong) MMCViewController2 *viewController2;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *runLoopButton;
@property (nonatomic, strong) UIButton *dellocTestButton;

@property (nonatomic, strong) MMCThread *subThread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationController];
    [self loadSubViews];
}

#pragma mark - loadSubviews
- (void)loadSubViews {
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.runLoopButton];
    [self.view addSubview:self.dellocTestButton];
}

#pragma mark - navigationController
- (void)setNavigationController {
    self.navigationItem.title = @"demo1";
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"下一个" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonEvent)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)rightBarButtonEvent {
    [self.navigationController pushViewController:self.viewController2 animated:NO];
}


#pragma mark - 线程销毁测试
- (void)threadDellocTest {
    NSLog(@"开启threadDelloc子线程");
    MMCThread *threadDelloc = [[MMCThread alloc] initWithTarget:self selector:@selector(threadDellocTestAction) object:nil];
    [threadDelloc setName:@"threadDelloc"];
    [threadDelloc start];
}

- (void)threadDellocTestAction {
    NSLog(@"没启动runLoop");
    NSLog(@"%@----子线程任务开始",[NSThread currentThread]);
    [NSThread sleepForTimeInterval:3.0];
    NSLog(@"%@----子线程任务结束",[NSThread currentThread]);
}

#pragma mark - 开启runLoop保持子线程存活
- (void)runLoopButtonAction {
    [self performSelector:@selector(runLoopThreadAction) onThread:self.subThread withObject:nil waitUntilDone:NO];
}

- (void)startRunLoop
{
    @autoreleasepool {
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        //如果注释了下面这一行，子线程中的任务并不能正常执行
        [runLoop addPort:[NSMachPort port] forMode:NSRunLoopCommonModes];
        NSLog(@"启动RunLoop前--%@",runLoop.currentMode);
        [runLoop run];
    }
}

- (void)runLoopThreadAction
{
    NSLog(@"启动RunLoop后--%@",[NSRunLoop currentRunLoop].currentMode);
    NSLog(@"%@----子线程任务开始",[NSThread currentThread]);
    [NSThread sleepForTimeInterval:2.0];
    NSLog(@"%@----子线程任务结束",[NSThread currentThread]);
}


#pragma mark - lazy
- (MMCViewController2 *)viewController2 {
    if (!_viewController2) {
        _viewController2 = [[MMCViewController2 alloc] init];
    }
    return _viewController2;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 0)];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.text = @"使用RunLoop 保证线程存活，有任务时执行，没任务时睡眠，以避免资源消耗。\n启动程序后，先打印出主线程的runloop和runloopModel。\n再自动创建子线程，三秒后子线程休眠。\n点击按钮后，子线程收到任务，被唤醒。";
        
        _titleLabel.numberOfLines = 0;
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (MMCThread *)subThread {
    if (!_subThread) {
        _subThread = [[MMCThread alloc] initWithTarget:self selector:@selector(startRunLoop) object:nil];
        [_subThread setName:@"threadRunLoop"];
        [_subThread start];
    }
    return _subThread;
}

- (UIButton *)runLoopButton {
    if (!_runLoopButton) {
        _runLoopButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view .frame.size.width / 2 - 100 , CGRectGetMaxY(self.dellocTestButton.frame) + 50, 200, 80)];
        _runLoopButton.backgroundColor = [UIColor systemGray5Color];
        _runLoopButton.titleLabel.font = [UIFont systemFontOfSize:20];
        [_runLoopButton setTitle:@"启动runLoop后" forState:UIControlStateNormal];
        [_runLoopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_runLoopButton addTarget:self action:@selector(runLoopButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _runLoopButton;
}

- (UIButton *)dellocTestButton {
    if (!_dellocTestButton) {
        _dellocTestButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view .frame.size.width / 2 - 100 , CGRectGetMaxY(self.titleLabel.frame) + 50, 200, 80)];
        _dellocTestButton.backgroundColor = [UIColor systemGray5Color];
        _dellocTestButton.titleLabel.font = [UIFont systemFontOfSize:20];
        [_dellocTestButton setTitle:@"线程销毁测试" forState:UIControlStateNormal];
        [_dellocTestButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_dellocTestButton addTarget:self action:@selector(threadDellocTest) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dellocTestButton;
}


@end

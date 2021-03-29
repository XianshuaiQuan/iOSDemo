//
//  MMCViewController2.m
//  MTRunLoopDemos
//
//  Created by 全先帅 on 2021/3/26.
//

#import "MMCViewController2.h"
#import "MMCThread.h"

@interface MMCViewController2 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) MMCThread *subThread;

@property (nonatomic, strong) UIButton *startButton;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MMCViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationController];
    [self loadSubViews];
    
    
    
}
#pragma mark - loadSubView
- (void)loadSubViews {
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.startButton];
    [self.view addSubview:self.tableView];
}

#pragma mark - setNavigationController
- (void)setNavigationController {
    self.navigationItem.title = @"demo2";
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"上一个" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonEvent)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)leftBarButtonEvent {
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - timerTest
- (void)startSubThread {
    
    [self.subThread start];
    self.startButton.userInteractionEnabled = NO;
    
    //tableView滑动时会导致定时器暂停,因为在主线程中采用了NSDefaultRunLoopModel，而试图滑动采用的是UITrackingRunLoopMode
//    [self.timer fire];
}

- (void)timerTest {
    @autoreleasepool {
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        
        //当在主线程运行时采用NSDefaultRunLoopModel，tableView滑动时会导致定时器暂停，在子线程中则不会
        [self.timer fire];
        
        [runLoop run];
        
    }
}

- (void)timeUpdate {
    NSLog(@"当前线程为：%@",[NSThread currentThread]);
//    NSLog(@"当前runloop为：%@",[NSRunLoop currentRunLoop]);
//    NSLog(@"启动runloop后model为：%@",[NSRunLoop currentRunLoop].currentMode);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.count ++;
        NSString *timerText = [NSString stringWithFormat:@"计时器：%ld",self.count];
        self.timeLabel.text = timerText;
    });
}

#pragma mark - UItableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}

#pragma mark - lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 0)];
        _titleLabel.text = @"使用RunLoop保证Timer在视图滑动时能够正常运转的例子。";
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.numberOfLines = 0;
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 100, CGRectGetMaxY(self.titleLabel.frame) + 20, 200, 100)];
        _timeLabel.font = [UIFont systemFontOfSize:30];
    }
    return _timeLabel;
}

- (MMCThread *)subThread {
    if (!_subThread) {
        _subThread = [[MMCThread alloc] initWithTarget:self selector:@selector(timerTest) object:nil];
        [_subThread setName:@"我是子线程"];
    }
    return _subThread;
}

- (UIButton *)startButton {
    if (!_startButton) {
        _startButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.timeLabel.frame), CGRectGetMaxY(self.timeLabel.frame)+100, 200, 100)];
        [_startButton setTitle:@"开始" forState:UIControlStateNormal];
        _startButton.backgroundColor = [UIColor systemGray3Color];
        _startButton.titleLabel.font = [UIFont systemFontOfSize:30];
        
        [_startButton addTarget:self action:@selector(startSubThread)  forControlEvents:UIControlEventTouchUpInside];
    }
    return _startButton;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.startButton.frame) + 20, self.view.frame.size.width, 500)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timeUpdate) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
    return _timer;
}

@end

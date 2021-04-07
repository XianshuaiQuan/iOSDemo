//
//  ViewController.m
//  MTNSNotificationDemo
//
//  Created by 全先帅 on 2021/4/7.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController ()

@property (nonatomic, strong) UIButton *sendMessage;
@property (nonatomic, strong) UIButton *racSendMessage;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.sendMessage];
    [self.view addSubview:self.racSendMessage];
    
    //1、注册消息通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firstNotification:) name:@"first" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(secondNotification:) name:@"second" object:nil];
}


#pragma mark - 消息回调函数
- (void)firstNotification:(NSNotification *)notification {
    NSLog(@"收到%@消息:%@",notification.name,notification.object);
}

- (void)secondNotification:(NSNotification *)notification {
    NSLog(@"收到%@消息:%@  userInfo:%@",notification.name,notification.object,notification.userInfo);
}

//2、给观察者发送消息
- (void)sendMessages {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"first" object:@"我是第一条消息"];
    
    NSDictionary *dict = @{@"123":@"全先帅"};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"second" object:@"我是第二条消息" userInfo:dict];
    
}

//ReactiveCocoa替代NSNotification

//特点：1、不需要指定消息的接收者
//     2、不需要手动释放消息的接受者
- (void)racSendMessages {
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"first" object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * notification) {
        NSLog(@"RAC收到%@消息:%@",notification.name,notification.object);
    }];
}

//3、移除观察者
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - lazy
- (UIButton *)sendMessage {
    if (!_sendMessage) {
        _sendMessage = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 100, CGRectGetMidY(self.view.frame), 200, 100)];
        [_sendMessage setTitle:@"Notification" forState:UIControlStateNormal];
        [_sendMessage setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _sendMessage.titleLabel.font = [UIFont systemFontOfSize:30];
        
        [_sendMessage addTarget:self action:@selector(sendMessages) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendMessage;
}

- (UIButton *)racSendMessage {
    if (!_racSendMessage) {
        _racSendMessage = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 100, CGRectGetMaxY(self.sendMessage.frame) + 100, 200, 100)];
        [_racSendMessage setTitle:@"RacNotification" forState:UIControlStateNormal];
        [_racSendMessage setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _racSendMessage.titleLabel.font = [UIFont systemFontOfSize:30];
        
        [_racSendMessage addTarget:self action:@selector(racSendMessages) forControlEvents:UIControlEventTouchUpInside];
    }
    return _racSendMessage;
}
@end


//
//  MMCViewController2.m
//  MTRunLoopDemos
//
//  Created by 全先帅 on 2021/3/26.
//

#import "MMCViewController4.h"

@interface MMCViewController4 ()

@end

@implementation MMCViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationController];
}

#pragma mark - setNavigationController
- (void)setNavigationController {
    self.navigationItem.title = @"demo4";
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"上一个" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonEvent)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)leftBarButtonEvent {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - lazy

@end

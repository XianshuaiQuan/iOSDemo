//
//  MMCViewController2.m
//  MTRunLoopDemos
//
//  Created by 全先帅 on 2021/3/26.
//

#import "MMCViewController2.h"
#import "MMCViewController3.h"

@interface MMCViewController2 ()

@property (nonatomic, strong) MMCViewController3 *viewController3;

@end

@implementation MMCViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationController];
}

#pragma mark - setNavigationController
- (void)setNavigationController {
    self.navigationItem.title = @"demo2";
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"下一个" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonEvent)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"上一个" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonEvent)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)rightBarButtonEvent {
   [self.navigationController pushViewController:self.viewController3 animated:YES];
}

- (void)leftBarButtonEvent {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - lazy
- (MMCViewController3 *)viewController3 {
    if (!_viewController3) {
        _viewController3 = [[MMCViewController3 alloc] init];
    }
    return _viewController3;
}

@end

//
//  MMCViewController2.m
//  MTRunLoopDemos
//
//  Created by 全先帅 on 2021/3/26.
//

#import "MMCViewController3.h"
#import "MMCViewController4.h"

@interface MMCViewController3 ()

@property (nonatomic, strong) MMCViewController4 *viewController4;

@end

@implementation MMCViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationController];
}

#pragma mark - setNavigationController
- (void)setNavigationController {
    self.navigationItem.title = @"demo3";
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"下一个" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonEvent)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"上一个" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonEvent)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)rightBarButtonEvent {
   [self.navigationController pushViewController:self.viewController4 animated:YES];
}

- (void)leftBarButtonEvent {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - lazy
- (MMCViewController4 *)viewController4 {
    if (!_viewController4) {
        _viewController4 = [[MMCViewController4 alloc] init];
    }
    return _viewController4;
}

@end

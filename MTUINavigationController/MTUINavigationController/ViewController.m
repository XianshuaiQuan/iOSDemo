//
//  ViewController.m
//  UINavigationController
//
//  Created by 全先帅 on 2021/3/11.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIViewController *myViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationController];
    
    [self.navigationController pushViewController:self.myViewController animated:YES];
}

//设置navigationControll
- (void)setNavigationController {
    //设置navigationBar的外观 （全局的）
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;//白底黑字
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;//黑底白字
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];//背景色
    self.navigationController.navigationBar.tintColor = [UIColor blueColor];//字体背景色
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor redColor]};//标题字体属性
    
    //设置navigatioBar内容navigationItem
    //UINavigationBar的内容是由处于UINavigationController堆栈栈顶的UIViewController的navigationItem属性来配置的
    self.navigationItem.backButtonTitle = @"bufanhui";
    self.navigationItem.title = @"1";
    self.navigationItem.prompt = @"111";
}

#pragma mark - lazy
- (UIViewController *)myViewController {
    if (!_myViewController) {
        _myViewController = [[UIViewController alloc] init];
        _myViewController.view.backgroundColor = [UIColor greenColor];
        _myViewController.navigationItem.backButtonTitle = @"我的返回";
        _myViewController.navigationItem.title = @"2";
        _myViewController.navigationItem.prompt = @"222";
    }
    return _myViewController;
}

@end

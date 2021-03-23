//
//  ViewController.m
//  MMTUIKitDemo
//
//  Created by 全先帅 on 2021/3/10.
//

#import "ViewController.h"
#import "PickerViewController.h"

@interface ViewController ()

@property (nonatomic, strong) PickerViewController *pickerController;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *prevButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self loadSubViews];
}

- (void)loadSubViews {
    [self.view addSubview:self.nextButton];
    [self.view addSubview:self.prevButton];
}


- (void)pushController {
    int flag = 0;
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if (viewController == self.pickerController) {
            flag = 1;
            break;
        }
    }
    if (flag) {
        NSLog(@"该页面已存在，不可重复添加！");
    }
    else {
        [self.navigationController pushViewController:self.pickerController animated:YES];
        NSLog(@"添加成功");
    }
   
}
    
- (void)popController {
    [self.navigationController popViewControllerAnimated:YES];
}

 
#pragma mark - lazy
- (PickerViewController *)pickerController {
    if (!_pickerController) {
        _pickerController = [[PickerViewController alloc] init];
        _pickerController.view.backgroundColor = [UIColor yellowColor];
    }
    return _pickerController;
}

- (UIButton *)nextButton {
    if (!_nextButton) {
        _nextButton = [[UIButton alloc] initWithFrame:CGRectMake(100,self.view.frame.size.height / 2, 100, 40)];
        [_nextButton setTitle:@"下一页" forState:UIControlStateNormal];
        [_nextButton titleLabel].font = [UIFont systemFontOfSize:14];
        [_nextButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        _nextButton.backgroundColor = [UIColor grayColor];
        
        [_nextButton addTarget:self action:@selector(pushController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

- (UIButton *)prevButton {
    if (!_prevButton) {
        _prevButton = [[UIButton alloc] initWithFrame:CGRectMake(250,self.view.frame.size.height / 2, 100, 40)];
        [_prevButton setTitle:@"上一页" forState:UIControlStateNormal];
        [_prevButton titleLabel].font = [UIFont systemFontOfSize:14];
        [_prevButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        _prevButton.backgroundColor = [UIColor grayColor];
        
        [_prevButton addTarget:self action:@selector(popController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _prevButton;
}
@end

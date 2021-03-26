//
//  ViewController.m
//  MTRunLoopDemos
//
//  Created by 全先帅 on 2021/3/26.
//

#import "ViewController.h"
#import "MMCViewController2.h"

@interface ViewController ()

@property (nonatomic, strong) MMCViewController2 *viewController2;

@property (nonatomic, strong) UILabel *titleLabel;

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
}

#pragma mark - navigationController
- (void)setNavigationController {
    self.navigationItem.title = @"demo1";
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"下一个" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonEvent)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)rightBarButtonEvent {
    [self.navigationController pushViewController:self.viewController2 animated:YES];
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
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 100)];
        _titleLabel.backgroundColor = [UIColor greenColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = @"使用RunLoop 保证线程存活，有任务时执行，没任务时睡眠，以避免资源消耗。";
        [_titleLabel sizeToFit];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 20;  //设置行间距
        paragraphStyle.lineBreakMode = _titleLabel.lineBreakMode;
        paragraphStyle.alignment = _titleLabel.textAlignment;
    
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_titleLabel.text];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_titleLabel.text length])];
        _titleLabel.attributedText = attributedString;
        
        
        
    }
    return _titleLabel;
}

@end

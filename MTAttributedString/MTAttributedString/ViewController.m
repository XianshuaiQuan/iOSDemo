//
//  ViewController.m
//  MTArributedString
//
//  Created by 全先帅 on 2021/3/29.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *attributedStringLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationController];
    [self.view addSubview:self.attributedStringLabel];
    [self arributedStringTest];
}

#pragma mark - setnavigationController
- (void)setNavigationController {
    self.navigationItem.title = @"ArribuTedString";
}

- (void)arributedStringTest {
    NSString *str = @"这是一个富文本字符串\n";
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(4, 3)];
    
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:str];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, 3)];

    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    [attrs setObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    [attrs setObject:[UIFont systemFontOfSize:30] forKey:NSFontAttributeName];
    [attributedString2 addAttributes:attrs range:NSMakeRange(4,3)];
    
    //段落属性
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 20;
    paragraphStyle.paragraphSpacing = 40;
    paragraphStyle.headIndent = 200;
    
    
    [attributedString appendAttributedString:attributedString1];
    [attributedString appendAttributedString:attributedString2];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,  [str length] * 3)];
    
    self.attributedStringLabel.attributedText = attributedString;
}

#pragma mark - lazy
- (UILabel *)attributedStringLabel {
    if (!_attributedStringLabel) {
        _attributedStringLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 500)];
        _attributedStringLabel.backgroundColor = [UIColor systemGray5Color];
        _attributedStringLabel.backgroundColor = [UIColor systemGray4Color];
        _attributedStringLabel.textAlignment = NSTextAlignmentCenter;
        
        _attributedStringLabel.numberOfLines = 0;
        
    }
    return _attributedStringLabel;
}

@end

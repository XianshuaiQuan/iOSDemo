//
//  PickerViewController.m
//  MMTUIKitDemo
//
//  Created by 全先帅 on 2021/3/11.
//

#import "PickerViewController.h"

@interface PickerViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.pickerView];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArray.count;
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.view.frame.size.width;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 100;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataArray[row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = (UILabel *)view;
    if (!label) {
        label = [[UILabel alloc] init];
        label.text = [self pickerView:pickerView titleForRow:row forComponent:component];
        label.textColor = [UIColor redColor];
    }
    return label;
}

#pragma mark - lazy
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:self.view.frame];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
    }
    return _pickerView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        for (int i=0 ; i<10 ; i++) {
            NSString *userNmae = [NSString stringWithFormat:@"userNmae_%d",i+1];
            [_dataArray addObject:userNmae];
        }
    }
    return _dataArray;
}
@end

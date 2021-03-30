//
//  ViewController.m
//  MTRecommendAroundApp
//
//  Created by 全先帅 on 2021/3/30.
//

#import "ViewController.h"
#import "MMCRAAViewModel.h"
#import "MMCRAAModel.h"
#import "MMCRAAModelItems.h"
#import <Mantle/Mantle.h>

@interface ViewController ()

@property (nonatomic, strong) MMCRAAViewModel *dataRACCommand;
@property (nonatomic, strong) MMCRAAModel *dataModel;
@property (nonatomic, strong) MMCRAAModelItems *dataModelItems;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationController];
    [self bindViewModel];
    [self.dataRACCommand.dataRequest execute:nil];
}

#pragma mark - setNavigationController
- (void)setNavigationController {
    self.navigationItem.title = @"周边美食推荐";
}

#pragma mark - bindViewModel
- (void)bindViewModel {
    [self.dataRACCommand.dataRequest.executionSignals.switchToLatest subscribeNext:^(id x) {
        self.dataModel = x;
        self.dataModelItems = [MTLJSONAdapter modelOfClass:[MMCRAAModelItems class] fromJSONDictionary:self.dataModel.data[0] error:nil];
        
    }];
}

#pragma mark - lazy
- (MMCRAAViewModel *)dataRACCommand {
    if (!_dataRACCommand) {
        _dataRACCommand = [[MMCRAAViewModel alloc] init];
    }
    return _dataRACCommand;
}

- (MMCRAAModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MMCRAAModel alloc] init];
    }
    return _dataModel;
}

- (MMCRAAModelItems *)dataModelItems {
    if (!_dataModelItems) {
        _dataModelItems = [[MMCRAAModelItems alloc] init];
    }
    return _dataModelItems;
}

@end

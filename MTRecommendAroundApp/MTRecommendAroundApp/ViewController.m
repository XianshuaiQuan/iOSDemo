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
#import "MMCTableViewCell.h"
#import <Masonry/Masonry.h>
#import "MMCTableViewHeaderView.h"

#define SCREEN_WIDTH self.view.frame.size.width
#define SCREEN_HEIGHT self.view.frame.size.height

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MMCRAAViewModel *dataRACCommand;
@property (nonatomic, strong) MMCRAAModel *dataModel;
@property (nonatomic, strong) MMCRAAModelItems *dataModelItems;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationController];
    [self bindViewModel];
    [self.dataRACCommand.dataRequest execute:nil];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_top).offset(64);
            make.bottom.mas_equalTo(self.view.mas_bottom);
            make.left.mas_equalTo(self.view.mas_left);
            make.right.mas_equalTo(self.view.mas_right);
    }];
    
}

#pragma mark - setNavigationController
- (void)setNavigationController {
    self.navigationItem.title = @"周边美食推荐";
}

#pragma mark - bindViewModel
- (void)bindViewModel {
    [self.dataRACCommand.dataRequest.executionSignals.switchToLatest subscribeNext:^(id x) {
        self.dataModel = x;
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataModel.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    MMCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MMCTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
   cell.dataDictionary = self.dataModel.data[indexPath.item];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *headerViewIdentifier = @"headerViewIdentifier";
    MMCTableViewHeaderView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewIdentifier];
    if (!headView) {
        headView = [[MMCTableViewHeaderView alloc] initWithReuseIdentifier:headerViewIdentifier];
    }
    NSString *headTitle = [NSString stringWithFormat:@"  %@",self.dataModel.title];
    headView.title = headTitle;
    return headView;
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

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 300;
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

@end

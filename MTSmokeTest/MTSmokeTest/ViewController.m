//
//  ViewController.m
//  MTSmokeTest
//
//  Created by 全先帅 on 2021/3/19.
//

#import "ViewController.h"
#import "MMCSmokeTestViewModel.h"
#import <Masonry/Masonry.h>
#import "MMCTableViewCell.h"

#define SCREEN_WIDTH self.view.bounds.size.width
#define SCREEN_HEIGHT self.view.bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) MMCSmokeTestViewModel *viewModel;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *smokeTestTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationController];
    
    [self.view addSubview:self.smokeTestTableView];
    [_smokeTestTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);;
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top).offset(self.navigationController.navigationBar.frame.size.height);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    [self bindViewModel];
    [self.viewModel.dataRequest execute:nil];
    
}

#pragma mark - navigationController
- (void)setNavigationController {
    self.navigationController.navigationBar.barTintColor = [UIColor yellowColor];
    
    self.navigationItem.title = @"测试POI列表";
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

#pragma mark - bindViewModel
- (void)bindViewModel {
    [self.viewModel.dataRequest.executionSignals.switchToLatest subscribeNext:^(NSArray *x) {
        for (int i=0 ; i<x.count ; i++) {
            [self.dataSource addObject:x[i]];
        }
        [self.smokeTestTableView reloadData];
    }];
}

#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *indexTitles = [NSMutableArray array];
    for (NSDictionary *dict in self.dataSource) {
        [indexTitles addObject:dict[@"type"]];
    }
    return indexTitles;
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section][@"pois"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"tableViewCellIdentifier";
    MMCTableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!tableViewCell) {
        tableViewCell = [[MMCTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSLog(@"%@", self.dataSource[indexPath.section][@"pois"][indexPath.item]);
    NSDictionary *itemsDict = self.dataSource[indexPath.section][@"pois"][indexPath.item];
    tableViewCell.itemsDictionary = itemsDict;
    return tableViewCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 40)];
    titleLabel.text = self.dataSource[section][@"type"];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [headerView addSubview:titleLabel];
    
    
    return headerView;
}


#pragma mark - lazy
- (MMCSmokeTestViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MMCSmokeTestViewModel alloc] init];
    }
    return _viewModel;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (UITableView *)smokeTestTableView {
    if (!_smokeTestTableView) {
        _smokeTestTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];

        _smokeTestTableView.rowHeight = UITableViewAutomaticDimension;
        _smokeTestTableView.estimatedRowHeight = 400;
        
        _smokeTestTableView.delegate = self;
        _smokeTestTableView.dataSource = self;
    }
    return _smokeTestTableView;
}


@end

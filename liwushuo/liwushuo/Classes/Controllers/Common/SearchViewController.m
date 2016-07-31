//
//  SearchViewController.m
//  liwushuo
//
//  Created by caohaifeng on 16/5/27.
//  Copyright © 2016年 haifeng. All rights reserved.
//

#import "SearchViewController.h"
#import "searchModel.h"

@interface SearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UISearchBar      *searchBar;
@property (nonatomic, strong) UITableView      *tableView;
@property (nonatomic, strong) NSMutableArray   *titleArr;
@property (nonatomic, strong) searchModel      *searchmodel;


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.924 alpha:1.000];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButton:)];
    
    //创建视图
    self.navigationItem.titleView = self.searchBar;
    [self.view addSubview:self.tableView];
    
    //获取数据
    [self getTitleData];


}

- (void)rightBarButton:(UIBarButtonItem *)right {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 数据加载
- (void)getTitleData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api.liwushuo.com/v2/search/hot_words" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = responseObject[@"data"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark -- 懒加载
#pragma mark -----searchBar
- (UISearchBar *)searchBar {
    if (_searchBar == nil) {
      _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 44)];
        _searchBar.delegate = self;
    }
    return _searchBar;
}

//searchBar的代理方法
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
}

#pragma mark -- tableView
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

//每组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

//cell的样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellIndentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCellIndentifier"];
    }
    cell.textLabel.text = @"1213";
    return cell;
}

//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


#pragma mark -- 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

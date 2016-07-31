//
//  PopularGiftsController.m
//  liwushuo
//
//  Created by caohaifeng on 16/5/27.
//  Copyright © 2016年 haifeng. All rights reserved.
//

#import "PopularGiftsController.h"
#import "PopularCollectionViewCell.h"
#import "HotModel.h"
#import "PopularDetialViewController.h"

@interface PopularGiftsController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) HotModel         *hotModel;
@property (nonatomic, strong) NSMutableArray   *dataSource;
@property (nonatomic, strong) NSMutableArray   *mutableArray;
@property (nonatomic, assign) NSInteger         page;
@property (nonatomic, strong) MBProgressHUD    *HUD;


@end

@implementation PopularGiftsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:228 / 255.0 green:228 / 255.0  blue:228 / 255.0 alpha:1.0];
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
    self.mutableArray = [NSMutableArray arrayWithCapacity:0];
    
    [self createSearchButton];
    [self getData];

    [self.view addSubview:self.collectionView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    // 马上进入刷新状态
//    [self.collectionView.mj_header beginRefreshing];
}


#pragma mark -- 获取网络数据
- (void)getData {
    _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.color = [UIColor blackColor];
    _HUD.dimBackground = YES;
    _HUD.labelText = @"正在加载";
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:PopularGiftsURL,(long) self.page ] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = [responseObject[@"data"] objectForKey:@"items"];
        
        for (NSDictionary *dic in array) {
            NSMutableArray *mutableArr = [NSMutableArray arrayWithArray:dic[@"data"][@"image_urls"]];
            
            self.hotModel = [[HotModel alloc] initWithDictionary:dic[@"data"]];
            [self.dataSource addObject:self.hotModel];
            [self.mutableArray addObject:mutableArr];
        }
        _HUD.hidden = YES;
        [self endRefresh];
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self endRefresh];
    }];
}

#pragma mark---搜索按钮
- (void)createSearchButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setImage:[UIImage imageNamed:@"searchButtonIcon"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

//搜索按钮的点击事件
- (void)searchButtonAction:(UIBarButtonItem *)right {
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark -- 懒加载
#pragma mark -- collectionView
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.itemSize = CGSizeMake((self.view.width - 20) / 2, 250);
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 69 - 44) collectionViewLayout:flowLayout];
        [self.collectionView registerClass:[PopularCollectionViewCell class] forCellWithReuseIdentifier:@"PopularCollectionViewCell"];
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.backgroundColor = [UIColor clearColor];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.page = 0;
            [self getData];
        }];
        _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            self.page += 20;
            [self getData];
        }];
    }
    return _collectionView;
}

/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}

/**
 * 更新视图.
 */
- (void) updateView
{
    [self.collectionView reloadData];
}

#pragma mark - CollectionViewDataSource
//返回的cell的样式
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PopularCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PopularCollectionViewCell" forIndexPath:indexPath];
    cell.hotModel = self.dataSource[indexPath.item];
    return cell;
}

//返回的行数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataSource.count) {
        return self.dataSource.count;
    }
    return 0;
}

#pragma mark - UICollectionViewDelegate
//点击每一个cell的时候
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    PopularDetialViewController *hotDetial = [[PopularDetialViewController alloc] init];
    HotModel *hotModel = self.dataSource[indexPath.row];
    hotDetial.model = hotModel;
//    if (self.mutableArray.count) {
//        hotDetial.model = self.dataSource[indexPath.item];
//        hotDetial.dataArray = self.dataSource[indexPath.item];
//        hotDetial.array = self.mutableArray[indexPath.item];
//        hotDetial.urlString = hotModel.url;
//    }
    
    
    [self.navigationController pushViewController:hotDetial animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

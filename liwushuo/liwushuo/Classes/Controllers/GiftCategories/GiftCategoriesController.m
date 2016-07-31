//
//  GiftCategoriesController.m
//  liwushuo
//
//  Created by caohaifeng on 16/5/27.
//  Copyright © 2016年 haifeng. All rights reserved.
//

#import "GiftCategoriesController.h"
#import "HFClassifyCollectionViewCell.h"

@interface GiftCategoriesController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic,strong) UICollectionView    *collectionView;
@property(strong, nonatomic) UISegmentedControl *segmentedControl;

@end

@implementation GiftCategoriesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSearchButton];
    [self segmentedControls];
    [self.view addSubview:self.collectionView];
    
}

#pragma mark -- 添加搜索按钮
- (void)createSearchButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setImage:[UIImage imageNamed:@"searchButtonIcon"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

//搜索按钮点击事件
- (void)searchButtonAction:(UIBarButtonItem *)right {
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark -- 分段控制器
- (void)segmentedControls {
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"攻略", @"礼物"]];
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.frame = CGRectMake(0, 0, 150, 30);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    segmentedControl.layer.cornerRadius = 3;
    segmentedControl.layer.masksToBounds = YES;
    [segmentedControl addTarget:self action:@selector(segmentedControlDidPress:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;
    self.segmentedControl = segmentedControl;
}

//点击分段控制器
- (void)segmentedControlDidPress:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 1) {
        self.collectionView.contentOffset = CGPointMake(self.view.width, 0);
    }else {
        self.collectionView.contentOffset = CGPointMake(0, 0);
    }
}

#pragma mark -- 懒加载
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = CGFLOAT_MIN;
        flowLayout.minimumLineSpacing = CGFLOAT_MIN;
        flowLayout.sectionInset = UIEdgeInsetsMake(CGFLOAT_MIN, CGFLOAT_MIN, CGFLOAT_MIN, CGFLOAT_MIN);
        flowLayout.itemSize = CGSizeMake(self.view.width, self.view.height);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[HFClassifyCollectionViewCell class] forCellWithReuseIdentifier:@"HFClassifyCollectionViewCellIdentifier"];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"HFGiftCollectionViewCellIdentifier"];
    }
    return _collectionView;
}

#pragma mark -- UICollectionViewDataSource
//item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

//cell的样式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        HFClassifyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HFClassifyCollectionViewCellIdentifier" forIndexPath:indexPath];
        return cell;
    } else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HFGiftCollectionViewCellIdentifier" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor greenColor];
        return cell;
    }
}

//滚动时
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.collectionView.contentOffset.x == 0) {
        self.segmentedControl.selectedSegmentIndex = 0;
    }else {
        self.segmentedControl.selectedSegmentIndex = 1;
    }
}

#pragma mark -- 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

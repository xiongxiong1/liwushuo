//
//  RaidersGiftsController.m
//  liwushuo
//
//  Created by caohaifeng on 16/5/27.
//  Copyright © 2016年 haifeng. All rights reserved.
//

#import "RaidersGiftsController.h"
#import "MYChannelLabel.h"

static NSString *const reuseID  = @"MYChannelCell";

@interface RaidersGiftsController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)NSArray          *channelList;
@property(nonatomic,strong)UIScrollView     *smallScrollView;
@property(nonatomic,strong)UICollectionView *bigCollectionView;
@property(nonatomic,strong)UIView           *underLine;
@property(nonatomic,strong)UIButton         *sortButton;
@property(nonatomic,strong)NSMutableArray   *pullArr;
@property(nonatomic,strong)NSMutableArray   *scrollIdArr;
@property(nonatomic,strong)NSMutableArray   *scrollButtonArr;
@property(nonatomic,strong)NSArray          *scrollTitleArr;

@end

@implementation RaidersGiftsController

- (instancetype)init {
    if (self == [super init]) {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //     Do any additional setup after loading the view.
    [self createSearchButton];
    [self.view addSubview:self.bigCollectionView];
    
    [self getData];
}

#pragma mark -- 数据请求
- (void)getData {
    [self.smallScrollView removeAllSubviews];
    self.pullArr = [[NSMutableArray alloc] initWithCapacity:0];
    self.scrollButtonArr = [[NSMutableArray alloc] initWithCapacity:0];
    self.scrollIdArr = [[NSMutableArray alloc] initWithCapacity:0];
    
//    SAKeyValueStore *store = [[SAKeyValueStore alloc] initDBWithName:@"myitems.db"];
//    [store createTableWithName:@"guide"];
//    for (SAKeyValueItem *item in [store getAllItemsFromTable:@"guide"]) {
//        [self.pullArr addObject:[item.itemObject valueForKey:@"name"]];
//        [self.scrollIdArr addObject:[item.itemObject valueForKey:@"id"]];
//    }
    self.scrollTitleArr = [NSArray arrayWithArray:self.pullArr];
    [self.bigCollectionView reloadData];
}

//搜索按钮的创建
- (void)createSearchButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setImage:[UIImage imageNamed:@"searchButtonIcon"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

//实现搜索按钮的点击事件
- (void)searchButtonAction:(UIBarButtonItem *)right {
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark -- 懒加载
//滚动视图
- (UIScrollView *)smallScrollView {
    if (_smallScrollView == nil) {
        _smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _smallScrollView.backgroundColor = [UIColor redColor];
        [self setupChannelLabel];
        [_smallScrollView addSubview:self.underLine];
    }
    return _smallScrollView;
}

/** 设置频道标题 */
- (void)setupChannelLabel {
    CGFloat margin = 20.0;
    CGFloat x = 8;
    CGFloat h = _smallScrollView.bounds.size.height;
    int i = 0;
    
}

//设置下划线
- (UIView *)underLine {
    if (_underLine == nil) {
        _underLine = [[UIView alloc] initWithFrame:CGRectMake(0, 12, 50, 20)];
        _underLine.backgroundColor = [UIColor blackColor];
        _underLine.alpha = 0.4;
        _underLine.layer.cornerRadius = 10;
    }
    return _underLine;
}

//collectionView
- (UICollectionView *)bigCollectionView {
    if (_bigCollectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _bigCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.smallScrollView.maxY, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - self.smallScrollView.height) collectionViewLayout:flowLayout];
        _bigCollectionView.backgroundColor = [UIColor whiteColor];
        _bigCollectionView.delegate = self;
        _bigCollectionView.dataSource = self;
        [_bigCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseID];
        // 设置cell的大小和细节
        flowLayout.itemSize = _bigCollectionView.bounds.size;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        _bigCollectionView.pagingEnabled = YES;
        _bigCollectionView.showsHorizontalScrollIndicator = NO;
        
    }
    return _bigCollectionView;
}

#pragma mark - UICollectionViewDataSource
//总个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

//cell的样式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
    return cell;

}

//#pragma mark - UICollectionViewDelegate
///** 正在滚动 */
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat value = scrollView.contentOffset.x / scrollView.frame.size.width;
//    if (value < 0) {return;} // 防止在最左侧的时候，再滑，下划线位置会偏移，颜色渐变会混乱。
//    
//    NSUInteger leftIndex = (int)value;
//    NSUInteger rightIndex = leftIndex + 1;
//    if (rightIndex >= [self getLabelArrayFromSubviews].count) {  // 防止滑到最右，再滑，数组越界，从而崩溃
//        rightIndex = [self getLabelArrayFromSubviews].count - 1;
//    }
//    
//    CGFloat scaleRight = value - leftIndex;
//    CGFloat scaleLeft  = 1 - scaleRight;
//    
//    MYChannelLabel *labelLeft  = [self getLabelArrayFromSubviews][leftIndex];
//    MYChannelLabel *labelRight = [self getLabelArrayFromSubviews][rightIndex];
//    
//    labelLeft.scale  = scaleLeft;
//    labelRight.scale = scaleRight;
//    
//    // 点击label会调用此方法1次，会导致【scrollViewDidEndScrollingAnimation】方法中的动画失效，这时直接return。
//    if (scaleLeft == 1 && scaleRight == 0) {
//        return;
//    }
//    _underLine.centerX = labelLeft.centerX   + (labelRight.centerX   - labelLeft.centerX)   * scaleRight;
//    _underLine.width   = labelLeft.textWidth + (labelRight.textWidth - labelLeft.textWidth) * scaleRight;
//}
//
///** 获取smallScrollView中所有的MYChannelLabel，合成一个数组，因为smallScrollView.subViews中有其他非Label元素 */
//- (NSArray *)getLabelArrayFromSubviews
//{
//    NSMutableArray *arrayM = [NSMutableArray array];
//    for (MYChannelLabel *label in self.smallScrollView.subviews) {
//        if ([label isKindOfClass:[MYChannelLabel class]]) {
//            [arrayM addObject:label];
//        }
//    }
//    return arrayM.copy;
//}
//
///** 手指滑动BigCollectionView，滑动结束后调用 */
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    if ([scrollView isEqual:self.bigCollectionView]) {
//        [self scrollViewDidEndScrollingAnimation:scrollView];
//    }
//}
//
///** 手指点击smallScrollView */
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
//    // 获得索引
//    NSUInteger index = scrollView.contentOffset.x / self.bigCollectionView.width;
//    // 滚动标题栏到中间位置
//    MYChannelLabel *titleLable = [self getLabelArrayFromSubviews][index];
//    CGFloat offsetx   =  titleLable.center.x - _smallScrollView.width * 0.5;
//    CGFloat offsetMax = _smallScrollView.contentSize.width - _smallScrollView.width;
//    // 在最左和最右时，标签没必要滚动到中间位置。
//    if (offsetx < 0)		 {offsetx = 0;}
//    if (offsetx > offsetMax) {offsetx = offsetMax;}
//    [_smallScrollView setContentOffset:CGPointMake(offsetx, 0) animated:YES];
//    
//    // 先把之前着色的去色：（快速滑动会导致有些文字颜色深浅不一，点击label会导致之前的标题不变回黑色）
//    for (MYChannelLabel *label in [self getLabelArrayFromSubviews]) {
//        label.textColor = [UIColor blackColor];
//    }
//    // 下划线滚动并着色
//    [UIView animateWithDuration:0.5 animations:^{
//        _underLine.width = titleLable.textWidth;
//        _underLine.centerX = titleLable.centerX;
//        titleLable.textColor = [UIColor redColor];
//    }];
//}

#pragma mark -- 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

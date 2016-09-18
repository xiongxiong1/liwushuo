//
//  GuidePageViewController.m
//  liwushuo
//
//  Created by Backkom on 9/18/16.
//  Copyright © 2016 haifeng. All rights reserved.
//

#import "GuidePageViewController.h"

@interface GuidePageViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray       *backGroudVIewArray;
@property (nonatomic, strong) NSArray       *scrollViewPages;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger     centerPageIndex;

@end

@implementation GuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    [self.view addSubview:self.enterButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///懒加载
//滚动视图
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

//分页控制器
- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
       _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 30, self.view.bounds.size.width, 30)];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    }
    return _pageControl;
}

//进入按钮
- (UIButton *)enterButton {
    if (_enterButton == nil) {
        _enterButton = [[UIButton alloc] init];
        _enterButton.frame = [self frameOfEnterButton];
        [_enterButton setTitle:@"Enter" forState:UIControlStateNormal];
        _enterButton.layer.borderWidth = 0.5;
        _enterButton.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor whiteColor]);
        _enterButton.alpha = 0;
        [_enterButton addTarget:self action:@selector(enter:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _enterButton;
}
//按钮的frame
- (CGRect)frameOfEnterButton {
    CGSize size = self.enterButton.bounds.size;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        size = CGSizeMake(self.view.frame.size.width * 0.6, 40);
    }
    return CGRectMake(self.view.frame.size.width / 2 - size.width / 2, self.pageControl.frame.origin.y - size.height, size.width, size.height);
}
//按钮的点击事件
- (void)enter:(id)object
{
    [self.delegate click];
}

@end

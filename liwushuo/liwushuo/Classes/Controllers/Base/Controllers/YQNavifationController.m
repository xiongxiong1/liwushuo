//
//  YQNavifationController.m
//  YQNavigationController
//
//  Created by 杨雯德 on 16/2/17.
//  Copyright © 2016年 杨雯德. All rights reserved.
//

#import "YQNavifationController.h"
#define kDefaultBackImageName @"back"


/**
 *  真正意义上的展示的导航视图
 *
 *  @return 展示的导航视图
 */
#pragma mark - YQWrapNavigationController

@interface YQWrapNavigationController : UINavigationController

@end


/**
 *  导航视图的父视图
 *
 *  @param YQWrapViewController YQWrapViewController Object
 *
 *  @return 导航视图的父视图
 */
#pragma mark - YQWrapViewController
@interface YQWrapViewController : UIViewController

+ (YQWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController;

@end


/**
 *  展示视图NavigationController
 */
@implementation YQWrapNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏的颜色和字体
    self.navigationBar.barTintColor = MYRGB(62.0, 184.0, 181.0, 1);
    [self.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationBar.translucent = NO;
    
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    YQWrapNavigationController *na = (YQWrapNavigationController *)self.navigationController;
    return [na popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    YQWrapNavigationController *na = (YQWrapNavigationController *)self.navigationController;
    
    return [na popToRootViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    YQWrapNavigationController *na = (YQWrapNavigationController *)self.navigationController;
    NSInteger index = [na.viewControllers indexOfObject:viewController];
    return [na popToViewController:na.viewControllers[index] animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    UIImage *backButtonImage = [UIImage imageNamed:kDefaultBackImageName];
//    UIImage *backButtonImage = [UIImage imageNamed:nil];

    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(didTapBackButton)];
    viewController.hidesBottomBarWhenPushed = YES;
    YQWrapNavigationController *na = (YQWrapNavigationController *)self.navigationController;
    [na pushViewController:[YQWrapViewController wrapViewControllerWithViewController:viewController] animated:animated];
}

- (void)didTapBackButton {
    YQWrapNavigationController *na = (YQWrapNavigationController *)self.navigationController;
    [na popViewControllerAnimated:YES];
}

@end

/**
 *  父视图
 */
@implementation YQWrapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

+ (YQWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController {
    
    YQWrapNavigationController *wrapNavController = [[YQWrapNavigationController alloc] init];
    YQWrapViewController *wrapViewController = [[YQWrapViewController alloc] init];
    [wrapViewController.view addSubview:wrapNavController.view];
    [wrapViewController addChildViewController:wrapNavController];
    wrapNavController.viewControllers = @[viewController];
    return wrapViewController;
}

@end


/**
 *  初始化方法
 */
@implementation YQNavifationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarHidden:YES];
    
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super init]) {
        self.viewControllers = @[[YQWrapViewController wrapViewControllerWithViewController:rootViewController]];
    }
    return self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

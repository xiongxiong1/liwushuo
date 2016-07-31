//
//  MYTabBarController.m
//  liwushuo
//
//  Created by caohaifeng on 16/5/27.
//  Copyright © 2016年 haifeng. All rights reserved.
//

#import "MYTabBarController.h"
#import "YQNavifationController.h"
#import "RaidersGiftsController.h"
#import "PopularGiftsController.h"
#import "GiftCategoriesController.h"
#import "MineController.h"

@interface MYTabBarController ()

@end

@implementation MYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildControllers];
}

//添加子控制器
- (void)addChildControllers {
    [self addChildControllerWithController:[[RaidersGiftsController alloc] init] andTitle:@"送礼攻略" andImageName:@"presentIcon"];
    [self addChildControllerWithController:[[PopularGiftsController alloc] init] andTitle:@"热门礼品" andImageName:@"hotIcon"];
    [self addChildControllerWithController:[[GiftCategoriesController alloc] init] andTitle:@"礼品分类" andImageName:@"classityIcon"];
    [self addChildControllerWithController:[[MineController alloc] init] andTitle:@"我的" andImageName:@"mineIcon"];
    
}

//添加单个控制器
- (void)addChildControllerWithController:(UIViewController *)controller andTitle:(NSString *)title andImageName:(NSString *)imageName {
    self.tabBar.tintColor = [UIColor redColor];
    YQNavifationController *vc = [[YQNavifationController alloc] initWithRootViewController:controller];
    controller.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    [self addChildViewController:vc];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

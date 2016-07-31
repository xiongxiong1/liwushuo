//
//  PopularDetialViewController.m
//  liwushuo
//
//  Created by caohaifeng on 16/5/27.
//  Copyright © 2016年 haifeng. All rights reserved.
//

#import "PopularDetialViewController.h"
#import "HotModel.h"

@interface PopularDetialViewController ()

@end

@implementation PopularDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"商品详情";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    NSLog(@"%@",self.model);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shareICon"] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction:)];

}

#pragma mark -- 分享按钮
- (void)shareAction:(UIBarButtonItem *)share {
    
}

#pragma mark -- 内存警告
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

//
//  MineController.m
//  liwushuo
//
//  Created by caohaifeng on 16/5/27.
//  Copyright © 2016年 haifeng. All rights reserved.
//

#import "MineController.h"

@interface MineController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UITableView *tableView;


@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.imageView];

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    //    if (y < 0) {
    CGRect frame = self.imageView.frame;
    //        frame.origin.y = y;
    frame.size.height =  -y;
    self.imageView.frame = frame;
    //    }
    
}

#pragma mark -- 懒加载
//头像
- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
        _imageView.image = [UIImage imageNamed:@"1"];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

//tableView
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.contentInset = UIEdgeInsetsMake(200, 10, 0, 0);
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

#pragma mark --- tableViewDataSource

//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

//cell的样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"tableViewCell"];
    }
    cell.textLabel.text = @"你好";
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

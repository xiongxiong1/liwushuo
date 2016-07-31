//
//  HFClassifyCollectionViewCell.m
//  liwushuo
//
//  Created by caohaifeng on 6/17/16.
//  Copyright © 2016 haifeng. All rights reserved.
//

#import "HFClassifyCollectionViewCell.h"
#import "ClassifyModel.h"

@interface HFClassifyCollectionViewCell () <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)  UITableView      *tableview;
@property(nonatomic,strong)  NSMutableArray   *dataSource;
@property(nonatomic,strong)  NSMutableArray   *data;
@property(nonatomic,strong)  MBProgressHUD    *HUD;
@property(nonatomic,copy)    NSString         *url;

@end

@implementation HFClassifyCollectionViewCell

//初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
        self.data       = [NSMutableArray arrayWithCapacity:0];
        
        [self getDataSource];
        [self addSubview:self.tableview];
        NSLog(@"打我啊");
        NSLog(@"%@",self.dataSource);
    }
    return self;
}

#pragma mark -- 获取网络数据
- (void)getDataSource {
    _HUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
    _HUD.color = [UIColor blackColor];
    _HUD.dimBackground = YES;
    _HUD.labelText = @"正在加载";
 
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:kStrategySpecialURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = responseObject[@"data"];
        NSArray *array = dictionary[@"collections"];
        for (NSDictionary *dic in array) {
            ClassifyModel *model = [[ClassifyModel alloc] initWithDictionary:dic];
            [self.dataSource addObject:model];
        }
        self.url = [dictionary[@"collections"] valueForKey:@"next_url"];
//        self.url = [dictionary[@"paging"] valueForKey:@"next_url"];
//        [_HUD hide:YES];
        NSLog(@"我爱你");
        NSLog(@"%@",self.url);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark -- 懒加载
//tableView
- (UITableView *)tableview {
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStyleGrouped];
        _tableview.dataSource = self;
        _tableview.delegate = self;
    }
    return _tableview;
}


#pragma mark - tableViewDataSource
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

//组数
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 2;
//}

//cell的样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HFClassifyTableViewCellIdentifier"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"HFClassifyTableViewCellIdentifier"];
        }
        cell.backgroundColor = [UIColor redColor];
        return cell;
        
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HFClassButtonTableViewCellIdentifier"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"HFClassButtonTableViewCellIdentifier"];
        }
        cell.backgroundColor = [UIColor greenColor];
        return cell;
    }
}

@end

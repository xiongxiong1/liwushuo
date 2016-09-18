//
//  GuidePageViewController.h
//  liwushuo
//
//  Created by Backkom on 9/18/16.
//  Copyright © 2016 haifeng. All rights reserved.
//

#import "BaseViewController.h"

@protocol guidePageDelegate <NSObject>
- (void)click;
@end

@interface GuidePageViewController : BaseViewController

@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIButton *enterButton;
@property(nonatomic,strong) id<guidePageDelegate>delegate;
@property(nonatomic,strong) NSArray *backGroudNameArray;
@property(nonatomic,strong) NSArray *coverNameArray;

@end

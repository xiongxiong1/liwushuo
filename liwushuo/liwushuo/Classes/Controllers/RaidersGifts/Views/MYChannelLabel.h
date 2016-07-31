//
//  MYChannelLabel.h
//  liwushuo
//
//  Created by caohaifeng on 7/16/16.
//  Copyright © 2016 haifeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYChannelLabel : UILabel

@property(nonatomic,assign) CGFloat scale;
@property(nonatomic,assign) CGFloat textWidth;

+ (instancetype)channelLabelWithTitle:(NSString *)title;

@end

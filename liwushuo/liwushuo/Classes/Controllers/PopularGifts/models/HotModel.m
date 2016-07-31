//
//  HotModel.m
//  liwushuo
//
//  Created by caohaifeng on 16/5/27.
//  Copyright © 2016年 haifeng. All rights reserved.
//

#import "HotModel.h"

@implementation HotModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"description"]) {
        self.descriptions = value;
    }
    if ([key isEqualToString:@"id"]) {
        self.ids = value;
    }
}

@end

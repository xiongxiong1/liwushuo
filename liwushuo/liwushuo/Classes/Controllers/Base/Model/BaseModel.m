//
//  BaseModel.m
//  liwushuo
//
//  Created by caohaifeng on 16/5/27.
//  Copyright © 2016年 haifeng. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (instancetype)initWithDictionary:(NSDictionary *)dataSource
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dataSource];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        self.nId = value;
    }
    
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

@end

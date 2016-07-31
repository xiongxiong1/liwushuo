//
//  BaseModel.h
//  liwushuo
//
//  Created by caohaifeng on 16/5/27.
//  Copyright © 2016年 haifeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property (nonatomic, strong) NSString *nId;

- (instancetype)initWithDictionary:(NSDictionary *)dataSource;
//+ (instancetype)BaseModelWithDictionary:(NSDictionary *)dictionary;

@end

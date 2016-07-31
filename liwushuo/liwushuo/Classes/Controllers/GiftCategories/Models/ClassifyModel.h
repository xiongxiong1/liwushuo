//
//  ClassifyModel.h
//  liwushuo
//
//  Created by caohaifeng on 6/18/16.
//  Copyright © 2016 haifeng. All rights reserved.
//

#import "BaseModel.h"

@interface ClassifyModel : BaseModel

@property(nonatomic,copy)NSString *banner_image_url;
@property(nonatomic,copy)NSString *banner_webp_url;
@property(nonatomic,copy)NSString *cover_image_url;
@property(nonatomic,copy)NSString *cover_webp_url;
@property(nonatomic,copy)NSString *subtitle;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *next_url;

@end

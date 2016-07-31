//
//  Macros.h
//  liwushuo
//
//  Created by caohaifeng on 16/5/27.
//  Copyright © 2016年 haifeng. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define MYRGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//相对高
#define XHIGHT [UIScreen mainScreen].bounds.size.height/667
//相对宽
#define XWIDTH [UIScreen mainScreen].bounds.size.width/375


//URL
#define PopularGiftsURL @"http://api.liwushuo.com/v2/items?limit=20&offset=%ld&gender=1&generation=1"
#define scrollButtonTitle @"http://api.liwushuo.com/v2/channels/preset?gender=1&generation=1"
#define CarouselURL @"http://api.liwushuo.com/v2/banners?channel=iOS"
#define PresentURL @"http://api.liwushuo.com/v2/channels/100/items?ad=1&gender=1&generation=1&limit=20&offset=0"
#define carouselNextURL @"http://api.liwushuo.com/v2/collections/180/posts?gender=1&generation=0&limit=20&offset=0"
#define kStrategySpecialURL @"http://api.liwushuo.com/v2/collections?limit=6&offset=0"
#define kStrategyButtonURL @"http://api.liwushuo.com/v2/channel_groups/all"
#define kGiftURL @"http://api.liwushuo.com/v2/item_categories/tree"
#define scrollButton @"http://api.liwushuo.com/v2/secondary_banners?gender=1&generation=0"//轮播图下按钮
#define selectShenqi @"http://api.liwushuo.com/v2/search/item_by_type?limit=20&offset=0"//选礼神器


#endif /* Macros_h */

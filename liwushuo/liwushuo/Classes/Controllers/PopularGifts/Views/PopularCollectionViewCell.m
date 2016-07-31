//
//  PopularCollectionViewCell.m
//  liwushuo
//
//  Created by caohaifeng on 16/5/27.
//  Copyright © 2016年 haifeng. All rights reserved.
//

#import "PopularCollectionViewCell.h"
#import "HotModel.h"

@interface PopularCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageViews;
@property (nonatomic, strong) UIImageView *heartImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *likeCount;

@end

@implementation PopularCollectionViewCell

- (void)setHotModel:(HotModel *)hotModel {
    if (_hotModel != hotModel) {
        _hotModel = hotModel;
    }
    [self.imageViews sd_setImageWithURL:[NSURL URLWithString:hotModel.cover_image_url]];
    self.titleLabel.text = hotModel.name;
    self.priceLabel.text = hotModel.price;
    self.likeCount.text = [NSString stringWithFormat:@"%@", [hotModel.favorites_count stringValue]];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = 5;
        self.contentView.clipsToBounds = YES;
        [self setupUI];
    }
    return self;
}

//搭建界面
- (void)setupUI {
    
    [self.contentView addSubview:self.imageViews];
    [self.contentView addSubview:self.heartImage];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.likeCount];
}

#pragma mark -- 懒加载
- (UIImageView *)imageViews {
    if (_imageViews == nil) {
        _imageViews = [[UIImageView alloc] init];
        _imageViews.contentMode = UIViewContentModeScaleAspectFill;
        _imageViews.frame = CGRectMake(0, 0, self.width, self.height / 4 * 3 - 10);
        _imageViews.clipsToBounds = YES;
    }
    return _imageViews;
}

- (UIImageView *)heartImage {
    if (_heartImage == nil) {
        _heartImage = [[UIImageView alloc] init];
        _heartImage.contentMode = UIViewContentModeScaleAspectFill;
        _heartImage.image = [UIImage imageNamed:@"heart"];
        _heartImage.frame = CGRectMake(self.likeCount.left - 25, self.height - 20, 20, 17);
    }
    return _heartImage;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.frame = CGRectMake(5, self.height / 4 * 3 - 5, self.width - 10, 45);
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (UILabel *)priceLabel {
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.frame = CGRectMake(5, self.height - 22, self.width / 3 - 5, 20);
        _priceLabel.font = [UIFont systemFontOfSize:14];
    }
    return _priceLabel;
}

- (UILabel *)likeCount {
    if (_likeCount == nil) {
        _likeCount = [[UILabel alloc] init];
        _likeCount.frame = CGRectMake(self.width / 4 * 3-5, self.height - 22, self.width / 3, 20);
        _likeCount.font = [UIFont systemFontOfSize:14];
        _likeCount.textAlignment = NSTextAlignmentLeft;
    }
    return _likeCount;
}

@end

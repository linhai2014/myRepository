//
//  ECGridCollectionCell.m
//  ExpenseClaim
//
//  Created by yulinhai on 2019/4/22.
//  Copyright © 2019年 linhai. All rights reserved.
//

#import "ECGridCollectionCell.h"
#import "ECGridView_Config.h"
@interface ECGridCollectionCell ()

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *titleLabel;
@end

@implementation ECGridCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.imageView.hidden = NO;
    self.titleLabel.hidden = NO;
    
    [self addSubview:_titleLabel];
    [self addSubview:_imageView];
}

- (void)layoutView {    
    _imageView.frame = CGRectMake(0, 0, scale(60), scale(60));
    _titleLabel.frame = CGRectMake(0, scale(65), scale(60), scale(20));
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [UIImageView new];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

- (void)setConfig:(ECGridView_Config *)config
{
    _config = config;
    
    self.imageView.image = [UIImage imageNamed:config.model.imageName];
   
    self.titleLabel.text = config.model.titleString; 
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textColor = [UIColor blackColor];
    
    [self layoutView];
}
@end

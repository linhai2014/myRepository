//
//  ECHomeTableViewCell.m
//  ExpenseClaim
//
//  Created by yulinhai on 2019/4/22.
//  Copyright © 2019年 linhai. All rights reserved.
//

#import "ECHomeTableViewCell.h"
#import "ECGridView.h"

@interface ECHomeTableViewCell()

@property(nonatomic, strong) ECGridView *gridView;
@property (nonatomic, strong) ECGridView_Config *gridViewConfig;

@end

@implementation ECHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self setupView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupView
{
//    _iconImageView = [UIImageView new];
//    _iconImageView.frame = CGRectMake(0, 0, 200, 150);
//
//    _nameLabel = [UILabel new];
//    _nameLabel.font = [UIFont systemFontOfSize:16];
//    _nameLabel.textColor = [UIColor blackColor];
//    _nameLabel.frame = CGRectMake(0, 250, 100, 50);
    
//    [self.contentView addSubview:_iconImageView];
//    [self.contentView addSubview:_nameLabel];
    
    [self.contentView addSubview:self.gridView];
}

- (ECGridView *)gridView
{
    if (!_gridView)
    {
//        _gridView = [[ECGridView alloc] init];
//        _gridView.backgroundColor = [UIColor redColor];
//        _gridView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth*0.25);
        
        /*
        self.ba_GridViewConfig.scrollEnabled = YES;
        // 是否显示分割线
        self.ba_GridViewConfig.showLineView = YES;
        // item：分割线颜色，默认：BAKit_Color_Gray_11【BAKit_Color_RGB(248, 248, 248)】
        self.ba_GridViewConfig.ba_gridView_lineColor = BAKit_Color_Red_pod;
        // item：每行 item 的个数，默认为4个
        self.ba_GridViewConfig.ba_gridView_rowCount = kGridView_rowCount;
        // item：高度/宽度
        self.ba_GridViewConfig.ba_gridView_itemHeight = kGridView_itemHeight;
        //        self.ba_GridViewConfig.ba_gridView_itemWidth = kGridView_itemWidth;
        
        // item：图片与文字间距（或者两行文字类型的间距），默认：0
        self.ba_GridViewConfig.ba_gridView_itemImageInset = 5;
        //  item：title 颜色，默认：BAKit_Color_Black【[UIColor blackColor]】
        //            self.ba_GridViewConfig.ba_gridView_titleColor = BAKit_Color_Black;
        // item：title Font，默认：图文样式下 16，两行文字下（上25，下12）
        self.ba_GridViewConfig.ba_gridView_titleFont = [UIFont boldSystemFontOfSize:15];
        // item：背景颜色，默认：BAKit_Color_White
        self.ba_GridViewConfig.ba_gridView_backgroundColor = [UIColor yellowColor];
        // item：背景选中颜色，默认：无色
        self.ba_GridViewConfig.ba_gridView_selectedBackgroundColor = BAKit_Color_Red_pod;
        self.ba_GridViewConfig.dataArray = self.gridDataArray;
        //        self.ba_GridViewConfig.ba_gridView_itemEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        //        self.ba_GridViewConfig.minimumLineSpacing = 10;
        //        self.ba_GridViewConfig.minimumInteritemSpacing = 10;
        */
        _gridView = [ECGridView creatGridViewWithGridViewConfig:self.gridViewConfig
                                                          block:^(ECGridItemModel *model, NSIndexPath *indexPath) {
//            BAKit_ShowAlertWithMsg_ios8(model.titleString);
                                                              NSLog(@"click %@", model.titleString);
        }];
    }
    return _gridView;
}

#pragma mark - properties
- (void)setData:(ECGridView_Config *)config
{
    self.gridViewConfig = config;
    [self setupView];
}

//- (void)setModel:(ECGridItemModel *)model
//{
////    _model = model;
//
//    self.iconImageView.image = [UIImage imageNamed:model.imageName];
//    self.nameLabel.text = model.titleString;
//}

- (ECGridView_Config *)gridViewConfig {
    if (!_gridViewConfig) {
        _gridViewConfig = [[ECGridView_Config alloc] init];
    }
    return _gridViewConfig;
}
@end

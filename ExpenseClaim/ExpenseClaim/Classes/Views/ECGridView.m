//
//  ECGridView.m
//  ExpenseClaim
//
//  Created by yulinhai on 2019/4/22.
//  Copyright © 2019年 linhai. All rights reserved.
//

#import "ECGridView.h"
#import "ECGridCollectionCell.h"

static NSString * const kCellID = @"ECGridCollectionCell";

@interface ECGridView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) ECGridView_Config *config;
@end
@implementation ECGridView

- (instancetype)init
{
    self = [super init];
    if (self) {
        //        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        //        [self setupUI];
    }
    return self;
}

/**
 快速创建宫格
 
 @param config view 基础配置
 @param block 点击事件回调
 @return BAGridView
 */
+ (instancetype)creatGridViewWithGridViewConfig:(ECGridView_Config *)config
                                          block:(ECGridViewBlock)block
{
    ECGridView *tempView = [[ECGridView alloc] init];
    tempView.backgroundColor = [UIColor yellowColor];

    NSInteger lineNum = config.dataArray.count % config.rowCount == 0 ? config.dataArray.count / config.rowCount : config.dataArray.count / config.rowCount + 1;
    tempView.frame = CGRectMake(0, 0, kScreenWidth, lineNum * (ItemMargin + ItemHeight) + ItemMargin);

    if (config == nil) {
        config = [[ECGridView_Config alloc] init];
    }
    
    tempView.config = config;
    tempView.config.gridViewBlock = block;
    [tempView setupUI];
    
    return tempView;
}

- (void)setupUI
{
    [self addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.config.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ECGridCollectionCell *cell;
    
    [collectionView selectItemAtIndexPath:indexPath
                                 animated:NO
                           scrollPosition:UICollectionViewScrollPositionNone];
    
    self.config.model = self.config.dataArray[indexPath.row];
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    cell.backgroundColor = randomColor; //[UIColor blueColor]; //BAKit_Color_Clear_pod;
    cell.config = self.config;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell *cell =  [collectionView cellForItemAtIndexPath:indexPath];
//    // 选中之后的cell变颜色
//    [self ba_updateCell:cell indexPath:indexPath selected:YES];

    ECGridItemModel *model = self.config.dataArray[indexPath.row];

    if (self.config.gridViewBlock)
    {
        self.config.gridViewBlock(model, indexPath);
    }
}

// 取消选中操作
- (void)deselectItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated
{
//    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
//    [self ba_updateCell:cell indexPath:indexPath selected:NO];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    self.collectionView.frame = self.bounds;
    self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, self.bounds.size.height);
}

#pragma mark - setter / getter
// 参考 https://www.cnblogs.com/JustForHappy/p/5724869.html
- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

//        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat itemWidth = (kScreenWidth - (self.config.rowCount + 1) * ItemMargin)/self.config.rowCount;
        layout.itemSize = CGSizeMake(itemWidth, ItemHeight);
        layout.sectionInset = UIEdgeInsetsMake(ItemMargin, ItemMargin, 0, ItemMargin);
        layout.minimumLineSpacing = ItemMargin;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor]; //BAKit_Color_Clear_pod;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = YES;    //self.config.isScrollEnabled;
        _collectionView.alwaysBounceVertical = YES;

        [_collectionView registerClass:[ECGridCollectionCell class] forCellWithReuseIdentifier:kCellID];
        
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

@end

//
//  ECGridView_Config.h
//  ExpenseClaim
//
//  Created by yulinhai on 2019/4/22.
//  Copyright © 2019年 linhai. All rights reserved.
//

#import "ECGridItemModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 ECGridView 回调
 
 @param model 返回 ECGridItemModel
 @param indexPath indexPath
 */
typedef void (^ECGridViewBlock)(ECGridItemModel *model, NSIndexPath *indexPath);

@interface ECGridView_Config : NSObject

/**
 数据源：来自 ECGridItemModel
 */
@property(nonatomic, strong) NSArray <ECGridItemModel *>*dataArray;

/**
 cell数据源：来自 ECGridItemModel
 */
@property(nonatomic, strong) ECGridItemModel *model;

/**
 item：高度，图片高度 默认：gridView_itemHeight * 0.4
 */
//@property(nonatomic, assign) CGFloat gridView_itemHeight;

/**
 item：宽度，图片高度 默认：（屏幕宽度 - gridView_itemHeight * count）/ count
 */
@property(nonatomic, assign) CGFloat itemWidth;

/**
 item：每行 item 的个数，默认：4个
 */
@property(nonatomic, assign) NSInteger rowCount;

/**
 item：点击回调
 */
@property(nonatomic, copy)  ECGridViewBlock gridViewBlock;

@end

NS_ASSUME_NONNULL_END

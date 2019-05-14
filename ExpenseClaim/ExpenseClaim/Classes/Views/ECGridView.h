//
//  ECGridView.h
//  ExpenseClaim
//
//  Created by yulinhai on 2019/4/22.
//  Copyright © 2019年 linhai. All rights reserved.
//

#import "ECGridView_Config.h"

NS_ASSUME_NONNULL_BEGIN

@interface ECGridView : UIView

/**
 快速创建宫格
 
 @param config view 基础配置
 @param block 点击事件回调
 @return BAGridView
 */
+ (instancetype)creatGridViewWithGridViewConfig:(ECGridView_Config *)config
                                          block:(ECGridViewBlock)block;
@end

NS_ASSUME_NONNULL_END

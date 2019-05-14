//
//  ECGridItemModel.h
//  ExpenseClaim
//
//  Created by yulinhai on 2019/4/22.
//  Copyright © 2019年 linhai. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface ECGridItemModel : NSObject

/**
 图片，可为本地图片名、网络图片 URL
 */
@property(nonatomic, copy) NSString *imageName;

/**
 标题
 */
@property(nonatomic, copy) NSString *titleString;
@end

NS_ASSUME_NONNULL_END

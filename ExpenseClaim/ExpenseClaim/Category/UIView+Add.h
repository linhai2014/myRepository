//
//  UIView+Add.h
//  ExpenseClaim
//
//  Created by yulinhai on 2019/4/24.
//  Copyright © 2019年 linhai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Add)

@property (nonatomic) CGFloat right; 
@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@end

NS_ASSUME_NONNULL_END

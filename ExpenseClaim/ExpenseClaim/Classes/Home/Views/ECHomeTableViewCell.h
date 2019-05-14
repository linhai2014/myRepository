//
//  ECHomeTableViewCell.h
//  ExpenseClaim
//
//  Created by yulinhai on 2019/4/22.
//  Copyright © 2019年 linhai. All rights reserved.
//

#import "ECGridItemModel.h"
#import "ECGridView_Config.h"

NS_ASSUME_NONNULL_BEGIN

@interface ECHomeTableViewCell : UITableViewCell

//@property (nonatomic, strong) UIImageView *iconImageView;
//@property (nonatomic, strong) UILabel *nameLabel;


//@property (nonatomic, strong) ECGridItemModel *model;

- (void)setData:(ECGridView_Config *)config;
@end

NS_ASSUME_NONNULL_END

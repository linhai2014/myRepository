//
//  ECGridView_Config.m
//  ExpenseClaim
//
//  Created by yulinhai on 2019/4/22.
//  Copyright © 2019年 linhai. All rights reserved.
//

#import "ECGridView_Config.h"

@implementation ECGridView_Config

- (instancetype)init {
    if (self == [super init]) {
        
        // 默认配置
//        self.gridViewType = BAGridViewTypeTitleDesc;

//        self.ba_gridView_lineColor = BAKit_Color_Gray_10_pod;
//        self.ba_gridView_titleColor = BAKit_Color_Black_pod;
//        self.ba_gridView_titleDescColor = BAKit_Color_Gray_9_pod;
//        self.ba_gridView_itemImageInset = 0;
//        self.ba_gridView_backgroundColor = BAKit_Color_White_pod;
        self.dataArray = @[].mutableCopy;
//        self.rowCount = 2;
//        self.ba_gridView_lineWidth = BAKit_Flat_pod(0.5f);
//        self.scrollEnabled = YES;
    }
    return self;
}
@end

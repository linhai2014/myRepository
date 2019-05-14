//
//  JSBridge.h
//  ExpenseClaim
//
//  Created by yulinhai on 2019/5/6.
//  Copyright © 2019年 linhai. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@protocol JSBridgeProtocol <JSExport>

- (NSInteger)add:(NSInteger)a b:(NSInteger)b;

@end

@interface JSBridge : NSObject<JSBridgeProtocol>

@end

NS_ASSUME_NONNULL_END

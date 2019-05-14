//
//  ECUserDefault.h
//  ExpenseClaim
//
//  Created by yulinhai on 2019/5/5.
//  Copyright © 2019年 linhai. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface ECUserDefault : NSObject

+(void)saveUserDefaultObject:(id)object key:(NSString *)key;

+(id)getUserDefaultObject:(NSString *)key;

+(void)removeObjectWithKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END

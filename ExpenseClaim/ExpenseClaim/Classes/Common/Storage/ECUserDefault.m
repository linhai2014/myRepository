//
//  ECUserDefault.m
//  ExpenseClaim
//
//  Created by yulinhai on 2019/5/5.
//  Copyright © 2019年 linhai. All rights reserved.
//

#import "ECUserDefault.h"

@implementation ECUserDefault

+(void)saveUserDefaultObject:(id)object key:(NSString *)key
{
    NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
    [defaults setObject:object forKey:key];
    [defaults synchronize];
}

+(id)getUserDefaultObject:(NSString *)key
{
    NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
    id tempObject = [defaults objectForKey:key];
    return tempObject;
}

+(void)removeObjectWithKey:(NSString *)key
{
    NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}
@end

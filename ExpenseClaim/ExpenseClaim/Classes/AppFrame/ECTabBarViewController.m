//
//  ECTabBarViewController.m
//  ExpenseClaim
//
//  Created by yulinhai on 2019/4/15.
//  Copyright © 2019年 linhai. All rights reserved.
//

#import "ECTabBarViewController.h"

#import "ECBaseNavigationController.h"
#import "ECHomeViewController.h"

#define kClassKey   @"rootVCClassString"
#define kTitleKey   @"title"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"

@interface ECTabBarViewController ()

@end

@implementation ECTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *childItemsArray = @[
                                 @{kClassKey  : @"ECHomeViewController",
                                   kTitleKey  : @"首页",
                                   kImgKey    : @"tabbar_Home",
                                   kSelImgKey : @"tabbar_HomeHL"},
                                 
                                 @{kClassKey  : @"ECExpenseClaimViewController",
                                   kTitleKey  : @"报销",
                                   kImgKey    : @"tabbar_ExpenseClaim",
                                   kSelImgKey : @"tabbar_ExpenseClaimHL"},
                                 
                                 @{kClassKey  : @"ECRecordViewController",
                                   kTitleKey  : @"记录",
                                   kImgKey    : @"tabbar_Record",
                                   kSelImgKey : @"tabbar_RecordHL"},
                                 
                                 @{kClassKey  : @"ECMeViewController",
                                   kTitleKey  : @"我",
                                   kImgKey    : @"tabbar_Me",
                                   kSelImgKey : @"tabbar_MeHL"} ];

    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = [NSClassFromString(dict[kClassKey]) new];
        vc.title = dict[kTitleKey];
        ECBaseNavigationController *nav = [[ECBaseNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[kTitleKey];
        item.image = [UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : Global_tintColor} forState:UIControlStateSelected];
        [self addChildViewController:nav];
    }];
}

@end

//
//  GuidPagesViewController.m
//  ExpenseClaim
//
//  Created by yulinhai on 2019/5/6.
//  Copyright © 2019年 linhai. All rights reserved.
//

#import "GuidPagesViewController.h"
#import "LoginViewController.h"

@interface GuidPagesViewController ()<UIScrollViewDelegate>
@property(nonatomic ,strong) UIScrollView * mainScrollV;
@property(nonatomic ,strong) UIPageControl * pageControl;
@property(nonatomic ,strong) NSMutableArray * images;
@end

@implementation GuidPagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainScrollV];
    [self.view addSubview:self.pageControl];
}

-(UIScrollView *)mainScrollV{
    if (!_mainScrollV) {
        _mainScrollV = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _mainScrollV.bounces = NO;
        _mainScrollV.pagingEnabled = YES;
        _mainScrollV.showsHorizontalScrollIndicator = NO;
        _mainScrollV.delegate = self;
        _mainScrollV.contentSize = CGSizeMake(self.images.count * UIScreenWidth, UIScreenHeight);
        [self addSubImageViews];
    }
    return _mainScrollV;
}

-(NSMutableArray *)images{
    if (!_images) {
        _images = [NSMutableArray array];
        NSArray * imageNames = @[@"u1",@"u2",@"u3",@"u4"];
        for (NSString * name in imageNames) {
            [self.images addObject:[UIImage imageNamed:name]];
        }
    }
    return _images;
}
- (void)addSubImageViews{
    for (int i = 0; i < self.images.count; i++) {
        UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(i * UIScreenWidth, 0, UIScreenWidth, UIScreenHeight)];
        imageV.image = self.images[i];
        [_mainScrollV addSubview:imageV];
        if (i == self.images.count - 1){//最后一张图片时添加点击进入按钮
            imageV.userInteractionEnabled = YES;
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(UIScreenWidth * 0.5 - 80, UIScreenHeight * 0.7, 160, 40);
            [btn setTitle:@"点击一下,你就知道" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor redColor];
            btn.layer.cornerRadius = 20;
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [UIColor redColor].CGColor;
            [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
            [imageV addSubview:btn];
        }
    }
}
//点击按钮保存第一次登录的标记到本地并且跳入登录界面
- (void)btnClick{
    [ECUserDefault saveUserDefaultObject:@(YES) key:kIsNotFirst];
    [UIApplication sharedApplication].keyWindow.rootViewController = [[LoginViewController alloc]init];
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(UIScreenWidth/self.images.count, UIScreenHeight * 15/16.0, UIScreenWidth/2, UIScreenHeight/16.0)];
        //设置总页数
        _pageControl.numberOfPages = self.images.count;
        //设置分页指示器颜色
        _pageControl.pageIndicatorTintColor = [UIColor blueColor];
        //设置当前指示器颜色
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.enabled = NO;
    }
    return _pageControl;
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = (NSInteger)self.mainScrollV.contentOffset.x/UIScreenWidth;
}

@end

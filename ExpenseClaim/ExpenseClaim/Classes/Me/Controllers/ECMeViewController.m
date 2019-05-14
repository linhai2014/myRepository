//
//  ECMeViewController.m
//  ExpenseClaim
//
//  Created by yulinhai on 2019/4/15.
//  Copyright © 2019年 linhai. All rights reserved.
//

#import "ECMeViewController.h"

//#define LOADONLINEWEBPAGE 0

@interface ECMeViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) JSContext *context;
@property (strong, nonatomic) UIWebView *webView;
@end

@implementation ECMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我";
    
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.webView];
}

- (void)showMsg:(NSString *)msg {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                             message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@", msg);
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    //对JSContext对象进行初始化
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //设置JSContext的错误处理函数
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue)
    {
        NSLog(@"oc catches the exception: %@", exceptionValue);
//        context.exception = exceptionValue;
    };
    
    __weak __typeof__(self) weakSelf = self;
    
    self.context[@"ocAlert"] = ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                                 message:@"JS调用OC成功" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"hello linhai");
        }]];
        
        [weakSelf presentViewController:alertController animated:YES completion:nil];
    };
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
        _webView.delegate = self;

#ifdef LOADONLINEWEBPAGE
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
        NSURL *baseURL = [[NSBundle mainBundle] bundleURL];
        [_webView loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:baseURL];
#else
//        NSURL *url = [NSURL URLWithString:@"https://www.qq.com"];
        NSString *strUrl = @"http://pase-ifin.pingan.com.cn/index.html#/reimbursementDetail";
//        NSString *strUrl = @"http://pase-ifin.pingan.com.cn/index.html#/approvalDetail";
//        NSString *strUrl = @"http://pase-ifin.pingan.com.cn/index.html#/gatherInfo";
//        NSString *strUrl = @"http://pase-ifin.pingan.com.cn/index.html#/applyForReimbursement";
        NSURL *url = [NSURL URLWithString:strUrl];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
#endif
    }
    
    return _webView;
}
@end

//
//  ECRecordViewController.m
//  ExpenseClaim
//
//  Created by yulinhai on 2019/4/15.
//  Copyright © 2019年 linhai. All rights reserved.
//

#import "ECRecordViewController.h"
#import "JSBridge.h"

@interface ECRecordViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) JSContext *context;
@property (strong, nonatomic) UIWebView *webView;

@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;
@property (nonatomic, strong) UIButton *btn4;
@end

@implementation ECRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"记录";
    self.view.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.btn1];
    [self.view addSubview:self.btn2];
    [self.view addSubview:self.btn3];
    [self.view addSubview:self.btn4];
}

- (void)showMsg:(NSString *)msg {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                             message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@", msg);
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)btnClick:(UIButton *)sender {
    //网页加载完成之后调用JS代码才会执行，因为这个时候html页面已经注入到webView中并且可以响应到对应方法
    if (sender.tag == 111) {
        [self.webView stringByEvaluatingJavaScriptFromString:@"alertMobile()"];
    }
    
    if (sender.tag == 222) {
        [self.webView stringByEvaluatingJavaScriptFromString:@"alertName('小红')"];
    }
    
    if (sender.tag == 333) {
        [self.webView stringByEvaluatingJavaScriptFromString:@"alertSendMsg('18870707070','周末爬山真是件愉快的事情')"];
    }
    
    if (sender.tag == 444) {
        if (!self.context) {
            return;
        }
        
//        JSValue *funcValue = self.context[@"alertFunc"];
//        [funcValue callWithArguments:nil];
        
        JSValue *funcValue = self.context[@"alertSendMsg"];
        [funcValue callWithArguments:@[@"13418547900", @"明天去爬山哈哈"]];
    }
}

#pragma mark - JS调用OC方法列表
- (void)showMobile {
    [self showMsg:@"hello linhai"];
    
    // 获取设备信息
    NSString *iPhoneName = [UIDevice currentDevice].name;
    NSLog(@"iPhone名称-->%@", iPhoneName);
}

- (void)showName:(NSString *)name {
    NSString *info = [NSString stringWithFormat:@"你好 %@, 很高兴见到你",name];
    [self showMsg:info];
}

- (void)showSendNumber:(NSString *)num msg:(NSString *)msg {
    NSString *info = [NSString stringWithFormat:@"这是我的手机号: %@, %@ !!",num,msg];
    [self showMsg:info];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    //OC调用JS是基于协议拦截实现的 下面是相关操作
    NSString *absolutePath = request.URL.absoluteString;
    NSString *scheme = @"rrcc://";
    
    if ([absolutePath hasPrefix:scheme]) {
        NSString *subPath = [absolutePath substringFromIndex:scheme.length];
        
        if ([subPath containsString:@"?"]) {//1个或多个参数
            
            if ([subPath containsString:@"&"]) {//多个参数
                NSArray *components = [subPath componentsSeparatedByString:@"?"];
                
                NSString *methodName = [components firstObject];
                
                methodName = [methodName stringByReplacingOccurrencesOfString:@"_" withString:@":"];
                SEL sel = NSSelectorFromString(methodName);
                
                NSString *parameter = [components lastObject];
                NSArray *params = [parameter componentsSeparatedByString:@"&"];
                
                if (params.count == 2) {
                    if ([self respondsToSelector:sel]) {
                        [self performSelector:sel withObject:[params firstObject] withObject:[params lastObject]];
                    }
                }
            } else {//1个参数
                NSArray *components = [subPath componentsSeparatedByString:@"?"];
                
                NSString *methodName = [components firstObject];
                methodName = [methodName stringByReplacingOccurrencesOfString:@"_" withString:@":"];
                SEL sel = NSSelectorFromString(methodName);
                
                NSString *parameter = [components lastObject];
                
                if ([self respondsToSelector:sel]) {
                    [self performSelector:sel withObject:parameter];
                }
            }
        } else {//没有参数
            NSString *methodName = [subPath stringByReplacingOccurrencesOfString:@"_" withString:@":"];
            SEL sel = NSSelectorFromString(methodName);
            
            if ([self respondsToSelector:sel]) {
                [self performSelector:sel];
            }
        }
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    //对JSContext对象进行初始化
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //验证JSContext对象是否初始化成功
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue)
    {
        context.exception = exceptionValue;
    };
    
    __weak __typeof__(self) weakSelf = self;
    
    self.context[@"ocObj"] = [[JSBridge alloc] init];
    self.context[@"ocAlert"] = ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                                 message:@"JS调用OC成功" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"hello linhai");
        }]];
        
        [weakSelf presentViewController:alertController animated:YES completion:nil];
    };
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 0.5 * UIScreenHeight)];
        
        _webView.delegate = self;
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
        NSURL *baseURL = [[NSBundle mainBundle] bundleURL];
        [_webView loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:baseURL];
    }
    
    return _webView;
}

- (UIButton*)btn1{
    if (!_btn1) {
        _btn1 = [[UIButton alloc]initWithFrame:CGRectMake(99, 374, 201, 40)];
        [_btn1 setTitle:@"小黄的手机号" forState:UIControlStateNormal];
        [_btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _btn1.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btn1.titleLabel sizeToFit];
        _btn1.tag = 111;
        [_btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn1;
}

- (UIButton*)btn2{
    if (!_btn2) {
        _btn2 = [[UIButton alloc]initWithFrame:CGRectMake(99, 434, 201, 40)];
        [_btn2 setTitle:@"打电话给小黄" forState:UIControlStateNormal];
        [_btn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _btn2.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btn2.titleLabel sizeToFit];
        _btn2.tag = 222;
        [_btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn2;
}

- (UIButton*)btn3{
    if (!_btn3) {
        _btn3 = [[UIButton alloc]initWithFrame:CGRectMake(99, 494, 201, 40)];
        [_btn3 setTitle:@"给小黄发短信" forState:UIControlStateNormal];
        [_btn3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _btn3.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btn3.titleLabel sizeToFit];
        _btn3.tag = 333;
        [_btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn3;
}

- (UIButton*)btn4{
    if (!_btn4) {
        _btn4 = [[UIButton alloc]initWithFrame:CGRectMake(99, 554, 201, 40)];
        [_btn4 setTitle:@"JSCore测试" forState:UIControlStateNormal];
        [_btn4 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _btn4.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btn4.titleLabel sizeToFit];
        _btn4.tag = 444;
        [_btn4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn4;
}
@end

//
//  LoginViewController.m
//  ExpenseClaim
//
//  Created by yulinhai on 2019/4/24.
//  Copyright © 2019年 linhai. All rights reserved.
//

#import "LoginViewController.h"
#import "UIView+Add.h"
#import "ECTabBarViewController.h"
#import "AFNetworking.h"

#define TOPOFFSET  200

@interface LoginViewController ()<UITextFieldDelegate ,NSURLSessionDataDelegate>
@property (nonatomic, strong) UIView *vPhone;
@property (nonatomic, strong) UIView *vPassword;
@property (nonatomic, strong) UITextField *tfPhone;
@property (nonatomic, strong) UITextField *tfPassword;
@property (nonatomic, strong) UIButton *btnLogin;
@property (nonatomic, strong) UIButton *btnRegister;
@property (nonatomic, strong) UIButton *btnForgot;

@property (nonatomic, strong) UISwitch *swtRememberPwd;
@property (nonatomic, strong) UILabel *lblRemberPwd;

@property (nonatomic, strong) UISwitch *swtAutoLogin;
@property (nonatomic, strong) UILabel *lblAutoLogin;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self initUI];
    [self configUI];
}

- (void)configUI{
    //temp code 4 test
    [ECUserDefault saveUserDefaultObject:@"chenjiawen516" key:kUserName];
//    [ECUserDefault saveUserDefaultObject:@"aaaaa888" key:kUserPassword];
    
    self.tfPhone.text = [ECUserDefault getUserDefaultObject:kUserName];
    BOOL isRemberPwd = [[ECUserDefault getUserDefaultObject:kRememberPassword] boolValue];
    self.swtRememberPwd.on = isRemberPwd;
    
    if (isRemberPwd) {
        self.tfPassword.text = [ECUserDefault getUserDefaultObject:kUserPassword];
    }
}

- (void)initUI{
    [self.view addSubview:self.vPhone];
    [self.view addSubview:self.vPassword];
    [self.view addSubview:self.btnLogin];
    [self.view addSubview:self.btnRegister];
    [self.view addSubview:self.btnForgot];
    [self.view addSubview:self.swtRememberPwd];
    [self.view addSubview:self.lblRemberPwd];
    [self.view addSubview:self.swtAutoLogin];
    [self.view addSubview:self.lblAutoLogin];
    
    //读取沙盒
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userName = [user objectForKey:@"userName"];
    NSString *userPassword = [user objectForKey:@"userPassword"];
    if (userName != nil) {
        self.tfPhone.text = userName;
    }
    if (userPassword != nil) {
        self.tfPassword.text = userPassword;
    }
}

#pragma mark NSURLSessionDataDelegate
/**
 *  1.接收到服务器的响应 它默认会取消该请求
 *
 *  @param session           会话对象
 *  @param dataTask          请求任务
 *  @param response          响应头信息
 *  @param completionHandler 回调 传给系统
 */
-(void)URLSession:(NSURLSession *)session
         dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    NSLog(@"%s",__func__);
    
    /*
     NSURLSessionResponseCancel = 0,取消 默认
     NSURLSessionResponseAllow = 1, 接收
     NSURLSessionResponseBecomeDownload = 2, 变成下载任务
     NSURLSessionResponseBecomeStream        变成流
     */
    completionHandler(NSURLSessionResponseAllow);
}

/**
 *  请求结束或者是失败的时候调用
 *
 *  @param session           会话对象
 *  @param task              请求任务
 *  @param error             错误信息
 */
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    NSLog(@"%s, error: %@",__func__, error);
    
    //解析数据
//    NSLog(@"%@",[[NSString alloc]initWithData:self.fileData encoding:NSUTF8StringEncoding]);
}

#pragma mark - Event
- (void)loginAction{
    
//    [self sendLoginRequest_Json];
//    return;
    
    [self hideKeyboard];
    
    NSString *phone = self.tfPhone.text;
    NSString *password = self.tfPassword.text;
    
    NSString *message = nil;
    if (phone.length < 6) {
        message = @"用户名不能少于6位";
    } else if (password.length < 6) {
        message = @"密码不能少于6位";
    }
    
    NSLog(@"%s", __FUNCTION__);
    
    if (message.length > 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                                 message:message preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"我知道了");
        }]];
        
        // 由于它是一个控制器 直接modal出来就好了
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else {
        [self loginWithUserName:phone Password:password];
        
//        [UIApplication sharedApplication].keyWindow.rootViewController = [[ECTabBarViewController alloc] init];
        
        //登录
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        hud.label.text = @"登录中...";
//        [[XmppClient shareClient] login:phone password:password success:^{
//            //存储沙盒
//            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//            [userDefaults setObject:phone forKey:@"userName"];
//            [userDefaults setObject:password forKey:@"userPassword"];
//            [userDefaults setObject:@(FALSE) forKey:@"loginFlag"];
//            [userDefaults synchronize];
//
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            VCMain *vc = [[VCMain alloc]init];
//            UIWindow *window = [UIApplication sharedApplication].keyWindow;
//            window.rootViewController = vc;
//        } failure:^(NSString *error) {
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"用户名或密码错误" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//            [alert show];
//        }];
     }
}

// https://blog.csdn.net/imkata/article/details/78829306
- (void)sendLoginRequest_delegate{
//     NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://pase-ifin.pingan.com.cn/login"]];
    NSURL *url = [NSURL URLWithString:@"https:www.baidu.com"];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    /*
     第一个参数:配置信息 [NSURLSessionConfiguration defaultSessionConfiguration]
     第二个参数:代理
     第三个参数:设置代理方法在哪个线程中调用
     */
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    [dataTask resume];
}

- (void)get_json
{
    NSString *url = @"http://pase-ifin.pingan.com.cn/ifin-isee-gather-service/conferenceBasic/queryConfereneceType.do";
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.HTTPShouldHandleCookies = YES;

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", nil];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject
                                                           options:0 // If that option is not set, the most compact possible JSON will be generated
                                                             error:nil];
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
        
        NSLog(@"请求成功: %@", jsonString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败--%@",error);
    }];

//////////////
    
//    NSURL *url = [NSURL URLWithString:@"http://pase-ifin.pingan.com.cn/ifin-isee-gather-service/conferenceBasic/queryConferenceType.do"];
   
    /*
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setHTTPShouldHandleCookies:YES];
  
//    NSLog(@"cookie : %@", cookie);
//    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        //解析拿到的响应数据
        NSLog(@"服务器响应数据: %@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        
        //        NSLog(@"%@\n%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding],response.allHeaderFields);
        //        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
    }];
    
    [sessionDataTask resume];*/
}

- (void)post_json{
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/content.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *jsonString;
        jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"从服务器获取到数据: %@", jsonString);
    }];
    
    [sessionDataTask resume];
}

- (void)loginWithUserName:(NSString *)userName
                 Password:(NSString *)password
{
    if (!userName || !password) {
        return;
    }
    
    NSArray *keys = [NSArray arrayWithObjects: @"userName", @"userPwd", nil];
    NSArray *objects = [NSArray arrayWithObjects:userName, password, nil];
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSData *myJSONData =[NSJSONSerialization dataWithJSONObject:jsonDictionary
                                                        options:0
                                                          error:0 ];
    
    NSLog(@"myJSONData :%@", myJSONData);
    
    NSURL *url = [NSURL URLWithString:@"http://pase-ifin.pingan.com.cn/login"];
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:myJSONData];
    
    // 3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 4.根据会话对象，创建一个Task任务
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) //登陆成功
        {
            NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
            NSLog(@"%@\n响应头信息:\n%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding],res.allHeaderFields);
            
            dispatch_async(dispatch_get_main_queue()
                           , ^{
                               [UIApplication sharedApplication].keyWindow.rootViewController = [[ECTabBarViewController alloc] init];
                           });
        }
    }];
    
    //5.最后一步，执行任务，(resume也是继续执行)。
    [sessionDataTask resume];
}

// https://www.jianshu.com/p/9bb595ed5553
// https://stackoverflow.com/questions/22033921/set-an-nsdictionary-in-httpbody-and-send-using-post-method
// https://stackoverflow.com/questions/15898979/httprequest-body-parameters-in-ios
- (void)sendLoginRequest_Json{
    NSArray *keys = [NSArray arrayWithObjects: @"userName",@"userPwd", nil];
    NSArray *objects = [NSArray arrayWithObjects:@"chenjiawen516",@"aaaaa888", nil];
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];

    NSData *myJSONData =[NSJSONSerialization dataWithJSONObject:jsonDictionary
                                                        options:0
                                                          error:0 ];
    
    NSLog(@"myJSONData :%@", myJSONData);

    NSURL *url = [NSURL URLWithString:@"http://pase-ifin.pingan.com.cn/login"];
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:myJSONData];

    // 3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 4.根据会话对象，创建一个Task任务
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
         NSLog(@"从服务器获取到数据");
        //  获取Cookie
        //拿到响应头信息
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
        NSLog(@"%@\n响应头信息:\n%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding],res.allHeaderFields);
        
        [self get_json];
    }];
    
    //5.最后一步，执行任务，(resume也是继续执行)。
    [sessionDataTask resume];
}

- (void)sendLoginRequest{
    // 1.创建一个网络路径
    NSURL *url = [NSURL URLWithString:@"http://pase-ifin.pingan.com.cn/login"];
    
    // 2.创建一个网络请求，分别设置请求方法、请求参数
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *args = @"\"userName\":\"chenjiawen516\",\"userPwd\":\"aaaaa888\"";
    request.HTTPBody = [args dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"request param: %@", args);
    
    // 3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 4.根据会话对象，创建一个Task任务
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"从服务器获取到数据");
        /*
         对从服务器获取到的数据data进行相应的处理.
         */
        //解析拿到的响应数据
        NSLog(@"响应数据: %@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    }];
    
    //5.最后一步，执行任务，(resume也是继续执行)。
    [sessionDataTask resume];
}

- (void)registerAction{
    NSLog(@"%s", __FUNCTION__);
}


- (void)forgotAction{
     NSLog(@"%s", __FUNCTION__);
}

- (void)switchAction:(UISwitch *)sender {
    if (sender.tag == 1000) { // 记住密码
        if (sender.on == YES) {
            [ECUserDefault saveUserDefaultObject:@(YES) key:kRememberPassword];
            [ECUserDefault saveUserDefaultObject:self.tfPassword.text key:kUserPassword];
        }
        else{
             [ECUserDefault saveUserDefaultObject:@(NO) key:kRememberPassword];
        }
    }
    else if (sender.tag == 1001) { // 自动登录
        if (sender.on == YES) {
             [ECUserDefault saveUserDefaultObject:@(YES) key:kAutoLogin];
        }
        else{
             [ECUserDefault saveUserDefaultObject:@(NO) key:kAutoLogin];
        }
    }
}

#pragma mark - Getter Setter
- (UIView *)vPhone{
    if (!_vPhone) {
        _vPhone = [[UIView alloc]initWithFrame:CGRectMake(10, TOPOFFSET + 20, kScreenWidth-20, 45)];
        _vPhone.layer.borderColor = BASE_COLOR.CGColor;
        _vPhone.layer.borderWidth = 1;
        _vPhone.layer.cornerRadius = 5;
        _vPhone.layer.masksToBounds = YES;
        [_vPhone addSubview:self.tfPhone];
    }
    return _vPhone;
}

- (UIView *)vPassword{
    if (!_vPassword) {
        _vPassword = [[UIView alloc]initWithFrame:CGRectMake(10, self.vPhone.bottom+10, kScreenWidth-20, 45)];
        _vPassword.layer.borderColor = BASE_COLOR.CGColor;
        _vPassword.layer.borderWidth = 1;
        _vPassword.layer.cornerRadius = 5;
        _vPassword.layer.masksToBounds = YES;
        [_vPassword addSubview:self.tfPassword];
    }
    return _vPassword;
}

- (UITextField *)tfPhone{
    if (!_tfPhone) {
        _tfPhone = [[UITextField alloc]initWithFrame:CGRectMake(10, 2.5, kScreenWidth-40, 40)];
        _tfPhone.placeholder = @"手机号码";
        _tfPhone.delegate = self;
    }
    return _tfPhone;
}

- (UITextField *)tfPassword{
    if (!_tfPassword) {
        _tfPassword = [[UITextField alloc]initWithFrame:CGRectMake(10, 2.5, kScreenWidth-40, 40)];
        _tfPassword.placeholder = @"请输入密码";
        _tfPassword.secureTextEntry = YES;
        _tfPassword.delegate = self;
    }
    return _tfPassword;
}

- (UIButton*)btnLogin{
    if (!_btnLogin) {
        _btnLogin = [[UIButton alloc]initWithFrame:CGRectMake(10, self.vPassword.bottom+70, kScreenWidth-20, 45)];
        _btnLogin.backgroundColor = BASE_COLOR;
        [_btnLogin setTitle:@"登录" forState:UIControlStateNormal];
        [_btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnLogin.layer.cornerRadius = 5;
        _btnLogin.layer.masksToBounds = YES;
        [_btnLogin addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLogin;
}

- (UIButton*)btnRegister{
    if (!_btnRegister) {
        _btnRegister = [[UIButton alloc]initWithFrame:CGRectMake(10, self.btnLogin.bottom+110, 100, 15)];
        [_btnRegister setTitle:@"新帐户注册" forState:UIControlStateNormal];
        [_btnRegister setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _btnRegister.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btnRegister.titleLabel sizeToFit];
        _btnRegister.width = _btnRegister.titleLabel.width;
        _btnRegister.hidden = YES;
        [_btnRegister addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRegister;
}

- (UIButton*)btnForgot{
    if (!_btnForgot) {
        _btnForgot = [[UIButton alloc]initWithFrame:CGRectMake(10, self.btnLogin.bottom+110, kScreenWidth-20, 15)];
        [_btnForgot setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_btnForgot setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _btnForgot.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btnForgot.titleLabel sizeToFit];
        _btnForgot.width = _btnForgot.titleLabel.width;
        _btnForgot.left = kScreenWidth-10-_btnForgot.width;
        _btnForgot.hidden = YES;
        [_btnForgot addTarget:self action:@selector(forgotAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnForgot;
}

- (UILabel*)lblRemberPwd{
    if (!_lblRemberPwd) {
        _lblRemberPwd = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 145, self.vPassword.bottom+3, 70, 50)];
        _lblRemberPwd.text = @"记住密码";
    }
    
    return _lblRemberPwd;
}

- (UISwitch*)swtRememberPwd{
    if (!_swtRememberPwd) {
        _swtRememberPwd = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenWidth - 65, self.vPassword.bottom+10, kScreenWidth-20, 15)];
        _swtRememberPwd.tag = 1000;
        [_swtRememberPwd addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _swtRememberPwd;
}

- (UILabel*)lblAutoLogin{
    if (!_lblAutoLogin) {
        _lblAutoLogin = [[UILabel alloc] initWithFrame:CGRectMake(15, self.vPassword.bottom+3, 70, 50)];
        _lblAutoLogin.text = @"自动登陆";
    }
    
    return _lblAutoLogin;
}

- (UISwitch*)swtAutoLogin{
    if (!_swtAutoLogin) {
        _swtAutoLogin = [[UISwitch alloc] initWithFrame:CGRectMake(self.lblAutoLogin.right + 10, self.vPassword.bottom+10, kScreenWidth-20, 15)];
        _swtAutoLogin.tag = 1001;
        [_swtAutoLogin addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _swtAutoLogin;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hideKeyboard];
}

- (void)hideKeyboard{
    [self.tfPhone resignFirstResponder];
    [self.tfPassword resignFirstResponder];
}
@end

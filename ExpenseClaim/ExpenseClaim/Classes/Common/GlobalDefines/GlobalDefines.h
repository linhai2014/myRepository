

#ifndef GlobalDefines_h
#define GlobalDefines_h

#define SDColor(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]

#define Global_tintColor [UIColor colorWithRed:0 green:(190 / 255.0) blue:(12 / 255.0) alpha:1]

#define Global_mainBackgroundColor SDColor(248, 248, 248, 1)

#define TimeLineCellHighlightedColor [UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0]

#define DAY @"day"

#define NIGHT @"night"

//iPhoneX 适配 https://www.cnblogs.com/qiyiyifan/p/8308584.html

#define IphoneX [[DeviceDataLibrery sharedLibrery] isIphoneX]

#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]
#define UIColorFromRGB(rgbValue)              UIColorFromRGBA(rgbValue, 1.0)

#define UIScreenWidth               ([UIScreen mainScreen].bounds.size.width)
#define UIScreenHeight              ([UIScreen mainScreen].bounds.size.height)

// iPhone尺寸表 https://blog.csdn.net/future_one/article/details/79465656
#define scale(x)        x*UIScreenWidth/375.0

#define ItemMargin scale(10) //scale(30)

// MARK: 系统宏定义
#define IOS11           ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 11.0)
#define IOS10           ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0)
#define IOS9            ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 9.0)
#define IOS8            ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)
#define IOS8_2          ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.2)
#define IOS7            ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)
#define IOS7_1          ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.1)

// 是否是模拟器
#define isSimulator     ([DeviceUtil hardware] == SIMULATOR)

// IOS常用宏 https://www.jianshu.com/p/02b953e81414

//1.屏幕宽高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
#define ItemHeight kScreenWidth*0.3

//2.手机型号
#define kISiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kScreenMaxLength (MAX(kScreenWidth, kScreenHeight))
#define kScreenMinLength (MIN(kScreenWidth, kScreenHeight))
#define kISiPhone5 (kISiPhone && kScreenMaxLength == 568.0)
#define kISiPhone6 (kISiPhone && kScreenMaxLength == 667.0)
#define kISiPhone6P (kISiPhone && kScreenMaxLength == 736.0)
#define kISiPhoneX (kISiPhone && kScreenMaxLength == 812.0)
#define kISiPhoneXr (kISiPhone && kScreenMaxLength == 896.0)
#define kISiPhoneXX (kISiPhone && kScreenMaxLength > 811.0)
#define IOS8 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)

//3.适配相关
//6为标准适配的,如果需要其他标准可以修改
#define kScale_W(w) ((kScreenWidth)/375) * (w)
#define kScale_H(h) (kScreenHeight/667) * (h)
//状态栏高度
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//状态栏高度
#define StatusBarHeight (kISiPhoneXX?44:20)
//标签栏高度
#define kTabBarHeight (StatusBarHeight > 20 ? 83 : 49)
//导航栏高度
#define kNavBarHeight (StatusBarHeight + 44)
//安全区高度
#define kSafeAreaBottom (kISiPhoneXX ? 34 : 0)

//3.字体样式
#define kBoldFont(x) [UIFont boldSystemFontOfSize:x]
#define kFont(x) [UIFont systemFontOfSize:x]
#define kNameFont(x) [UIFont fontWithName:@"Heiti SC" size:x]

//4.颜色设置
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

//RGB格式
#define kRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//RGBA格式
#define kRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//随机颜色
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1)
#define RGB3(v) RGB(v,v,v)
#define BASE_COLOR RGB(4, 175, 255)

//5.系统对象
//APP对象 （单例对象）
#define kApplication [UIApplication sharedApplication]
//主窗口 （keyWindow）
#define kKeyWindow [UIApplication sharedApplication].keyWindow
//NSUserDefaults实例化
#define kUserDefaults [NSUserDefaults standardUserDefaults]
//通知中心 （单例对象）
#define kNotificationCenter [NSNotificationCenter defaultCenter]
//发送通知
#define KPostNotification(name,obj,info) [[NSNotificationCenter defaultCenter]postNotificationName:name object:obj userInfo:info]
//APP版本号
#define kVersion [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]
//系统版本号
#define kSystemVersion [[UIDevice currentDevice] systemVersion]

//6.简单调用
//加载图片
#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
//弱引用
#define kWeakSelf(type)  __weak typeof(type) weak##type = type
//强引用
#define kStrongSelf(type)  __strong typeof(type) type = weak##type
//安全调用Block
#define kSafeBlock(blockName,...) ({!blockName ? nil : blockName(__VA_ARGS__);})
//加载xib
#define kLoadNib(nibName) [UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]]
//字符串拼接
#define kStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]
//属性快速声明（建议使用代码块）
#define kPropertyString(name) @property(nonatomic,copy)NSString *name
#define kPropertyStrong(type,name) @property(nonatomic,strong)type *name
#define kPropertyAssign(name) @property(nonatomic,assign)NSInteger name
// View 圆角和加边框
#define kViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]
// View 圆角
#define kViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]
//永久存储对象
#define kSetUserDefaults(object, key)                                                                                                 \
({                                                                                                                                             \
NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];                                                                         \
[defaults setObject:object forKey:key];                                                                                                    \
[defaults synchronize];                                                                                                                    \
})
//获取对象
#define kGetUserDefaults(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
//删除某一个对象
#define kRemoveUserDefaults(key)                                         \
({                                                                          \
NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];       \
[defaults removeObjectForKey:_key];                                     \
[defaults synchronize];                                                 \
})
//清除 NSUserDefaults 保存的所有数据
#define kRemoveAllUserDefaults  [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]]

//7. 获取时间
//获得当前的年份
#define  kCurrentYear [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:[NSDate date]]
//获得当前的月份
#define  kCurrentMonth [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:[NSDate date]]
//获得当前的日期
#define  kCurrentDay  [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:[NSDate date]]
//获得当前的小时
#define  kCurrentHour [[NSCalendar currentCalendar] component:NSCalendarUnitHour fromDate:[NSDate date]]
//获得当前的分
#define  kCurrentMin [[NSCalendar currentCalendar] component:NSCalendarUnitMinute fromDate:[NSDate date]]
//获得当前的秒
#define  kCurrentSec [[NSCalendar currentCalendar] component:NSCalendarUnitSecond fromDate:[NSDate date]]

//8. 沙盒路径
//获取沙盒 temp
#define kPathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
//Library/Caches 文件路径
#define kFilePath ([[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil])

//9. 线程
//GCD - 在Main线程上运行
#define kMainThread(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
//GCD - 开启异步线程
#define kGlobalThread(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);

//10.判空
//字符串是否为空
#define kISNullString(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kISNullArray(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0 ||[array isEqual:[NSNull null]])
//字典是否为空
#define kISNullDict(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0 || [dic isEqual:[NSNull null]])
//是否是空对象
#define kISNullObject(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
//判断对象是否为空,为空则返回默认值
#define kGetNullDefaultObj(_value,_default) ([_value isKindOfClass:[NSNull class]] || !_value || _value == nil || [_value isEqualToString:@"(null)"] || [_value isEqualToString:@"<null>"] || [_value isEqualToString:@""] || [_value length] == 0)?_default:_value

//11.自定义Log
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#endif

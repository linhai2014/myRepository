//
//  ECExpenseClaimViewController.m
//  ExpenseClaim
//
//  Created by yulinhai on 2019/4/15.
//  Copyright © 2019年 linhai. All rights reserved.
//

#import "ECExpenseClaimViewController.h"
#import "LoginViewController.h"

@interface ECExpenseClaimViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIButton *takePhoto;
@property (strong, nonatomic) UIButton *selectPhoto;
@property (nonatomic, strong) UIButton *btnLogout;
@end

@implementation ECExpenseClaimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 这段代码会自动判断当前设备是否有摄像机功能，如果没有，会弹窗提示
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Device has no camera" preferredStyle:UIAlertControllerStyleAlert];
                                          
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击取消");
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击确认");
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"警告" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击警告");
        }]];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            NSLog(@"添加一个textField就会调用 这个block");
        }];

        // 由于它是一个控制器 直接modal出来就好了
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    self.navigationItem.title = @"报销";
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.takePhoto];
    [self.view addSubview:self.selectPhoto];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 300, 100, 100)];
    imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://localhost/sea"]]];
    [self.view addSubview:imageView];
    [self.view addSubview:self.btnLogout];
}

- (void)clickTakePhoto{
//    NSLog(@"%s", __FUNCTION__);
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)clickSelectPhoto{
//    NSLog(@"%s", __FUNCTION__);
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark ---代理方法
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerController *,id> *)info{
    
    UIImage *choseImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = choseImage;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ---Properties
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 80, 200, 100)];
        _imageView.image = [UIImage imageNamed:@"tabbar_RecordHL"];
    }
    
    return _imageView;
}

- (UIButton *)takePhoto{
    if (!_takePhoto) {
        _takePhoto = [UIButton buttonWithType:UIButtonTypeSystem];
        _takePhoto.frame = CGRectMake(10, 200, 150, 40);
        [_takePhoto setTitle:@"拍摄照片" forState:UIControlStateNormal];
        
        [_takePhoto addTarget:self action:@selector(clickTakePhoto) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _takePhoto;
}

- (UIButton *)selectPhoto{
    if (!_selectPhoto) {
        _selectPhoto = [UIButton buttonWithType:UIButtonTypeSystem];
        _selectPhoto.frame = CGRectMake(10, 300, 150, 40);
        [_selectPhoto setTitle:@"选取照片" forState:UIControlStateNormal];
        
        [_selectPhoto addTarget:self action:@selector(clickSelectPhoto) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _selectPhoto;
}

- (void)logoutAction{
    
    [ECUserDefault saveUserDefaultObject:@(NO) key:kAutoLogin];
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = loginVC;
}

- (UIButton*)btnLogout{
    if (!_btnLogout) {
        _btnLogout = [[UIButton alloc]initWithFrame:CGRectMake(150, 300, 100, 45)];
        [_btnLogout setTitle:@"注销" forState:UIControlStateNormal];
        [_btnLogout setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _btnLogout.layer.cornerRadius = 5;
        _btnLogout.layer.masksToBounds = YES;
        [_btnLogout addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLogout;
}

@end

//
//  FeedBackViewController.m
//  greenTeaUser
//
//  Created by chenTengfei on 15/7/7.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "FeedBackViewController.h"
#import "CameraTakeMamanger.h"
#import "UploadManager.h"

@interface FeedBackViewController ()

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(10, 50, 100, 30);
    button.backgroundColor = [UIColor greenColor];
    [button addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - event response
- (void)submitClick:(UIButton *)sender {
    [[CameraTakeMamanger sharedInstance] cameraSheetInController:self handler:^(UIImage *image, NSString *imagePath) {

        // !!
//        [[UploadManager sharedInstance] uploadFileWithFilePath:imagePath success:^(NSString *assetId, NSString *fileName, NSString *fileUrl) {
//            // 上传成功逻辑
//            
//        } failure:^(NSString *message) {
//            // 上传失败逻辑
//        }];
        
    }];
}


@end

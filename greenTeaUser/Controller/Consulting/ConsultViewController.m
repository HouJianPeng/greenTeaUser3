//
//  ConsultViewController.m
//  greenTeaUser
//
//  Created by chenTengfei on 15/7/7.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "ConsultViewController.h"
#import "MJRefresh.h"
@interface ConsultViewController ()<UIWebViewDelegate>
{
    UIWebView *protWebView;
}
@property (retain, nonatomic) IBOutlet UIWebView *protWebView;
@end


@implementation ConsultViewController
@synthesize protWebView;

- (void)viewDidLoad {
    NSLog(@"viewDidLoad");
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.title= @"咨询";
    //self.navigationController.navigationBar.hidden= YES;//是否隐藏导航栏
    //进入网页聊天
    NSURL *url = [[NSURL alloc]initWithString:@"http://chat.looyuoms.com/chat/chat/p.do?c=20000665&f=10050116&g=10054615"];//乐语地址
    
    [protWebView loadRequest:[NSURLRequest requestWithURL:url]];
    [self reloadInputViews];
}

//几个代理方法

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    NSLog(@"webViewDidStartLoad");
    
}

- (void)webViewDidFinishLoad:(UIWebView *)web{
    
    NSLog(@"webViewDidFinishLoad");
    
}

-(void)webView:(UIWebView*)webView  DidFailLoadWithError:(NSError*)error{
    
    NSLog(@"DidFailLoadWithError");
    
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

@end

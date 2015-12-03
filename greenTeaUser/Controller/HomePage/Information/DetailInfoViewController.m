//
//  DetailInfoViewController.m
//  greenTeaUser
//
//  Created by 侯建鹏 on 15/7/22.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "DetailInfoViewController.h"
#import "NewsVM.h"

@interface DetailInfoViewController ()<UIWebViewDelegate>
{
    UIWebView *detailWebView;//加载详情网页
}

@property (weak, nonatomic) IBOutlet UILabel *detaiTitle;
@property (retain, nonatomic) IBOutlet UIWebView *detailWebView;
@end

@implementation DetailInfoViewController
@synthesize detailWebView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"详情页";
    [self netWorkForDetail];
    [self setDetalBtn];
}


- (void)netWorkForDetail
{
    
    NSString *url = [NSString stringWithFormat:@"http://www.lawcheck.com.cn//cosmos.json?command=scommerce.SC_ADV_ADVERTISEMENT_GET&advertisementId=%@", self.advertisementId];
    [NetWork POST:url parmater:nil Block:^(NSData *data) {
        
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", myDic);
        
        NSDictionary *dic = [[[[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"SC_ADV_ADVERTISEMENT_GET"] objectForKey:@"list"] firstObject] firstObject];
        
        NewsModel *model = [NewsVM newsModelWithDict:dic];
        NSLog(@"%@", model);
        self.detaiTitle.text = [NSString stringWithFormat:@"%@",model.newsTitle ];
        
        [self.detailWebView loadHTMLString:model.contentStr baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]bundlePath]]];
        
    }];
   
}

- (void)setDetalBtn{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return_1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}


- (void)doBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

//
//  MoreInfoViewController.m
//  greenTeaLawyer
//
//  Created by 陈腾飞 on 15/7/16.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "MoreInfoViewController.h"
#import "HomePageTableViewCell.h"
#import "DetailInfoViewController.h"
#import "NewsInfoApiRequest.h"
#import "DetailInfoApiRequest.h"
#import "NewsVM.h"
#import "MJRefresh.h"
static NSInteger page =1;
@interface MoreInfoViewController ()<UITableViewDelegate, UITableViewDataSource,APIRequestDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/// 最新资讯请求
@property (nonatomic, strong) NewsInfoApiRequest *apiRequestInfo;
/// 更多资讯数据
@property (nonatomic, strong) NSMutableArray *newsInfoArray;

@end

@implementation MoreInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setLeftBtn];
    self.title = @"绿茶网头条";
    [self.tableView registerNib:[HomePageTableViewCell nibWithHomePageCell] forCellReuseIdentifier:kHomePageTableViewCell];
    self.tableView.rowHeight = 95;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.newsInfoArray = [NSMutableArray array];
    // 网络请求
    self.apiRequestInfo = [[NewsInfoApiRequest alloc] initWithDelegate:self];
    [self.apiRequestInfo setApiParamsWithPostName:@"1436840296083" PageLimit:@"20" CurrentPage:@"0"];
//    [APIClient execute:self.apiRequestInfo];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self.tableView.header beginRefreshing];
        NSString *str = [NSString stringWithFormat:@"%ld",page];
        [self.apiRequestInfo setApiParamsWithPostName:@"1436840296083" PageLimit:@"20" CurrentPage:str];
         [APIClient execute:self.apiRequestInfo];
        [self.tableView.header endRefreshing];
    }];
    [APIClient execute:self.apiRequestInfo];
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (self.newsInfoArray.count==10) {
            page ++;
        }
        page ++;
        [self.tableView.footer beginRefreshing];
        NSString *str = [NSString stringWithFormat:@"%ld",page];
        [self.apiRequestInfo setApiParamsWithPostName:@"1436840296083" PageLimit:@"20" CurrentPage:str];
        [APIClient execute:self.apiRequestInfo];
        [self.tableView.footer endRefreshing];
        
    }];
    
}





#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsInfoArray.count;
}


//tableView进行传值赋值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomePageTableViewCell forIndexPath:indexPath];
    
    NewsModel *model = [self.newsInfoArray objectAtIndex:indexPath.row];
    cell.tf_titleLabel.text = model.newsTitle;

    NSString *imageUrl = [NSString stringWithFormat:@"%@%@", SERVER_IMAGE, model.picUrl];
    [cell.tf_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"firstImage"]];
    cell.tf_dateLabel.text = model.createTime;
    NSString *filterHtmlTagStr = [self filterHtmlTag:model.content]; // added by necaluo
    NSString *subStr = [NSString stringWithFormat:@"%@%@", [filterHtmlTagStr substringToIndex:40], @"..."];
   

    cell.tf_contentLabel.text = subStr;
    return cell;
}
- (NSString *)filterHtmlTag:(NSString *)originHtmlStr{
    NSString *result = nil;
    NSRange arrowTagStartRange = [originHtmlStr rangeOfString:@"<"];
    if (arrowTagStartRange.location != NSNotFound) { //如果找到
        NSRange arrowTagEndRange = [originHtmlStr rangeOfString:@">"];
        //        NSLog(@"start-> %d   end-> %d", arrowTagStartRange.location, arrowTagEndRange.location);
        //        NSString *arrowSubString = [originHtmlStr substringWithRange:NSMakeRange(arrowTagStartRange.location, arrowTagEndRange.location - arrowTagStartRange.location)];
        result = [originHtmlStr stringByReplacingCharactersInRange:NSMakeRange(arrowTagStartRange.location, arrowTagEndRange.location - arrowTagStartRange.location + 1) withString:@""];
        // NSLog(@"Result--->%@", result);
        return [self filterHtmlTag:result];    //递归，过滤下一个标签
    }else{
        result = [originHtmlStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];  // 过滤&nbsp等标签
        //result = [originHtmlStr stringByReplacingOccurrencesOf  ........
    }
    return result;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailInfoViewController *detailVC = [[DetailInfoViewController alloc]init];
    NewsModel *model = [self.newsInfoArray objectAtIndex:indexPath.row];
    detailVC.advertisementId = model.newsId;
    NSLog(@"1");
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


#pragma mark - APIRequestDelegate

- (void)serverApi_RequestFailed:(APIRequest *)api error:(NSError *)error {
    
}
- (void)serverApi_FinishedSuccessed:(APIRequest *)api result:(NSDictionary *)sr {
    
    if (api == self.apiRequestInfo) {
        NSArray *newsArray = sr[@"result"][@"scommerce"][@"LC_ADV_ADVERTISEMENT_LIST_BLOCK"][@"list"][0];
        [self.newsInfoArray removeAllObjects];
        for (NSDictionary *dict in newsArray) {
            NewsModel *model = [NewsVM newsModelWithDict:dict];
            [self.newsInfoArray addObject:model];
        }
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

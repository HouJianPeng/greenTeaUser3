//
//  HomeViewController.m
//  greenTeaUser
//
//  Created by 侯建鹏 on 15/7/7.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "HomeViewController.h"
#import "lawyerCatViewController.h"
#import "ConsultViewController.h"
#import "CaseConsignViewController.h"
#import "BusinessAreaViewController.h"
#import "ImagePlayerView.h"
#import "DetailInfoViewController.h"


#import "MoreInfoViewController.h"
#import "MMDrawerController.h"
#import "NewsInfoApiRequest.h"
#import "DetailInfoApiRequest.h"

#import "HomePageTableViewCell.h"
#import "HomeBusinessCollectionCell.h"
#import "NewsVM.h"
#import "MJRefresh.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate, ImagePlayerViewDelegate, APIRequestDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic,strong)IBOutlet UITableView *tableview;//首页的tableview
@property (weak, nonatomic) IBOutlet UIView *tableHeadView;
@property (weak, nonatomic) IBOutlet ImagePlayerView *imagePlayerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lawCarHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *businessHeight; // 业务领域
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NewsInfoApiRequest *apiRequestInfo; /// 最新资讯请求
@property (nonatomic, strong) NSMutableArray *newsInfoArray; /// 最新资讯数据

@end

@implementation HomeViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupImageView];
    
    self.newsInfoArray = [NSMutableArray array];
    [self setupImageView];
    [self layoutPageSubviews];
    
    
    // 设置左边按钮
    [self setLeftBtnImage:[UIImage imageNamed:@"lv013"] eventHandler:^(id sender) {
        
        MMDrawerController *mmDrawerC = (MMDrawerController *)kRootViewController;
        [mmDrawerC openDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
            
        }];
    }];
    
    // tableView设置
    [self.tableview registerNib:[HomePageTableViewCell nibWithHomePageCell] forCellReuseIdentifier:kHomePageTableViewCell];
    self.tableview.rowHeight = 95;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableview.header beginRefreshing];
        [self.tableview.header endRefreshing];
    }];
    self.tableview.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.tableview.footer beginRefreshing];
        [self.tableview.footer endRefreshing];
    }];

    // 设置tableFootView
    UIView *tableFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenBoundWidth, 60)];
    CGFloat moreButtonWidth = kScreenBoundWidth - 20;
    CGFloat moreButtonHeight = 40;
    CGFloat moreButtonX = (kScreenBoundWidth - moreButtonWidth) / 2;
    CGFloat moreButtonY = (60 - moreButtonHeight) / 2;
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeSystem];
    moreButton.frame = CGRectMake(moreButtonX, moreButtonY, moreButtonWidth, moreButtonHeight);
    [moreButton setBackgroundImage:[UIImage imageNamed:@"lv006"] forState:UIControlStateNormal];
    [tableFootView addSubview:moreButton];
    [moreButton bk_addEventHandler:^(id sender) {
        MoreInfoViewController *moreInfoVC = [[MoreInfoViewController alloc] init];
        [self.navigationController pushViewController:moreInfoVC animated:YES];
        
    } forControlEvents:UIControlEventTouchUpInside];
    self.tableview.tableFooterView = tableFootView;
    
    
    // 网络请求
    
    self.newsInfoArray = [NSMutableArray array];
    self.apiRequestInfo = [[NewsInfoApiRequest alloc] initWithDelegate:self];
    [self.apiRequestInfo setApiParamsWithPostName:@"1436840296083" PageLimit:@"3" CurrentPage:@"0"];
    [APIClient execute:self.apiRequestInfo];
}


//设置自动轮播
- (void)setupImageView
{
    self.imagePlayerView.imagePlayerViewDelegate = self;
    self.imagePlayerView.backgroundColor = [UIColor clearColor];
    self.imagePlayerView.contentMode = UIViewContentModeScaleAspectFill;
    self.imagePlayerView.scrollInterval = 3.0;
    self.imagePlayerView.pageControlPosition = ICPageControlPosition_BottomCenter;
    self.imagePlayerView.hidePageControl = NO;
    [self.imagePlayerView reloadData];
    }

//设置适配
- (void)layoutPageSubviews {
    
    CGFloat lawCarWidth = (kScreenBoundWidth - 2) / 2.0;  // 法律直通车高度
    self.lawCarHeight.constant = lawCarWidth / (202.0 / 165);  // 法律直通车宽度
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 40.0f)];//初始化图片视图控件
    imageView.contentMode = UIViewContentModeScaleAspectFit;//设置内容样式,通过保持长宽比缩放内容适应视图的大小,任何剩余的区域的视图的界限是透明的。
    UIImage *image = [UIImage imageNamed:@"phone_icon"];//初始化图像视图
    [imageView setImage:image];
    self.navigationItem.titleView = imageView;//设置导航栏的titleView为imageView

    self.tableHeadView.height = 130 + self.businessHeight.constant + self.lawCarHeight.constant + 25 + 8 + 8;// tableHeadView的高度
    [self setupCollectionView];
}

- (void)setupCollectionView {
    // 业务领域设置
    CGFloat itemWidth = kScreenBoundWidth / 4.0;
    CGFloat itemHeight = itemWidth / (203.0 / 233);
    self.businessHeight.constant = itemHeight + 8;
    self.flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.minimumLineSpacing = 0;
    
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = YES;
    [self.collectionView registerClass:[HomeBusinessCollectionCell class] forCellWithReuseIdentifier:kReusableHomeBusinessCollectionCell];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsInfoArray.count;
}

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
#pragma mark - UITableViewDelegate    点击列表页面进入资讯详情页面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中 %ld",(long)indexPath.row);
    DetailInfoViewController *detailVC = [[DetailInfoViewController alloc]init];
    NewsModel *model = [self.newsInfoArray objectAtIndex:indexPath.row];
    detailVC.advertisementId = model.newsId;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

//点击collectionview，cell跳转业务领域
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeBusinessCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReusableHomeBusinessCollectionCell forIndexPath:indexPath];
    NSString *imgStr = [NSString stringWithFormat:@"Home_business%@", @(indexPath.row)];
    cell.imageView.image = [UIImage imageNamed:imgStr];
//    cell.tf_imageView.image = [UIImage imageNamed:imgStr];
//    cell.tf_imageView.contentMode = UIViewContentModeScaleAspectFill;
//    cell.tf_imageView.layer.masksToBounds = YES;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BusinessAreaViewController *businessVC = [[BusinessAreaViewController alloc] init];
    [self.navigationController pushViewController:businessVC animated:YES];
}

#pragma mark - ImagePlayerViewDelegate

- (NSInteger)numberOfItems {
    return 2;
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index {
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.masksToBounds = YES;
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"lunbo_user%@", @(index)]];
}

#pragma mark - event response
-(IBAction)lawyerbutn:(id)sender
{
    NSLog(@"律师");
    lawyerCatViewController *CarVC = [[lawyerCatViewController alloc]init];
    [self.navigationController pushViewController:CarVC animated:YES];
    
}

//- (void)netrequest{
//    NSString *settingsName = [AccountManager sharedInstance].account.settingsName;
//    NSString *siteId = [AccountManager sharedInstance].account.siteId;
//    NSString *surl = [NSString stringWithFormat:@"%@/cosmos.json?command=scommerce.SC_SYS_SITE_SETTINGS_GET&settingsName=%@&siteId=%@",SERVER_HOST_PRODUCT,settingsName,siteId];
//    
//    [NetWork POST:surl parmater:nil Block:^(NSData *data) {
//        NSDictionary *mDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"%@", mDic);
//        NSDictionary *foDic = [[[[[[mDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_ACC_ACCOUNT_GET"] objectForKey:@"list"] firstObject] firstObject];
//        NSLog(@"foDic = %@", foDic);
//       Account *accont = [Account initAccount:foDic];
//        if [(accont.settingsName valueForKey:@"1") ] {
//            NSLog(@"");
//        }else{
//            NSLog(@"");
//        }
//        
//    }];
//    
//}
-(IBAction)entrustbutn:(id)sender
{
    if ([AccountManager sharedInstance].isLogin) {
        
        NSString *userId = [AccountManager sharedInstance].account.userId;
        
        NSString *url = [NSString stringWithFormat:@"%@scommerce.LC_ACC_ACCOUNT_GET&userId=%@", SERVER_HOST_PRODUCT, userId];
        
        [NetWork POST:url parmater:nil Block:^(NSData *data) {
            NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@", myDic);
            
            NSDictionary *infoDic = [[[[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_ACC_ACCOUNT_GET"] objectForKey:@"list"] firstObject] firstObject];
            NSLog(@"infoDic = %@", infoDic);
            Account *account = [Account initAccount:infoDic];
            
            
            if ([account.isAudited isEqualToString:@"0"] || [account.isAudited isEqualToString:@"1"] || [account.isAudited isEqualToString:@"2"]) {
                CaseConsignViewController*view =[[CaseConsignViewController alloc] init];
                [self.navigationController pushViewController:view animated:YES];

            }
//            else {
//                [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"用户未审核" cancelButtonTitle:@"确定" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
//                }];
//            }
        }];
    }
    else{
        [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"您未登录, 请登录" cancelButtonTitle:@"取消" otherButtonTitles:[NSArray arrayWithObjects:@"登录", nil] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex != 0) {
                [AccountManager changeRootVCWithLogin];
            }
        }];
    }
}

#pragma mark - APIRequestDelegate

- (void)serverApi_RequestFailed:(APIRequest *)api error:(NSError *)error {
    
}
- (void)serverApi_FinishedSuccessed:(APIRequest *)api result:(NSDictionary *)sr {
    
    if (api == self.apiRequestInfo) {
        NSArray *newsArray = sr[@"result"][@"scommerce"][@"LC_ADV_ADVERTISEMENT_LIST_BLOCK"][@"list"][0];
        for (NSDictionary *dict in newsArray) {
            NewsModel *model = [NewsVM newsModelWithDict:dict];
            [self.newsInfoArray addObject:model];
        }
        [self.tableview reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

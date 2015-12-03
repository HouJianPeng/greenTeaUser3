//
//  CaseViewController.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/12.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "CaseViewController.h"
#import "CaseTableViewCell.h"
#import "InCaseViewController.h"
#import "NetWork.h"
#import "NetWorkMacro.h"
#import "Account.h"
#import "AccountManager.h"
#import "CaseManager.h"
#import "MJRefresh.h"
static NSInteger page =1;
#define KUserCaseReuse @"CaseCellReuse"
@interface CaseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *caseTableView;
@property (nonatomic, strong) NSMutableArray *caseArray;

@end

@implementation CaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.caseTableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return_1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;

    // Do any additional setup after loading the view from its nib.
    self.title = @"案件管理";
    //注册cell
    [self.caseTableView registerNib:[UINib nibWithNibName:@"CaseTableViewCell" bundle:nil] forCellReuseIdentifier:KUserCaseReuse];
    self.caseTableView.rowHeight = 235;
    self.caseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self network];
    self.caseTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page =1;
        [self.caseTableView.header beginRefreshing];
        [self network];
        [self.caseTableView.header endRefreshing];
    }];
    self.caseTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (self.caseArray.count==10) {
             page++;
        }
        [self.caseTableView.footer beginRefreshing];
        [self network];
        [self.caseTableView.footer endRefreshing];
    }];
    
}

- (void)doBack:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - network
- (void)network
{
    NSString *userId = [AccountManager sharedInstance].account.userId;
    NSString *url = [NSString stringWithFormat:@"%@scommerce.LC_CASE_LAWCASE_LIST4USER_BLOCK&cosmosPassportId=%@&keywords=%@&page=%ld&pageSize=%@",SERVER_HOST_PRODUCT, userId,@"",(long)page,@"10"];
    
    [NetWork GET:url parmater:nil Block:^(NSData *data) {
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", myDic);
        
        NSArray *arrayTem = [[[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_CASE_LAWCASE_LIST4USER_BLOCK"] objectForKey:@"list"] firstObject];
         self.caseArray = [NSMutableArray array];
        for (NSDictionary *dic in arrayTem) {
            CaseModel *caseModel = [CaseManager caseModelWithDict:dic];
            [self.caseArray addObject:caseModel];
//            NSLog(@"model = %@", [CaseManager caseModelWithDict:dic]);
        }
        NSLog(@"%@", self.caseArray);
        [self.caseTableView reloadData];
    }];
}
#pragma mark  tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.caseArray.count;
}

#pragma mark TableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KUserCaseReuse];
    CaseModel *model = [self.caseArray objectAtIndex:indexPath.section];
    cell.caseStateLabel.text = model.statusLabel;
    cell.caseNumberLabel.text = model.caseNo;
    cell.caseTypeLabel.text = model.businessTypeLabel;
    cell.caseTitleLable.text = model.caseTitle;
    cell.caseTypeLabel.userInteractionEnabled =YES;
    cell.theDetialButton.tag = indexPath.section+100;
    [cell.theDetialButton addTarget:self action:@selector(pushTheDetialView:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)pushTheDetialView:(UIButton*)tap{
    CaseModel *model = [self.caseArray objectAtIndex:tap.tag-100];
    InCaseViewController *incaseVC = [[InCaseViewController alloc]init];
    incaseVC.caseId = model.caseId;
    //incaseVC.caseModel = model;
    
    [self.navigationController pushViewController:incaseVC animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

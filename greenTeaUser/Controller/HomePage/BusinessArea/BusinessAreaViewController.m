//
//  BusinessAreaViewController.m
//  greenTeaUser
//
//  Created by 侯建鹏 on 15/7/13.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "BusinessAreaViewController.h"
#import "BusinessAreaCollectionViewCell.h"

static NSString *cellIdentifier = @"BusinessAreaCollectionViewCell";

@interface BusinessAreaViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *theCollectionView;
@property (nonatomic, retain) UIAlertView *businessAlert; // 业务领域提示框
@property(nonatomic,retain)NSArray*array;

@end

@implementation BusinessAreaViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"业务领域";
    
    [self loadBlackButton];
    [self loadTheCollectionView];
}

-(void)loadBlackButton{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return_1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

-(void)loadTheCollectionView{
   
    UINib *nib = [UINib nibWithNibName:cellIdentifier bundle:[NSBundle mainBundle]];
    [self.theCollectionView registerNib:nib forCellWithReuseIdentifier:cellIdentifier];
    
    UIImage *img_m = [UIImage imageNamed:@"bigbg"];
    UIImage *img_a;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [img_m drawInRect:CGRectMake(0, 0, width, height)];
    img_a = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.theCollectionView.backgroundColor = [UIColor colorWithPatternImage:img_a];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
//    self.array = @[@"民商事合同诉讼与仲裁",
//                   @"劳动争议",
//                   @"公司法律事务",
//                   @"房地产与建筑工程",
//                   @"银行与金融",
//                   @"证券与资本市场",
//                   @"公司收购、兼并与重组",
//                   @"私募股权与投资基金",
//                   @"知识产权",
//                   @"刑事案件"];

}

#pragma mark CollectionViewLayoutDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width/5,[UIScreen mainScreen].bounds.size.width/5+35);
}

#pragma mark CollectionViewDatasource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BusinessAreaCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSString*str = [NSString stringWithFormat:@"Home_business%@", @(indexPath.row)];
    cell.businessImage.image = [UIImage imageNamed:str];
//    cell.businessName.text = self.array[indexPath.row];
//    cell.businessName.textColor = [UIColor whiteColor];

    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"您点击了第%ld个",indexPath.row);
    self.businessAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"功能暂未开通" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [self.businessAlert show];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
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

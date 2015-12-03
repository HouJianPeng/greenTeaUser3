//
//  GuidanceViewController.m
//  greenTeaUser
//
//  Created by 陈腾飞 on 15/7/16.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "GuidanceViewController.h"
#import "GuidanceCollectionViewCell.h"

@interface GuidanceViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation GuidanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self layoutPageSubviews];
    
    [self.collectionView registerNib:[GuidanceCollectionViewCell nibWithGuidanceCell] forCellWithReuseIdentifier:kGuidanceCollectionViewCell];
}

- (void)layoutPageSubviews {
    self.flowLayout.itemSize = CGSizeMake(kScreenBoundWidth, kScreenBoundHeight);
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.minimumLineSpacing = 0;
    
//    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GuidanceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGuidanceCollectionViewCell forIndexPath:indexPath];
    NSString *imgStr = [NSString stringWithFormat:@"Guidance%@", @(indexPath.row)];
    cell.tf_backGroundView.image = [UIImage imageNamed:imgStr];
    if (indexPath.row == 4) {
        cell.tf_enterButton.hidden = NO;
        [cell.tf_enterButton addTarget:self action:@selector(enterClick:) forControlEvents:UIControlEventTouchUpInside];
        
    } else {
        cell.tf_enterButton.hidden = YES;
    }
    
    return cell;
}

#pragma mark - event response
- (void)enterClick:(UIButton *)button {
    [AccountManager changeRootVCWithMMDrawer];
}
@end

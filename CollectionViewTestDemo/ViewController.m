//
//  ViewController.m
//  CollectionViewTestDemo
//
//  Created by fei on 15/2/13.
//  Copyright (c) 2015年 self. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma UICollectionView DataSource
/*
 每组个数
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}
/*
 组数
 */
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

/*
 获取对应cell
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"reuseCell" forIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell viewWithTag:101];
    label.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    if (indexPath.section == 1) {
        cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"reuseCell2" forIndexPath:indexPath];
        UIImageView *imageV = (UIImageView *)[cell viewWithTag:101];
        imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",(long)indexPath.row%3+1]];
        UILabel *label2 = (UILabel *)[cell viewWithTag:102];
        label2.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    }
    return cell;
}

/*
 设置对应的sectionHeaderView sectionFooterView，这里的UICollectionReusableView 是复用的，所以header与footer区分开，每次要做判断是header还是footer，再取对应的自定义view。
 */
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *view;
    if (kind == UICollectionElementKindSectionHeader) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    } else if (kind == UICollectionElementKindSectionFooter) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
    }
    return view;
}

/*
 collectionView 代理方法
 */
#pragma UICollectionView Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"did selectItem :%@",indexPath);
}



/*
 collectionView 默认布局代理方法，主要对应cell sectionHeader sectionFooter 大小、间隔等
 */
#pragma UICollectionViewDelegateFlowLayout
/*
 限定secontion内，top:cell顶部距离headerView的间隔  bottom:最后cell底部距离FooterView的间隔
 left:左侧相对空余位置 ，right:右侧相对空余位置
*/
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 10, 50, 10);
}
/*
 确定对应cell 大小
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake(60, 20);
    if (indexPath.section==1) {
        size = CGSizeMake(140, 80);
    }
    return size;
}
/*
 列与列之间的距离，目测是以cell的宽度、给定的间隔以及collectionView的宽度确定的一个值，但这个宽度不一定是给定的值，可能比给定的值大
 */
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section==1) {
        return 10;
    }
    return 11;
}
/*
 确定对应组行与行之间的距离
 */
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section==1)
        return 10;
    return 20;
}
/*
 定义sectionfooter的size
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section==1) {
        return CGSizeZero;
    }
    return CGSizeMake(collectionView.frame.size.width, 100);
}
/*
 定义sectionheader的size
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return CGSizeZero;
    }
    return CGSizeMake(collectionView.frame.size.width-20, 50);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

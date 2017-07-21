
//
//  BMIdenticalSizeCellVC.m
//  BMDragCellCollectionViewDemo
//
//  Created by __liangdahong on 2017/7/20.
//  Copyright © 2017年 http://idhong.com. All rights reserved.
//

#import "BMIdenticalSizeCellVC.h"
#import "BMDragCollectionViewCell.h"
#import "BMDragCellCollectionView.h"

#define WIDTH   self.view.bounds.size.width
#define HEIGHT  self.view.bounds.size.height

@interface BMIdenticalSizeCellVC () <BMDragCellCollectionViewDelegate, BMDragCollectionViewDataSource>

@property (nonatomic, strong) BMDragCellCollectionView *collectionView; // collectionView
@property (strong, nonatomic) NSMutableArray <NSDictionary *> *dataSource;

@end

static NSString *reuseIdentifier = @"forCellWithReuseIdentifier";

@implementation BMIdenticalSizeCellVC

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource = [NSMutableArray array];
    for (int i = 1; i <= 80; i++) {
        UIColor *color = [UIColor colorWithHue:arc4random_uniform(128)/255.0 + 0.5 saturation:arc4random_uniform(128)/255.0 + 0.5  brightness:arc4random_uniform(128)/255.0 + 0.5  alpha:1];
        [_dataSource addObject:@{@"color" : color, @"title" : [NSString stringWithFormat:@"%d", i]}];
    }
    [self.view addSubview:self.collectionView];
}

#pragma mark - getters setters

- (BMDragCellCollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat width = arc4random_uniform(50)+50;
        layout.itemSize = CGSizeMake(width, width);
        _collectionView = [[BMDragCellCollectionView alloc] initWithFrame:CGRectMake(0, 20, WIDTH, HEIGHT - 20) collectionViewLayout:layout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        layout.minimumLineSpacing = arc4random_uniform(20)+1;
        layout.minimumInteritemSpacing = arc4random_uniform(20)+1;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(BMDragCollectionViewCell.class) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

#pragma mark - 系统delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BMDragCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.label.text = _dataSource[indexPath.item][@"title"];
    cell.label.backgroundColor = _dataSource[indexPath.item][@"color"];
    return cell;
}

- (NSArray *)dataSourceWithDragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView {
    return self.dataSource;
}

- (void)dragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(NSArray *)newDataArray {
    self.dataSource = [newDataArray mutableCopy];
}


@end

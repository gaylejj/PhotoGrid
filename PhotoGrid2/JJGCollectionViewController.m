//
//  JJGCollectionViewController.m
//  PhotoGrid2
//
//  Created by Jeff Gayle on 5/29/14.
//  Copyright (c) 2014 Jeff Gayle. All rights reserved.
//

#import "JJGCollectionViewController.h"
#import "PhotoCell.h"

@interface JJGCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *photos;

@end

@implementation JJGCollectionViewController

- (void)viewDidLoad
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
    
    [self.collectionView addGestureRecognizer:longPress];
    
    _photos = [NSMutableArray new];
    
    [super viewDidLoad];
    
    UIImage *image1 = [UIImage imageNamed:@"Frisbee 1.jpg"];
    [_photos addObject:image1];
    
    UIImage *image2 = [UIImage imageNamed:@"Frisbee 2.jpeg"];
    [_photos addObject:image2];
    
    UIImage *image3 = [UIImage imageNamed:@"Frisbee 3.jpg"];
    [_photos addObject:image3];
    
    UIImage *image4 = [UIImage imageNamed:@"Kessa 1.jpg"];
    [_photos addObject:image4];
    
    UIImage *image5 = [UIImage imageNamed:@"Kessa 2.jpg"];
    [_photos addObject:image5];
    
    UIImage *image6 = [UIImage imageNamed:@"Kessa 3.jpg"];
    [_photos addObject:image6];
    
    UIImage *image7 = [UIImage imageNamed:@"Sounders 1.jpg"];
    [_photos addObject:image7];
    
    UIImage *image8 = [UIImage imageNamed:@"Sounders 2.jpeg"];
    [_photos addObject:image8];
    
    UIImage *image9 = [UIImage imageNamed:@"Sounders 3.jpg"];
    [_photos addObject:image9];
    
    UIImage *image10 = [UIImage imageNamed:@"Sounders 4.jpg"];
    [_photos addObject:image10];
    
    UIImage *image11 = [UIImage imageNamed:@"Sounders 5.jpg"];
    [_photos addObject:image11];
    
    UIImage *image12 = [UIImage imageNamed:@"Wallace Falls 1.jpg"];
    [_photos addObject:image12];
    
    UIImage *image13 = [UIImage imageNamed:@"Wallace Falls 2.jpg"];
    [_photos addObject:image13];
    
    UIImage *image14 = [UIImage imageNamed:@"Wallace Falls 3.jpg"];
    [_photos addObject:image14];
    
    UIImage *image15 = [UIImage imageNamed:@"Wallace Falls 4.jpg"];
    [_photos addObject:image15];
    
    UIImage *image16 = [UIImage imageNamed:@"Wallace Falls 5.jpg"];
    [_photos addObject:image16];
    
    UIImage *image17 = [UIImage imageNamed:@"Wallace Falls 6.jpg"];
    [_photos addObject:image17];
    
    UIImage *image18 = [UIImage imageNamed:@"Wallace Falls 7.jpg"];
    [_photos addObject:image18];
    
    UIImage *image19 = [UIImage imageNamed:@"Wallace Falls 8.jpg"];
    [_photos addObject:image19];
    
    UIImage *image20 = [UIImage imageNamed:@"Wallace Falls 9.jpg"];
    [_photos addObject:image20];
    
    UIImage *image21 = [UIImage imageNamed:@"Wallace Falls 10.jpg"];
    [_photos addObject:image21];
    
    UIImage *image22 = [UIImage imageNamed:@"Wallace Falls 11.jpg"];
    [_photos addObject:image22];
    
    UIImage *image23 = [UIImage imageNamed:@"Wallace Falls 12.jpg"];
    [_photos addObject:image23];
    
    UIImage *image24 = [UIImage imageNamed:@"Wallace Falls 13.jpg"];
    [_photos addObject:image24];
    
    UIImage *image25 = [UIImage imageNamed:@"Wallace Falls 14.jpg"];
    [_photos addObject:image25];
}

#pragma mark - CollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.photoView.image = _photos[indexPath.row];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _photos.count;
}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UIImage *image;
//    image = _photos[indexPath.row];
//    return image.size;
//}

#pragma mark - UIGestureRecognizer
- (IBAction)longPressGestureRecognized:(id)sender
{
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:location];
    
    static UIView       *snapshot = nil;
    static NSIndexPath  *sourceIndexPath = nil;
    
    switch (state) {
        case UIGestureRecognizerStateBegan:
            if (indexPath) {
                sourceIndexPath = indexPath;
                
                UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
                
                snapshot = [self customSnapshotFromView:cell];
                
                __block CGPoint center = cell.center;
                snapshot.center = center;
                snapshot.alpha = 0.0;
                [self.collectionView addSubview:snapshot];
                [UIView animateWithDuration:0.25 animations:^{
                    center.y = location.y;
                    center.x = location.x;
                    snapshot.center = center;
                    snapshot.transform = CGAffineTransformMakeScale(2,2);
                    snapshot.alpha = 0.98;
                    
                    cell.backgroundColor = [UIColor whiteColor];
                    
                }completion:nil];
            }
            break;
            
        case UIGestureRecognizerStateChanged: {
            CGPoint center = snapshot.center;
            center.y = location.y;
            center.x = location.x;
            snapshot.center = center;
            
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                
                [self.photos exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                
                [self.collectionView moveItemAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                
                sourceIndexPath = indexPath;
            }
            break;
        }
            
        default:{
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:sourceIndexPath];
            [UIView animateWithDuration:0.25 animations:^{
                
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                
                cell.backgroundColor = [UIColor blackColor];
                
            } completion:^(BOOL finished) {
                
                [snapshot removeFromSuperview];
                snapshot = nil;
                
            }];
            sourceIndexPath = nil;
            break;
        }
    }
}

- (UIView *)customSnapshotFromView:(UIView *)inputView
{
    UIView *snapshot = [inputView snapshotViewAfterScreenUpdates:YES];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

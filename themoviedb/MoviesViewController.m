//
//  MoviesViewController.m
//  themoviedb
//
//  Created by user116657 on 3/18/16.
//  Copyright © 2016 gama. All rights reserved.
//

#import "MoviesViewController.h"
#import "APIClient.h"

@interface MoviesViewController ()

@property (nonatomic, strong) NSString *secureBaseURL;
@property (nonatomic, strong) NSString *posterSize;
@property (nonatomic, strong) NSArray *results;
@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation MoviesViewController

static NSString * const reuseIdentifier = @"MovieCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.collectionView registerClass:[MovieCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    _secureBaseURL = @"";
    _posterSize = @"";
    _imageArray = [[NSMutableArray alloc] init];
    
    [[APIClient sharedInstance] requestConfigurationExecutingBlock:^(BOOL success, NSDictionary *entries) {
        if (success) {
            _secureBaseURL = (entries[@"secure_base_url"]) ?: nil;
            _posterSize = (entries[@"poster_sizes"][2]) ?: nil;
        } else {
            NSLog(@"ERROR ");
        }
    }];
    
    [[APIClient sharedInstance] requestMovieListExecutingBlock:^(BOOL success, NSArray *entries) {
        if(success) {
            _results = (entries) ?: nil;
            NSString *urlString = [[NSString alloc] init];
            
            for (int i = 0; i < _results.count; i++) {
                urlString = [NSString stringWithFormat:@"%@%@%@",_secureBaseURL,_posterSize,_results[i][@"poster_path"]];
                
                [[APIClient sharedInstance] loadRemoteImageFromURL:[NSURL URLWithString:urlString] andExecuteBlock:^(BOOL success, UIImage *image, NSURL *url) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (success) {
                            [_imageArray addObject:image];
                        } else {
                            NSLog(@"Error loading image from URL");
                        }
                    });
                }];
            }
            
            [self.collectionView reloadData];
        }
    }];
    
    // Do any additional setup after loading the view.
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _results.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
   
    cell.imageView.image = [_imageArray objectAtIndex:indexPath.row];
    
    cell.backgroundColor = UIColor.blackColor;
    
    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize retval = CGSizeMake(185, 185);
    return retval;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end

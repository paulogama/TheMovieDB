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
                                    
                                    [self.collectionView reloadData];                                    
                                } else {
                                    NSLog(@"Error loading image from URL");
                                }
                            });
                        }];
                    }
                }
            }];
        } else {
            NSLog(@"ERROR ");
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
    return _imageArray.count;
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

// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"MovieDetailSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"MovieDetailSegue"]){
        NSArray *indexPathArray = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *indexPath = indexPathArray[0];
        MovieDetailViewController *movieDetailViewController = segue.destinationViewController;
        
        movieDetailViewController.titleText = _results[indexPath.row][@"original_title"];
        movieDetailViewController.poster = _imageArray[indexPath.row];
        movieDetailViewController.yearText = _results[indexPath.row][@"release_date"];
        movieDetailViewController.durationText = _results[indexPath.row][@"id"];
        movieDetailViewController.voteAverageText = _results[indexPath.row][@"vote_average"];
        movieDetailViewController.overviewText = _results[indexPath.row][@"overview"];
    }
}

@end

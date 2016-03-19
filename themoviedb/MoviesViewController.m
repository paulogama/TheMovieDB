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
@property (nonatomic, strong) NSArray *results;

@end

@implementation MoviesViewController

static NSString * const reuseIdentifier = @"MovieCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [[APIClient sharedInstance] requestConfigurationExecutingBlock:^(BOOL success, NSDictionary *entries) {
        if (success) {
            _secureBaseURL = (entries[@"secure_base_url"]) ?: nil;
            NSLog(@"%@ ",_secureBaseURL);
        } else {
            NSLog(@"ERROR ");
        }
    }];
    
    [[APIClient sharedInstance] requestMovieListExecutingBlock:^(BOOL success, NSArray *entries) {
        if(success) {
            _results = (entries) ?: nil;
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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",_secureBaseURL,_results[0][@""]];
    
    [[APIClient sharedInstance] loadRemoteImageFromURL:[NSURL URLWithString:urlString] andExecuteBlock:^(BOOL success, UIImage *image, NSURL *url) {
        NSLog(@"%@",url);
    }];
    
    cell.backgroundColor = UIColor.blackColor;
    
    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize retval = CGSizeMake(100, 100);
    retval.height += 35;
    retval.width += 35;
    return retval;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 20, 50, 20);
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

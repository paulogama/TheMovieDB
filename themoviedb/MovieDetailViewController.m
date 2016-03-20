//
//  MovieDetailViewController.m
//  themoviedb
//
//  Created by user116657 on 3/19/16.
//  Copyright © 2016 gama. All rights reserved.
//

#import "MovieDetailViewController.h"

@interface MovieDetailViewController()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *yearLabel;
@property (nonatomic, strong) UILabel *durationLabel;
@property (nonatomic, strong) UILabel *voteAverageLabel;
@property (nonatomic, strong) UIButton *favoriteButton;
@property (nonatomic, strong) UITextView *overviewTextView;
//@property (nonatomic, strong) UITableView *trailerTableView;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self adjustSubviewsOnScreen];
    
    _titleLabel.text = [NSString stringWithFormat:@"%@",_titleText];
    _imageView.image = _poster;
    _yearLabel.text = [NSString stringWithFormat:@"%@",_yearText];
    _durationLabel.text = [NSString stringWithFormat:@"%@",_durationText];
    _voteAverageLabel.text = [NSString stringWithFormat:@"%@ / 10",_voteAverageText];
    [_favoriteButton setTitle:@"MARK AS FAVORITE" forState:UIControlStateNormal];
    _overviewTextView.text = [NSString stringWithFormat:@"%@",_overviewText];
    //_trailerTableView.dataSource = self;
}

- (void)adjustSubviewsOnScreen {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, 400, 100)];
    _titleLabel.backgroundColor = [UIColor colorWithRed:0 green:0.6 blue:0.6 alpha:1];
    [self.view addSubview:_titleLabel];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, _titleLabel.frame.origin.y + _titleLabel.frame.size.height, 375, 544)];
    [self.view addSubview:view];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 154, 231)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:_imageView];
    
    _yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(174, 10, 165, 21)];
    [view addSubview:_yearLabel];
    
    _durationLabel = [[UILabel alloc] initWithFrame:CGRectMake(174, _yearLabel.frame.origin.y + _yearLabel.frame.size.height + 15, 165, 21)];
    [view addSubview:_durationLabel];
    
    _voteAverageLabel = [[UILabel alloc] initWithFrame:CGRectMake(174, _durationLabel.frame.origin.y + _durationLabel.frame.size.height + 15, 165, 21)];
    [view addSubview:_voteAverageLabel];
    
    _favoriteButton = [[UIButton alloc] initWithFrame:CGRectMake(174, _voteAverageLabel.frame.origin.y + _voteAverageLabel.frame.size.height + 15, 165, 30)];
    _favoriteButton.backgroundColor = [UIColor colorWithRed:0 green:0.9 blue:0.9 alpha:1];
    [view addSubview:_favoriteButton];
    
    _overviewTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, _imageView.frame.origin.y + _imageView.frame.size.height + 15, 357, 80)];
    [view addSubview:_overviewTextView];
    
    /*_trailerTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 346, 357, 189)];
    [view addSubview:_trailerTableView];*/
    
}

@end

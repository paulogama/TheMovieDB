//
//  MovieDetailViewController.m
//  themoviedb
//
//  Created by user116657 on 3/19/16.
//  Copyright © 2016 gama. All rights reserved.
//

#import "MovieDetailViewController.h"

@implementation MovieDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, 400, 50)];
    titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.text = _titleText;
    
    [self.view addSubview:titleLabel];
}

@end

//
//  MovieDetailViewController.h
//  themoviedb
//
//  Created by user116657 on 3/19/16.
//  Copyright © 2016 gama. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailViewController : UIViewController

@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) UIImage *poster;
@property (nonatomic, strong) NSString *yearText;
@property (nonatomic, strong) NSString *durationText;
@property (nonatomic, strong) NSString *voteAverageText;
@property (nonatomic, strong) NSString *overviewText;


@end

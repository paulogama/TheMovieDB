//
//  ViewController.m
//  themoviedb
//
//  Created by user116657 on 3/17/16.
//  Copyright © 2016 gama. All rights reserved.
//

#import "ViewController.h"
#import "APIClient.h"

@interface ViewController ()

@property NSArray *movies;
@property APIClient *apiClient;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    APIClient *apiClient = [[APIClient alloc] init];
    [apiClient getConfiguration];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

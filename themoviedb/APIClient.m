//
//  APIClient.m
//  themoviedb
//
//  Created by user116657 on 3/18/16.
//  Copyright © 2016 gama. All rights reserved.
//

#import "APIClient.h"
#import "AFNetworking.h"

#import "Constants.h"

#import "Configuration.h"
#import "Movie.h"

@interface APIClient ()

@property NSString *url;
@property NSDictionary *configurationDict;
@property Configuration *configuration;
@end

@implementation APIClient

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.url = [NSString stringWithFormat:@"%@%@",kBaseConfigurationURL,kApiKey];
    }
    return self;
}

- (void) getConfiguration {
    NSURL *URL = [NSURL URLWithString:self.url];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        self.configurationDict = (NSDictionary *)responseObject;
        Configuration *configuration = [[Configuration alloc] initWithAttributes:self.configurationDict];
        
        NSLog(@"Base URL: %@", configuration.images[@"secure_base_url"]);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
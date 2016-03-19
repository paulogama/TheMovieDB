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

@implementation APIClient

+ (APIClient *) sharedInstance {
    static dispatch_once_t pred = 0;
    __strong static APIClient * _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (void) requestConfigurationExecutingBlock: ( void (^) (BOOL success, NSDictionary  * entries) ) block {
    NSString *urlString = [NSString stringWithFormat:@"%@%@",kBaseConfigurationURL,kApiKey];
    NSURL *URL = [NSURL URLWithString:urlString];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDict = (NSDictionary *)responseObject;
            NSDictionary *imagesDict = responseDict[@"images"];
            
            if(imagesDict && ([imagesDict isKindOfClass:[NSDictionary class]])) {
                block(YES,imagesDict);
            } else block(NO,nil);
        } else block(NO,nil);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        block(NO,nil);
        
    }];
}

- (void) requestMovieListExecutingBlock: ( void (^) (BOOL success, NSArray * entries) ) block {
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@",kBaseMovieURL,kApiKey,kSortByPopularity];
    NSURL *URL = [NSURL URLWithString:urlString];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDict = (NSDictionary *)responseObject;
            NSArray *results = responseDict[@"results"];
            
            if(results && ([results isKindOfClass:[NSArray class]])) {
                block(YES,results);
            } else block(NO,nil);
        } else block(NO,nil);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        block(NO,nil);
        
    }];
}

- (void) loadRemoteImageFromURL: (NSURL *) url andExecuteBlock: (void (^)(BOOL success, UIImage * image, NSURL * url)) block {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFImageResponseSerializer serializer]];
    
    [manager GET:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        block(YES,responseObject,url);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        block(NO,nil,nil);
    }];
}


@end
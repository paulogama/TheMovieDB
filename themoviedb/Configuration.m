//
//  Configuration.m
//  themoviedb
//
//  Created by user116657 on 3/18/16.
//  Copyright © 2016 gama. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Configuration.h"

@interface Configuration()

- (void)populateFromAttributes:(NSDictionary *)attributes;

@end

@implementation Configuration

/*+ (instancetype)configurationWithAttributes:(NSDictionary *)attributes {
    return [[self alloc] initWithAttributes:attributes];
}*/

/*- (Configuration *)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        _secureBaseURL = nil;
        _posterSizes = nil;
    }
    return self;
}*/

-(instancetype)init {
    self = [super init];
    if (self) {
        _secureBaseURL = nil;
        _posterSizes = nil;
    }
    return self;
}

- (void)getConfigurationsExecutingBlock:( void (^) (BOOL success) ) block {
    
    [[APIClient sharedInstance] requestConfigurationExecutingBlock:^(BOOL success, NSDictionary *entries) {
        if (success) {
            _images = (entries[@"images"]) ?: nil;
            _changeKeys = (entries[@"change_keys"]) ?: nil;
            if(_images) {
                _baseURL = (_images[@"base_url"]) ?: nil;
                _secureBaseURL = (_images[@"secure_base_url"]) ?: nil;
                _backDropSizes = (_images[@"backdrop_sizes"]) ?: nil;
                _logoSizes = (_images[@"logo_sizes"]) ?: nil;
                _posterSizes = (_images[@"poster_sizes"]) ?: nil;
                _profileSizes = (_images[@"profile_sizes"]) ?: nil;
                _stillSizes = (_images[@"still_sizes"]) ?: nil;
            }
            block(YES);
        } else {
            NSLog(@"Error while getting configurations.");
            block(NO);
        }
    }];
}
/*
- (void)populateFromAttributes:(NSDictionary *)attributes {
    self.images = (NSDictionary *)attributes[@"images"];
    self.changeKeys = (NSDictionary *)attributes[@"change_keys"];
}*/

@end
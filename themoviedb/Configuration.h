//
//  Configuration.h
//  themoviedb
//
//  Created by user116657 on 3/18/16.
//  Copyright © 2016 gama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIClient.h"
#import "Movie.h"

#ifndef Configuration_h
#define Configuration_h

@interface Configuration : NSObject

@property (nonatomic, strong) NSDictionary *images;
@property (nonatomic, strong) NSDictionary *changeKeys;

@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, strong) NSString *secureBaseURL;
@property (nonatomic, strong) NSArray *backDropSizes;
@property (nonatomic, strong) NSArray *logoSizes;
@property (nonatomic, strong) NSArray *posterSizes;
@property (nonatomic, strong) NSArray *profileSizes;
@property (nonatomic, strong) NSArray *stillSizes;

/*+ (instancetype)configurationWithAttributes:(NSDictionary *)attributes;
- (Configuration *)initWithAttributes:(NSDictionary *)attributes;*/

- (void)getConfigurationsExecutingBlock:(void (^) (BOOL success)) block;

@end

#endif /* Configuration_h */

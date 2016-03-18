//
//  Movie.m
//  themoviedb
//
//  Created by user116657 on 3/18/16.
//  Copyright © 2016 gama. All rights reserved.
//

#import "Movie.h"

@interface Movie()

- (void)populateFromAttributes:(NSDictionary *)attributes;

@end

@implementation Movie : NSObject 

+ (instancetype)movieWithAttributes:(NSDictionary *)attributes {
    return [[self alloc] initWithAttributes:attributes];
}

- (Movie *)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        [self populateFromAttributes:attributes];
    }
    return self;
}

- (void)populateFromAttributes:(NSDictionary *)attributes {
    self.id = (int)attributes[@"id"];
}

@end
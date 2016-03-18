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

+ (instancetype)configurationWithAttributes:(NSDictionary *)attributes {
    return [[self alloc] initWithAttributes:attributes];
}

- (Configuration *)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        [self populateFromAttributes:attributes];
    }
    return self;
}

- (void)populateFromAttributes:(NSDictionary *)attributes {
    self.images = (NSDictionary *)attributes[@"images"];
    self.changeKeys = (NSDictionary *)attributes[@"change_keys"];
}

@end
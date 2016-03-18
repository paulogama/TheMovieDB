//
//  Configuration.h
//  themoviedb
//
//  Created by user116657 on 3/18/16.
//  Copyright © 2016 gama. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef Configuration_h
#define Configuration_h

@interface Configuration : NSObject

@property (nonatomic, strong) NSDictionary *images;
@property (nonatomic, strong) NSDictionary *changeKeys;

+ (instancetype)configurationWithAttributes:(NSDictionary *)attributes;
- (Configuration *)initWithAttributes:(NSDictionary *)attributes;

@end

#endif /* Configuration_h */

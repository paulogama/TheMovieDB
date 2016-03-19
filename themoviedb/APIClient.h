//
//  APIClient.h
//  themoviedb
//
//  Created by user116657 on 3/18/16.
//  Copyright © 2016 gama. All rights reserved.
//

#ifndef APIClient_h
#define APIClient_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Configuration.h"

@interface APIClient : NSObject

+ (APIClient *) sharedInstance;
- (void) requestConfigurationExecutingBlock: ( void (^) (BOOL success, NSDictionary * entries) ) block;
- (void) requestMovieListExecutingBlock: ( void (^) (BOOL success, NSArray * entries) ) block;
- (void) loadRemoteImageFromURL: (NSURL *) url andExecuteBlock: (void (^)(BOOL success, UIImage * image, NSURL * url)) block;

@end

#endif /* APIClient_h */

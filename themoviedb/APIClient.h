//
//  APIClient.h
//  themoviedb
//
//  Created by user116657 on 3/18/16.
//  Copyright © 2016 gama. All rights reserved.
//

#ifndef APIClient_h
#define APIClient_h

#import "Constants.h"
#import "AFNetworking.h"

@interface APIClient : AFHTTPSessionManager

- (void) getApiConfigurationWithURL(NSString *);

@end

#endif /* APIClient_h */

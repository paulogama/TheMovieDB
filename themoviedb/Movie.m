//
//  Movie.m
//  themoviedb
//
//  Created by user116657 on 3/18/16.
//  Copyright © 2016 gama. All rights reserved.
//

#import "Movie.h"
#import "APIClient.h"
#import "Configuration.h"

@interface Movie()

@property (nonatomic, strong) Configuration *configuration;
@property (nonatomic, strong) Movie *movie;

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

- (instancetype)init
{
    self = [super init];
    if (self) {
        _configuration = [[Configuration alloc] init];
        _movie = [[Movie alloc] init];
    }
    return self;
}

- (void)requestAllMoviesExecutingBlock:( void (^) (BOOL success, NSArray *array) ) block {
    NSMutableArray *results = [[NSMutableArray alloc] init];

    [_configuration getConfigurationsExecutingBlock:^(BOOL success) {
        if(success) {
            [[APIClient sharedInstance] requestMovieListExecutingBlock:^(BOOL success, NSArray *entries) {
                if(success) {
                    [results addObjectsFromArray:(entries) ?: nil];
                    NSString *urlString = [[NSString alloc] init];
                    
                    for (int i = 0; i < entries.count; i++) {
                        _movie.posterPath = entries[i][@"poster_path"];
                        _movie.adult = entries[i][@"adult"];
                        _movie.overview = entries[i][@"overview"];
                        _movie.releaseDate = entries[i][@"release_date"];
                        _movie.genreIds = entries[i][@"genre_ids"];
                        _movie.id = (int)entries[i][@"id"];
                        _movie.originalTitle = entries[i][@"original_title"];
                        _movie.originalLanguage = entries[i][@"original_language"];
                        _movie.title = entries[i][@"title"];
                        _movie.backdropPath =  entries[i][@"backdrop_path"];
                        _movie.popularity = [entries[i][@"popularity"] floatValue];
                        _movie.voteCount = (int)entries[i][@"vote_count"];
                        _movie.video = entries[i][@"video"];
                        _movie.voteAverage = [entries[i][@"vote_average"] floatValue];
                        
                        urlString = [NSString stringWithFormat:@"%@%@%@",_configuration.secureBaseURL,_configuration.posterSizes[2],_movie.posterPath];
                        
                        [[APIClient sharedInstance] loadRemoteImageFromURL:[NSURL URLWithString:urlString] andExecuteBlock:^(BOOL success, UIImage *image, NSURL *url) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                if (success) {
                                    _movie.posterImage = image;
                                    [results addObject:_movie];
                                } else {
                                    [results addObject:_movie];
                                    NSLog(@"Error loading image from URL");
                                }
                            });
                        }];
                    }
                    block(YES,results);
                } else {
                    block(NO,nil);
                }
            }];
        }
    }];
}

@end
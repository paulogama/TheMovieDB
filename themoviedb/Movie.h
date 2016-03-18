//
//  Movie.h
//  themoviedb
//
//  Created by user116657 on 3/18/16.
//  Copyright © 2016 gama. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef Movie_h
#define Movie_h

@interface Movie : NSObject

@property (nonatomic) int id;
@property (nonatomic, strong) NSString *originalTitle;
@property (nonatomic, strong) NSString *originalLanguage;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *backdropPath;
@property (nonatomic) float popularity;
@property (nonatomic, strong) NSString *voteCount;
@property (nonatomic) BOOL video;
@property (nonatomic) float voteAverage;
@property (nonatomic, strong) NSString *posterPath;
@property (nonatomic, getter=isAdult) BOOL adult;
@property (nonatomic, strong) NSString *overview;
@property (nonatomic, strong) NSDate *releaseDate;
@property (nonatomic, strong) NSArray *genreIds;

+ (instancetype)movieWithAttributes:(NSDictionary *)attributes;
- (Movie *)initWithAttributes:(NSDictionary *)attributes;

@end

#endif /* Movie_h */

//
//  MovieCollectionViewCell.m
//  themoviedb
//
//  Created by user116657 on 3/18/16.
//  Copyright © 2016 gama. All rights reserved.
//

#import "MovieCollectionViewCell.h"

@interface MovieCollectionViewCell()

@end

@implementation MovieCollectionViewCell

-(void) setImage:(UIImage *)image{
    
    if(_image != image) {
        _image = image;
    }
    
    self.imageView.image = _image;
    
}

@end

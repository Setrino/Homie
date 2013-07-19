//
//  Room.h
//  Homie
//
//  Created by Sergei Kostevitch on 7/19/13.
//  Copyright (c) 2013 Prestigio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Room : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) UIImage *image;
@property (nonatomic, strong) NSArray *devices;

@end

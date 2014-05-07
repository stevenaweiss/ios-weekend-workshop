//
//  MediaObject.m
//  WorkshopApp-noxib
//
//  Created by Alfred Hanssen on 11/13/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import "MediaObject.h"

@implementation MediaObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        // Extract the data we require,
        // Checking for presence and validity of the data along the way,
        // Falling back on default values if something's amiss
        
        self.username = [self parseUsername:dictionary];
        self.imageURL = [self parseImageURL:dictionary];
    
    }
    return self;
}

- (NSString *)parseUsername:(NSDictionary *)dictionary
{
    NSString * username = [dictionary valueForKeyPath:@"user.username"];;
    
    return username;
}

- (NSURL *)parseImageURL:(NSDictionary *)dictionary
{
    NSString *URLString = [dictionary valueForKeyPath:@"images.standard_resolution.url"];
    
    return [NSURL URLWithString:URLString];
}

@end

//
//  MediaObject.m
//  WorkshopApp-noxib
//
//  Created by Alfred Hanssen on 11/13/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import "MediaObject.h"

@implementation MediaObject

- (id)initWithDictionary:(NSDictionary *)dictionary
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
    NSString * username = @"-";
    
    NSDictionary *userDictionary = [dictionary valueForKey:@"user"];
    if ([self isValidElement:userDictionary])
    {
        NSString * tempUsername = [userDictionary valueForKey:@"username"];
        if ([self isValidElement:tempUsername])
        {
            username = tempUsername;
        }
    }
    
    return username;
}

- (NSURL *)parseImageURL:(NSDictionary *)dictionary
{
    NSString *URLString = @"";
    
    NSDictionary *images = [dictionary valueForKey:@"images"];
    if ([self isValidElement:images])
    {
        NSDictionary * imageDictionary = [images valueForKey:@"standard_resolution"];
        if ([self isValidElement:imageDictionary])
        {
            NSString *tempURLString = [imageDictionary valueForKey:@"url"];
            if ([self isValidElement:tempURLString])
            {
                URLString = tempURLString;
            }
        }
    }
    
    return [NSURL URLWithString:URLString];
}

- (BOOL)isValidElement:(id)element
{
    // Check that the JSON element exists (is not nil) and is not null
    
    if (element && (NSNull *)element != [NSNull null])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end

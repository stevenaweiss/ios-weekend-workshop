//
//  MediaObject.m
//  WorkshopApp-noxib
//
//  Created by Alfred Hanssen on 11/13/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import "MediaObject.h"
#import "MediaManager.h"

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
        self.caption = [self parseCaption:dictionary];
        self.imageURL = [self parseImageURL:dictionary];
    
    }
    return self;
}

- (NSString *)parseUsername:(NSDictionary *)dictionary
{
    NSString * username = @"-";
    
    NSDictionary *userDictionary = [dictionary valueForKey:@"user"];
    if ([MediaManager isValidElement:userDictionary])
    {
        NSString * tempUsername = [userDictionary valueForKey:@"username"];
        if ([MediaManager isValidElement:tempUsername])
        {
            username = tempUsername;
        }
    }
    
    return username;
}

- (NSString *)parseCaption:(NSDictionary *)dictionary
{
    NSString * caption = @"-";
    
    NSDictionary *captionDictionary = [dictionary valueForKey:@"caption"];
    if ([MediaManager isValidElement:captionDictionary])
    {
        NSString * tempCaption = [captionDictionary valueForKey:@"text"];
        if ([MediaManager isValidElement:tempCaption])
        {
            caption = tempCaption;
        }
    }
    
    return caption;
}

- (NSURL *)parseImageURL:(NSDictionary *)dictionary
{
    NSString *URLString = @"";
    
    NSDictionary *images = [dictionary valueForKey:@"images"];
    if ([MediaManager isValidElement:images])
    {
        NSDictionary * imageDictionary = [images valueForKey:@"standard_resolution"];
        if ([MediaManager isValidElement:imageDictionary])
        {
            NSString *tempURLString = [imageDictionary valueForKey:@"url"];
            if ([MediaManager isValidElement:tempURLString])
            {
                URLString = tempURLString;
            }
        }
    }
    
    return [NSURL URLWithString:URLString];
}

@end

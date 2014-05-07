//
//  MediaManager.m
//  WorkshopApp-noxib
//
//  Created by Alfred Hanssen on 11/11/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import "MediaManager.h"
#import "MediaObject.h"

// The Instagram "popular media" endpoint we're hitting is documented here:
// http://instagram.com/developer/endpoints/media/#get_media_popular

@implementation MediaManager

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _mediaObjects = [NSArray array];
    }
    return self;
}

#pragma mark - Networking

- (void)fetchPopularMediaWithCompletionBlock:(void (^)(BOOL success))completionBlock
{
    // Use an NSURLSessionDataTask to download the popular media JSON

    NSString *clientID = @"5609d2fb2bf74d749716bd00a9090e5e"; // FILL THIS IN
    NSString *instagramEndpoint = [NSString stringWithFormat:@"https://api.instagram.com/v1/media/popular?client_id=%@", clientID];
    NSURL *URL = [NSURL URLWithString:instagramEndpoint];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        NSError *JSONParseError = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&JSONParseError];

        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (error || JSONParseError || httpResponse.statusCode != 200 || dictionary == nil)
        {
            completionBlock(NO);
        }
        else
        {
            self.mediaObjects = [self mediaObjectsFromResponse:dictionary];
            self.mediaObjects = [self sortMediaObjects];
            completionBlock(YES);
        }
    }];
    [task resume];
}

#pragma mark - Utilities

// Convert dictionaries into instances of the MediaObject class

- (NSArray *)mediaObjectsFromResponse:(NSDictionary *)response
{
    NSMutableArray * mediaObjects = [NSMutableArray array];
    
    NSArray *data = response[@"data"];
    for (NSDictionary *dictionary in data)
    {
        MediaObject *mediaObject = [[MediaObject alloc] initWithDictionary:dictionary];
        [mediaObjects addObject:mediaObject];
    }
    
    return mediaObjects;
}

// Sort mediaObjects alphabetically by username

- (NSArray *)sortMediaObjects
{
    NSSortDescriptor * descriptor = [[NSSortDescriptor alloc] initWithKey:@"username" ascending:YES];
    NSArray * descriptors = @[descriptor];
    NSArray * sortedArray = [self.mediaObjects sortedArrayUsingDescriptors:descriptors];
    
    return sortedArray;
}

@end

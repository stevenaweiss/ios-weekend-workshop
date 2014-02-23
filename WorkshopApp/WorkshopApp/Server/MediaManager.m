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

- (id)init
{
    self = [super init];
    if (self)
    {
        self.mediaObjects = [NSArray array];
    }
    return self;
}

#pragma mark - Networking

- (void)fetchPopularMediaWithCompletionBlock:(void (^)(BOOL success))completionBlock
{
    // Use an NSURLSessionDataTask to download the popular media JSON
    
    __weak MediaManager * weakSelf = self;
    
    NSString *instagramEndpoint = @"https://api.instagram.com/v1/media/popular?client_id=5609d2fb2bf74d749716bd00a9090e5e";
    NSURL *URL = [NSURL URLWithString:instagramEndpoint];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        // Check for a valid HTTP response status code
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode == 200)
        {
            // Then parse the data object into JSON
            
            NSError *JSONParseError = nil;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:&JSONParseError];
            if (JSONParseError)
            {
                completionBlock(NO);
            }
            else
            {
                // And convert the JSON into a sorted array of MediaObjects
                
                weakSelf.mediaObjects = [weakSelf mediaObjectsFromResponse:dictionary];
                weakSelf.mediaObjects = [weakSelf sortMediaObjects];
                completionBlock(YES);
            }
            
        }
        else
        {
            completionBlock(NO);
        }
        
    }];
    [task resume];
}

#pragma mark - Utilities

- (NSArray *)mediaObjectsFromResponse:(NSDictionary *)response
{
    // Convert dictionaries into instances of the MediaObject class

    NSMutableArray * mediaObjects = [NSMutableArray array];
    
    NSArray *data = [response valueForKey:@"data"];
    for (NSDictionary *mediaDictionary in data)
    {
        MediaObject *mediaObject = [[MediaObject alloc] initWithDictionary:mediaDictionary];
        [mediaObjects addObject:mediaObject];
    }
    
    return mediaObjects;
}

- (NSArray *)sortMediaObjects
{
    // Sort mediaObjects alphabetically by username
    
    NSSortDescriptor * descriptor = [[NSSortDescriptor alloc] initWithKey:@"username" ascending:YES];
    NSArray * descriptors = @[descriptor];
    NSArray * sortedArray = [self.mediaObjects sortedArrayUsingDescriptors:descriptors];
    
    return sortedArray;
}

@end

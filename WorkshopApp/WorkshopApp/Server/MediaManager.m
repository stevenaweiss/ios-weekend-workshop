//
//  MediaManager.m
//  WorkshopApp-noxib
//
//  Created by Alfred Hanssen on 11/11/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import "MediaManager.h"
#import "NSError+Extensions.h"
#import "MediaObject.h"

#define INSTAGRAM_URL [NSURL URLWithString:@"https://api.instagram.com/v1/media/popular?client_id=5609d2fb2bf74d749716bd00a9090e5e"]

// The Instagram "popular media" endpoint we're hitting is documented here:
// http://instagram.com/developer/endpoints/media/#get_media_popular

@implementation MediaManager

#pragma mark - Networking

- (void)fetchPopularMediaWithCompletionBlock:(void (^)(NSArray *media, NSError *error))completionBlock
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        [self postiOS7PopularMediaWithCompletionBlock:completionBlock];
    } else {
        [self preiOS7PopularMediaWithCompletionBlock:completionBlock];
    }
}

- (void)preiOS7PopularMediaWithCompletionBlock:(void (^)(NSArray *media, NSError *error))completionBlock
{
    __weak MediaManager *weakSelf = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:INSTAGRAM_URL];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        [weakSelf handleData:data response:response error:error completionBlock:completionBlock];
    }];
}

- (void)postiOS7PopularMediaWithCompletionBlock:(void (^)(NSArray *media, NSError *error))completionBlock
{
    __weak MediaManager * weakSelf = self;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:INSTAGRAM_URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        [weakSelf handleData:data response:response error:error completionBlock:completionBlock];
    }];
    [task resume];
}

- (void)handleData:(NSData *)data
          response:(NSURLResponse *)response
             error:(NSError *)error
   completionBlock:(void (^)(NSArray *media, NSError *error))completionBlock
{
    // Check for errors related to the request and response
    // Call the requisite delegate methods
    
    if (error) {
        completionBlock(nil, error);
    } else {
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:&error];
        if (error){
            completionBlock(nil, error);
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200) {
                NSArray *media = [self mediaFromResponse:dictionary];
                completionBlock(media, nil);
            } else {
                error = [NSError errorFromResponse:dictionary];
                completionBlock(nil, error);
            }
        }
    }
}

- (void)downloadImage:(NSURL *)imageURL withCompletionBlock:(void (^)(NSURL *location, NSError *error))completionBlock
{
    // Use an NSURLSessionDownloadTask to asynchronously fetch the image
    // TODO: provide a pre-iOS7 alternative
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *getImageTask = [session downloadTaskWithURL:imageURL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (error) {
            completionBlock(nil, error);
        } else if (location) {
            completionBlock(location, nil);
        }
    }];
    [getImageTask resume];
}

#pragma mark - Utilities

- (NSArray *)mediaFromResponse:(NSDictionary *)response
{
    NSMutableArray * mediaObjects = [NSMutableArray array];
    
    // Convert dictionaries into instances of the MediaObject class
    
    NSArray *data = [response valueForKey:@"data"];
    if (data && (NSNull *)data != [NSNull null]) {
        for (NSDictionary *mediaDictionary in data) {
            MediaObject *mediaObject = [[MediaObject alloc] initWithDictionary:mediaDictionary];
            [mediaObjects addObject:mediaObject];
        }
    }
    
    // Sort mediaObjects alphabetically by username
    
    NSSortDescriptor * descriptor = [[NSSortDescriptor alloc] initWithKey:@"username" ascending:YES];
    NSArray * descriptors = @[descriptor];
    NSArray * sortedArray = [mediaObjects sortedArrayUsingDescriptors:descriptors];

    return sortedArray;
}

@end

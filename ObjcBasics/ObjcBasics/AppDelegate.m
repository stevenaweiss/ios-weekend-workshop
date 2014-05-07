//
//  AppDelegate.m
//  ObjcBasics
//
//  Created by Alfred Hanssen on 11/17/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import "AppDelegate.h"
#import "Cat.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    
    [self runExamples];
    
    // Do this to void warning about applications expected to have rootViewController at launch
    UIViewController *viewController = [[UIViewController alloc] init];
    [self.window setRootViewController:viewController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - Examples

- (void)runExamples
{
    [self variablesExample];
    
    [self conditionalExample];
    
    [self loopExample];
    
    [self dictionaryExample];
    
    [self classExample];    
}

- (void)variablesExample // Datatypes, variables, logging
{
    NSString *name = @"Alfie";
    int age = 34;
    float height = 6 + 4.0f/12;
    
    NSLog(@"My name is %@. I am %i years old. I am %.2f feet tall.", name, age, height);
}

- (void)conditionalExample // Conditionals, sending messages
{
    NSString *name = @"Alfie";
    BOOL hasPrettyLongName = NO;
    
    if ([name length] > 10)
    {
        hasPrettyLongName = YES;
    }
    
    NSLog(@"Is my name pretty long? %i (%lu characters)", hasPrettyLongName, (unsigned long)[name length]);
}

- (void)loopExample // For loops, arrays
{
    NSArray *numbers = @[@10, @20, @25, @100];
    
    float sum = 0.0f;
    
    for (int i = 0; i < [numbers count]; i++)
    {
        NSNumber *number = numbers[i];
        sum = sum + [number intValue];
    }
    
    float average = sum / [numbers count]; // Should be 38.75
    
    NSLog(@"average = %.2f", average);
}

- (void)dictionaryExample // Dictionaries
{
    NSDictionary *myInfo = @{@"name" : @"Alfie",
                             @"age" : @34,
                             @"height" : @6.33};
    
    NSArray *keys = [myInfo allKeys];
    NSLog(@"keys: %@", keys);
    
    NSArray *values = [myInfo allValues];
    NSLog(@"values: %@", values);

    NSLog(@"Name: %@", myInfo[@"name"]);
    NSLog(@"Age: %i", [myInfo[@"age"] intValue]);
    NSLog(@"Height: %.2f", [myInfo[@"height"] floatValue]);
}

- (void)classExample // Classes, instances, properties
{
    Cat *scrumptious = [[Cat alloc] initWithName:@"Scrumptious"];
    Cat *meatball = [[Cat alloc] initWithName:@"Meatball"];
    
    [scrumptious makeSomeNoise];
    [meatball makeSomeNoise];
    
    NSLog(@"Cat names: %@ and %@", scrumptious.name, meatball.name);

    scrumptious.name = @"Fluffy";
    meatball.name = @"Dustmop";
    
    NSLog(@"Cat names: %@ and %@", scrumptious.name, meatball.name);
}

@end

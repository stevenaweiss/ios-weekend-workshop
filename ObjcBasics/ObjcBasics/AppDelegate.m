//
//  AppDelegate.m
//  ObjcBasics
//
//  Created by Alfred Hanssen on 11/17/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import "AppDelegate.h"
#import "Tree.h"

@interface AppDelegate () <TreeDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    
    [self runExamples];
    
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
    
    [self blockExample];
    
    [self delegateExample];
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
    
    if ([name length] > 10) {
        hasPrettyLongName = YES;
    } else {
        hasPrettyLongName = NO;
    }
    
    NSLog(@"Is my name pretty long? %i (%i characters)", hasPrettyLongName, [name length]);
}

- (void)loopExample // For loops, arrays
{
    NSArray *numbers = @[@10, @20, @25, @100];
    
    float sum = 0.0f;
    
    for (int i = 0; i < [numbers count]; i++) {
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

    NSLog(@"Name: %@", [myInfo valueForKey:@"name"]);
    NSLog(@"Age: %i", [[myInfo valueForKey:@"age"] intValue]);
    NSLog(@"Height: %.2f", [[myInfo valueForKey:@"height"] floatValue]);
}

- (void)classExample // Classes, instances, properties
{
    Tree *dogwoodTree = [[Tree alloc] initWithSpecies:@"Dogwood" age:35];
    Tree *japaneseMapleTree = [[Tree alloc] initWithSpecies:@"Japanese Maple" age:41];
    
    [dogwoodTree printDescription];
    [japaneseMapleTree printDescription];
    NSLog(@"Species: %@, Age: %i", dogwoodTree.species, dogwoodTree.age);
    
    dogwoodTree.species = @"Catwood Tree";
    dogwoodTree.age = 48;
    [dogwoodTree printDescription];
    
    [dogwoodTree setSpecies:@"Hamsterwood Tree"];
    [dogwoodTree setAge:48];
    [dogwoodTree printDescription];
}

- (void)blockExample // Blocks
{
    Tree *redwoodTree = [[Tree alloc] initWithSpecies:@"Redwood" age:50];

    [redwoodTree descriptionWithBlock:^(NSString *description) {
        NSLog(@"%@", description);
    }];
}

- (void)delegateExample // Protocols and delegates
{
    Tree *pineTree = [[Tree alloc] initWithSpecies:@"Pine" age:5];
    pineTree.delegate = self;
    [pineTree doSomething];
}

#pragma mark - Tree Delegate

- (void)tree:(Tree *)tree description:(NSString *)description
{
    NSLog(@"%@", description);
}

@end

//
//  PopularMediaViewController.m
//  WorkshopApp-noxib
//
//  Created by Alfred Hanssen on 11/11/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import "PopularMediaViewController.h"
#import "ImageViewController.h"
#import "MediaManager.h"
#import "MediaObject.h"

@interface PopularMediaViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MediaManager *mediaManager;

@end

@implementation PopularMediaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    
    self.title = @"Media";
    
    self.mediaManager = [[MediaManager alloc] init];

    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(didTapRefresh:)];
    self.navigationItem.rightBarButtonItem = refreshButton;
    
    [self updateContent];
}

#pragma mark - Content 

- (void)updateContent
{
    __weak PopularMediaViewController *weakSelf = self;
    [self.mediaManager fetchPopularMediaWithCompletionBlock:^(BOOL success) {

        dispatch_sync(dispatch_get_main_queue(), ^{

            [weakSelf enableRefreshButton:YES];

            if (success) {
                [weakSelf.tableView reloadData];
            
            } else {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Uh Oh!"
                                                                 message:@"An error occurred"
                                                                delegate:nil
                                                       cancelButtonTitle:@"Okay"
                                                       otherButtonTitles:nil];
                [alert show];
            }
        });

    }];
}

#pragma mark - Button Actions

- (void)didTapRefresh:(UIBarButtonItem *)sender
{
    [self enableRefreshButton:NO];
    [self updateContent];
}

- (void)enableRefreshButton:(BOOL)shouldEnable
{
    self.navigationItem.rightBarButtonItem.enabled = shouldEnable;
}

#pragma mark - UITableView Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    MediaObject *mediaObject = [self.mediaManager.mediaObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = mediaObject.username;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.mediaManager.mediaObjects count];
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ImageViewController *viewController = [[ImageViewController alloc] initWithNibName:@"ImageViewController" bundle:Nil];
    viewController.mediaObject = [self.mediaManager.mediaObjects objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end

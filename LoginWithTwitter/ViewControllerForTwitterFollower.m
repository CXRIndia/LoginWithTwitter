//
//  ViewControllerForTwitterFollower.m
//  LoginWithTwitter
//
//  Created by Gaurav Taywade on 26/04/13.
//  Copyright (c) 2013 Gaurav taywade. All rights reserved.
//

#import "ViewControllerForTwitterFollower.h"

@interface ViewControllerForTwitterFollower ()

@end

@implementation ViewControllerForTwitterFollower
@synthesize TwitterArray;
@synthesize TwitterFollowerListTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Friend_type:(NSString*)type
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        FriendType=type;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setHidden:YES];

    if ([FriendType isEqualToString:@"Followers"])
    {
        [self gettwitterFollwers];
    }
    else if ([FriendType isEqualToString:@"Friends"])
    {
        [self gettwitterFriends];
    }

}

#pragma mark - button pressed

- (IBAction)fnForBackButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - twitter info

- (void) gettwitterFollwers
{
    // Request access to the Twitter accounts
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error){
        if (granted) {
            
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            
            // Check if the users has setup at least one Twitter account
            
            if (accounts.count > 0)
            {
                ACAccount *twitterAccount = [accounts objectAtIndex:0];
                
                // Creating a request to get the info about a user on Twitter
                // Pass exact username in parameter that we got at the time of login.
                
                NSDictionary *params = @{@"cursor" : @"-1",
                @"screen_name" : @"oabstudios",
                @"skip_status" : @"true",
                @"include_user_entities" : @"false"};

                SLRequest *twitterInfoRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/followers/list.json"] parameters:params];
                [twitterInfoRequest setAccount:twitterAccount];
                
                // Making the request
                
                [twitterInfoRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        
                        if ([urlResponse statusCode] == 429) {
                            return;
                        }
                        
                        
                        if (error) {
                            return;
                        }
                        
                        // Check if there is some response data
                        
                        if (responseData) {
                            
                            TwitterArray=nil;
                            NSError *error = nil;
                            TwitterArray = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                            
                            NSLog(@"==================>Follower array%@",TwitterArray);
                            
                            
                        }
                    });
                }];
            }
        } else {
            NSLog(@"Access denied");
        }
    }];
}

- (void) gettwitterFriends
{
    // Request access to the Twitter accounts
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error){
        if (granted) {
            
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            
            // Check if the users has setup at least one Twitter account
            
            if (accounts.count > 0)
            {
                ACAccount *twitterAccount = [accounts objectAtIndex:0];
                
                // Creating a request to get the info about a user on Twitter
                // Pass exact username in parameter that we got at the time of login.
                
                NSDictionary *params = @{@"cursor" : @"-1",
                @"screen_name" : @"oabstudios",
                @"skip_status" : @"true",
                @"include_user_entities" : @"false"};

                SLRequest *twitterInfoRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/friends/list.json"] parameters:params];
                [twitterInfoRequest setAccount:twitterAccount];
                
                // Making the request
                
                [twitterInfoRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        
                        if ([urlResponse statusCode] == 429) {
                            return;
                        }
                        
                        
                        if (error) {
                            return;
                        }
                        
                        // Check if there is some response data
                        
                        if (responseData)
                        {
                            
                            NSError *error = nil;
                            TwitterArray=nil;
                            TwitterArray= [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                            
                           NSLog(@"++++++++++++++++++++++++>FriendsArray%@",TwitterArray);
                            [TwitterFollowerListTableView reloadData];
                            
                            
                        }
                    });
                }];
            }
        } else {
            NSLog(@"Access denied");
        }
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [TwitterArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...

    cell.textLabel.text = [[(NSDictionary *)TwitterArray objectForKey:@"name"] objectAtIndex:indexPath.row];
    [cell.textLabel setFont:[UIFont fontWithName:@"Arial" size:16.0f]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // For Inviting friends
    // Navigation logic may go here. Create and push another view controller.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
//
//  ViewControllerForTwitterLogin.m
//  LoginWithTwitter
//
//  Created by Gaurav Taywade on 26/04/13.
//  Copyright (c) 2013 Gaurav taywade. All rights reserved.
//

#import "ViewControllerForTwitterLogin.h"
#import "ViewControllerForHomeScreen.h"

@interface ViewControllerForTwitterLogin ()

@end

@implementation ViewControllerForTwitterLogin

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setHidden:YES];

}

- (IBAction)fnForTwitterButtonPressed:(id)sender
{
    ViewControllerForHomeScreen *ViewControllerForHomeScreen_obj=[[ViewControllerForHomeScreen alloc]initWithNibName:@"ViewControllerForHomeScreen" bundle:nil];
    [self.navigationController pushViewController:ViewControllerForHomeScreen_obj animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

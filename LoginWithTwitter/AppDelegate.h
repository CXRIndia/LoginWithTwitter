//
//  AppDelegate.h
//  LoginWithTwitter
//
//  Created by Gaurav Taywade on 26/04/13.
//  Copyright (c) 2013 Gaurav taywade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerForTwitterLogin.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    ViewControllerForTwitterLogin *ViewControllerForTwitterLogin_obj;

}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;

@end

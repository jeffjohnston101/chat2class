

//
//  LoginController.h
//  Class2Chat
//
//  Created by John Schrantz on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//********************************************************************************************
// Class Implementation File
// Manages the entry into the C2C app and determines if the user has an account or needs to create
// one and sends them to the appropriate view as a result
//
//********************************************************************************************



#import "AppEntryController.h"
#import "Repository.h"

@implementation AppEntryController


//********************************************************************************************
//METHOD
//Default view controller method
//Checks NSUserDefaults for existing login (email, password and userId).  If they exist, the 
//user has a C2C account and segues to Messages is called.  If not, they segue to the view to
//create an account.
//********************************************************************************************

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    sleep(3);
    
    //********************************************************************************************
    //The following line is for development and will reset all defaults to the registration domain
    //It's like 'removeObjectForKey' for every key ever registered
    //NOTE:  Comment this out to bypass the 'New User Creation' screen once an account is created
    //********************************************************************************************
    //[[NSUserDefaults standardUserDefaults] setPersistentDomain:[NSDictionary dictionary] forName:[[NSBundle mainBundle] bundleIdentifier]];
    
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    NSString* email = [defaults objectForKey:@"email"];
    NSString* password = [defaults objectForKey:@"password"];
    NSNumber* userId = [defaults objectForKey:@"userId"];
    
    if (email != nil && password != nil && userId != nil) {
        Repository* repository = [Repository getRepository];
        [repository setLoginEmail:email andPassword:password];
        
        NSError* error = nil;
        
        [repository setCurrentUser:[repository getUserWithId:userId error:&error]];
        
        [self performSegueWithIdentifier:@"EntryToFeed" sender:nil];
    }
    else {
        [self performSegueWithIdentifier:@"EntryToCreateUser" sender:nil];
    }
    
    
}

@end
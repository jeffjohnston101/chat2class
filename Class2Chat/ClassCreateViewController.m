//
//  ClassCreateViewController.m
//  Class2Chat
//
//  Created by John Schrantz on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//




//********************************************************************************************
// Class Implementation File
// Displays the view controller that captures information about a new class being created  
// by the user.
//
//********************************************************************************************

#import "ClassCreateViewController.h"
#import "Repository.h"

@implementation ClassCreateViewController

@synthesize className;
@synthesize accessCode;
@synthesize accessCodeConfirm;



//********************************************************************************************
// METHOD
// Captures input from the user, checks to make sure it's legit and correct.  Then creates a
// class id associated with the class name and access code and places it into the repository
// 
//********************************************************************************************

- (IBAction)createClass:(id)sender
{
    NSString* classNameText = [self.className text];
    NSString* accessCodeText = [self.accessCode text];
    NSString* accessCodeConfirmText = [self.accessCodeConfirm text];
    
    if ([classNameText length] && [accessCodeText length] && [accessCodeConfirmText length]) {
        if ([accessCodeText isEqualToString:accessCodeConfirmText]) {
            Repository* repository = [Repository getRepository];
            NSError* error = nil;
            
            //Create a classId associated with the user input for class name and access code
            NSNumber* classId = [repository createClass:classNameText withAccessCode:accessCodeText error:&error];
            
            if (classId != nil) {
                
                // Pop the view
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else {
                // Failure on user 
                UIAlertView* message = [[UIAlertView alloc] initWithTitle:@"Server Error"
                                                                  message:@"There was a server side error."
                                                                 delegate:nil 
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles:nil];
                [message show];
            }
        }
        else {
            // Passwords don't match
            UIAlertView* message = [[UIAlertView alloc] initWithTitle:@"Passwords Don't Match"
                                                              message:@"Password and Confirm must match."
                                                             delegate:nil 
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];            
        }
    }
    else {
        // Need to fill out all the values
        UIAlertView* message = [[UIAlertView alloc] initWithTitle:@"Missing Values"
                                                          message:@"Please fill in all fields before attempting to create the new user."
                                                         delegate:nil 
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    }
}


@end

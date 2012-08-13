//
//  CreateUserViewController.h
//  Class2Chat
//
//  Created by John Schrantz on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



//********************************************************************************************
//Class Header File
//The header file for the view controller that's designed for creating a new user.  
//
//Consists of an interface for the CreateUserViewController which is a sub-class of UIViewContorller
//********************************************************************************************





#import <UIKit/UIKit.h>

@interface CreateUserViewController : UIViewController 
    

@property (nonatomic, weak) IBOutlet UITextField* firstName;            //User first name
@property (nonatomic, weak) IBOutlet UITextField* lastName;             //User last name
@property (nonatomic, weak) IBOutlet UITextField* email;                //User email
@property (nonatomic, weak) IBOutlet UITextField* password;             //User password
@property (nonatomic, weak) IBOutlet UITextField* passwordConfirm;      //User confirmation field for password



- (IBAction)createUser:(id)sender;

- (void)keyboardWillHide:(NSNotification *)notification;  
- (void)keyboardWillShow:(NSNotification *)notification;


@end

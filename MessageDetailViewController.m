//
//  MessageDetailViewController.m
//  Class2Chat
//
//  Created by Jeffrey Johnston on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


//********************************************************************************************
// Class Implementation File
// Displays the view controller for the detailed view of the message text sent by a user
//********************************************************************************************

#import "MessageDetailViewController.h"
#import "MessageCreateViewController.h"
#import "C2CMessage.h"
#import "C2CClass.h"
#import "Repository.h"
#import "C2CUser.h"

@implementation MessageDetailViewController

@synthesize message = _message;
@synthesize messageHeader;
@synthesize messageText;
@synthesize className;
@synthesize userName;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    //Setting up message header text view
    [messageHeader.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [messageHeader.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [messageHeader.layer setBorderWidth: 1.5];
    [messageHeader.layer setCornerRadius:8.0f];
    [messageHeader.layer setMasksToBounds:YES];
    
    //Setting up message body text view
    [messageText.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [messageText.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [messageText.layer setBorderWidth: 1.5];
    [messageText.layer setCornerRadius:8.0f];
    [messageText.layer setMasksToBounds:YES];
    

    
}

//This is a default method overloaded to get a repository and detail information
//about the class and owner of the message.  In doing so, we are able to get the
//user's first name and last name for display.  We also set the text of the user 
//name, class name and message here.

- (void)viewWillAppear:(BOOL)animated
{
   
    [super viewWillAppear:animated];
    
    
    Repository *repository = [Repository getRepository];
    NSError* error = nil;
    NSNumber *messageClassId = self.message.classId;
    NSNumber *messageOwnerId = self.message.ownerId;

    C2CUser* selectUser = [repository getUserWithId: messageOwnerId error:&error];
    C2CClass* selectClass = [repository getClassWithId: messageClassId error:&error];
    
    NSString *userFirstName = selectUser.firstName;
    NSString *userLastName = selectUser.lastName;
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", userFirstName, userLastName];
    
    [self.userName setText:fullName];
    [self.className setText:selectClass.name];
    [self.messageText setText:self.message.message]; 
    
}

@end

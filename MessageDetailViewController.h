//
//  MessageDetailViewController.h
//  Class2Chat
//
//  Created by Jeffrey Johnston on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//********************************************************************************************
//Class Header File
//The header file for the view controller that allows users to create a new message for a C2C class 
//
//********************************************************************************************

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class C2CMessage;
@class C2CClass;

@interface MessageDetailViewController : UIViewController  
{
    C2CMessage* _message;                                               //Instance of C2CMessage class

}

@property (nonatomic) C2CMessage* message;


@property (nonatomic, weak) IBOutlet UITextView* messageText;           //Text view for message text
@property (nonatomic, weak) IBOutlet UITextView* messageHeader;         //Text view for message header
@property (nonatomic, weak) IBOutlet UILabel* className;                //Label for class name
@property (nonatomic, weak) IBOutlet UILabel* userName;                 //Label for user name



@end

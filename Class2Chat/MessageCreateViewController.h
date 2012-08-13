//
//  PostViewController.h
//  Class2Chat
//
//  Created by Jeffrey Johnston on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



//********************************************************************************************
//Class Header File
//The header file for the view controller that allows users to create a new message for a C2C class 
//
//********************************************************************************************


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ClassPickerViewController.h"

@class C2CClass;

@interface MessageCreateViewController : UIViewController <ClassPickerHandler>
{   
    C2CClass* _klass;                                                           //An instance of the C2CClass class
}

@property (nonatomic) C2CClass* klass;

@property (nonatomic, weak) IBOutlet UILabel* classLabel;                       //A label for the class name
@property (nonatomic, weak) IBOutlet UITextView* messageTextView;               //A text view for the message text


- (IBAction)createMessage:(id)sender;

- (void)handlePickedClass:(C2CClass *)klass;

@end

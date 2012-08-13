//
//  ClassJoinViewController.h
//  Class2Chat
//
//  Created by Jeffrey Johnston on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


//********************************************************************************************
//Class Header File
//The header file for the view controller that allows users to join an existing class given the 
//correct accesscode and name.
//Class is delegate for ClassPickerHandler
//********************************************************************************************

#import <UIKit/UIKit.h>
#import "ClassPickerViewController.h"

@class C2CClass;

@interface ClassJoinViewController : UIViewController <ClassPickerHandler>
{
    C2CClass* _klass;                           //C2CClass reference
    id<ClassPickerHandler> _delegate;           //ClassPickerHandler class delegate
}

@property (nonatomic) C2CClass* klass;
@property (nonatomic) id<ClassPickerHandler> delegate;
@property (nonatomic, weak) IBOutlet UILabel* className;        //Label for class name
@property (nonatomic, weak) IBOutlet UITextField* accessCode;   //Label for class access code

- (IBAction)joinClass:(id)sender;
- (void)handlePickedClass:(C2CClass*)klass;

@end

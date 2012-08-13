//
//  MyFeedViewController.h
//  Class2Chat
//
//  Created by Jeffrey Johnston on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


//********************************************************************************************
//Class Header File
//The header file for the view controller that displayes a table view for all messages associated
//with the classes that a user is a member of in C2C.  Also support a way to filter the view
//to show only those classes selected by the user
//********************************************************************************************

#import <UIKit/UIKit.h>
#import "ClassPickerViewController.h"


@class C2CClass;

@interface MessagesTableViewController : UITableViewController <ClassPickerHandler>
{
    NSArray* messages;                                          //A array to hold all messages
    C2CClass* classFilter;                                      //A reference of the C2CClass class
    
}



- (void)handlePickedClass:(C2CClass*)klass;

@end

//
//  ClassesViewController.h
//  Class2Chat
//
//  Created by John Schrantz on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


//********************************************************************************************
//Class Header File
//The header file for the view controller that dispalys the classes for which the user is a member 
//
//Consists of an interface for the ClassesTableViewController which is a sub-class of UIViewContorller
//********************************************************************************************

#import <UIKit/UIKit.h>

@interface ClassesTableViewController : UITableViewController
{
    NSArray* classes;       //An array that holds all classes for which the user is a member
}

@end

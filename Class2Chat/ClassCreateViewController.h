//
//  ClassCreateViewController.h
//  Class2Chat
//
//  Created by John Schrantz on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//********************************************************************************************
//Class Header File
//The header file for the view controller that dispalys fields for creating a class
//Consists of an interface for the ClassCreateViewController which is a sub-class of UIViewContorller
//********************************************************************************************



#import <UIKit/UIKit.h>

@interface ClassCreateViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField* className;            //Text field for class name
@property (nonatomic, weak) IBOutlet UITextField* accessCode;           //Text field for class access code
@property (nonatomic, weak) IBOutlet UITextField* accessCodeConfirm;    //Text field for class access code confirmation


- (IBAction)createClass:(id)sender;

@end

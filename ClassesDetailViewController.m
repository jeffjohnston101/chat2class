//
//  ClassesDetailViewController.m
//  Class2Chat
//
//  Created by Jeffrey Johnston on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



//********************************************************************************************
// Class Implementation File
// Displays the detailed information about a class 
//********************************************************************************************


#import "ClassesDetailViewController.h"
#import "C2CClass.h"


@implementation ClassesDetailViewController

@synthesize klass = _klass;
@synthesize className;
@synthesize classId;
@synthesize deleteClass;
@synthesize universityLogo;
@synthesize messageHeader;


//Sets up some graphic design for the containers that show the class detail information
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [messageHeader.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [messageHeader.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [messageHeader.layer setBorderWidth: 1.5];
    [messageHeader.layer setCornerRadius:8.0f];
    [messageHeader.layer setMasksToBounds:YES];
    
    
    [className.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [className.layer setBorderWidth: 1.5];
    [className.layer setCornerRadius:8.0f];
    [className.layer setMasksToBounds:YES];
    
    
    [classId.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [classId.layer setBorderWidth: 1.5];
    [classId.layer setCornerRadius:8.0f];
    [classId.layer setMasksToBounds:YES];
    
    
}

//Sets the text for the class name and class id
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.className setText:self.klass.name];
    [self.classId setText:[[NSString alloc] initWithFormat:@"%@", self.klass.classId]];
    
}

@end

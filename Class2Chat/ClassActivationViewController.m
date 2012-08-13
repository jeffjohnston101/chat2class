//
//  ClassActivationViewController.m
//  Class2Chat
//
//  Created by Jeffrey Johnston on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ClassActivationViewController.h"

@interface ClassActivationViewController ()

@end

@implementation ClassActivationViewController



@synthesize universityLogo;
@synthesize className;
@synthesize submitPasscode;
@synthesize classPasscode;
@synthesize messageHeader;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [classPasscode.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [classPasscode.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [classPasscode.layer setBorderWidth: 1.5];
    [classPasscode.layer setCornerRadius:8.0f];
    [classPasscode.layer setMasksToBounds:YES];
    
    [messageHeader.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [messageHeader.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [messageHeader.layer setBorderWidth: 1.5];
    [messageHeader.layer setCornerRadius:8.0f];
    [messageHeader.layer setMasksToBounds:YES];
    //[messageTextView becomeFirstResponder];
    [classPasscode becomeFirstResponder];

    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

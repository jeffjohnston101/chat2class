//
//  ClassJoinViewController.m
//  Class2Chat
//
//  Created by Jeffrey Johnston on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



//********************************************************************************************
// Class Implementation File
// Displays the view controller that allows users to enter an access code to join an existing  
// class.  This class acts as a delgate for the ClassPickerHandler class that displays a
// picker view that allows users to pick from a list of all current classes on the server
//********************************************************************************************


#import "ClassJoinViewController.h"
#import "Repository.h"
#import "C2CClass.h"

@implementation ClassJoinViewController

@synthesize klass = _klass;
@synthesize delegate = _delegate;
@synthesize className;
@synthesize accessCode;




//********************************************************************************************
// METHOD
// Captures input from the user, checks to make sure it's correct and then adds the appropriate
// class id to the user's list of associated classes
//********************************************************************************************

- (IBAction)joinClass:(id)sender 
{
    NSString* accessCodeText = [self.accessCode text];
    
    if (self.klass != nil && [accessCodeText length]) {
        Repository* repository = [Repository getRepository];
        NSError* error = nil;
        
        [repository joinClass:self.klass.classId withAccessCode:accessCodeText error:&error];
        
        if (error == nil) {
            
            // Pop the view
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else {
            if ([error code] == 200)
            {
                // Failure on user 
                UIAlertView* message = [[UIAlertView alloc] initWithTitle:@"Access Code Error"
                                                                  message:@"You entered the wrong Access Code."
                                                                 delegate:nil 
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles:nil];
                [message show];                
            }
            else {
                // Failure on user 
                UIAlertView* message = [[UIAlertView alloc] initWithTitle:@"Server Error"
                                                                  message:@"There was a server side error."
                                                                 delegate:nil 
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles:nil];
                [message show];
            }
        }
    }
    else {
        // Need to fill out all the values
        UIAlertView* message = [[UIAlertView alloc] initWithTitle:@"Missing Values"
                                                          message:@"Please fill in all fields before attempting to create the new user."
                                                         delegate:nil 
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    }
}


//A method that prepares for the presentation of the ClassPickerViewController 
//which allows the user to choose from all classes on the server and input an
//access code to join.  
- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"JoinClassToClassPicker"]) {
        
        ClassPickerViewController* picker = [segue destinationViewController];
        
        Repository* repository = [Repository getRepository];
        NSError* error = nil;
        
        NSArray* classes = [repository getAllClasses:&error];
        
        [picker setClasses:classes];
        [picker setDelegate:self];
    }
}

//A method that allows the picked class from the picker to be assigned
//to the label className in the view
- (void)handlePickedClass:(C2CClass*)klass
{
    self.klass = klass;
    
    if (self.klass != nil) {
        [self.className setText:[self.klass name]];
    }
    else {
        [self.className setText:@""];
    }
    
    [self.presentedViewController dismissModalViewControllerAnimated:TRUE];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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

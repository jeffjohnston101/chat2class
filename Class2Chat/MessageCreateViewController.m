//
//  PostViewController.m
//  Class2Chat
//
//  Created by Jeffrey Johnston on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


//********************************************************************************************
// Class Implementation File
// Displays the view controller that allows users to select a class from a picker and compose
// a message for posting to that class.
//********************************************************************************************


#import "MessageCreateViewController.h"
#import "ClassPickerViewController.h"
#import "Repository.h"
#import "C2CClass.h"

@implementation MessageCreateViewController

@synthesize klass = _klass;
@synthesize classLabel;
@synthesize messageTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self != nil) {
        _klass = nil;
        
    }
    
    return self;
}


//********************************************************************************************
// METHOD
// Captures message input from the user, checks to make sure it's correct and then assigns the 
// message a message id and puts the message into the repository
//********************************************************************************************
- (IBAction)createMessage:(id)sender
{
    Repository* repository = [Repository getRepository];
    
    // Grab the message from messageTextView
    NSString* messageText = [self.messageTextView text];
    
    
    NSError* error = nil;
    if ([messageText length] && self.klass != nil) {
        
        //Message length is limited to less than 140 characters
        //Assign a messageId to the message and handle input errors
        if ([messageText length] <= 140) {
            NSNumber* messageId = [repository createMessage:messageText forClass:[self.klass classId] error:&error];
                
            if (messageId != nil) {
                [self.navigationController popToRootViewControllerAnimated:true];
            }
            else {
                UIAlertView* message = [[UIAlertView alloc] initWithTitle:@"Server Error"
                                                                  message:@"There was a server side error."
                                                                 delegate:nil 
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles:nil];
                [message show];
            }
        }
        else {
            UIAlertView* message = [[UIAlertView alloc] initWithTitle:@"Message Too Long"
                                                              message:@"Your message can be no longer than 140 characters."
                                                             delegate:nil 
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
        }
    }
    else { 
        UIAlertView* message = [[UIAlertView alloc] initWithTitle:@"Missing Values"
                                                          message:@"Please fill in all fields before attempting to create the new message."
                                                         delegate:nil 
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    }
}


#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    //Simply sets up the message text view with design formatting
    [messageTextView.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [messageTextView.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [messageTextView.layer setBorderWidth: 1.5];
    [messageTextView.layer setCornerRadius:8.0f];
    [messageTextView.layer setMasksToBounds:YES];
    [messageTextView becomeFirstResponder];
    
}

//A method that prepares for the presentation of the ClassPickerViewController 
//which allows the user to choose from all classes on the server and input an
//access code to join.  
- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"CreateMessageToClassPicker"]) {
        
        ClassPickerViewController* picker = [segue destinationViewController];
        
        Repository* repository = [Repository getRepository];
        NSError* error = nil;
        
        NSArray* classes = [repository getMyClasses:&error];
        
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
        [self.classLabel setText:[self.klass name]];
    }
    else {
        [self.classLabel setText:@""];
    }
    
    [self.presentedViewController dismissModalViewControllerAnimated:TRUE];
}

@end

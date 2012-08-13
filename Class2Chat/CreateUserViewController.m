//
//  CreateUserViewController.m
//  Class2Chat
//
//  Created by John Schrantz on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



//********************************************************************************************
// Class Implementation File
// Captures user input and manages the creation of a new user of the C2C application
// 
//
//********************************************************************************************

#import "CreateUserViewController.h"
#import "Repository.h"

@implementation CreateUserViewController

@synthesize firstName;
@synthesize lastName;
@synthesize email;
@synthesize password;
@synthesize passwordConfirm;




//********************************************************************************************
// METHOD
// Default view controller method initializing the view
//********************************************************************************************
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
 
        // Custom initialization
    }
    return self;
}



//********************************************************************************************
// METHOD
// Puts user creation input into the repository.  Establishes defaults for the user, handles
// input errors
//********************************************************************************************
- (IBAction)createUser:(id)sender
{

    
    NSString* firstNameText = [self.firstName text];
    NSString* lastNameText = [self.lastName text];
    NSString* emailText = [self.email text];
    NSString* passwordText = [self.password text];
    NSString* passwordConfirmText = [self.passwordConfirm text];
    

    
    if ([firstNameText length] && [lastNameText length] && [emailText length] && [passwordText length] && [passwordConfirmText length]) {
        if ([passwordText isEqualToString:passwordConfirmText]) {
            Repository* repository = [Repository getRepository];
            NSError* error = nil;
            
            NSNumber* userId = [repository createUserWithFirstName:firstNameText lastName:lastNameText email:emailText aboutMe:@"" andPassword:passwordText error:&error];
            
            if (userId != nil) {
                // Set the login information in the persistant user data store
                NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
                
                [defaults setObject:emailText forKey:@"email"];
                [defaults setObject:passwordText forKey:@"password"];
                [defaults setObject:userId forKey:@"userId"];
                
                // Pop the view
                [self dismissModalViewControllerAnimated:YES];
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
        else {
            // Passwords don't match
            UIAlertView* message = [[UIAlertView alloc] initWithTitle:@"Passwords Don't Match"
                                                              message:@"Password and Confirm must match."
                                                             delegate:nil 
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];            
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


// Dismisses the keyboard from the view
-(void)resignKeyboard {
    [firstName resignFirstResponder];
    [lastName resignFirstResponder];
    [email resignFirstResponder];
    [password resignFirstResponder];
    [passwordConfirm resignFirstResponder];
}

//Notifies the view that the keyboard will show
- (void)keyboardWillShow:(NSNotification *)notification
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
    [UIView setAnimationDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    
    [UIView commitAnimations];
}

//Notifies the view that the keyboard will hide
- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
    [UIView setAnimationDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    
    [UIView commitAnimations];
}


//
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Sets up the toolbar on top of the keyboard
    // Adds a Done button to the toolbar
    // Adds security text entry for the password fields
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    UIBarButtonItem *flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignKeyboard)];
    
    NSArray *itemsArray = [NSArray arrayWithObjects:flexButton, doneButton, nil];

    [toolbar setItems:itemsArray];
    
    [firstName setInputAccessoryView:toolbar];
    [lastName setInputAccessoryView:toolbar];
    [email setInputAccessoryView:toolbar];
    [password setInputAccessoryView:toolbar];
    [passwordConfirm setInputAccessoryView:toolbar];
    
    password.secureTextEntry = YES;
    passwordConfirm.secureTextEntry = YES;
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // Removes the notifications with regard to the keyboard
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

//
//  ClassPickerViewController.m
//  Class2Chat
//
//  Created by John Schrantz on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


//********************************************************************************************
// Class Implementation File
// Displays the view controller for the class picker and handles the input from the user as to
// which class the user is selecting both the the message posting and filtering of messages
//********************************************************************************************


#import "ClassPickerViewController.h"
#import "Repository.h"
#import "C2CClass.h"

@implementation ClassPickerViewController

@synthesize delegate = _delegate;
@synthesize classes = _classes;
@synthesize pickerView;




//********************************************************************************************
// METHOD
// Captures user input from the picker view getting the class selection and calling the delegate
//********************************************************************************************
- (IBAction)pickClass:(id)sender;
{
    // Get the class
    NSInteger row = [self.pickerView selectedRowInComponent:0];
    C2CClass* klass = [self.classes objectAtIndex:row];
    
    // Call the delegate
    if (self.delegate != nil) {
        [self.delegate handlePickedClass:klass];
    }
}

//Clears the class selection
- (IBAction)clear:(id)sender
{
    // Call the delegate
    if (self.delegate != nil) {
        [self.delegate handlePickedClass:nil];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView; 
{
    return 1;
}

 - (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
}
 
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [self.classes count];   
}
 
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{   
    return [[self.classes objectAtIndex:row] name];
}




@end

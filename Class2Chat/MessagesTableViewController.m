//
//  MessagesTableViewController.m
//  Class2Chat
//
//  Created by Jeffrey Johnston on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MessagesTableViewController.h"
#import "MessageDetailViewController.h"
#import "ClassPickerViewController.h"
#import "ClassCreateViewController.h"
#import "Repository.h"
#import "C2CMessage.h"
#import "C2CClass.h"

//********************************************************************************************
// Class Implementation File
// Displays the view controller for the detailed view of the message text sent by a user
//********************************************************************************************

@implementation MessagesTableViewController

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self != nil) {
        classFilter = nil;
    }
    
    return self;
}


//A default method that has been overloaded to do additional setup for the view.
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Repository* repository = [Repository getRepository];
    NSError* error = nil;

    if (classFilter != nil) {
        messages = [repository getMessagesWithClassId:[classFilter classId] error:&error];
    }
    else {
        messages = [repository getAllMessages:&error];
    }
        
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [messages count];
}


//Gets a copy of the repository and the messages we need to display in the table view
//We get the class name as well for setting the label of the cell with the class name
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"MessageCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Repository *repository = [Repository getRepository];
    NSError* error = nil;
    C2CMessage* message = [messages objectAtIndex:indexPath.row];
    NSNumber *messageClassId = message.classId;
    C2CClass *selectClass = [repository getClassWithId: messageClassId error:&error];
            

    if (message != nil) {
        [cell.textLabel setText:selectClass.name];           
        [cell.detailTextLabel setText:message.message];      
    }

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"MessagesToDetail" sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"MessagesToDetail"]) {
        if ([sender isKindOfClass:[NSIndexPath class]]) {
            // Get destination view
            MessageDetailViewController* detail = [segue destinationViewController];
            
            C2CMessage* message = [messages objectAtIndex:[(NSIndexPath*)sender row]];
            [detail setMessage:message];

            
        }
    }
    else if ([[segue identifier] isEqualToString:@"MessagesToClassPicker"]) {
        ClassPickerViewController* picker = [segue destinationViewController];
        
        Repository* repository = [Repository getRepository];
        NSError* error = nil;
        
        NSArray* classes = [repository getMyClasses:&error];
        
        [picker setClasses:classes];
        [picker setDelegate:self];
    }
}

- (void)handlePickedClass:(C2CClass*)klass
{
    classFilter = klass;
    [self.presentedViewController dismissModalViewControllerAnimated:TRUE];
}

@end
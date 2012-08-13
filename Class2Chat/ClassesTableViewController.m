//
//  ClassesViewController.m
//  Class2Chat
//
//  Created by John Schrantz on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



//********************************************************************************************
// Class Implementation File
// Gets a copy of the repository and pulls all classes for which the user is a member and 
// displays them in the table view
//
//********************************************************************************************


#import "ClassesTableViewController.h"
#import "ClassesDetailViewController.h"
#import "Repository.h"
#import "C2CClass.h"

@implementation ClassesTableViewController


//Sets up the table view by getting the list of classes
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    Repository* repository = [Repository getRepository];
    NSError* error = nil;
    classes = [repository getMyClasses:&error];
    
    [self.tableView reloadData];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // One section containing the C2CClasses
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Count of the number of classes for which the user is a member
    //Used to determine the number of rows in the table
    return [classes count];
}


//Constructs the tableview cell data for each cell
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"ClassCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    //create a C2CClass reference for each class/row in the table
    C2CClass* klass = [classes objectAtIndex:indexPath.row];
    
    //Populate the cell with the class name 
    if (klass != nil) {
        [cell.textLabel setText:[klass name]];
        //[cell.detailTextLabel setText:@"detail"];
    }
        
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ClassesToDetail" sender:indexPath];
}


//Prepares data to be loaded into the detail view that will display after a user has
//tapped on a cell and a segue is performed
- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ClassesToDetail"]) {
        if ([sender isKindOfClass:[NSIndexPath class]]) {
            // Get destination view
            ClassesDetailViewController* detail = [segue destinationViewController];
        
            C2CClass* klass = [classes objectAtIndex:[(NSIndexPath*)sender row]];
            [detail setKlass:klass];
        }
    }
}

@end
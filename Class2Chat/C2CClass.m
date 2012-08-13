//
//  C2CClass.m
//  Class2Chat
//
//  Created by John Schrantz on 2/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "C2CClass.h"
#import "C2CUser.h"

@implementation C2CClass

@synthesize name;
@synthesize classId;
@synthesize enterpriseId;
@synthesize ownerId;
@synthesize students;

// Translate a Dictionary into this object using the fields we require
- (id)initFromDict:(NSDictionary*)dict
{
    // Check for the keys we need
    if ([dict objectForKey:@"name"] && [dict objectForKey:@"class_id"] && [dict objectForKey:@"enterprise_id"] && [dict objectForKey:@"owner_id"] && [dict objectForKey:@"students"]) {        
        self = [super init];
        
        if (self != nil) {            
            name = [dict objectForKey:@"name"];
            classId = [dict objectForKey:@"class_id"];
            enterpriseId = [dict objectForKey:@"enterprise_id"];
            ownerId = [dict objectForKey:@"owner_id"];
            //students = [[NSMutableArray alloc] init];
            
            //for (NSDictionary* studentDict in [dict objectForKey:@"students"]) {
            //    [students addObject:[[C2CUser alloc] initFromDict:studentDict]];
            //}
        }
    }
    else {
        self = nil;
    }
    
    return self;
}

// Make a Dictionary out of our fields
- (NSDictionary*)serializeToDict
{
    NSMutableArray* studentDicts = [[NSMutableArray alloc] init];
    
    for (C2CUser* student in students) {
        [studentDicts addObject:[student serializeToDict]];
    }
    
    return [[NSDictionary alloc] initWithObjectsAndKeys:
            name, @"name",
            classId, @"class_id",
            enterpriseId, @"enterprise_id",
            ownerId, @"owner_id",
            //studentDicts, @"students",
            nil];
}

@end

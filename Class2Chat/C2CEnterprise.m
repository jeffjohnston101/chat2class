//
//  C2CEnterprise.m
//  Class2Chat
//
//  Created by John Schrantz on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "C2CEnterprise.h"
#import "C2CClass.h"

@implementation C2CEnterprise

@synthesize name;
@synthesize description;
@synthesize enterpriseId;
@synthesize classes;

// Translate a Dictionary into this object using the fields we require
- (id)initFromDict:(NSDictionary*)dict
{
    // Check for the keys we need
    if ([dict objectForKey:@"name"] && [dict objectForKey:@"description"] && [dict objectForKey:@"enterprise_id"] && [dict objectForKey:@"class_ids"]) {
        self = [super init];
        
        if (self != nil) {            
            name = [dict objectForKey:@"name"];
            description = [dict objectForKey:@"description"];
            enterpriseId = [dict objectForKey:@"enterprise_id"];
            classes = [[NSMutableArray alloc] init];
            
            for (NSDictionary* classDict in [dict objectForKey:@"class_ids"]) {
                [classes addObject:[[C2CClass alloc] initFromDict:classDict]];
                //[classes addObject:[repository getClassFromDictionary:class_dict]];
            }
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
    NSMutableArray* classDicts = [[NSMutableArray alloc] init];

    for (C2CClass* klass in classes) {
        [classDicts addObject:[klass serializeToDict]];
    }
    
    return [[NSDictionary alloc] initWithObjectsAndKeys:
            name, @"name",
            description, @"description",
            enterpriseId, @"enterprise_id",
            classDicts, @"class_ids",
            nil];
}


@end

//
//  C2CUser.m
//  Class2Chat
//
//  Created by John Schrantz on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "C2CUser.h"

@implementation C2CUser

@synthesize firstName;
@synthesize lastName;
@synthesize email;
@synthesize aboutMe;
@synthesize userId;

// Translate a Dictionary into this object using the fields we require
- (id)initFromDict:(NSDictionary*)dict
{
    // Check for the keys we need
    if ([dict objectForKey:@"first_name"] && [dict objectForKey:@"last_name"] && [dict objectForKey:@"email"] && [dict objectForKey:@"about_me"] && [dict objectForKey:@"user_id"]) {        
        self = [super init];
        
        if (self != nil) {
            firstName = [dict objectForKey:@"first_name"];
            lastName = [dict objectForKey:@"last_name"];            
            email = [dict objectForKey:@"email"];
            aboutMe = [dict objectForKey:@"about_me"];
            userId = [dict objectForKey:@"user_id"];
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
    return [[NSDictionary alloc] initWithObjectsAndKeys:
            firstName, @"first_name",
            lastName, @"last_name",
            email, @"email",
            aboutMe, @"about_me",
            userId, @"user_id",
            nil];
}

@end

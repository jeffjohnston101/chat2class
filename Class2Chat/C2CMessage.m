//
//  Message.m
//  Class2Chat
//
//  Created by John Schrantz on 2/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "C2CMessage.h"

@implementation C2CMessage

@synthesize message;
@synthesize messageId;
@synthesize ownerId;
@synthesize classId;

// Translate a Dictionary into this object using the fields we require
- (id)initFromDict:(NSDictionary*)dict
{
    // Check for the keys we need
    if ([dict objectForKey:@"message"] && [dict objectForKey:@"message_id"] && [dict objectForKey:@"owner_id"] && [dict objectForKey:@"class_id"]) {        
        self = [super init];
        
        if (self != nil) {          
            message = [dict objectForKey:@"message"];
            messageId = [dict objectForKey:@"message_id"];
            ownerId = [dict objectForKey:@"owner_id"];
            classId = [dict objectForKey:@"class_id"];
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
            message, @"message",
            messageId, @"message_id",
            ownerId, @"owner_id",
            classId, @"class_id",
            nil];
}

@end

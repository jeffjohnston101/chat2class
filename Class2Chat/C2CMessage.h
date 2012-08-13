//
//  Message.h
//  Class2Chat
//
//  Created by John Schrantz on 2/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "C2CObject.h"

// This is the client side wrapper for the Class object implementing the C2CObject protocal functions
@interface C2CMessage : NSObject <C2CObject>
{
    NSString* message;
    NSNumber* messageId;
    NSNumber* ownerId;
    NSNumber* classId;
}

@property (nonatomic, strong) NSString* message;
@property (nonatomic, readonly, strong) NSNumber* messageId;
@property (nonatomic, readonly, strong) NSNumber* ownerId;
@property (nonatomic, readonly, strong) NSNumber* classId;

- (id)initFromDict:(NSDictionary*)dict;
- (NSDictionary*)serializeToDict;

@end
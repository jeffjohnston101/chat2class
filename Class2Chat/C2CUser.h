//
//  C2CUser.h
//  Class2Chat
//
//  Created by John Schrantz on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "C2CObject.h"

// This is the client side wrapper for the Class object implementing the C2CObject protocal functions
@interface C2CUser : NSObject <C2CObject>
{
    NSString* firstName;
    NSString* lastName;
    NSString* email;
    NSString* aboutMe;
    NSNumber* userId;
}

@property (nonatomic, strong) NSString* firstName;
@property (nonatomic, strong) NSString* lastName;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* aboutMe;
@property (nonatomic, readonly, strong) NSNumber* userId;

- (id)initFromDict:(NSDictionary*)dict;
- (NSDictionary*)serializeToDict;

@end

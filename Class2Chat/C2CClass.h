//
//  C2CClass.h
//  Class2Chat
//
//  Created by John Schrantz on 2/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "C2CObject.h"


// This is the client side wrapper for the Class object implementing the C2CObject protocal functions
@interface C2CClass : NSObject <C2CObject>
{
    NSString* name;
    NSNumber* classId;
    NSNumber* enterpriseId;
    NSNumber* ownerId;
    NSMutableArray* students;
}

@property (nonatomic, strong) NSString* name;
@property (nonatomic, readonly, strong) NSNumber* classId;
@property (nonatomic, readonly, strong) NSNumber* enterpriseId;
@property (nonatomic, readonly, strong) NSNumber* ownerId;
@property (nonatomic, readonly, strong) NSMutableArray* students;

- (id)initFromDict:(NSDictionary*)dict;
- (NSDictionary*)serializeToDict;

@end
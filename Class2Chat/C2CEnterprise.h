//
//  C2CEnterprise.h
//  Class2Chat
//
//  Created by John Schrantz on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "C2CObject.h"

// This is the client side wrapper for the Class object implementing the C2CObject protocal functions
@interface C2CEnterprise : NSObject <C2CObject>
{
    NSString* name;
    NSString* description;
    NSNumber* enterpriseId;
    NSMutableArray* classes;
}

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* description;
@property (nonatomic, readonly, strong) NSNumber* enterpriseId;
@property (nonatomic, strong) NSMutableArray* classes;

- (id)initFromDict:(NSDictionary*)dict;
- (NSDictionary*)serializeToDict;

@end

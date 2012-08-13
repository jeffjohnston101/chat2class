//
//  RESTObject.h
//  Class2Chat
//
//  Created by John Schrantz on 2/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// This protocol defines the functions that any class using the repository must implement
@protocol C2CObject <NSObject>

// The class must be able to initialize itself from a dictionary in order to deserialize it
- (id)initFromDict:(NSDictionary*)dict;
// The class must be able to serialize itself to a dictionary to send it over the wire
- (NSDictionary*)serializeToDict;

@end
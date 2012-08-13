//
//  RESTSession.h
//  Class2Chat
//
//  Created by John Schrantz on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


// This is the lowest level communication with the server. 
// The class takes in Objects and serialized them to json, 
// sends the json over the wire, and parses the responses into objects
@interface RESTSession : NSObject
{
    NSString* baseUrl;
    NSString* loginEmail;
    NSString* loginPassword;
}

- (id)initWithBaseUrl:(NSString*)url loginEmail:(NSString*)email andPassword:(NSString*)password;
- (void)setLoginEmail:(NSString*)email andPassword:(NSString*)password;

- (NSObject*)requestToUrl:(NSString*)urlPath withMethod:(NSString*)method andParameters:(NSDictionary*)parameters returningResponse:(NSHTTPURLResponse**)response error:(NSError**)error;
- (NSObject*)getToUrl:(NSString*)urlPath returningResponse:(NSHTTPURLResponse**)response error:(NSError**)error;
- (NSObject*)postToUrl:(NSString*)urlPath withParameters:(NSDictionary*)parameters returningResponse:(NSHTTPURLResponse**)response error:(NSError**)error;
- (NSObject*)putToUrl:(NSString*)urlPath withParameters:(NSDictionary*)parameters returningResponse:(NSHTTPURLResponse**)response error:(NSError**)error;
- (NSObject*)deleteToUrl:(NSString*)urlPath returningResponse:(NSHTTPURLResponse**)response error:(NSError**)error;

// Session Management Methods
- (void)logIn:(NSError**)error;
- (void)logOut:(NSError**)error;

// Create Methods
- (NSNumber*)createMessage:(NSString*)messageText forClass:(NSNumber*)classId error:(NSError**)error;
- (NSNumber*)createClass:(NSString*)name withAccessCode:(NSString*)accessCode error:(NSError**)error;
- (NSNumber*)createUserWithFirstName:(NSString*)firstName lastName:(NSString*)lastName email:(NSString*)email aboutMe:(NSString*)aboutMe andPassword:(NSString*)password error:(NSError**)error;

// Get Methods
- (NSArray*)getCollectionFromUrl:(NSString*)urlPath error:(NSError**)error;
- (NSDictionary*)getObjectFromUrl:(NSString*)urlPath error:(NSError**)error;
- (NSArray*)getMyClasses:(NSError**)error;
- (NSArray*)getAllClasses:(NSError**)error;
- (NSDictionary*)getClassWithId:(NSNumber*)classId error:(NSError**)error;
- (NSArray*)getAllMessages:(NSError**)error;
- (NSArray*)getMessagesWithClassId:(NSNumber*)classId error:(NSError**)error;
- (NSDictionary*)getMessageWithId:(NSNumber*)messageId error:(NSError**)error;
- (NSArray*)getAllUsers:(NSError**)error;
- (NSDictionary*)getUserWithId:(NSNumber*)userId error:(NSError**)error;

// RPC Method
- (void)joinClass:(NSNumber*)classId withAccessCode:(NSString*)accessCode error:(NSError**)error;

// Update Methods
/*- (NSDictionary*)updateClass:(NSDictionary*)classDict error:(NSError**)error;
- (NSDictionary*)updateMessage:(NSDictionary*)messageDict error:(NSError**)error;
- (NSDictionary*)updateUser:(NSDictionary*)userDict error:(NSError**)error;
*/
// Delete Methods
- (void)deleteClassWithId:(NSNumber*)classId error:(NSError**)error;
/*- (void)deleteMessageWithId:(NSNumber*)messageId error:(NSError**)error;
- (void)deleteUserWithId:(NSNumber*)userId error:(NSError**)error;
*/
@end

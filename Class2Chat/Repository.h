//
//  Repository.h
//  Class2Chat
//
//  Created by John Schrantz on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RESTSession;
@class C2CClass;
@class C2CMessage;
@class C2CUser;

// This is the class responsible for mapping the C2CClasses implenting the C2CObject protocol into RESTSession calls using Dictionaries
@interface Repository : NSObject
{
    // A RESTSession object used to communicate with the server
    RESTSession* session;
    // The currently logged in user
    C2CUser* _currentUser;
}

@property (nonatomic) C2CUser* currentUser;

// This is a singleton class
+ (Repository*)getRepository;

// This wrapper method sets the login info of the RESTSession object
- (void)setLoginEmail:(NSString*)email andPassword:(NSString*)password;

// Get Individual Object Methods
- (C2CClass*)getClassWithId:(NSNumber*)classId error:(NSError**)error;
- (C2CMessage*)getMessageWithId:(NSNumber*)messageId error:(NSError**)error;
- (C2CUser*)getUserWithId:(NSNumber*)userId error:(NSError**)error;

// Get Collection Methods
- (NSArray*)getMyClasses:(NSError**)error;
- (NSArray*)getAllClasses:(NSError**)error;
- (NSArray*)getAllMessages:(NSError**)error;
- (NSArray*)getMessagesWithClassId:(NSNumber*)classId error:(NSError**)error;

// Create Methods
- (NSNumber*)createMessage:(NSString*)messageText forClass:(NSNumber*)classId error:(NSError**)error;
- (NSNumber*)createClass:(NSString*)name withAccessCode:(NSString*)accessCode error:(NSError**)error;
- (NSNumber*)createUserWithFirstName:(NSString*)firstName lastName:(NSString*)lastName email:(NSString*)email aboutMe:(NSString*)aboutMe andPassword:(NSString*)password error:(NSError**)error;

// Join Class Method
- (void)joinClass:(NSNumber*)classId withAccessCode:(NSString*)accessCode error:(NSError**)error;

@end

//
//  Repository.m
//  Class2Chat
//
//  Created by John Schrantz on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Repository.h"
#import "RESTSession.h"
#import "C2CClass.h"
#import "C2CMessage.h"
#import "C2CUser.h"


@implementation Repository

@synthesize currentUser = _currentUser;

// Sets up the caches and the RESTSession
- (id)init
{
    self = [super self];
    
    if (self != nil) {
        session = [[RESTSession alloc] initWithBaseUrl:@"http://chat2class.appspot.com/" loginEmail:@"" andPassword:@""];
    }
    
    return self;
}

// Sets the login info of the session
- (void)setLoginEmail:(NSString*)email andPassword:(NSString*)password
{
    [session setLoginEmail:email andPassword:password];
}

// Singleton method returns the instance of repository
+ (Repository*)getRepository
{
    static Repository* repository;
    
    if (repository == nil) {
        repository = [[Repository alloc] init];
    }
    
    return repository;
}

// Returns the C2CClass with the given id or nil
- (C2CClass*)getClassWithId:(NSNumber*)classId error:(NSError**)error
{
    NSDictionary* classDict = [session getClassWithId:classId error:error];
    C2CClass* klass = nil;
    
    if (classDict != nil) {
        klass = [[C2CClass alloc] initFromDict:classDict];
    }

    return klass;
}

// Returns the C2CMessage with the given id or nil
- (C2CMessage*)getMessageWithId:(NSNumber*)messageId error:(NSError**)error
{
    NSDictionary* messageDict = [session getMessageWithId:messageId error:error];
    C2CMessage* message = nil;
    
    if (messageDict != nil) {
        message = [[C2CMessage alloc] initFromDict:messageDict];
    }
    
    return message;
}

// Returns the C2CUser with the given id or nil
- (C2CUser*)getUserWithId:(NSNumber*)userId error:(NSError**)error
{
    NSDictionary* userDict = [session getUserWithId:userId error:error];
    C2CUser* user = nil;
    
    if (userDict != nil) {
        user = [[C2CUser alloc] initFromDict:userDict];
    }
    
    return user;
}

// Returns the C2CClasses that the logged in user has permission to see (owns or a member of the class)
- (NSArray*)getMyClasses:(NSError**)error
{
    NSArray* classDicts = [session getMyClasses:error];
    NSMutableArray* classes = [[NSMutableArray alloc] init];
    
    for (NSDictionary* classDict in classDicts) {
        C2CClass* tmpClass = [[C2CClass alloc] initFromDict:classDict];
        
        if (tmpClass != nil) {
            [classes addObject:tmpClass];
        }
    }
        
    return [[NSArray alloc] initWithArray:classes];
}

// Returns All C2CClasses stored on the server
- (NSArray*)getAllClasses:(NSError**)error
{
    NSArray* classDicts = [session getAllClasses:error];
    NSMutableArray* classes = [[NSMutableArray alloc] init];
    
    for (NSDictionary* classDict in classDicts) {
        C2CClass* tmpClass = [[C2CClass alloc] initFromDict:classDict];
        
        if (tmpClass != nil) {
            [classes addObject:tmpClass];
        }
    }
    
    return [[NSArray alloc] initWithArray:classes];
}

// Returns all the C2CMessages this user has permission to see
- (NSArray*)getAllMessages:(NSError**)error
{
    NSArray* messageDicts = [session getAllMessages:error];
    NSMutableArray* messages = [[NSMutableArray alloc] init];
    
    for (NSDictionary* messageDict in messageDicts) {
        C2CMessage* tmpMessage = [[C2CMessage alloc] initFromDict:messageDict];
        
        if (tmpMessage != nil) {
            [messages addObject:tmpMessage];
        }
    }
    
    return [[NSArray alloc] initWithArray:messages];
}

// Returns all the C2CMessages for a given classId
- (NSArray*)getMessagesWithClassId:(NSNumber*)classId error:(NSError**)error
{
    NSArray* messageDicts = [session getMessagesWithClassId:classId error:error];
    NSMutableArray* messages = [[NSMutableArray alloc] init];
    
    for (NSDictionary* messageDict in messageDicts) {
        C2CMessage* message = [[C2CMessage alloc] initFromDict:messageDict];
        
        if (message != nil) {
            [messages addObject:message];
        }
    }
    
    return [[NSArray alloc] initWithArray:messages];
}

// The create methods are just wrappers around the restsession versions.
- (NSNumber*)createMessage:(NSString*)messageText forClass:(NSNumber*)classId error:(NSError**)error
{
    return [session createMessage:messageText forClass:classId error:error];
}

- (NSNumber*)createClass:(NSString*)name withAccessCode:(NSString*)accessCode error:(NSError**)error
{
    return [session createClass:name withAccessCode:accessCode error:error];
}

- (NSNumber*)createUserWithFirstName:(NSString*)firstName lastName:(NSString*)lastName email:(NSString*)email aboutMe:(NSString*)aboutMe andPassword:(NSString*)password error:(NSError**)error
{
    return [session createUserWithFirstName:firstName lastName:lastName email:email aboutMe:aboutMe andPassword:password error:error];
}

// Wrapper around the RPC call to add a user to a class
- (void)joinClass:(NSNumber*)classId withAccessCode:(NSString*)accessCode error:(NSError**)error
{
    [session joinClass:classId withAccessCode:accessCode error:error];
}

@end

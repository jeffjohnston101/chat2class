//
//  RESTSession.m
//  Class2Chat
//
//  Created by John Schrantz on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RESTSession.h"
#import "C2CMessage.h"
#import "C2CClass.h"

@implementation RESTSession

// Initializes the class with a base url that all the other calls depend on
- (id)initWithBaseUrl:(NSString*)url loginEmail:(NSString*)email andPassword:(NSString*)password
{
    self = [super init];
    
    if( self != nil ) {
        baseUrl = url;
        loginEmail = email;
        loginPassword = password;
    }
    
    return self;
}

// Sets the login email and password
- (void)setLoginEmail:(NSString*)email andPassword:(NSString*)password
{
    loginEmail = email;
    loginPassword = password;
}

// Lowest level communication. All REST calls go through this function.
// Takes a url path, a method, optional parameters, and returns the object returned
// from the server allong with the response and errors
- (NSObject*)requestToUrl:(NSString*)urlPath withMethod:(NSString*)method andParameters:(NSDictionary*)parameters returningResponse:(NSHTTPURLResponse**)response error:(NSError**)error
{
    // Set up the url
    NSURL* url = [NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@%@", baseUrl, urlPath]];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:method];
    
    // If there are data parameters (POST or PUT), serialize them into the request
    if (parameters != nil) {
        NSMutableData* requestData = nil;

        // Start the data with the json= required by the java backend
        requestData = [[NSMutableData alloc] initWithBytes:"json=" length:5];
            
        // Serialize parameter dictionary into a json data string and append it to the requestData
        [requestData appendData:[NSJSONSerialization dataWithJSONObject:parameters options:0 error:error]];

        // Set the data on the HTTP request
        [request setHTTPBody:requestData];
    }
    
    // If there was already an error then don't bother with the request
    if (*error != nil) {
        return nil;
    }
    
    // Send a synchronous request to the server (i.e. sit and wait for the response)
    NSData* responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:response error:error];
    NSObject* responseObject = nil;
    
    // If there aren't any communication errors
    if (*error == nil) {
        // And the status code says "all is good"
        if ([*response statusCode] == 200) {
            responseObject = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:error];
            
            // Then ensure we can parse json from the response (a server well formed response guarantee
            if (*error == nil) {
                // If the request was Okay, but there is an error_id in the payload then create an error
                NSDictionary* potentialError = nil;
                
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    potentialError = (NSDictionary*)responseObject;
                }
                else if ([responseObject isKindOfClass:[NSArray class]] && [(NSArray*)responseObject count] > 0) {
                    potentialError = [(NSArray*)responseObject objectAtIndex:0];
                }
                
                // Ensure that the server program did not have an issue with our request
                if (potentialError != nil && [potentialError objectForKey:@"error_id"]) {
                    *error = [[NSError alloc] initWithDomain:@"error_id error" code:200 userInfo:nil];
                }
            }
        }
        // If we are not able to access the resource
        else if ([*response statusCode] == 401) {
            // Attempt to log in and try again
            [self logIn:error];
            
            if (*error != nil) {
                 // If the log in was successful then retry the request
                *error = nil;
                responseObject = [self requestToUrl:urlPath withMethod:method andParameters:parameters returningResponse:response error:error];
            }
            else {
                // If not then create a login error
                *error = [[NSError alloc] initWithDomain:@"LoginError" code:401 userInfo:nil];
            }
        }
        else {
            // Create an error for any server side errors
            *error = [[NSError alloc] initWithDomain:@"requestToUrlError" code:[*response statusCode] userInfo:nil];
        }
    }
    // This is to deal with a crappy api. Apple decided to not just return the response with a 401 status code, they set an error with a custom 
    // error code instead. (Imagine this is not here and it is properly handled in the 401 section above)
    else if ([*error code] == -1012) {
        // Attempt to log in and try again
        *error = nil;
        [self logIn:error];
        
        if (*error == nil) {
            // If the log in was successful then retry the request
            responseObject = [self requestToUrl:urlPath withMethod:method andParameters:parameters returningResponse:response error:error];
        }
        else {
            // If not then create a login error
            *error = [[NSError alloc] initWithDomain:@"LoginError" code:401 userInfo:nil];
        }
    }
    
    return responseObject;
}

// Simple wrapper around requestToUrl with hardcoded method and parameters
- (NSObject*)getToUrl:(NSString*)urlPath returningResponse:(NSHTTPURLResponse**)response error:(NSError**)error
{
    return [self requestToUrl:urlPath withMethod:@"GET" andParameters:nil returningResponse:response error:error];
}

// Simple wrapper around requestToUrl with hardcoded method and parameters
- (NSObject*)postToUrl:(NSString*)urlPath withParameters:(NSDictionary*)parameters returningResponse:(NSHTTPURLResponse**)response error:(NSError**)error
{
    return [self requestToUrl:urlPath withMethod:@"POST" andParameters:parameters returningResponse:response error:error];
}

// Simple wrapper around requestToUrl with hardcoded method and parameters
- (NSObject*)putToUrl:(NSString*)urlPath withParameters:(NSDictionary*)parameters returningResponse:(NSHTTPURLResponse**)response error:(NSError**)error
{
    return [self requestToUrl:urlPath withMethod:@"PuT" andParameters:parameters returningResponse:response error:error];
}

// Simple wrapper around requestToUrl with hardcoded method and parameters
- (NSObject*)deleteToUrl:(NSString*)urlPath returningResponse:(NSHTTPURLResponse**)response error:(NSError**)error
{
    return [self requestToUrl:urlPath withMethod:@"DELETE" andParameters:nil returningResponse:response error:error];
}

/********** Session Management Methods **********/
// Logs in to the server with the saved credentials
- (void)logIn:(NSError**)error
{
    NSString* urlPath = @"/authentication";
    
    // Turn the parameters into a dictionary
    NSDictionary* loginCredentials = [[NSDictionary alloc] initWithObjectsAndKeys:
                                      loginEmail, @"email",
                                      loginPassword, @"password",
                                      nil];
    
    NSHTTPURLResponse* response = nil;
    
    [self postToUrl:urlPath withParameters:loginCredentials returningResponse:&response error:error];
}

// Logs out of the server
- (void)logOut:(NSError**)error
{
    // Set up the url
    NSString* urlPath = @"/authentication?logout=true";

    NSHTTPURLResponse* response = nil;
    [self getToUrl:urlPath returningResponse:&response error:error];
}

/********** Create Methods **********/
// Creates a dictionary from the passed in fields and passes it to postToUrl
- (NSNumber*)createMessage:(NSString*)messageText forClass:(NSNumber*)classId error:(NSError**)error
{
    NSString* urlPath = @"/message";
    NSMutableDictionary* newMessage = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       messageText, @"message",
                                       classId, @"class_id",
                                       nil];
    
    NSNumber* messageId = nil;
    NSHTTPURLResponse* response = nil;
    
    // Call postRequestToUrl and cast the result to a NSDictionary. That is all the api allows so it is safe.
    NSDictionary* responseDict = (NSDictionary*)[self postToUrl:urlPath withParameters:newMessage returningResponse:&response error:error];
    
    // If there was no error
    if (*error == nil) {
        messageId = [responseDict objectForKey:@"message_id"];
    }
    
    return messageId;
}

// Creates a dictionary from the passed in fields and passes it to postToUrl
- (NSNumber*)createClass:(NSString*)name withAccessCode:(NSString*)accessCode error:(NSError**)error
{
    NSString* urlPath = @"/class";

    NSMutableDictionary* newClass = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                     name, @"name",
                                     accessCode, @"access_code",
                                     nil];
    NSNumber* classId = nil;
    NSHTTPURLResponse* response = nil;
    
    // Call postRequestToUrl and cast the result to a NSDictionary. That is all the api allows so it is safe.
    NSDictionary* responseDict = (NSDictionary*)[self postToUrl:urlPath withParameters:newClass returningResponse:&response error:error];
    
    // If there was no error
    if (*error == nil) {
        classId = [responseDict objectForKey:@"class_id"];
    }
    
    return classId;
}

// Creates a dictionary from the passed in fields and passes it to postToUrl
- (NSNumber*)createUserWithFirstName:(NSString*)firstName lastName:(NSString*)lastName email:(NSString*)email aboutMe:(NSString*)aboutMe andPassword:(NSString*)password error:(NSError**)error
{
    NSString* urlPath = @"/user";
    // Turn the parameters into a dictionary
    NSMutableDictionary* newUser = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             firstName, @"first_name",
                             lastName, @"last_name",
                             email, @"email",
                             aboutMe, @"about_me",
                             password, @"password",
                             @"student", @"user_type", // We don't use this, but need to hardcode it to pass server side
                             nil];
    
    NSNumber* userId = nil;
    NSHTTPURLResponse* response = nil;
    
    // Call postRequestToUrl and cast the result to a NSDictionary. That is all the api allows so it is safe.
    NSDictionary* responseDict = (NSDictionary*)[self postToUrl:urlPath withParameters:newUser returningResponse:&response error:error];
    
    // If there was no error
    if (*error == nil) {
        userId = [responseDict objectForKey:@"user_id"];
    }
    
    return userId;
}

/********** Get Methods **********/
// Simple wrapper for the collection methods (getAll* getMyClasses, etc) gets the object for a given url
// and if there were no errors, casts it to a NSArray (A server side well formed guarantee)
- (NSArray*)getCollectionFromUrl:(NSString*)urlPath error:(NSError**)error
{
    NSArray* messages = nil;
    
    NSHTTPURLResponse* response = nil;
    
    NSObject* responseObject = [self getToUrl:urlPath returningResponse:&response error:error];
    
    // If there were no errors
    if (*error == nil) {
        messages = (NSArray*)responseObject;
    }
    
    return messages;    
}

// Wrapper around getCollection for single items. The server always returns an array for get requests,
// Pluck the first item out of the array when that is all we need.
- (NSDictionary*)getObjectFromUrl:(NSString*)urlPath error:(NSError**)error
{
    NSArray* objects = [self getCollectionFromUrl:urlPath error:error];
    NSDictionary* object = nil;

    if ([objects count] > 0) {
        object = [objects objectAtIndex:0];
    }

    return object;
}

// Call get collection with the messages for class id url
- (NSArray*)getMessagesWithClassId:(NSNumber*)classId error:(NSError**)error
{
    NSString* urlPath = [[NSString alloc] initWithFormat:@"/message?class_id=%@", classId];
    return [self getCollectionFromUrl:urlPath error:error];
}

// Call get collection with the get all messages url
- (NSArray*)getAllMessages:(NSError**)error
{
    NSString* urlPath = @"/message";
    return [self getCollectionFromUrl:urlPath error:error];
}

// Call get object with the get messages with id url
- (NSDictionary*)getMessageWithId:(NSNumber*)messageId error:(NSError**)error
{
    NSString* urlPath = [[NSString alloc] initWithFormat:@"/message?message_id=%@", messageId];
    return [self getObjectFromUrl:urlPath error:error];
}

// Call get collection with the get my classes url
- (NSArray*)getMyClasses:(NSError**)error
{
    NSString* urlPath = @"/class?mine=true";
    return [self getCollectionFromUrl:urlPath error:error];
}

// Call get collection with the get all classes url
- (NSArray*)getAllClasses:(NSError**)error
{
    NSString* urlPath = @"/class";
    return [self getCollectionFromUrl:urlPath error:error];
}

// Call get object with the get class with id url
- (NSDictionary*)getClassWithId:(NSNumber*)classId error:(NSError**)error
{
    NSString* urlPath = [[NSString alloc] initWithFormat:@"/class?class_id=%@", classId];
    return [self getObjectFromUrl:urlPath error:error];
}

// Call get collection with the get all users url
- (NSArray*)getAllUsers:(NSError**)error
{
    NSString* urlPath = @"/user";
    return [self getCollectionFromUrl:urlPath error:error];
}

// Call get object with the get user with id url
- (NSDictionary*)getUserWithId:(NSNumber*)userId error:(NSError**)error
{
    NSString* urlPath = [[NSString alloc] initWithFormat:@"/user?user_id=%@", userId];
    return [self getObjectFromUrl:urlPath error:error];    
}


/********** RPC Methods **********/
// Do to limitations in the Java backend, we decided to make a Remote Procedure Call for adding a user to a class
// breaking our adherance to rest. Simply calls post to url with the parameters given to the function.
- (void)joinClass:(NSNumber*)classId withAccessCode:(NSString*)accessCode error:(NSError**)error
{
    NSString* urlPath = @"/addStudent";

    NSMutableDictionary* classDetails = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                         classId, @"class_id",
                                         accessCode, @"access_code",
                                         nil];
    
    NSHTTPURLResponse* response = nil;
    
    [self postToUrl:urlPath withParameters:classDetails returningResponse:&response error:error];
}

// The following methods would be used to update and delete objects respectively, but they aren't used in the app so they are commented out

/********** Update Methods **********/
/*- (NSDictionary*)updateClass:(NSDictionary*)classDict error:(NSError**)error
{
    NSString* urlPath = @"/class";
    return [self ];
}

- (NSDictionary*)updateMessage:(NSDictionary*)messageDict error:(NSError**)error
{
    return nil;
}

- (NSDictionary*)updateUser:(NSDictionary*)userDict error:(NSError**)error
{
    return nil;
}
*/

/********** Delete Methods **********/
- (void)deleteClassWithId:(NSNumber*)classId error:(NSError**)error
{
    NSString* urlPath = [[NSString alloc] initWithFormat:@"/class?class_id=%@", classId];
    
    NSHTTPURLResponse* response = nil;
    [self deleteToUrl:urlPath returningResponse:&response error:error];
}

/*
- (void)deleteMessageWithId:(NSNumber*)messageId error:(NSError**)error
{
}

- (void)deleteUserWithId:(NSNumber*)userId error:(NSError**)error
{
}
*/
@end

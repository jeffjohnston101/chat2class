//
//  RESTSessionTest.m
//  Class2Chat
//
//  Created by John Schrantz on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RESTSessionTest.h"
#import "RESTSession.h"

@implementation RESTSessionTest

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    baseUrl = @"http://localhost:8888";
    loginEmail = @"test@test.com";
    loginPassword = @"Password";
    
    restSession = [[RESTSession alloc] initWithBaseUrl:baseUrl loginEmail:loginEmail andPassword:loginPassword];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testLogIn
{
    NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    NSURL* url = [[NSURL alloc] initWithString:baseUrl];
    
    // Clear any stored cookies
    for (NSHTTPCookie* cookie in [cookies cookiesForURL:url]) {
        [cookies deleteCookie:cookie];
    }
    
    NSError* error = nil;
    [restSession logIn:&error];
    STAssertTrue([[cookies cookiesForURL:url] count] > 0, @"No cookie was added for log in url");
    NSLog(@"here");
}

- (void)testCreateClass
{
    NSError* error = nil;
    NSNumber* newClass = [restSession createClass:@"TestClass" inEnterprise:nil error:&error];
    
    STAssertNotNil(newClass, @"The class was not created");
    STAssertNil(error, @"There was an error during class creation");
}

- (void)testCreateMessage
{
    NSError* error = nil;
    
    NSNumber* newClass = [restSession createClass:@"TestClass" inEnterprise:nil error:&error];
    NSNumber* newMessage = [restSession createMessage:@"This is my test message" forClass:newClass error:&error];
    
    STAssertNotNil(newMessage, @"The message was not created");
    STAssertNil(error, @"There was an error during message creation");
}

- (void)testCreateUser
{
    NSError* error = nil;
    NSNumber* newUser = [restSession createUserWithFirstName:@"ftest" lastName:@"ltest" email:loginEmail aboutMe:@"I am not real" andPassword:loginPassword error:&error];
    
    STAssertNotNil(newUser, @"The user was not created.");
    STAssertNil(error, @"There was an error during class creation");
}

@end

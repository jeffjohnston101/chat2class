//
//  RESTSessionTest.h
//  Class2Chat
//
//  Created by John Schrantz on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class RESTSession;

@interface RESTSessionTest : SenTestCase
{
    RESTSession* restSession;
    NSString* baseUrl;
    NSString* loginEmail;
    NSString* loginPassword;
}


@end

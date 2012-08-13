//
//  ClassActivationViewController.h
//  Class2Chat
//
//  Created by Jeffrey Johnston on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ClassActivationViewController : UIViewController {

    
}





@property (weak, nonatomic) IBOutlet UIImageView *universityLogo;
//@property (weak, nonatomic) IBOutlet UIImageView *userProfileImage;

@property (weak, nonatomic) IBOutlet UILabel *className;
@property (weak, nonatomic) IBOutlet UIButton *submitPasscode;

@property (weak, nonatomic) IBOutlet UITextView *messageHeader;
@property (weak, nonatomic) IBOutlet UITextView *classPasscode;

@end

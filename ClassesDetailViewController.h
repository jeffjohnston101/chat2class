//
//  ClassesDetailViewController.h
//  Class2Chat
//
//  Created by Jeffrey Johnston on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


//********************************************************************************************
//Class Header File
//The header file for the view controller that dispalys the detailed information about a class 
//from the class table view.
//Consists of an interface for the ClassesDetailViewController which is a sub-class of UIViewContorller
//********************************************************************************************


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class C2CClass;

@interface ClassesDetailViewController : UIViewController  
{
    C2CClass* _klass;                       // C2CClass object reference
}

@property (nonatomic) C2CClass* klass;

@property (nonatomic, weak) IBOutlet UIImageView* universityLogo;       //ImageView for universitylogo
@property (nonatomic, weak) IBOutlet UILabel* className;                //Label for class name
@property (nonatomic, weak) IBOutlet UILabel* classId;                  //Label for class id
@property (nonatomic, weak) IBOutlet UIButton* deleteClass;             //Button for delete class
@property (nonatomic, weak) IBOutlet UITextView* messageHeader;         //Text view for message header background

@end

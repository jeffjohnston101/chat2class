//
//  ClassPickerViewController.h
//  Class2Chat
//
//  Created by John Schrantz on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//********************************************************************************************
//Class Header File
//The header file for the ClassPickerHandler and view controller.  
//********************************************************************************************



#import <UIKit/UIKit.h>

@class C2CClass;

@protocol ClassPickerHandler <NSObject>

- (void)handlePickedClass:(C2CClass*)klass;

@end

@interface ClassPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    id<ClassPickerHandler> _delegate;                                       //Delegate for the ClassPickerHandler
    NSArray* _classes;                                                      //Array holding list of user classes
}

@property (nonatomic) id<ClassPickerHandler> delegate;                      //Delegate  
@property (nonatomic) NSArray* classes;                                     //Pointer to array of classes
@property (nonatomic, weak) IBOutlet UIPickerView* pickerView;              //Picker view for classes

- (IBAction)pickClass:(id)sender;
- (IBAction)clear:(id)sender;

@end

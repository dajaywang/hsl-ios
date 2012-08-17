//
//  DatePickerViewController.h
//  HSL
//
//  Created by DajieWang on 3/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerDelegate <NSObject>

-(void)dateChanged:(NSDate *)newDate;

@end

@interface DatePickerViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong) id <DatePickerDelegate> datePickerDelegate;

- (IBAction)dateChanged:(id)sender;
@end

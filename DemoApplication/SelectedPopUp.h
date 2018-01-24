//
//  SelectedPopUp.h
//  DemoApplication
//
//  Created by Su Pro on 1/24/18.
//  Copyright © 2018 NiNS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClickDelegate;

@interface SelectedPopUp : UIView {
    UIView *childPopUp;
    id<ClickDelegate> _click_delegate;
    UIViewController *_parent;
}

@property (nonatomic, retain) id<ClickDelegate> _click_delegate;
@property (nonatomic, retain) UIViewController *_parent;

-(void) initAlertwithParent : (UIViewController *) parent withDelegate : (id<ClickDelegate>) theDelegate;

-(IBAction)OnOKClick :(id) sender;
-(IBAction)OnDelete :(id) sender;
-(IBAction)OnUpdate :(id) sender;
-(IBAction)OnWriteFeeling :(id) sender;

-(void) hide;

-(void) show;
@end

// Delegate

@protocol ClickDelegate<NSObject>

@optional

-(void) okClicked;
-(void) OnDelete;
-(void) OnUpdate;
-(void) OnWriteFeeling;
-(void) cancelClicked;

@end

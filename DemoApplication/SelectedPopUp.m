//
//  SelectedPopUp.m
//  DemoApplication
//
//  Created by Su Pro on 1/24/18.
//  Copyright © 2018 NiNS. All rights reserved.
//

#import "SelectedPopUp.h"
#import <Foundation/Foundation.h>

@implementation SelectedPopUp {
    float popUpX;
    CGRect popUpRect;
    UIView *blurEffectView;
    UIView *custom;
}
@synthesize _click_delegate, _parent;

-(void) initAlertwithParent : (UIViewController *) parent withDelegate : (id<ClickDelegate>) theDelegate {
    
    self._click_delegate = theDelegate;
    self._parent = parent;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    CGRect rect = CGRectMake(0, 0, screenWidth, screenHeight);
    self.frame = rect;
    self.backgroundColor = [UIColor clearColor];
    
    childPopUp = [UIView new];
    float popUpHeight = screenHeight - 200;
    popUpX = 20.0;
    
    popUpRect = CGRectMake(popUpX, (screenHeight - popUpHeight)/2, screenWidth - (popUpX * 2), popUpHeight);
    childPopUp.center = self.center;
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    childPopUp.frame = popUpRect;
    childPopUp.backgroundColor = [UIColor whiteColor];
    [self addSubview:childPopUp];
    
    //    [self addLabel];
    
    [self addButton];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce1AnimationStopped)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    [UIView commitAnimations];
    
}

-(void) show{
    
    blurEffectView = [[UIView alloc] initWithFrame:self._parent.view.bounds];
    blurEffectView.backgroundColor =  [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:0.8];
    [self._parent.view addSubview:blurEffectView];
    [self._parent.view addSubview:self];
    
}

-(void) addButton{
    
    // Add Button
    UIButton *editBtn = [[UIButton alloc]initWithFrame:CGRectMake(popUpRect.size.width/4 - 5, 50, popUpRect.size.width/2 + 10, 50)];
    [editBtn setTitle:@"修正" forState:UIControlStateNormal];
    [editBtn.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
    [editBtn addTarget:self action:@selector(OnUpdate:) forControlEvents:UIControlEventTouchDown];
    editBtn.backgroundColor = [UIColor blackColor];
    [childPopUp addSubview:editBtn];
    
    // Add Button
    UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(popUpRect.size.width/4 - 5, 130, popUpRect.size.width/2 + 10, 50)];
    [deleteBtn setTitle:@"削除" forState:UIControlStateNormal];
    [deleteBtn.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
    [deleteBtn addTarget:self action:@selector(OnDelete:) forControlEvents:UIControlEventTouchDown];
    deleteBtn.backgroundColor = [UIColor blackColor];
    [childPopUp addSubview:deleteBtn];
    
    // Add Button
    UIButton *feelingBtn = [[UIButton alloc]initWithFrame:CGRectMake(popUpRect.size.width/4 - 5, 210, popUpRect.size.width/2 + 10, 50)];
    [feelingBtn setTitle:@"感想の一覧" forState:UIControlStateNormal];
    [feelingBtn.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
    [feelingBtn addTarget:self action:@selector(OnWriteFeeling:) forControlEvents:UIControlEventTouchDown];
    feelingBtn.backgroundColor = [UIColor blackColor];
    [childPopUp addSubview:feelingBtn];
    
    
    
    // Add Button
    UIButton *okBtn = [[UIButton alloc]initWithFrame:CGRectMake(popUpRect.size.width/4 - 5, childPopUp.frame.size.height - 45, popUpRect.size.width/2 + 10, 40)];
    UIColor *btnColor = [UIColor colorWithRed:0.72 green:0.69 blue:0.67 alpha:1.0];
    [okBtn setTitle:@"     閉じる" forState:UIControlStateNormal];
    [okBtn.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
    [okBtn addTarget:self action:@selector(OnOKClick:) forControlEvents:UIControlEventTouchDown];
    okBtn.backgroundColor = btnColor;
    [childPopUp addSubview:okBtn];
    
}

-(IBAction)OnOKClick :(id) sender{
    
    [_click_delegate okClicked];
    
}

-(IBAction)OnUpdate :(id) sender {
    [_click_delegate OnUpdate];
    [self hide];
}

-(IBAction)OnDelete :(id) sender {
    [_click_delegate OnDelete];
    [self hide];
}

-(IBAction)OnWriteFeeling :(id) sender {
    [_click_delegate OnWriteFeeling];
    [self hide];
}



-(void) show : (UIViewController *) parent{
    
}

-(void) hide{
    
    [blurEffectView removeFromSuperview];
    [self removeFromSuperview];
}

- (void)bounce1AnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    [UIView commitAnimations];
}

- (void)bounce2AnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.2];
    self.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
}


-(void) setBorder:(UIView *) theView withCornerRadius :(float) radius andBorderWidth :(float) borderWidth andBorderColor :(UIColor *) bgColor
{
    theView.layer.borderWidth = borderWidth;
    theView.layer.cornerRadius = radius;
    theView.layer.borderColor = [bgColor CGColor];
}

@end

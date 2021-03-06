//
//  ViewController.h
//  TicTacToe
//
//  Created by Matthew Voracek on 1/10/14.
//  Copyright (c) 2014 Matthew Voracek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
-(void)takeATurn:(UILabel *)label;
-(IBAction)onLabelTapped:(UITapGestureRecognizer *)tapGestureRecognizer;
-(UILabel*)findLabelUsingPoint:(CGPoint)point;
-(NSString*)whoOne;
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;


@end

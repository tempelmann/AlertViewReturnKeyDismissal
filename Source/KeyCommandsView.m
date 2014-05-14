//
//  KeyCommandsView.m
//  AlertViewReturnKeyDismissal
//
//  Created by Thomas Tempelmann on 14/05/14.
//	See http://stackoverflow.com/questions/23567682 (Francescu's answer)
//

#import "KeyCommandsView.h"

@implementation KeyCommandsView

- (BOOL)canBecomeFirstResponder
{
	NSLog(@"KeyCommandsView's canBecomeFirstResponder invoked");
	return YES;
}

-(NSArray *)keyCommands
{
	NSLog(@"KeyCommandsView's keyCommands invoked");
	return @[[UIKeyCommand keyCommandWithInput:@"\r" modifierFlags:0 action:@selector(enterPressed)]];
}

- (void)enterPressed
{
	NSLog(@"Success! Return key was pressed in alert view");
	[self.alertView dismissWithClickedButtonIndex:0 animated:YES];
}

@end

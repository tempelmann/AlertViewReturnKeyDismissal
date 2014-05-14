//
//  UIAlertView+ReturnKey.m
//  AlertViewReturnKeyDismissal
//
//  Created by Thomas Tempelmann on 14/05/14.
//	See http://stackoverflow.com/questions/23567682
//

#import "UIAlertView+ReturnKey.h"

@implementation UIAlertView (ReturnKey)

- (NSArray *)keyCommands
{
	NSLog(@"keyCommands if UIAlertView invoked");
    return @[[UIKeyCommand keyCommandWithInput:@"\r" modifierFlags:0 action:@selector(returnPressed:)]];
}

- (void)returnPressed:(id)sender
{
	NSLog(@"Success! Return key was pressed");
	[sender dismissWithClickedButtonIndex:0 animated:YES];
}

@end

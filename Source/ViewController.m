//
//  ViewController.m
//  AlertViewReturnKeyDismissal
//
//  Created by Thomas Tempelmann on 14/05/14.
//	See http://stackoverflow.com/questions/23567682
//

#import "ViewController.h"
#import "UIAlertView+ReturnKey.h"

@interface ViewController ()
	@property (nonatomic, strong) UIAlertView *theAlertView;
@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
	[self becomeFirstResponder];	// for responding to 'keyCommands'
}

- (BOOL)canBecomeFirstResponder
{
	NSLog(@"canBecomeFirstResponder invoked");
	return YES;
}

- (NSArray *)keyCommands
{
	NSLog(@"keyCommands invoked");
    return @[[UIKeyCommand keyCommandWithInput:@"\r" modifierFlags:0 action:@selector(returnPressed)]];
}

- (IBAction)showAlert:(id)sender
{
	self.theAlertView = [[UIAlertView alloc] initWithTitle:@"title" message:@"msg" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[self.theAlertView show];
	NSLog(@"Alert getting shown...");
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	self.theAlertView = NULL;
	NSLog(@"Alert is closed");
}

- (void)didPresentAlertView:(UIAlertView *)alertView
{
	NSLog(@"Alert has appeared; Setting first responder again");
	[self becomeFirstResponder];
	
	// let's try that again a bit later in case our caller has reset it - doesn't help either, though:
	[self performSelector:@selector(becomeFirstResponder) withObject:NULL afterDelay:0.1];
}

- (void)returnPressed
{
	if (self.theAlertView) {
		NSLog(@"Success! Return key was pressed");
		[self.theAlertView dismissWithClickedButtonIndex:0 animated:YES];
	} else {
		NSLog(@"Return key was pressed");
	}
}

@end

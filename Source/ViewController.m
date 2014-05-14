//
//  ViewController.m
//  AlertViewReturnKeyDismissal
//
//  Created by Thomas Tempelmann on 14/05/14.
//	See http://stackoverflow.com/questions/23567682
//

#import "ViewController.h"
#import "KeyCommandsView.h"

@interface ViewController ()
	@property (nonatomic, strong) UIAlertView *theAlertView;
	@property (nonatomic, strong) KeyCommandsView *keyCommandsView;
@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	#if 0
		// if we show the alert here, then we'll get the key press callbacks, oddly, but we want to be able to show the dialog later and have it still work
		[self showAlert:NULL];
	#endif
}

- (void)viewDidAppear:(BOOL)animated
{
	[self becomeFirstResponder];	// for responding to 'keyCommands'
}

- (BOOL)canBecomeFirstResponder
{
	NSLog(@"Main view's canBecomeFirstResponder invoked");
	return YES;
}

- (NSArray *)keyCommands
{
	NSLog(@"Main view's keyCommands invoked");
	return @[[UIKeyCommand keyCommandWithInput:@"\r" modifierFlags:0 action:@selector(returnPressed)]];
}

- (IBAction)showAlert:(id)sender
{
	self.theAlertView = [[UIAlertView alloc] initWithTitle:@"title" message:@"msg" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];

	#if 1
		// Trying Francescu's idea:
		self.keyCommandsView = [[KeyCommandsView alloc] initWithFrame:CGRectMake(-1, -1, 1, 1)];
		[self.theAlertView addSubview:self.keyCommandsView];
		self.keyCommandsView.alertView = self.theAlertView;
	#endif

	[self.theAlertView show];
	NSLog(@"Alert getting shown...");
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	[self.keyCommandsView resignFirstResponder];
	self.theAlertView = NULL;
	NSLog(@"Alert is closed");
}

- (void)didPresentAlertView:(UIAlertView *)alertView
{
	NSLog(@"Alert has appeared");
	if (self.keyCommandsView) {
		[self.keyCommandsView becomeFirstResponder];
	} else {
		[self becomeFirstResponder];
	}
}

- (void)returnPressed
{
	NSLog(@"Return key was pressed in main view");
}

@end

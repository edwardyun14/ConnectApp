//
//  BroadcastingViewController.m
//  Connect
//
//  Created by Ethan Yu on 11/15/14.
//  Copyright (c) 2014 Liu. All rights reserved.
//

#import "BroadcastingViewController.h"
#import "ConfirmViewController.h"

@interface BroadcastingViewController ()

@property (nonatomic) NSMutableDictionary *requestedServicesWithInfo;

@end

@implementation BroadcastingViewController

- (void)broadcastMessage {
	NSMutableString *messageToBroadcast = [[NSMutableString alloc] init];
	NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"realname"];
	NSString *fb = [[NSUserDefaults standardUserDefaults] objectForKey:@"fbusername"];
	NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phonenumber"];
	NSString *twitter = [[NSUserDefaults standardUserDefaults] objectForKey:@"twitterID"];
	NSString *yo = [[NSUserDefaults standardUserDefaults] objectForKey:@"YoID"];
	
	[messageToBroadcast appendString:[NSString stringWithFormat:@"NAME:%@\n", name]];
	[messageToBroadcast appendString:[NSString stringWithFormat:@"FB:%@\n", fb]];
	
	if (phone) {
		[messageToBroadcast appendString:@"PHONE"];
	}
	if (twitter) {
		[messageToBroadcast appendString:@"TWITTER\n"];
	}
	if (yo) {
		[messageToBroadcast appendString:@"YO\n"];
	}
	
	// broadcast this message
}

- (void)listenForRequests {
	NSString *messageReceived = @""; //change
	self.requestedServicesWithInfo = [[NSMutableDictionary alloc] init];

	NSArray *components = [messageReceived componentsSeparatedByString:@"\n"];
	for (NSString *component in components) {
		if ([component containsString:@"NAME:"]) {
			NSString *name = [component componentsSeparatedByString:@"NAME:"][0];
			[self.requestedServicesWithInfo setObject:name forKey:@"NAME"];
		}
		else if ([component containsString:@"FB:"]) {
			NSString *fb = [component componentsSeparatedByString:@"FB:"][0];
			[self.requestedServicesWithInfo setObject:fb forKey:@"FB"];
		}
		else if ([component containsString:@"PHONE:"]) {
			NSString *phone = [component componentsSeparatedByString:@"PHONE:"][0];
			[self.requestedServicesWithInfo setObject:phone forKey:@"PHONE"];
		}
		else if ([component containsString:@"TWITTER:"]) {
			NSString *twitter = [component componentsSeparatedByString:@"TWITTER:"][0];
			[self.requestedServicesWithInfo setObject:twitter forKey:@"TWITTER"];
		}
		else if ([component containsString:@"YO:"]) {
			NSString *yo = [component componentsSeparatedByString:@"YO:"][0];
			[self.requestedServicesWithInfo setObject:yo forKey:@"YO"];
		}
	}
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([[segue destinationViewController] isKindOfClass:[ConfirmViewController class]]) {
		((ConfirmViewController *)[segue destinationViewController]).requestedServicesWithInfo = self.requestedServicesWithInfo;
	}
}

@end

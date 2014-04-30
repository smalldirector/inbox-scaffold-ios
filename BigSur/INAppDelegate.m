//
//  INAppDelegate.m
//  BigSur
//
//  Created by Ben Gotow on 4/22/14.
//  Copyright (c) 2014 Inbox. All rights reserved.
//

#import "INAppDelegate.h"
#import "INViewController.h"
#import "INDatabaseManager.h"
#import "INContact.h"
#import "INModelProvider.h"
#import "INModelObject+Uniquing.h"

@implementation INAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.rootViewController = [[INViewController alloc] init];
	[self.window makeKeyAndVisible];

	// Let's say we have an API call that returns two JSON dictionaries that we want
	// to add to the local cache. We may or may not already have these objects.
	// This function either creates them or retrieves them and updates them in memory.
	INContact * a = [INContact attachedInstanceWithResourceDictionary:@{@"name": @"Ben Gotow", @"id": @(2), @"namespace_id":@(1), @"email_address":@"bengotow@gmail.com", @"account_id":@(12), @"uid":@(4)}];
	[[INDatabaseManager shared] persistModel: a];

	INContact * b = [INContact attachedInstanceWithResourceDictionary:@{@"name": @"John Gotow", @"id": @(3), @"namespace_id":@(1), @"account_id":@(12), @"uid":@(4)}];
	[[INDatabaseManager shared] persistModel: b];

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		INContact * a = [INContact attachedInstanceWithResourceDictionary:@{@"name": @"Ben Gotow Again!", @"id": @(4), @"namespace_id": @(1), @"email_address":@"bengotow+test@gmail.com", @"account_id":@(12), @"uid":@(4)}];
		[[INDatabaseManager shared] persistModel: a];
	});
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

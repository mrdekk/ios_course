//
//  AppDelegate.m
//  iosc.02
//
//  Created by MrDekk on 10/07/14.
//  Copyright (c) 2014 mrdekk. All rights reserved.
//

#import "AppDelegate.h"

#import "RSS.h"
#import "RssItem.h"
#import "RssChannel.h"
#import "RssParser.h"

#import "RssItemViewController.h"

@interface AppDelegate ( ) < RssLoadingProtocol >

-( void ) rssLoaded: ( RSS* )rss;

@end

@implementation AppDelegate
{
	UIWindow* _window;
	RssItemViewController* _itemCtrl;
}

-( void ) dealloc
{
	[ _itemCtrl release ];
	[ _window release ];
	
	[ super dealloc ];
}

-( void ) rssLoaded: ( RSS* )rss
{
	NSLog( @"RSS loaded (TS): %@", [ rss description ] );
}

-( void ) didSucceededLoadRSS: ( RSS* )rss
{
	NSLog( @"RSS loaded (Prot): %@", [ rss description ] );
	[ _itemCtrl setRssItem: ( RssItem* )[ ( ( RssChannel* ) [ rss.Channels objectAtIndex: 0 ] ).Items objectAtIndex: 0 ] ];
}

-( void ) didRSSLoadFailed: ( NSError* )error
{
	NSLog( @"RSS load failed: %@ [ %@ ] ", error, [ error userInfo ] );
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	_window = [ [ UIWindow alloc ] initWithFrame: [ [ UIScreen mainScreen ] bounds ] ];
	_window.backgroundColor = [ UIColor whiteColor ];
	
	_itemCtrl = [ [ RssItemViewController alloc ] initWithNibName: @"RssItemViewController" bundle: [ NSBundle mainBundle ] ];
	_window.rootViewController = _itemCtrl;
	[ _window makeKeyAndVisible ];
	
	/*
	RSS* rss = [ RSS sample ];
	NSLog( @"%@", [ rss description ] );
	*/
	
	[ RSS loadRssFromFile: @"file.sample.txt" target: self selector: @selector( rssLoaded: ) ];
	[ RSS loadRssFromFile: [ [ NSBundle mainBundle ] pathForResource: @"rss" ofType: @"xml" ] thenCallback: self ];
	
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

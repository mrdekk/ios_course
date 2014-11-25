//
//  RssLoader.m
//  iosc.02
//
//  Created by MrDekk on 10/08/14.
//  Copyright (c) 2014 mrdekk. All rights reserved.
//

#import "RssLoader.h"
#import "RssParser.h"

@interface RssLoader ( ) < NSURLConnectionDataDelegate, NSURLConnectionDelegate  >

@end

@implementation RssLoader
{
	NSMutableData* _data;
	NSURLConnection* _connection;
	
	id _target;
	SEL _selector;
}

#pragma mark - NSURLConnectionDataDelegate

-( id ) initWithURL: ( NSURL* )url thenCallTarget: ( id )target withSelector: ( SEL )selector;
{
	self = [ super init ];
	if ( nil != self )
	{
		_data = [ [ NSMutableData alloc ] init ];
		_target = target;
		_selector = selector;
		
		NSMutableURLRequest* req = [ [ [ NSMutableURLRequest alloc ] initWithURL: url ] autorelease ];
		[ req setHTTPMethod: @"GET" ];
		[ req setCachePolicy: NSURLRequestReloadIgnoringLocalAndRemoteCacheData ];
		
		_connection = [ [ NSURLConnection connectionWithRequest: req delegate: self ] retain ];
	}
	
	return self;
}

-( void ) dealloc
{
	[ _data release ];
	[ _connection release ];

	[ super dealloc ];
}

-( void ) connection: ( NSURLConnection* )connection didReceiveResponse: ( NSURLResponse* )response
{
	[ _data setLength: 0 ];
}

-( void ) connection: ( NSURLConnection* )connection didReceiveData: ( NSData* )data
{
	[ _data appendData: data ];
}

-( void ) connectionDidFinishLoading: ( NSURLConnection* )connection
{
	RssParser* parser = [ [ [ RssParser alloc ] init ] autorelease ];
	RSS* rss = [ parser parseRssFeedFromData: _data ];

	[ _target performSelector: _selector withObject: rss ];
	[ self autorelease ];
}

#pragma mark - NSURLConnectionDelegate

-( void ) connection: ( NSURLConnection* )connection didFailWithError: ( NSError* )error
{
	[ _target performSelector: _selector withObject: error ];
	[ self autorelease ];
}

@end

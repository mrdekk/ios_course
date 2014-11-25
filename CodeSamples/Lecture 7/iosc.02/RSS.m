//
//  RSS.m
//  iosc.02
//
//  Created by MrDekk on 10/07/14.
//  Copyright (c) 2014 mrdekk. All rights reserved.
//

#import "RSS.h"
#import "RssChannel.h"
#import "RssItem.h"

#import "RssParser.h"

@implementation RSS
{
	NSArray* _channels;
}

@synthesize Channels = _channels;

-( id ) init
{
	self = [ super init ];
	
	if ( nil != self )
	{
		// TODO:
	}
	
	return self;
}

-( void ) dealloc
{
	[ _channels release ];
	
	[ super dealloc ];
}

-( NSString* ) description
{
	NSMutableString* str = [ NSMutableString string ];
	
	[ str appendFormat: @"Channels:\n" ];
	
	for ( RssChannel* ch in _channels )
	{
		[ str appendFormat: @"%@\n", [ ch description ] ];
	}
	
	return [ NSString stringWithString: str ];
}

#pragma mark - public routines

+( RSS* ) sample
{
	RSS* rss = [ [ [ RSS alloc ] init ] autorelease ];
	
	RssChannel* ch = [ RssChannel sampleChannel ];
	
	rss.Channels = [ NSArray arrayWithObjects: ch, nil ];
	
	return rss;
}

+( void ) loadRssFromFile: ( NSString* )fileName target: ( id )target selector: ( SEL )selector
{
	RSS* rss = [ [ [ RSS alloc ] init ] autorelease ];
	RssChannel* ch = [ RssChannel sampleChannel ];
	rss.Channels = [ NSArray arrayWithObjects: ch, nil ];
	
	if ( [ target respondsToSelector: selector ] )
		[ target performSelector: selector withObject: rss ];
}

+( void ) loadRssFromFile: ( NSString* )fileName thenCallback: ( id< RssLoadingProtocol > )callback
{
	RssParser* parser = [ [ [ RssParser alloc ] init ] autorelease ];
	RSS* rss = [ parser parseRssFeedFromFile: fileName ];
	
	if ( nil != callback )
		[ callback didSucceededLoadRSS: rss ];
}

+( void ) loadRssFromURL: ( NSURL* )url thenCallback: ( id< RssLoadingProtocol > )callback
{
	
}


@end

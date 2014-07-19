//
//  RSS.m
//  iosc.02
//
//  Created by MrDekk on 10/07/14.
//  Copyright (c) 2014 mrdekk. All rights reserved.
//

#import "RSS.h"
#import "RssChannel.h"

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


@end

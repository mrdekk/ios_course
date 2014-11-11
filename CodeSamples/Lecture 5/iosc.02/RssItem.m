//
//  RssItem.m
//  iosc.02
//
//  Created by MrDekk on 10/07/14.
//  Copyright (c) 2014 mrdekk. All rights reserved.
//

#import "RssItem.h"

@implementation RssItem
{
	NSString* _title;
	NSString* _guid;
	NSString* _link;
	NSString* _desc;
	NSDate* _pubDate;
	NSArray* _categories;
}

@synthesize Title = _title;
@synthesize GUID = _guid;
@synthesize Link = _link;
@synthesize Desc = _desc;
@synthesize PubDate = _pubDate;
@synthesize Categories = _categories;

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
	[ _title release ];
	[ _guid release ];
	[ _link release ];
	[ _desc release ];
	[ _pubDate release ];
	[ _categories release ];

	[ super dealloc ];
}

-( NSString* ) description
{
	NSMutableString* str = [ NSMutableString string ];
	
	NSDateFormatter* fmt = [ [ [ NSDateFormatter alloc ] init ] autorelease ];
	[ fmt setDateFormat: @"EEE, dd MMM yyyy HH:mm:ss z" ];
	
	[ str appendFormat: @"\t\tTitle: %@\n", _title ];
	[ str appendFormat: @"\t\tGUID: %@\n", _guid ];
	[ str appendFormat: @"\t\tLink: %@\n", _link ];
	[ str appendFormat: @"\t\tDesc: %@\n", _desc ];
	[ str appendFormat: @"\t\tPubDate: %@\n", [ fmt stringFromDate: _pubDate ] ];
	[ str appendFormat: @"\t\tCategories: " ];
	
	for ( NSString* cat in _categories )
	{
		[ str appendFormat: @"%@, ", cat ];
	}
	[ str appendFormat: @"\n" ];
	
	return [ NSString stringWithString: str ];
}

@end

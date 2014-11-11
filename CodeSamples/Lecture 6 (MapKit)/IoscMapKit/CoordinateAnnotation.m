//
//  CoordinateAnnotation.m
//  IoscMapKit
//
//  Created by MrDekk on 10/08/14.
//  Copyright (c) 2014 mrdekk. All rights reserved.
//

#import <MapKit/MapKit.h>

#import "CoordinateAnnotation.h"

@interface CoordinateAnnotation ( )

@end

@implementation CoordinateAnnotation
{
	CLLocationCoordinate2D _coord;
	NSDate* _date;
}

@synthesize Coord = _coord;
@synthesize Date = _date;

-( CLLocationCoordinate2D ) coordinate
{
	return _coord;
}

-( NSString* ) title
{
	NSDateFormatter* fmt = [ NSDateFormatter new ];
	[ fmt setDateFormat: @"HH:mm:ss" ];
	
	return [ fmt stringFromDate: _date ];
}

-( id ) init
{
	self = [ super init ];
	if ( nil != self )
	{
	}
	
	return self;
}

-( void ) dealloc
{
	[ _date release ];

	[ super dealloc ];
}

@end

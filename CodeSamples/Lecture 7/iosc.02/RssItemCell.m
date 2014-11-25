//
//  RssItemCell.m
//  iosc.02
//
//  Created by MrDekk on 10/08/14.
//  Copyright (c) 2014 mrdekk. All rights reserved.
//

#import "RssItemCell.h"

@implementation RssItemCell
{
	UIImageView* _imageView;
	UILabel* _title;
	UILabel* _desc;
	UILabel* _date;
}

@synthesize ImageView = _imageView;
@synthesize Title = _title;
@synthesize Desc = _desc;
@synthesize Date = _date;

-( id ) initWithStyle: ( UITableViewCellStyle )style reuseIdentifier: ( NSString* )reuseIdentifier
{
	self = [ super initWithStyle: style reuseIdentifier: reuseIdentifier ];
	if ( self )
	{
	}
	
	return self;
}

-( void ) dealloc
{
	[ _imageView release ];
	[ _title release ];
	[ _desc release ];
	[ _date release ];

	[ super dealloc ];
}

-( void ) awakeFromNib
{
}

-( void ) setSelected: ( BOOL )selected animated: ( BOOL )animated
{
	[ super setSelected: selected animated: animated ];
}

@end

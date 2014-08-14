//
//  RssItemViewController.m
//  iosc.02
//
//  Created by MrDekk on 20/07/14.
//  Copyright (c) 2014 mrdekk. All rights reserved.
//

#import "RssItemViewController.h"

#import "RssItem.h"

@interface RssItemViewController ( )

@property ( nonatomic, retain ) IBOutlet UIImageView* ImageView;
@property ( nonatomic, retain ) IBOutlet UILabel* TitleView;
@property ( nonatomic, retain ) IBOutlet UIWebView* DescriptionView;

@end

@implementation RssItemViewController
{
	UIImageView* _imageView;
	UILabel* _titleView;
	UIWebView* _descriptionView;
}

@synthesize ImageView = _imageView;
@synthesize TitleView = _titleView;
@synthesize DescriptionView = _descriptionView;

-( id ) initWithNibName: ( NSString* )nibNameOrNil bundle: ( NSBundle* )nibBundleOrNil
{
	self = [ super initWithNibName: nibNameOrNil bundle: nibBundleOrNil ];

	if ( nil != self )
	{
    }
	
	return self;
}

-( void ) dealloc
{
	[ _imageView release ];
	[ _titleView release ];
	[ _descriptionView release ];
	
	[ super dealloc ];
}

-( void ) viewDidLoad
{
	[ super viewDidLoad ];
	
	_titleView.text = @"";
	[ _descriptionView loadHTMLString: @"<html><body></body></html>" baseURL: nil ];
}

-( void ) didReceiveMemoryWarning
{
	[ super didReceiveMemoryWarning ];
}

#pragma mark - public routines

-( void ) setRssItem: ( RssItem* )item
{
	_titleView.text = item.Title;
	[ _descriptionView loadHTMLString: item.Desc baseURL: nil ];
	
	NSDataDetector* detector = [ NSDataDetector dataDetectorWithTypes: NSTextCheckingTypeLink error: nil ];
	NSArray* matches = [ detector matchesInString: item.Desc options: 0 range: NSMakeRange( 0, [ item.Desc length ] ) ];
	if ( [ matches count ] > 0 )
	{
		NSTextCheckingResult* match = [ matches objectAtIndex: 0 ];
		if ( [ match resultType ] == NSTextCheckingTypeLink )
		{
			NSURL* url = [ match URL ];
			NSData* data = [ NSData dataWithContentsOfURL: url ];
			UIImage* img = [ UIImage imageWithData: data ];
			_imageView.image = img;
		}
		else
		{
			_imageView.image = nil;
		}
	}
	else
	{
		_imageView.image = nil;
	}
}


@end

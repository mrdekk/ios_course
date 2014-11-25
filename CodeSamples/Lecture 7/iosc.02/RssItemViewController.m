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
	
	RssItem* _item;
}

@synthesize ImageView = _imageView;
@synthesize TitleView = _titleView;
@synthesize DescriptionView = _descriptionView;

@synthesize Item = _item;

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
	
	[ _item release ];
	
	[ super dealloc ];
}

-( void ) viewDidLoad
{
	[ super viewDidLoad ];
	
	self.edgesForExtendedLayout = UIRectEdgeNone;
	
	_titleView.text = @"";
	[ _descriptionView loadHTMLString: @"<html><body></body></html>" baseURL: nil ];
}

-( void ) viewDidAppear: ( BOOL )animated
{
	[ super viewDidAppear: animated ];
	
	[ self setItem: _item ];
}

-( void ) viewWillAppear: ( BOOL )animated
{
	[ super viewWillAppear: animated ];
	
	self.navigationItem.title = _item.Title;
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
}

-( void ) didReceiveMemoryWarning
{
	[ super didReceiveMemoryWarning ];
}

#pragma mark - public routines

-( void ) setItem: ( RssItem* )item
{
	[ _item release ];
	_item = [ item retain ];

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

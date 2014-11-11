//
//  RssChannelViewController.m
//  iosc.02
//
//  Created by MrDekk on 20/07/14.
//  Copyright (c) 2014 mrdekk. All rights reserved.
//

#import "RssChannelViewController.h"
#import "RssItemViewController.h"

#import "RssChannel.h"
#import "RssItem.h"

#import "UIImage+Resize.h"
#import "UIImage+Colored.h"

#import "NSString+Stripping.h"

#import "RssItemCell.h"

@interface RssChannelViewController ( ) < UITableViewDataSource, UITableViewDelegate >

@property ( nonatomic, retain ) IBOutlet UITableView* TableView;
@property ( nonatomic, retain ) IBOutlet RssItemCell* RssItemCell;

@end

@implementation RssChannelViewController
{
	UITableView* _tableView;
	RssChannel* _channel;
	
	NSMutableDictionary* _index;
	NSArray* _keys;
	
	RssItemCell* _rssItemCell;
}

@synthesize TableView = _tableView;
@synthesize Channel = _channel;

@synthesize RssItemCell = _rssItemCell;

-( id ) initWithNibName: ( NSString* )nibNameOrNil bundle: ( NSBundle* )nibBundleOrNil
{
	self = [ super initWithNibName: nibNameOrNil bundle: nibBundleOrNil ];
	
	if ( nil !=  self )
	{
		_index = [ [ NSMutableDictionary alloc ] init ];
		_keys = [ [ NSArray alloc ] init ];
	}

	return self;
}

-( void ) dealloc
{
	[ _tableView release ];
	[ _channel release ];
	
	[ _index release ];
	[ _keys release ];
	
	[ _rssItemCell release ];
	
	[ super dealloc ];
}

-( void ) viewDidLoad
{
	[ super viewDidLoad ];
}

-( void ) viewDidAppear: ( BOOL )animated
{
	[ super viewDidAppear: animated ];
}

-( void ) viewWillAppear: ( BOOL )animated
{
	[ super viewWillAppear: animated ];
	
	self.navigationItem.title = _channel.Title;
}

-( void ) didReceiveMemoryWarning
{
	[ super didReceiveMemoryWarning ];
}

-( void ) setChannel: ( RssChannel* )channel
{
	[ _channel release ];
	_channel = [ channel retain ];
	
	[ _index removeAllObjects ];
	[ _keys release ];
	
	NSDateFormatter* fmt = [ [ [ NSDateFormatter alloc ] init ] autorelease ];
	[ fmt setDateFormat: @"yyyy-MM-dd" ];
	
	NSMutableArray* keys = [ NSMutableArray array ];
	
	for ( RssItem* item in channel.Items )
	{
		NSString* pubDate = [ fmt stringFromDate: item.PubDate ];
		
		NSMutableArray* indexitems = [ _index objectForKey: pubDate ];
		if ( nil == indexitems )
		{
			indexitems = [ [ [ NSMutableArray alloc ] init ] autorelease ];
			[ _index setObject: indexitems forKey: pubDate ];
			
			[ keys addObject: pubDate ];
		}
		
		if ( nil != indexitems )
		{
			[ indexitems addObject: item ];
		}
	}
	
	_keys = [ [ keys sortedArrayUsingComparator: ^NSComparisonResult( NSString* key1, NSString* key2 )
	{
		return [ key2 compare: key1 ];
	} ] retain ];
}

#pragma mark - UITableViewDataSource

-( NSInteger ) numberOfSectionsInTableView: ( UITableView* )tableView
{
	return 1 + [ [ _index allKeys ] count ];
}

-( NSInteger ) tableView: ( UITableView* )tableView numberOfRowsInSection: ( NSInteger )section
{
	if ( section == 0 )
		return 1;
		
	NSMutableArray* indexitems = [ _index objectForKey: [ _keys objectAtIndex: section - 1 ] ];
	return [ indexitems count ];
}

-( NSString* ) tableView: ( UITableView* )tableView titleForHeaderInSection: ( NSInteger )section
{
	if ( section == 0 )
		return nil;
		
	return [ _keys objectAtIndex: section - 1 ];
}

-( UITableViewCell* ) tableView: ( UITableView* )tableView cellForRowAtIndexPath: ( NSIndexPath* )indexPath
{
	static NSString* cellStyle1 = @"CellStyle1";
	static NSString* cellStyleItem = @"rssCellStyle";
	
	if ( 0 == indexPath.section )
	{
		UITableViewCell* cell = [ tableView dequeueReusableCellWithIdentifier: cellStyle1 ];
		if ( nil == cell )
		{
			cell = [ [ [ UITableViewCell alloc ] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: cellStyle1 ] autorelease ];
		}

		cell.textLabel.text = [ NSString stringWithFormat: @"Количество - %d", [ _channel.Items count ] ];
		cell.detailTextLabel.text = @"";
		cell.imageView.image = nil;
		cell.accessoryType = UITableViewCellAccessoryNone;
		
		return cell;
	}
	else
	{
		RssItemCell* cell = ( RssItemCell* )[ tableView dequeueReusableCellWithIdentifier: cellStyleItem ];
		
		if ( nil == cell )
		{
			[ [ NSBundle mainBundle ] loadNibNamed: @"RssItemCell" owner: self options: nil ];
			cell = _rssItemCell;
			_rssItemCell = nil;
		}
	
		NSMutableArray* indexitems = [ _index objectForKey: [ _keys objectAtIndex: indexPath.section - 1 ] ];
	
		//RssItem* item = [ _channel.Items objectAtIndex: indexPath.row ];
		RssItem* item = [ indexitems objectAtIndex: indexPath.row ];
		
		// cell.textLabel.text = item.Title;
		cell.Title.text = item.Title;
		// cell.detailTextLabel.text = item.Link;
		cell.Desc.text = [ [ item.Desc stringByStrippingHTML ] substringToIndex: 100 ];

		NSDateFormatter* fmt = [ NSDateFormatter new ];
		[ fmt setDateFormat: @"dd.MM.yyyy" ];

		cell.Date.text = [ fmt stringFromDate: [ NSDate new ] ];

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
				if ( nil != img )
					cell.ImageView.image = [ img scaleToSize: CGSizeMake( 52.0f, 52.0f ) ];
				else
					cell.ImageView.image = [ [ UIImage imageWithColor: [ UIColor whiteColor ] ] scaleToSize: CGSizeMake( 52.0f, 52.0f ) ];
			}
			else
			{
				cell.ImageView.image = [ [ UIImage imageWithColor: [ UIColor whiteColor ] ] scaleToSize: CGSizeMake( 52.0f, 52.0f ) ];
			}
		}
		else
		{
			cell.ImageView.image = [ [ UIImage imageWithColor: [ UIColor whiteColor ] ] scaleToSize: CGSizeMake( 52.0f, 52.0f ) ];
		}
		
		CGRect frame = cell.ImageView.frame;
		frame.size.width = frame.size.height;
		cell.ImageView.frame = frame;
		
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
		return cell;
	}
}

#pragma mark - UITableViewDelegate

-( CGFloat ) tableView: ( UITableView* )tableView heightForRowAtIndexPath: ( NSIndexPath* )indexPath
{
	return 93.0f;
}

-( void ) tableView: ( UITableView* )tableView didSelectRowAtIndexPath: ( NSIndexPath* )indexPath
{
	[ tableView deselectRowAtIndexPath: indexPath animated: YES ];

	RssItemViewController* ctrl = [ [ [ RssItemViewController alloc ] initWithNibName: @"RssItemViewController" bundle: [ NSBundle mainBundle ] ] autorelease ];

	NSMutableArray* indexitems = [ _index objectForKey: [ [ _index allKeys ] objectAtIndex: indexPath.section - 1 ] ];
	
	ctrl.Item = [ indexitems objectAtIndex: indexPath.row ];
	
	[ self.navigationController pushViewController: ctrl animated: YES ];
}

@end

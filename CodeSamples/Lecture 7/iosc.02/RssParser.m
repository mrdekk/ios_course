//
//  RssParser.m
//  iosc.02
//
//  Created by MrDekk on 14/07/14.
//  Copyright (c) 2014 mrdekk. All rights reserved.
//

#import "RssParser.h"

#import "RssItem.h"
#import "RssChannel.h"

static NSString* const kChannelElement = @"channel";
static NSString* const kChannelTitleElement = @"title";
static NSString* const kChannelLinkElement = @"link";
static NSString* const kChannelDescElement = @"description";
static NSString* const kChannelAtomLinkElement = @"atom:link";
static NSString* const kItemElement = @"item";
static NSString* const kItemTitleElement = @"title";
static NSString* const kItemGuidElement = @"guid";
static NSString* const kItemLinkElement = @"link";
static NSString* const kItemAuthorElement = @"dc:creator";
static NSString* const kItemDescElement = @"description";
static NSString* const kItemPubDateElement = @"pubDate";
static NSString* const kCategoryElement = @"category";

typedef enum IWRssFeedParserParsingSteps
{
	kRssParserParsingStepNo = 0,
	
	kRssParserParsingStepChannel,
	kRssParserParsingStepChannelTitle,
	kRssParserParsingStepChannelLink,
	kRssParserParsingStepChannelDesc,
	
	kRssParserParsingStepItem,
	kRssParserParsingStepItemTitle,
	kRssParserParsingStepItemGuid,
	kRssParserParsingStepItemLink,
	kRssParserParsingStepItemAuthor,
	kRssParserParsingStepItemDesc,
	kRssParserParsingStepItemPubDate,
	kRssParserParsingStepItemCategory,
	
	kRssParserParsingStepCategory,
} IRssParserParsingSteps;

@interface RssParser ( ) < NSXMLParserDelegate >

@end

@implementation RssParser
{
	int _currentStep;
		
	NSMutableString* _currentElementString;
	
	NSMutableDictionary* _channelParsingElements;
	NSMutableDictionary* _itemParsingElements;
	NSMutableArray* _itemCategories;
	
	NSMutableArray* _parsedChannels;
	NSMutableArray* _parsedItems;
}

#pragma mark - initiation and deallocation

-( id ) init
{
	self = [ super init ];
	
	if ( nil != self )
	{
		_currentStep = kRssParserParsingStepNo;
		
		_currentElementString = nil;
		
		_channelParsingElements = nil;
		_itemParsingElements = nil;
		_itemCategories = nil;
		
		_parsedChannels = [ [ NSMutableArray alloc ] init ];
		_parsedItems = nil;
	}
	
	return self;
}

-( void ) dealloc
{
	NSLog( @"RssParser dealloc" );

	[ _currentElementString release ];
	
	[ _channelParsingElements release ];
	[ _itemParsingElements release ];
	[ _itemCategories release ];
	
	[ _parsedChannels release ];
	[ _parsedItems release ];
	
	[ super dealloc ];
}

#pragma mark - public routines

-( RSS* ) parseRssFeedFromFile: ( NSString* )filePath
{
	if ( ! [ [ NSFileManager defaultManager ] fileExistsAtPath: filePath ] )
		return [ [ [ RSS alloc] init ] autorelease ];
	
	NSData* fileData = [ NSData dataWithContentsOfFile: filePath ];
	if ( nil == fileData )
		return [ [ [ RSS alloc ] init ] autorelease ];
	
	return [ self parseRssFeedFromData: fileData ];
}

-( RSS* ) parseRssFeedFromData: ( NSData* )data
{
	NSXMLParser* xmlParser = [ [ NSXMLParser alloc ] initWithData: data ];
	[ xmlParser setDelegate: self ];
	
	if ( [ xmlParser parse ] )
	{
		[ xmlParser release ];
		
		RSS* rss = [ [ [ RSS alloc ] init ] autorelease ];
		rss.Channels = [ NSArray arrayWithArray: _parsedChannels ];
		return rss;
	}
	
	[ xmlParser release ];
	return [ [ [ RSS alloc ] init ] autorelease ];
}

#pragma mark - NSXMLParserDelegate

-( void ) parser: ( NSXMLParser* )parser didStartElement:( NSString* )elementName namespaceURI: ( NSString* )namespaceURI qualifiedName: ( NSString* )qName attributes: ( NSDictionary* )attributeDict
{
	switch ( _currentStep )
	{
		case kRssParserParsingStepNo:
			if ( [ elementName isEqualToString: kChannelElement ] )
			{
				_currentStep = kRssParserParsingStepChannel;
				_channelParsingElements = [ [ NSMutableDictionary alloc ] init ];
				_parsedItems = [ [ NSMutableArray alloc ] init ];
			}
			break;
			
		case kRssParserParsingStepChannel:
			if ( [ elementName isEqualToString: kChannelTitleElement ] && nil == [ _channelParsingElements objectForKey: @"title" ] )
			{
				_currentStep = kRssParserParsingStepChannelTitle;
				_currentElementString = [ [ NSMutableString alloc ] init ];
			}
			else if ( [ elementName isEqualToString: kChannelAtomLinkElement ] && nil == [ _channelParsingElements objectForKey: @"atomlink" ] )
			{
				[ _channelParsingElements setObject: [ attributeDict objectForKey: @"href" ] forKey: @"atomlink" ];
			}
			else if ( [ elementName isEqualToString: kChannelLinkElement ] && nil == [ _channelParsingElements objectForKey: @"link" ] )
			{
				_currentStep = kRssParserParsingStepChannelLink;
				_currentElementString = [ [ NSMutableString alloc ] init ];
			}
			else if ( [ elementName isEqualToString: kChannelDescElement ] && nil == [ _channelParsingElements objectForKey: @"desc" ] )
			{
				_currentStep = kRssParserParsingStepChannelDesc;
				_currentElementString = [ [ NSMutableString alloc ] init ];
			}
			else if ( [ elementName isEqualToString: kItemElement ] )
			{
				_currentStep = kRssParserParsingStepItem;
				_itemParsingElements = [ [ NSMutableDictionary alloc ] init ];
				_itemCategories = [ [ NSMutableArray alloc ] init ];
			}
			break;
			
		case kRssParserParsingStepItem:
			if ( [ elementName isEqualToString: kItemTitleElement ] )
			{
				_currentStep = kRssParserParsingStepItemTitle;
				_currentElementString = [ [ NSMutableString alloc ] init ];
			}
			else if ( [ elementName isEqualToString: kItemGuidElement ] )
			{
				_currentStep = kRssParserParsingStepItemGuid;
				_currentElementString = [ [ NSMutableString alloc ] init ];
			}
			else if ( [ elementName isEqualToString: kItemLinkElement ] )
			{
				_currentStep = kRssParserParsingStepItemLink;
				_currentElementString = [ [ NSMutableString alloc ] init ];
			}
			else if ( [ elementName isEqualToString: kItemAuthorElement ] )
			{
				_currentStep = kRssParserParsingStepItemAuthor;
				_currentElementString = [ [ NSMutableString alloc ] init ];
			}
			else if ( [ elementName isEqualToString: kItemDescElement ] )
			{
				_currentStep = kRssParserParsingStepItemDesc;
				_currentElementString = [ [ NSMutableString alloc ] init ];
			}
			else if ( [ elementName isEqualToString: kItemPubDateElement ] )
			{
				_currentStep = kRssParserParsingStepItemPubDate;
				_currentElementString = [ [ NSMutableString alloc ] init ];
			}
			else if ( [ elementName isEqualToString: kCategoryElement ] )
			{
				_currentStep = kRssParserParsingStepItemCategory;
				_currentElementString = [ [ NSMutableString alloc ] init ];
			}
			break;
	}	
}

-( void ) parser: ( NSXMLParser* )parser didEndElement: ( NSString* )elementName namespaceURI: ( NSString* )namespaceURI qualifiedName: ( NSString* )qName
{
	switch ( _currentStep )
	{
		case kRssParserParsingStepItemTitle:
			if ( [ elementName isEqualToString: kItemTitleElement ] )
			{
				[ _itemParsingElements setObject: [ NSString stringWithString: _currentElementString ] forKey: @"title" ];
				[ _currentElementString release ];
				_currentElementString = nil;
				_currentStep = kRssParserParsingStepItem;
			}
			
		case kRssParserParsingStepItemGuid:
			if ( [ elementName isEqualToString: kItemGuidElement ] )
			{
				[ _itemParsingElements setObject: [ NSString stringWithString: _currentElementString ] forKey: @"guid" ];
				[ _currentElementString release ];
				_currentElementString = nil;
				_currentStep = kRssParserParsingStepItem;
			}
			break;
			
		case kRssParserParsingStepItemLink:
			if ( [ elementName isEqualToString: kItemLinkElement ] )
			{
				[ _itemParsingElements setObject: [ NSString stringWithString: _currentElementString ] forKey: @"link" ];
				[ _currentElementString release ];
				_currentElementString = nil;
				_currentStep = kRssParserParsingStepItem;
			}
			break;
			
		case kRssParserParsingStepItemAuthor:
			if ( [ elementName isEqualToString: kItemAuthorElement ] )
			{
				[ _itemParsingElements setObject: [ NSString stringWithString: _currentElementString ] forKey: @"author" ];
				[ _currentElementString release ];
				_currentElementString = nil;
				_currentStep = kRssParserParsingStepItem;
			}
			break;
			
		case kRssParserParsingStepItemDesc:
			if ( [ elementName isEqualToString: kItemDescElement ] )
			{
				[ _itemParsingElements setObject: [ NSString stringWithString: _currentElementString ] forKey: @"desc" ];
				[ _currentElementString release ];
				_currentElementString = nil;
				_currentStep = kRssParserParsingStepItem;
			}
			
		case kRssParserParsingStepItemPubDate:
			if ( [ elementName isEqualToString: kItemPubDateElement ] )
			{
				[ _itemParsingElements setObject: [ NSString stringWithString: _currentElementString ] forKey: @"pubdate" ];
				[ _currentElementString release ];
				_currentElementString = nil;
				_currentStep = kRssParserParsingStepItem;
			}
			break;
			
		case kRssParserParsingStepItemCategory:
			if ( [ elementName isEqualToString: kCategoryElement ] )
			{
				[ _itemCategories addObject: [ NSString stringWithString: _currentElementString ] ];
				[ _currentElementString release ];
				_currentElementString = nil;
				_currentStep = kRssParserParsingStepItem;
			}
			break;
			
		case kRssParserParsingStepItem:
			if ( [ elementName isEqualToString: kItemElement ] )
			{
				NSString* guid = [ _itemParsingElements objectForKey: @"guid" ];
				
				RssItem* item = [ [ [ RssItem alloc ] init ] autorelease ];
				item.Title = [ _itemParsingElements objectForKey: @"title" ];
				item.GUID = guid;
				item.Link = [ _itemParsingElements objectForKey: @"link" ];
				item.Desc = [ _itemParsingElements objectForKey: @"desc" ];
								
				NSDateFormatter* fmt = [ [ [ NSDateFormatter alloc ] init ] autorelease ];
				[ fmt setDateFormat: @"EEE, dd MMM yyyy HH:mm:ss ZZZZ" ];
				[ fmt setLocale: [ [ [ NSLocale alloc ] initWithLocaleIdentifier: @"en_US" ] autorelease ] ];
				
				item.PubDate = [ fmt dateFromString: [ _itemParsingElements objectForKey: @"pubdate" ] ];
				item.Categories = [ NSArray arrayWithArray: _itemCategories ];

				[ _parsedItems addObject: item ];
				
				[ _itemParsingElements release ];
				_itemParsingElements = nil;
				
				[ _itemCategories release ];
				_itemCategories = nil;
				
				_currentStep = kRssParserParsingStepChannel;
			}
			break;
			
		case kRssParserParsingStepChannelTitle:
			if ( [ elementName isEqualToString: kChannelTitleElement ] )
			{
				[ _channelParsingElements setObject: [ NSString stringWithString: _currentElementString ] forKey: @"title" ];
				[ _currentElementString release ];
				_currentElementString = nil;
				_currentStep = kRssParserParsingStepChannel;
			}
			break;
			
		case kRssParserParsingStepChannelLink:
			if ( [ elementName isEqualToString: kChannelLinkElement ] )
			{
				[ _channelParsingElements setObject: [ NSString stringWithString: _currentElementString ] forKey: @"link" ];
				[ _currentElementString release ];
				_currentElementString = nil;
				_currentStep = kRssParserParsingStepChannel;
			}
			break;
			
		case kRssParserParsingStepChannelDesc:
			if ( [ elementName isEqualToString: kChannelDescElement ] )
			{
				[ _channelParsingElements setObject: [ NSString stringWithString: _currentElementString ] forKey: @"desc" ];
				[ _currentElementString release ];
				_currentElementString = nil;
				_currentStep = kRssParserParsingStepChannel;
			}
			break;

		case kRssParserParsingStepChannel:
			if ( [ elementName isEqualToString: kChannelElement ] )
			{
				// NSString* atomLink = [ _channelParsingElements objectForKey: @"atomlink" ];
				
				RssChannel* channel = [ [ [ RssChannel alloc ] init ] autorelease ];
				channel.Title = [ _channelParsingElements objectForKey: @"title" ];
				channel.Link = [ _channelParsingElements objectForKey: @"link" ];
				channel.Desc = [ _channelParsingElements objectForKey: @"desc" ];
				channel.Items = [ NSArray arrayWithArray: _parsedItems ];
				
				[ _parsedChannels addObject: channel ];
				
				[ _parsedItems release ];
				_parsedItems = nil;
				
				[ _channelParsingElements release ];
				_channelParsingElements = nil;
			}
			break;

		case kRssParserParsingStepNo:
			break;
	}
}

-( void ) parser: ( NSXMLParser* )parser foundCharacters: ( NSString* )string
{
	if ( nil != _currentElementString )
	{
		[ _currentElementString appendString: string ];
	}
}


@end

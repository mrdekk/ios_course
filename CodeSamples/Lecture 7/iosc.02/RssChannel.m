//
//  RssChannel.m
//  iosc.02
//
//  Created by MrDekk on 10/07/14.
//  Copyright (c) 2014 mrdekk. All rights reserved.
//

#import "RssItem.h"
#import "RssChannel.h"

@implementation RssChannel
{
	NSString* _title;
	NSString* _link;
	NSString* _desc;
	NSArray* _items;
}

@synthesize Title = _title;
@synthesize Link = _link;
@synthesize Desc = _desc;
@synthesize Items = _items;

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
	[ _link release ];
	[ _desc release ];
	[ _items release ];

	[ super dealloc ];
}

-( NSString* ) description
{
	NSMutableString* str = [ NSMutableString string ];
	
	[ str appendFormat: @"\tTitle: %@\n", _title ];
	[ str appendFormat: @"\tLink: %@\n", _link ];
	[ str appendFormat: @"\tDesc: %@\n", _desc ];
	[ str appendFormat: @"\tItems:\n" ];
	
	for ( RssItem* item in _items )
	{
		[ str appendFormat: @"%@\n", [ item description ] ];
	}
	
	return [ NSString stringWithString: str ];
}

#pragma mark - public routines

+( RssChannel* ) sampleChannel
{
	RssChannel* ch = [ [ [ RssChannel alloc] init ] autorelease ];
	
	ch.Title = @"it works!";
	ch.Link = @"http://itw66.ru";
	ch.Desc = @"it works! / RSS channel";

	NSDateFormatter* fmt = [ [ [ NSDateFormatter alloc ] init ] autorelease ];
	[ fmt setDateFormat: @"EEE, dd MMM yyyy HH:mm:ss z" ];
	
	RssItem* item = [ [ [ RssItem alloc ] init ] autorelease ];
	item.Title = @"Персональный батискаф";
	item.GUID = @"http://itw66.ru/blog/interesting_things/743.html";
	item.Link = @"http://itw66.ru/blog/interesting_things/743.html";
	item.Desc = @"<img src=\"http://itw66.ru/uploads/images/00/00/01/2014/07/03/7b7a39.jpg\"/><br/><br/>Жак=Ив Кусто, один из создателей акваланга, является одним из самых известных исследователей морей и океанов. Всем хорошо известна «Подводная одиссея команды Кусто». Кроме того, один из его первых цветных подводных фильмов был удостоен Пальмовой Ветви в Каннах в 1956 году. Кусто успел повидать и поведать нам о многом, но несмотря на это морское дно хранит еще много тайн о жизни на Земле. <br/><br/>С начала исследований морского дна и во многом благодаря им были сделаны существенные технологические и экологические открытия. Совсем недавно, в 2010 году, в своей речи на событии Mission Blue, организованном TED, океанограф Эдит Виддер (Edith Widder) говорила об исследовании водной части Земли и заметила, что в исследование морских глубин денег вкладывается гораздо меньше, чем например в исследовании  космоса, хотя на данный момент всего около 5% океанов исследовано человеком. Она также заметила, что исследования — это сила, которая движет инновациями.<br/><br/>Ее призыв услышал дизайнер Эдуардо Гальвани (Eduardo Galvani), который предложил проект персонального батискафа — Manatee, для создания возможности персонального изучения морских глубин.<br/><br/><br><a href=\"http://itw66.ru/blog/interesting_things/743.html#cut\" title=\"Читать дальше\">подробности...</a>";
	item.PubDate = [ fmt dateFromString: @"Thu, 03 Jul 2014 12:56:57 +0400" ];
	item.Categories = [ NSArray arrayWithObjects: @"батискаф", @"персональный", @"manatee", @"Eduardo Galvani", nil ];

	RssItem* item2 = [ [ [ RssItem alloc ] init ] autorelease ];
	item2.Title = @"Новый взгляд на ветряную турбину!";
	item2.GUID = @"http://itw66.ru/blog/alternative_energy/742.html";
	item2.Link = @"http://itw66.ru/blog/alternative_energy/742.html";
	item2.Desc = @"img src=\"http://itw66.ru/uploads/images/00/00/01/2014/06/23/2f7842.jpg\"/><br/><br/>Все мы уже привыкли к традиционным формам ветряков, которые конструкцию свою получили от достаточно древних ветряных мельниц. У них есть как свои плюсы, так и свои минусы. Специалисты из компании Solar Wind Energy Inc. задумались над тем, как решить проблему отсутствия ветра, а заодно и повышения КПД устройства. В итоге они изобрели Solar Wind Downdraft Tower, башню, которая для генерации электричества может создавать свой собственный ветер. Как это может работать? Читайте далее…<br/><br/><br><a href=\"http://itw66.ru/blog/alternative_energy/742.html#cut\" title=\"Читать дальше\">а вот как...</a>";
	item2.PubDate = [ fmt dateFromString: @"Mon, 23 Jun 2014 21:45:20 +0400" ];
	item2.Categories = [ NSArray arrayWithObjects: @"Solar Wind Energy Inc", @"Downdraft Tower", @"башня-ветряк", nil ];
	
	ch.Items = [ NSArray arrayWithObjects: item, item2, nil ];
	
	return ch;
}


@end

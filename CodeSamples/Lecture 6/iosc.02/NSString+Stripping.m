//
//  NSString+Stripping.m
//  iosc.02
//
//  Created by MrDekk on 10/08/14.
//  Copyright (c) 2014 mrdekk. All rights reserved.
//

#import "NSString+Stripping.h"

@implementation NSString ( Stripping )

-( NSString* ) stringByStrippingHTML
{
	NSRange r;
	NSString* s = [ [ self copy ] autorelease ];
	while ( ( r = [ s rangeOfString: @"<[^>]+>" options: NSRegularExpressionSearch ] ).location != NSNotFound )
		s = [ s stringByReplacingCharactersInRange:r withString: @"" ];
	return s;
}

@end

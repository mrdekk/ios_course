//
//  UIImage+Colored.m
//  iosc.02
//
//  Created by MrDekk on 20/07/14.
//  Copyright (c) 2014 mrdekk. All rights reserved.
//

#import "UIImage+Colored.h"

@implementation UIImage ( Colored )

+( UIImage* ) imageWithColor: ( UIColor* )color
{
	CGRect rect = CGRectMake( 0, 0, 1, 1 );

	UIGraphicsBeginImageContextWithOptions( rect.size, NO, 0 );
	[ color setFill ];
	UIRectFill( rect );
	UIImage* image = UIGraphicsGetImageFromCurrentImageContext( );
	UIGraphicsEndImageContext( );
    
	return image;
}

@end

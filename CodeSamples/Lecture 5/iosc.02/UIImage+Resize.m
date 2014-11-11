//
//  UIImage+Resize.m
//  iosc.02
//
//  Created by MrDekk on 20/07/14.
//  Copyright (c) 2014 mrdekk. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage ( Resize )

-( UIImage* ) scaleToSize: ( CGSize )size
{
	UIGraphicsBeginImageContext( size );

	CGContextRef context = UIGraphicsGetCurrentContext( );
	CGContextTranslateCTM( context, 0.0, size.height );
	CGContextScaleCTM( context, 1.0, -1.0 );

	CGContextDrawImage( context, CGRectMake( 0.0f, 0.0f, size.width, size.height ), self.CGImage );

	UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext( );

	UIGraphicsEndImageContext( );

	return scaledImage;
}

@end

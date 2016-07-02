//
//  GeoffAssetLoader.m
//  GeoffIOSApp
//
//  Created by Simon Morris on 02/07/2016.
//  Copyright © 2016 MoJaWorks. All rights reserved.
//

#import <GeoffAssetLoader.h>

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

void geoff_load_texture( geoff::renderer::Texture texture )
{
    UIImage* image = [UIImage imageNamed:@"assets.bundle/test/bug.png"];
    CGImageRef cg_image = [image CGImage];
    CGColorSpaceRef rgb_color = CGColorSpaceCreateDeviceRGB();
    
    texture->width = Int(image.size.width);
    texture->height = Int(image.size.height);
    texture->pixels = haxe::io::Bytes_obj::alloc( 4 * texture->width * texture->height );
    
    CGContextRef ctx = CGBitmapContextCreate((void*)&(texture->pixels->b[0]), (int)image.size.width, (int)image.size.height, 8, ((int)image.size.width) * 4, rgb_color, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrderDefault );
    CGContextDrawImage( ctx, CGRectMake( 0, 0, texture->width, texture->height ), cg_image );
    CGContextRelease( ctx );

}

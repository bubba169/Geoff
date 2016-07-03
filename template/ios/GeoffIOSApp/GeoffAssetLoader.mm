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

void geoff_load_texture( geoff::renderer::Texture texture, haxe::io::Bytes bytes )
{
    NSData* data = [NSData dataWithBytes:(void*)&(bytes->b[0]) length:bytes->length];
    UIImage* image = [UIImage imageWithData: data];
    CGImageRef cg_image = [image CGImage];
    CGColorSpaceRef rgb_color = CGColorSpaceCreateDeviceRGB();
    
    texture->width = Int(image.size.width);
    texture->height = Int(image.size.height);
    texture->pixels = haxe::io::Bytes_obj::alloc( 4 * texture->width * texture->height );
    
    CGContextRef ctx = CGBitmapContextCreate((void*)&(texture->pixels->b[0]), (int)image.size.width, (int)image.size.height, 8, ((int)image.size.width) * 4, rgb_color, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrderDefault );
    CGContextDrawImage( ctx, CGRectMake( 0, 0, texture->width, texture->height ), cg_image );
    CGContextRelease( ctx );
}


String geoff_load_text( String path )
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource: [NSString stringWithUTF8String: path.__CStr()] ofType:nil ];
    NSString* str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    return String([str UTF8String]);
}


haxe::io::Bytes geoff_load_bytes( String path )
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource: [NSString stringWithUTF8String: path.__CStr()] ofType:nil ];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    
    haxe::io::Bytes bytes = haxe::io::Bytes_obj::alloc( (int)data.length );
    memcpy((void*)&(bytes->b[0]), [data bytes], data.length );
    
    return bytes;
}


bool geoff_asset_exists( ::String path )
{
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource: [NSString stringWithUTF8String: path.__CStr()] ofType:nil ];
    return filePath != nil;
}

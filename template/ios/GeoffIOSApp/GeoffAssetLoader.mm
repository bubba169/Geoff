//
//  GeoffAssetLoader.m
//  GeoffIOSApp
//
//  Created by Simon Morris on 02/07/2016.
//  Copyright © 2016 MoJaWorks. All rights reserved.
//

#import <GeoffAssetLoader.h>

void geoff_load_texture( geoff::renderer::Texture )
{
    UIImage* image = [UIImage imageNamed:@"assets.bundle/test/bug.png"];
    NSLog(@"%f, %f", image.size.width, image.size.height );
}

//
//  GeoffAssetLoader.h
//  GeoffIOSApp
//
//  Created by Simon Morris on 02/07/2016.
//  Copyright © 2016 MoJaWorks. All rights reserved.
//

#ifndef GeoffAssetLoader_h
#define GeoffAssetLoader_h

#import <haxe/io/Bytes.h>
#import <geoff/renderer/Texture.h>

void geoff_load_texture( geoff::renderer::Texture texture, haxe::io::Bytes bytes );
::String geoff_load_text( ::String path );
haxe::io::Bytes geoff_load_bytes( ::String path );
bool geoff_asset_exists( ::String path );


#endif /* GeoffAssetLoader_h */

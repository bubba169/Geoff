//
//  UIView_OpenGLView.h
//  GeoffIOSApp
//
//  Created by Simon Morris on 15/06/2016.
//  Copyright © 2016 MoJaWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface OpenGLView : UIView {

CAEAGLLayer* _eaglLayer;
EAGLContext* _context;
GLuint _colorRenderBuffer;
    
}

@end

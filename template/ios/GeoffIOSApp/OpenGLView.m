//
//  OpenGLView.m
//  GeoffIOSApp
//
//  Created by Simon Morris on 15/06/2016.
//  Copyright © 2016 MoJaWorks. All rights reserved.
//

#import "OpenGLView.h"

@implementation OpenGLView

+ (Class)layerClass
{
    return [CAEAGLLayer class];
}

-(void)setupLayer
{
    _eaglLayer = (CAEAGLLayer*)self.layer;
    _eaglLayer.opaque = YES;
}

-(void)setupContext
{
    EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
    _context = [[EAGLContext alloc] initWithAPI:api];
    if ( !_context )
    {
        NSLog(@"Failed to init OpenGL2.0 Context");
        exit(1);
    }
    
    if ( ![EAGLContext setCurrentContext:_context] )
    {
        NSLog(@"Failed to set current context");
        exit(1);
    }
}

-(void)setupRenderBuffer
{
    glGenRenderbuffers(1, &_colorRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eaglLayer];
}

-(void)setupFrameBuffer
{
    GLuint framebuffer;
    glGenFramebuffers(1, &framebuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, framebuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _colorRenderBuffer);
}

-(void)render
{
    glClearColor(0, 104/255.0, 55/255.0, 1 );
    glClear( GL_COLOR_BUFFER_BIT );
    [_context presentRenderbuffer:GL_RENDERBUFFER];
    
    NSLog(@"Render");
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self )
    {
        [self setupLayer];
        [self setupContext];
        [self setupRenderBuffer];
        [self setupFrameBuffer];
        [self render];
    }
    
    NSLog(@"Initing with Frame");
    
    return self;
}

@end

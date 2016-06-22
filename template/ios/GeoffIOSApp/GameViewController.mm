//
//  GameViewController.m
//  GeoffIOSApp
//
//  Created by Simon Morris on 17/06/2016.
//  Copyright © 2016 MoJaWorks. All rights reserved.
//

#import "GameViewController.h"

extern "C" const char *hxRunLibrary();
extern "C" void hxcpp_set_top_of_stack();

#define BUFFER_OFFSET(i) ((char *)NULL + (i))

@interface GameViewController () {
    geoff::App _app;
}

@property (strong, nonatomic) EAGLContext *context;

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(deviceOrientationDidChangeNotification:)
     name:UIDeviceOrientationDidChangeNotification
     object:nil];

    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [EAGLContext setCurrentContext:self.context];
    
    hxcpp_set_top_of_stack();
    hxRunLibrary();
    
    _app = geoff::App_obj::current;
    _app->init();
    
    Array< int > array = Array_obj< int >::__new();
    array->push(self.view.frame.size.width);
    array->push(self.view.frame.size.height);
    _app->platform->eventManager->sendEventInt( ::String("Resize"), array );
}

- (void)dealloc
{
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
    
    _app->destroy();
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    if ([self isViewLoaded] && ([[self view] window] == nil)) {
        self.view = nil;
        
        if ([EAGLContext currentContext] == self.context) {
            [EAGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }

    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


#pragma mark - GLKView and GLKViewController delegate methods

- (void)update
{

}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [EAGLContext setCurrentContext:self.context];
    _app->update();
}

- (void)deviceOrientationDidChangeNotification:(NSNotification*)note
{
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    
    Array< int > array = Array_obj< int >::__new();
    array->push(self.view.frame.size.width * screenScale);
    array->push(self.view.frame.size.height * screenScale);
    _app->platform->eventManager->sendEventInt( ::String("Resize"), array );
}

@end

//
//  AppDelegate.h
//  GeoffIOSApp
//
//  Created by Simon Morris on 15/06/2016.
//  Copyright © 2016 MoJaWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpenGLView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    OpenGLView* _glView;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) IBOutlet OpenGLView* glView;

@end


//
//  TestObjcGeneratorAppDelegate.h
//  TestObjcGenerator
//
//  Created by Juan Cruz Ghigliani on 09/04/11.
//  Copyright 2011 Juan Cruz Ghigliani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Main.h"

@interface TestObjcGeneratorAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	Main * main;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) Main * main;
@end


//
//  _Main.m
//  
//
//  Created by  on .
//  Copyright 2011 . All rights reserved.
//

#import  "_Main.h"

@implementation _Main

@synthesize uiview1;
@synthesize lblMainViewTitle;
@synthesize btnOpenSecondView;


- (id)initWithNibName:(NSString *)nibNameOrNil
bundle:(NSBundle *)nibBundleOrNil {
if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
[lblMainViewTitle setText:NSLocalizedString(@"This is the Main View",@"This is the Main View")];
[btnOpenSecondView setTitle:NSLocalizedString(@"Tap to open th Second view",@"Tap to open th Second view") forState:UIControlStateNormal];


}
return self;
}


- (void)dealloc {
self.uiview1 = nil;
self.lblMainViewTitle = nil;
self.btnOpenSecondView = nil;

[super dealloc];
}

@end

//
//  _TestViewController.m
//  exampleProject
//
//  Created by JuanCruzGhigliani on 02/04/11.
//  Copyright 2011 MyCompany. All rights reserved.
//

#import  "_TestViewController.h"

@implementation _TestViewController

@synthesize File's Owner;
@synthesize uiview1;
@synthesize btnMainAction;
@synthesize lblOutput;
@synthesize tfInput;
@synthesize proxyobject-2;


- (id)initWithNibName:(NSString *)nibNameOrNil
bundle:(NSBundle *)nibBundleOrNil {
if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {

}
return self;
}


- (void)dealloc {
self.File's Owner = nil;
self.uiview1 = nil;
self.btnMainAction = nil;
self.lblOutput = nil;
self.tfInput = nil;
self.proxyobject-2 = nil;

[super dealloc];
}

@end

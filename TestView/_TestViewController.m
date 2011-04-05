//
//  _TestViewController.m
//  exampleProject
//
//  Created by JuanCruzGhigliani on 02/04/11.
//  Copyright 2011 MyCompany. All rights reserved.
//

#import  "_TestViewController.h"

@implementation _TestViewController

@synthesize uiview1;
@synthesize btnMainAction;
@synthesize lblOutput;
@synthesize tfInput;


- (id)initWithNibName:(NSString *)nibNameOrNil
bundle:(NSBundle *)nibBundleOrNil {
if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {

}
return self;
}


- (void)dealloc {
self.uiview1 = nil;
self.btnMainAction = nil;
self.lblOutput = nil;
self.tfInput = nil;

[super dealloc];
}

@end

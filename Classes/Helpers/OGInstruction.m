//
//  OGInstruction.m
//  objc-generator
//
//  Created by Juan Cruz Ghigliani on 06/04/11.
//  Copyright 2011 Juan Cruz Ghigliani. All rights reserved.
//

#import "OGInstruction.h"


@implementation OGInstruction
@synthesize localized;
@synthesize instruction;

+(OGInstruction *)initWithString:(NSString *)_string{
	OGInstruction * aux = [[OGInstruction alloc]init];
	aux.instruction = _string;
	aux.localized = FALSE;
	return [aux autorelease];
}

+(OGInstruction *)initWithStringLocalized:(NSString *)_string{
	OGInstruction * aux = [[OGInstruction alloc]init];
	aux.instruction = _string;
	aux.localized = TRUE;
	return [aux autorelease];
}
- (void) dealloc
{
	self.instruction = nil;
	[super dealloc];
}


@end

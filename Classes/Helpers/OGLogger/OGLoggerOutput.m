//
//  OGLoggerOutput.m
//  objc-generator
//
//  Created by Juan Cruz Ghigliani on 19/04/11.
//  Copyright 2011 Juan Cruz Ghigliani. All rights reserved.
//

#import "OGLoggerOutput.h"


@implementation OGLoggerOutput

- (id)init
{
	if ([[self class] isEqualTo:[OGLoggerOutput class]]) { 
		[NSException raise:@"Abstract Class Exception" format:@"Error, attempting to instantiate OGLoggerOutput (Abstract)? directly."];
		[self release]; 
		return nil; 
	}
	if (self = [super init]) {
		return self;
	}
	return nil;
}

-(void)write:(NSString *)_msg{
	[self doesNotRecognizeSelector:_cmd];
}



@end

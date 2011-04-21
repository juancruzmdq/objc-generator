//
//  OGLoggerOutputConsole.m
//  objc-generator
//
//  Created by Juan Cruz Ghigliani on 19/04/11.
//  Copyright 2011 Juan Cruz Ghigliani. All rights reserved.
//

#import "OGLoggerOutputConsole.h"


@implementation OGLoggerOutputConsole

-(void)write:(NSString *)_msg{
	printf("%s - %s\n",[[NSString stringWithFormat:@"%@",[NSDate date] ]  UTF8String],[_msg UTF8String]);
}

@end

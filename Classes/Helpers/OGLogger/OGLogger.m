//
//  OGLogger.m
//  objc-generator
//
//  Created by Juan Cruz Ghigliani on 19/04/11.
//  Copyright 2011 Juan Cruz Ghigliani. All rights reserved.
//

#import "OGLogger.h"


@implementation OGLogger
@synthesize context;
@synthesize level;
@synthesize output;


#pragma mark -
#pragma mark Life cycle

-(id)init{
	if (self = [super init]) {
		level = OGLogLevelError;
		context = @"EMPTY";
		output = [[OGLoggerOutputConsole alloc]init];
		return self;
	}
	return nil;
}

-(id)initInContext:(NSString *)_context{
	if (self = [super init]) {
		level = OGLogLevelError;
		context = _context;
		output = [[OGLoggerOutputConsole alloc]init];
		return self;
	}
	return nil;
}

-(id)initInContext:(NSString *)_context withLogLevel:(OGLogLevel)_logLevel{
	if (self = [super init]) {
		level = _logLevel;
		context = _context;
		output = [[OGLoggerOutputConsole alloc]init];
		return self;
	}
	return nil;
}

-(id)initInContext:(NSString *)_context withLogLevel:(OGLogLevel)_logLevel andOutput:(OGLoggerOutput *)_output{
	if (self = [super init]) {
		level = _logLevel;
		context = _context;
		output = _output;
		return self;
	}
	return nil;
}

- (void) dealloc
{
	self.context = nil;
	self.output = nil;
	[super dealloc];
}


#pragma mark -
#pragma mark Error Log

-(void)error:(NSString *)_msg{
	if (level >= OGLogLevelError) {
		[output write:[NSString stringWithFormat:@"[%@] %@ - %@",context,@"ERROR",_msg ]];
	}
}

- (void)errorWithFormat:(NSString *)messageFormat, ... {
	if (level >= OGLogLevelError) {
		va_list args;
		va_start(args, messageFormat);
		NSString *s = [[NSString alloc] initWithFormat:messageFormat arguments:args];
		[self error:s];
		[s release];
	}
}

#pragma mark -
#pragma mark Warning Log

-(void)warning:(NSString *)_msg{
	if (level >= OGLogLevelWarning) {
		[output write:[NSString stringWithFormat:@"[%@] %@ - %@",context,@"WARNING",_msg ]];
		
	}
}

- (void)warningWithFormat:(NSString *)messageFormat, ... {
	if (level >= OGLogLevelWarning) {
		va_list args;
		va_start(args, messageFormat);
		NSString *s = [[NSString alloc] initWithFormat:messageFormat arguments:args];
		[self warning:s];
		[s release];
	}
}

#pragma mark -
#pragma mark Info Log


-(void)info:(NSString *)_msg{
	if (level >= OGLogLevelInfo) {
		[output write:[NSString stringWithFormat:@"[%@] %@ - %@",context,@"INFO",_msg ]];
	}
}

- (void)infoWithFormat:(NSString *)messageFormat, ... {
	if (level >= OGLogLevelInfo) {
		va_list args;
		va_start(args, messageFormat);
		NSString *s = [[NSString alloc] initWithFormat:messageFormat arguments:args];
		[self info:s];
		[s release];
	}
}

#pragma mark -
#pragma mark Debug Log


-(void)debug:(NSString *)_msg{	
	if (level >= OGLogLevelDebug) {
		[output write:[NSString stringWithFormat:@"[%@] %@ - %@",context,@"DEBUG",_msg ]];
	}
}

- (void)debugWithFormat:(NSString *)messageFormat, ... {
	if (level >= OGLogLevelDebug) {
		va_list args;
		va_start(args, messageFormat);
		NSString *s = [[NSString alloc] initWithFormat:messageFormat arguments:args];
		[self debug:s];
		[s release];
	}
}

@end

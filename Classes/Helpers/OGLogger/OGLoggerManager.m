//
//  OGLoggerManager.m
//  objc-generator
//
//  Created by Juan Cruz Ghigliani on 20/04/11.
//  Copyright 2011 Juan Cruz Ghigliani. All rights reserved.
//

#import "OGLoggerManager.h"

static OGLoggerManager * _sharedInstance = nil;
static OGLogger * _sharedConsoleLogger = nil;

@implementation OGLoggerManager


+(OGLoggerManager*)sharedInstance
{
    @synchronized([OGLoggerManager class])
    {
		if (!_sharedInstance)
			//if the instance doesn,t exist create it
			[[[self alloc] init]autorelease];
		
		return _sharedInstance;
    }
	
	return nil;
	
}


+(id)alloc
{
    @synchronized([OGLoggerManager class])
    {
		//check if the instance already exist
		NSAssert(_sharedInstance == nil, @"Attempted to allocate a second instance of a singleton.");
		//create the instance and save the reference in the static attribute
		_sharedInstance = [super alloc];
		return _sharedInstance;
    }
    return nil;
}

-(id)copy {
    //avoid the copy of the instance
    return self;
}

-(id)retain {
    return self;
}

-(NSUInteger)retainCount {
    return UINT_MAX;  //denotes an object that cannot be release
}


+(OGLogger*)console{

	if (!_sharedConsoleLogger)
		//if the instance doesn,t exist create it
		_sharedConsoleLogger = [[OGLogger alloc] init];
	
	return _sharedConsoleLogger;


}

@end

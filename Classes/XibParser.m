//
//  XibParser.m
//  objc-generator
//
//  Created by Juan Cruz Ghigliani on 04/04/11.
//  Copyright 2011 Juan Cruz Ghigliani. All rights reserved.
//

#import "XibParser.h"
#import "Processor.h"
#import "NSString+Nib2ObjcExtensions.h"

@interface XibParser ()

- (void)getDictionaryFromXIB;
- (NSDictionary *)parseChildren:(NSDictionary *)dict ofCurrentView:(int)currentView withObjects:(NSDictionary *)nibObjects;
- (NSDictionary *)parseObject:(NSDictionary *)object withHierarchy:(NSDictionary *)hierarchy;
- (NSDictionary *)inputAsDictionary;

@end




@implementation XibParser

@dynamic filename;
@synthesize dictionary = _dictionary;


- (id)init
{
    if (self = [super init])
    {

    }
    return self;
}

- (void)dealloc
{
    [_filename release];
    [_dictionary release];
    [_data release];
	[_mainStructure release];
	[_objects release];
    [super dealloc];
}

#pragma mark -
#pragma mark Properties

- (NSString *)filename
{
    return _filename;
}

- (void)setFilename:(NSString *)newFilename
{
    [_filename release];
    _filename = nil;
    _filename = [newFilename copy];
    [self getDictionaryFromXIB];
}

- (NSDictionary *)inputAsDictionary
{
    NSString *errorStr = nil;
    NSPropertyListFormat format;
    NSDictionary *propertyList = [NSPropertyListSerialization propertyListFromData:_data
                                                                  mutabilityOption:NSPropertyListImmutable
                                                                            format:&format
                                                                  errorDescription:&errorStr];
    [errorStr release];
    return propertyList;    
}

#pragma mark -
#pragma mark Private methods

- (void)getDictionaryFromXIB
{
    NSArray *arguments = [NSArray arrayWithObjects:_filename, @"--objects", @"--hierarchy", nil];//, @"--connections", @"--classes"
    NSTask *task = [[NSTask alloc] init];
    NSPipe *pipe = [NSPipe pipe];
    NSFileHandle *readHandle = [pipe fileHandleForReading];
    NSData *temp = nil;
	
    [_data release];
    _data = [[NSMutableData alloc] init];
    
    [task setLaunchPath:@"/usr/bin/ibtool"];
    [task setArguments:arguments];
    [task setStandardOutput:pipe];
    [task launch];
    
    while ((temp = [readHandle availableData]) && [temp length]) 
    {
        [_data appendData:temp];
    }
	
    // Dictionary with result of ibtool
	[_dictionary release];
    _dictionary = [[self inputAsDictionary] mutableCopy];
    
    [task release];
}

- (void)process
{
    //    NSDictionary *xibClasses = [_dictionary objectForKey:@"com.apple.ibtool.document.classes"];
    //    NSDictionary *xibConnections = [_dictionary objectForKey:@"com.apple.ibtool.document.connections"];
    NSDictionary *xibObjects = [_dictionary objectForKey:@"com.apple.ibtool.document.objects"];
    NSArray *xibHierarchy = [_dictionary objectForKey:@"com.apple.ibtool.document.hierarchy"];
	
	[_mainStructure release];
	_mainStructure = [[NSMutableDictionary alloc] init];
	
	[_objects release];
	_objects = [[NSMutableDictionary alloc] init];	
	
	for (NSDictionary *item in xibHierarchy)
    {
		NSLog(@"Main Loop Item");
        int currentView = [[item objectForKey:@"object-id"] intValue];
        [_mainStructure setObject:[self parseChildren:item ofCurrentView:currentView withObjects:xibObjects] 
							   forKey:[NSString stringWithFormat:@"%i",currentView] ];
    }
	
	
	[_dictionary setObject:_mainStructure forKey:@"com.objc-generator.structure"];
	[_dictionary setObject:_objects forKey:@"com.objc-generator.objects"];

	
}

- (NSDictionary *)parseChildren:(NSDictionary *)dict ofCurrentView:(int)currentView withObjects:(NSDictionary *)nibObjects
{
	
	NSMutableDictionary * resultDict = [[NSMutableDictionary alloc] init];
	
	//parseo la vista actual "dict"
	id currentViewObject = [nibObjects objectForKey:[NSString stringWithFormat:@"%i",currentView]];
	
	NSMutableDictionary * auxHierarchy = [dict mutableCopy];
	[auxHierarchy removeObjectForKey:@"children"];
	
	[resultDict setObject:[NSNumber numberWithInt:currentView] forKey:@"object-id"];
	[resultDict setObject:auxHierarchy forKey:@"hierarchy"];
	[resultDict setObject:currentViewObject forKey:@"object"];
	
	[auxHierarchy release];
	
	NSLog(@"Pre-Parse Object");
	[resultDict setObject:[self parseObject:currentViewObject withHierarchy:dict] 
				   forKey:@"parsedObject"];
	NSLog(@"Post-Parse Object");
	
	NSMutableDictionary * childrens = [[NSMutableDictionary alloc]init];
    NSArray *children = [dict objectForKey:@"children"];
    if (children != nil)
    {
        for (NSDictionary *subitem in children)
        {
			NSLog(@"Recursive Loop Item");
			//continuo recursivo con los hijos	
            [childrens setObject:[self parseChildren:subitem ofCurrentView:[[subitem objectForKey:@"object-id"] intValue] withObjects:nibObjects]
						  forKey:[subitem objectForKey:@"object-id"]];
        }
    }
	
	
	[resultDict setObject:childrens forKey:@"childrens"];
	
	return [resultDict autorelease];
}




-(NSDictionary *)parseObject:(NSDictionary *)object withHierarchy:(NSDictionary *)hierarchy{
	NSString *klass = [object objectForKey:@"class"];
	Processor *processor = [Processor processorForClass:klass];
	NSMutableDictionary *dict = nil;

	if (processor == nil){
		dict = [[NSMutableDictionary alloc] init];
#ifdef NDEBUG
		NSLog(@"Parsing Debug Class Object");
		[dict setObject:klass forKey:@"// unknown class"];
		[_objects setObject:dict forKey:[hierarchy objectForKey:@"object-id"]];
#endif
	}else{
		NSLog(@"Parsing Class Object");
		dict = [[processor processObject:object] retain];
		[_objects setObject:dict forKey:[hierarchy objectForKey:@"object-id"]];
	}

    return [dict autorelease];
}



@end

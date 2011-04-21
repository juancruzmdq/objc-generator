//
//  objcGeneratorApp.h
//  objc-generator
//
//  Created by Juan Cruz Ghigliani on 18/04/11.
//  Copyright 2011 Juan Cruz Ghigliani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDCommandLineInterface.h"


#define CURRENT_MARKETING_VERSION  @"1.0"

@interface objcGeneratorApp : NSObject <DDCliApplicationDelegate>
{
    BOOL _setters;
	BOOL _xibConstructor;
	BOOL _localized;
    BOOL _version;
	BOOL _help;
	NSString * _verbose;
	NSString * _className;
	NSString * _projectName;
	NSString * _createBy;
	NSString * _createDate;
	NSString * _companyName;
	NSString * _inheritClass;
	NSString * _projectDefinition;
	NSString * _destination;
	
}
- (void) printVersion;
- (void) printHelp;
- (void) printUsage: (FILE *) stream;

@end

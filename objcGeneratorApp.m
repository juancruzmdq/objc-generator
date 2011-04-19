//
//  objcGeneratorApp.m
//  objc-generator
//
//  Created by Juan Cruz Ghigliani on 18/04/11.
//  Copyright 2011 Juan Cruz Ghigliani. All rights reserved.
//

#import "objcGeneratorApp.h"
#include "XibParser.h"
#include "CodeGenerator.h"
#include "FilesGenerator.h"
#include "ProjectDefinitionParser.h"

@implementation objcGeneratorApp

- (id) init;
{
    self = [super init];
    if (self == nil)
        return nil;
    
	_setters = TRUE;
	_xibConstructor = TRUE;
	_localized = TRUE;
	_verbosity = 0;
	_version = FALSE;
	_help = FALSE;
	_className = @"";
	_projectName = @"";
	_createBy = @"";
	_createDate = @"";
	_companyName = @"";
	_inheritClass = @"";
	_projectDefinition = @"";
	_destination = @"";
	
    
    return self;
}







- (void) application: (DDCliApplication *) app
    willParseOptions: (DDGetoptLongParser *) optionsParser;
{
    [optionsParser setGetoptLongOnly: YES];
    DDGetoptOption optionTable[] = 
    {
        // Long					Short   Argument options
        {@"version",			'v',    DDGetoptNoArgument},
        {@"help",				'h',    DDGetoptNoArgument},
        {@"setters",			's',    DDGetoptNoArgument},
        {@"xib-constructor",	'x',    DDGetoptNoArgument},
		{@"localized",			'l',    DDGetoptNoArgument},
        {@"class-name",			'c',    DDGetoptRequiredArgument},
		{@"project-name",		'p',    DDGetoptRequiredArgument},
        {@"create-by",			'b',    DDGetoptRequiredArgument},
		{@"create-date",		'd',    DDGetoptRequiredArgument},
        {@"company-name",		'n',    DDGetoptRequiredArgument},
		{@"inherit-class",		'i',    DDGetoptRequiredArgument},
        {@"project-definition",	't',    DDGetoptRequiredArgument},
		{@"destination",		'e',    DDGetoptRequiredArgument},
		{nil,					0,      0},
    };
	
    [optionsParser addOptionsFromTable: optionTable];
}

- (void) setVerbose: (BOOL) verbose;
{
    if (verbose)
        _verbosity++;
    else if (_verbosity > 0)
        _verbosity--;
}

- (int) application: (DDCliApplication *) app
   runWithArguments: (NSArray *) arguments;
{
	
	if (_help)
    {
        [self printHelp];
        return EXIT_SUCCESS;
    }
    
    if (_version)
    {
        [self printVersion];
        return EXIT_SUCCESS;
    }


	
	if (_projectDefinition && ![_projectDefinition isEqualToString:@""]) {
		ProjectDefinitionParser * pdp = [[ProjectDefinitionParser alloc]init];
		[pdp parseProjectDefinition:_projectDefinition];
		[pdp release];
	}else {
		if ([arguments count] < 1)
		{
			ddfprintf(stderr, @"%@: At least one argument is required\n", DDCliApp);
			[self printUsage: stderr];
			ddfprintf(stderr, @"Try `%@ --help' for more information.\n",
					  DDCliApp);
			return EX_USAGE;
		}
		
		NSMutableDictionary * fileToParse = [[NSMutableDictionary alloc]init];
		[fileToParse setObject:_projectName forKey:@"project"];
		[fileToParse setObject:_createBy forKey:@"created_by"];
		[fileToParse setObject:_createDate forKey:@"creation_date"];
		[fileToParse setObject:_companyName forKey:@"company_name"];
		[fileToParse setObject:_inheritClass forKey:@"inherit"];
		[fileToParse setObject:[NSNumber numberWithBool:_setters] forKey:@"setters"];
		[fileToParse setObject:[NSNumber numberWithBool:_xibConstructor] forKey:@"xib_constructor"];
		[fileToParse setObject:[NSNumber numberWithBool:_localized] forKey:@"localize"];	
		[fileToParse setObject:_className forKey:@"class"];	
		[fileToParse setObject:[arguments objectAtIndex:0] forKey:@"xib"];
		[fileToParse setObject:_destination forKey:@"destination"];
		ProjectDefinitionParser * pdp = [[ProjectDefinitionParser alloc]init];
		[pdp parse:fileToParse];
		[fileToParse release];
		[pdp release];
	}
	
    return EXIT_SUCCESS;
}


- (void) printUsage: (FILE *) stream
{
    ddfprintf(stream, @"%@: Usage [OPTIONS] <argument> [...]\n", DDCliApp);
}

- (void) printHelp
{
    [self printUsage: stdout];
    printf("\n"
           "  -h, --help                            Display this help and exit\n"
           "  -v, --verbose                         Increase verbosity\n"
           "      --version                         Display version and exit\n"
           "  -s, --setters                         Assign with setters\n"
           "  -x, --xib-constructor                 Constructor with xib\n"
           "  -l, --localized                       Localize text in components\n"
           "  -c, --class-name <CLASS NAME>         Class name\n"
           "  -p, --project-name <PROJECT NAME>     Project Name\n"
           "  -b, --create-by <NAME>                Created By\n"
           "  -d, --create-date <DATE>              Creation Date\n"
           "  -n, --company-name <NAME>             Company Name\n"
           "  -i, --inherit-class <CLASS NAME>      Inherit from class\n"
           "  -t, --project-definition <FILE PATH>  Plist Project Definition File\n"
		   "  -e, --destination <DIR PATH>          Destination Directory\n"
           "\n"
           "\n");
}

- (void) printVersion
{
    ddprintf(@"%@ version %@\n", DDCliApp, CURRENT_MARKETING_VERSION);
}





@end

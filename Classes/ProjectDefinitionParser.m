//
//  ProjectDefinitionParser.m
//  objc-generator
//
//  Created by Juan Cruz Ghigliani on 08/04/11.
//  Copyright 2011 Juan Cruz Ghigliani. All rights reserved.
//

#import "ProjectDefinitionParser.h"
#import "FileGenerator.h"


@implementation ProjectDefinitionParser




-(NSDictionary *)loadProjectDefinition:(NSString *)_path{
	NSDictionary * res = [[NSMutableDictionary alloc]initWithContentsOfFile:_path];
	return [res autorelease];
}

-(void)ParseProjectDefinition:(NSString *)_projectDefinitionPath{
	
	NSFileManager *manager = [NSFileManager defaultManager];
	BOOL isDirectory = NO;
	BOOL fileExists = [manager fileExistsAtPath:_projectDefinitionPath isDirectory:&isDirectory];
	if (!fileExists || isDirectory)
	{
		printf("Invalid project definition File.\n");
		return;
	}
	
	NSDictionary * _project = [self loadProjectDefinition:_projectDefinitionPath];
		
	
	//Create Array with parameters of files to Parse
	NSArray * filesDef = [_project objectForKey:@"views"];
	NSMutableArray * filesToParse = [[NSMutableArray alloc] init];
	for (NSDictionary * fileDef in filesDef) {
		printf("parsing file parameters\n");
		if (([fileDef objectForKey:@"class"] == nil)||
			([[fileDef objectForKey:@"class"] isEqualToString:@"" ])) {
			printf("The parameter c = \"Class\" is required.\n");
			return;
		}
		NSMutableDictionary * fileToParse = [[NSMutableDictionary alloc]init];
		if ([fileDef objectForKey:@"project"]) {
			[fileToParse setObject:[fileDef objectForKey:@"project"] forKey:@"project"];
		}else if ([_project objectForKey:@"project"]){
			[fileToParse setObject:[_project objectForKey:@"project"] forKey:@"project"];
		}

		if ([fileDef objectForKey:@"created_by"]) {
			[fileToParse setObject:[fileDef objectForKey:@"created_by"] forKey:@"created_by"];
		}else if ([_project objectForKey:@"created_by"]){
			[fileToParse setObject:[_project objectForKey:@"created_by"] forKey:@"created_by"];
		}
		
		if ([fileDef objectForKey:@"creation_date"]) {
			[fileToParse setObject:[fileDef objectForKey:@"creation_date"] forKey:@"creation_date"];
		}else if ([_project objectForKey:@"creation_date"]){
			[fileToParse setObject:[_project objectForKey:@"creation_date"] forKey:@"creation_date"];
		}

		if ([fileDef objectForKey:@"company_name"]) {
			[fileToParse setObject:[fileDef objectForKey:@"company_name"] forKey:@"company_name"];
		}else if ([_project objectForKey:@"company_name"]){
			[fileToParse setObject:[_project objectForKey:@"company_name"] forKey:@"company_name"];
		}
		
		if ([fileDef objectForKey:@"inherit"]) {
			[fileToParse setObject:[fileDef objectForKey:@"inherit"] forKey:@"inherit"];
		}else if ([_project objectForKey:@"inherit"]){
			[fileToParse setObject:[_project objectForKey:@"inherit"] forKey:@"inherit"];
		}
		
		if ([fileDef objectForKey:@"setters"]) {
			[fileToParse setObject:[fileDef objectForKey:@"setters"] forKey:@"setters"];
		}else if ([_project objectForKey:@"setters"]){
			[fileToParse setObject:[_project objectForKey:@"setters"] forKey:@"setters"];
		}
		
		if ([fileDef objectForKey:@"xib_constructor"]) {
			[fileToParse setObject:[fileDef objectForKey:@"xib_constructor"] forKey:@"xib_constructor"];
		}else if ([_project objectForKey:@"xib_constructor"]){
			[fileToParse setObject:[_project objectForKey:@"xib_constructor"] forKey:@"xib_constructor"];
		}
		
		if ([fileDef objectForKey:@"localize"]) {
			[fileToParse setObject:[fileDef objectForKey:@"localize"] forKey:@"localize"];
		}else if ([_project objectForKey:@"localize"]){
			[fileToParse setObject:[_project objectForKey:@"localize"] forKey:@"localize"];
		}
		

		[fileToParse setObject:[fileDef objectForKey:@"xib"] forKey:@"xib"];
		[fileToParse setObject:[fileDef objectForKey:@"class"] forKey:@"class"];
		
		if ([fileDef objectForKey:@"destination"]) {
			[fileToParse setObject:[fileDef objectForKey:@"destination"] forKey:@"destination"];
		}else if ([_project objectForKey:@"destination"]){
			[fileToParse setObject:[_project objectForKey:@"destination"] forKey:@"destination"];
		}else {
			NSString * path = [fileDef objectForKey:@"xib"];
			[fileToParse setObject:[path stringByDeletingLastPathComponent] forKey:@"destination"];
		}

		
		NSLog(@"%@",fileToParse);
		
		[filesToParse addObject:fileToParse];
	}
	
	FileGenerator * fg = [[FileGenerator alloc] init];
	for (NSDictionary * fileDef in filesToParse) {
		[fg processFileDefinition:fileDef];
	}
	[fg release];

}

-(void)ParseCommandLine:(CommandLine *)commandLine{
	printf("parsing command line\n");
	
	if (![commandLine cL_optionIsSet: @"c"]) {
		printf("The parameter c = \"Class\" is required.\n");
		return;
	}
	
	NSString *nibFile = [commandLine cL_parameterGetValue: 1] ;
	NSFileManager *manager = [NSFileManager defaultManager];
	BOOL isDirectory = NO;
	BOOL fileExists = [manager fileExistsAtPath:nibFile isDirectory:&isDirectory];
	if (!fileExists || isDirectory)
	{
		printf("obj-generator requires a valid XIB file path as parameter.\n");
		return;
	}
	
	if ([[commandLine cL_parameterGetValue: 1] isEqualToString:@""]) {
		printf("obj-generator requires a valid XIB file path as parameter.\n");
		return ;
	}
	
	NSMutableDictionary * fileToParse = [[NSMutableDictionary alloc]init];
	
	if ([commandLine cL_optionIsSet: @"p"]) {
		[fileToParse setObject:[commandLine.parsedCommandLine valueForKey:@"p"] forKey:@"project"];
	}else {
		[fileToParse setObject:@"" forKey:@"project"];
	}
	
	if ([commandLine cL_optionIsSet: @"b"]) {
		[fileToParse setObject:[commandLine.parsedCommandLine valueForKey:@"b"] forKey:@"created_by"];
	}else{
		[fileToParse setObject:@"" forKey:@"created_by"];
	}
	
	if ([commandLine cL_optionIsSet: @"d"]) {
		[fileToParse setObject:[commandLine.parsedCommandLine valueForKey:@"d"] forKey:@"creation_date"];
	}else{
		[fileToParse setObject:@"" forKey:@"creation_date"];
	}
	
	if ([commandLine cL_optionIsSet: @"n"]) {
		[fileToParse setObject:[commandLine.parsedCommandLine valueForKey:@"n"] forKey:@"company_name"];
	}else {
		[fileToParse setObject:@"" forKey:@"company_name"];
	}
	
	if ([commandLine cL_optionIsSet: @"i"]) {
		[fileToParse setObject:[commandLine.parsedCommandLine valueForKey:@"i"] forKey:@"inherit"];
	}else {
		[fileToParse setObject:@"" forKey:@"inherit"];
	}
	
	if ([commandLine cL_optionIsSet: @"s"]) {
		[fileToParse setObject:[NSNumber numberWithBool:TRUE] forKey:@"setters"];
	}else{
		[fileToParse setObject:[NSNumber numberWithBool:FALSE] forKey:@"setters"];
	}
	

	if ([commandLine cL_optionIsSet: @"x"]) {
		[fileToParse setObject:[NSNumber numberWithBool:TRUE] forKey:@"xib_constructor"];
	}else{
		[fileToParse setObject:[NSNumber numberWithBool:FALSE] forKey:@"xib_constructor"];
	}
	
	if ([commandLine cL_optionIsSet: @"l"]) {
		[fileToParse setObject:[NSNumber numberWithBool:TRUE] forKey:@"localize"];
	}else{
		[fileToParse setObject:[NSNumber numberWithBool:FALSE] forKey:@"localize"];
	}
	
	[fileToParse setObject:[commandLine cL_parameterGetValue: 1] forKey:@"xib"];
	[fileToParse setObject:[commandLine.parsedCommandLine valueForKey:@"c"] forKey:@"class"];
	
	NSString * path = [commandLine cL_parameterGetValue: 1];
	[fileToParse setObject:[path stringByDeletingLastPathComponent] forKey:@"destination"];
	
	NSLog(@"%@",fileToParse);
	
	FileGenerator * fg = [[FileGenerator alloc] init];
	
	[fg processFileDefinition:fileToParse];
	
	[fg release];
	
}



@end

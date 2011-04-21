//
//  FileGenerator.m
//  objc-generator
//
//  Created by Juan Cruz Ghigliani on 08/04/11.
//  Copyright 2011 Juan Cruz Ghigliani. All rights reserved.
//

#import "FileGenerator.h"
#import "XibParser.h"
#import "CodeGenerator.h"
#import "FilesGenerator.h"

@implementation FileGenerator


-(void)processFileDefinition:(NSDictionary *) _fileDef{
	//***************************************************************
	//  Parse the input file
	//***************************************************************
	
	XibParser *processor = [[XibParser alloc] init];
	processor.filename = [_fileDef objectForKey:@"xib"];
	[processor process];
	
	//***************************************************************
	//  Create Blocks of code
	//***************************************************************
	
	CodeGenerator * codeGenerator = [[CodeGenerator alloc]init];
	codeGenerator.fileStructure = processor.dictionary;
	
	//use setters or properties
	if ([[_fileDef objectForKey:@"setters"] boolValue]) {
		codeGenerator.codeStyle = NibProcessorCodeStyleSetter;
	}else {
		codeGenerator.codeStyle = NibProcessorCodeStyleProperties;		
	}
	//generate localized code
	if ([[_fileDef objectForKey:@"localize"] boolValue]) {
		codeGenerator.generateLocalized = TRUE;
	}else {
		codeGenerator.generateLocalized = FALSE;		
	}
	
	
	[codeGenerator process];
	
	//***************************************************************
	//  Create output files
	//***************************************************************
	
	FilesGenerator * filesGenerator = [[FilesGenerator alloc]init];
	filesGenerator.variables = [codeGenerator.codeStructure mutableCopy];
	
	
	[filesGenerator.variables setObject:[_fileDef objectForKey:@"class"] forKey:@"__ViewClassName__"];
	[filesGenerator.variables setObject:[_fileDef objectForKey:@"project"] forKey:@"__ProjectName__"];
	[filesGenerator.variables setObject:[_fileDef objectForKey:@"created_by"] forKey:@"__CreatedBy__"];
	[filesGenerator.variables setObject:[_fileDef objectForKey:@"creation_date"] forKey:@"__Date__"];
	[filesGenerator.variables setObject:[_fileDef objectForKey:@"company_name"] forKey:@"__MyCompanyName__"];
	if (![[_fileDef objectForKey:@"inherit"] isEqualToString:@""]) {
		[filesGenerator.variables setObject:[_fileDef objectForKey:@"inherit"] forKey:@"__InheritClassName__"];
	}
	
	
	//Verify if need to create code for constructor, or use xib file
	if ([[_fileDef objectForKey:@"xib_constructor"] boolValue]) {
		filesGenerator.withCodeContructor = FALSE;
	}else {
		filesGenerator.withCodeContructor = TRUE;
	}
	
	filesGenerator.destinationPath = [_fileDef objectForKey:@"destination"];
	
	[filesGenerator process];
	
	
	[processor release];
	[codeGenerator release];
	[filesGenerator release];
	
}


@end

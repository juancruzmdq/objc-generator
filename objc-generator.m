#include <stdio.h>
#import  <Foundation/Foundation.h>
#import  "CommandLine.h"
#include "XibParser.h"
#include "CodeGenerator.h"
#include "FilesGenerator.h"

void printHelp(){
	printf("\n"
		   "\"s\"	 CL_OPTION_OPTIONAL - Assign with setters \n"
		   "\"x\"	 CL_OPTION_OPTIONAL - Constructor with xib \n"
		   "\"c\"	 CL_OPTION_REQUIRED_WITH_VALUE - Class name \n"
		   "\"p\"	 CL_OPTION_OPTIONAL_WITH_VALUE - Project Name \n"
		   "\"b\"	 CL_OPTION_OPTIONAL_WITH_VALUE - Created By \n"
		   "\"d\"	 CL_OPTION_OPTIONAL_WITH_VALUE - Creation Date \n"
		   "\"n\"	 CL_OPTION_OPTIONAL_WITH_VALUE - Company Name \n"
		   "\"i\"	 CL_OPTION_OPTIONAL_WITH_VALUE - Inherit from class \n"
		   "\"l\"	 CL_OPTION_OPTIONAL - Localize text in components \n");
	
}

int main (int argc, char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	BOOL parseSuccess;
	
	
    CommandLine *commandLine = [[CommandLine alloc] initWithArgc: argc andArgv: argv];
	
    // This sample expects at least one parameter (other that options)
    int sampleMinNumberOfParams = 1;
	
    // Define the matrix describing expected options
    NSDictionary *sampleOptionsMatrix =
	[NSDictionary dictionaryWithObjectsAndKeys:
	 CL_OPTION_OPTIONAL, @"s", //Assign with setters
	 CL_OPTION_OPTIONAL, @"x", //Constructor with xib
	 CL_OPTION_REQUIRED_WITH_VALUE, @"c", //Class
	 CL_OPTION_OPTIONAL_WITH_VALUE, @"p", //ProjectName
	 CL_OPTION_OPTIONAL_WITH_VALUE, @"b", //Created By
	 CL_OPTION_OPTIONAL_WITH_VALUE, @"d", //Creation Date
	 CL_OPTION_OPTIONAL_WITH_VALUE, @"n", //Company Name
	 CL_OPTION_OPTIONAL_WITH_VALUE, @"i", //Inherit from class
	 CL_OPTION_OPTIONAL, @"l", //Localize text in components
	 //CL_OPTION_REQUIRED_WITH_VALUE, @"f",
	 //CL_OPTION_OPTIONAL_WITH_VALUE, @"x",
	 nil];
	
    // Pass on required parameters to the parser and execute the parser
    [commandLine cL_setOptionsMatrix: sampleOptionsMatrix
				andMinNumberOfParams: sampleMinNumberOfParams];
	
    parseSuccess = [commandLine cL_parse];
	
    if (parseSuccess) {
        // Display the parsed options.
        for (NSString *key in commandLine.parsedCommandLine) {
			NSLog(@"%@",
				  [NSString stringWithFormat: @"Option: %@ Value: %@", key,[commandLine.parsedCommandLine valueForKey:key]]
				  );
        }
		
		if ([[commandLine cL_parameterGetValue: 1] isEqualToString:@""]) {
			printf("obj-generator requires a valid XIB file path as parameter.\n");
			printHelp();
			[pool drain];
			return 0;
		}
		
    } else {
        //Display the error message
        NSLog(@"%@",commandLine.resultText);
		printHelp();
		return 0;
    }
	
	
    
    NSString *nibFile = [commandLine cL_parameterGetValue: 1] ;
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    BOOL fileExists = [manager fileExistsAtPath:nibFile isDirectory:&isDirectory];
    if (!fileExists || isDirectory)
    {
        printf("obj-generator requires a valid XIB file path as parameter.\n");
		printHelp();
        [pool drain];
        return 0;
    }
    

	
    //***************************************************************
	//  Parse the input file
	//***************************************************************
	
	XibParser *processor = [[XibParser alloc] init];
	processor.filename = nibFile;
	NSLog(@"Pre-Process XibParser");
	[processor process];
	NSLog(@"Post-Process XibParser");

	//***************************************************************
	//  Create Blocks of code
	//***************************************************************
	
	CodeGenerator * codeGenerator = [[CodeGenerator alloc]init];
	codeGenerator.fileStructure = processor.dictionary;

	//use setters or properties
	if ([commandLine cL_optionIsSet: @"s"]) {
		codeGenerator.codeStyle = NibProcessorCodeStyleSetter;
	}else {
		codeGenerator.codeStyle = NibProcessorCodeStyleProperties;		
	}
	
	NSLog(@"Pre-Process CodeGenerator");
	[codeGenerator process];
	NSLog(@"Post-Process CodeGenerator");
	
	//***************************************************************
	//  Create output files
	//***************************************************************
	
	FilesGenerator * filesGenerator = [[FilesGenerator alloc]init];
	filesGenerator.variables = [codeGenerator.codeStructure mutableCopy];

	
	[filesGenerator.variables setObject:[commandLine.parsedCommandLine valueForKey:@"c"]==nil?@"":[commandLine.parsedCommandLine valueForKey:@"c"] forKey:@"__ViewClassName__"];
	[filesGenerator.variables setObject:[commandLine.parsedCommandLine valueForKey:@"p"]==nil?@"":[commandLine.parsedCommandLine valueForKey:@"p"] forKey:@"__ProjectName__"];
	[filesGenerator.variables setObject:[commandLine.parsedCommandLine valueForKey:@"b"]==nil?@"":[commandLine.parsedCommandLine valueForKey:@"b"] forKey:@"__CreatedBy__"];
	[filesGenerator.variables setObject:[commandLine.parsedCommandLine valueForKey:@"d"]==nil?@"":[commandLine.parsedCommandLine valueForKey:@"d"] forKey:@"__Date__"];
	[filesGenerator.variables setObject:[commandLine.parsedCommandLine valueForKey:@"n"]==nil?@"":[commandLine.parsedCommandLine valueForKey:@"n"] forKey:@"__MyCompanyName__"];
	if ([commandLine.parsedCommandLine valueForKey:@"i"]) {
		[filesGenerator.variables setObject:[commandLine.parsedCommandLine valueForKey:@"i"] forKey:@"__InheritClassName__"];
	}
	
	
	//Verify if need to create code for constructor, or use xib file
  	if ([commandLine cL_optionIsSet: @"x"]) {
		filesGenerator.withCodeContructor = FALSE;
	}else {
		filesGenerator.withCodeContructor = TRUE;
	}
	
	
    [filesGenerator process];
	
	
    [processor release];
	[codeGenerator release];
	[filesGenerator release];
	
    [pool drain];
    return 0;
}



#include <stdio.h>
#import  <Foundation/Foundation.h>
#import  "CommandLine.h"
#include "XibParser.h"
#include "CodeGenerator.h"
#include "FilesGenerator.h"
#include "ProjectDefinitionParser.h"

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
		   "\"l\"	 CL_OPTION_OPTIONAL - Localize text in components \n"
		   "\"t\"    CL_OPTION_OPTIONAL_WITH_VALUE - Plist Project Definition File \n");
	
}

int main (int argc, char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	BOOL parseSuccess;
	
	
    CommandLine *commandLine = [[CommandLine alloc] initWithArgc: argc andArgv: argv];
	
    // This sample expects at least one parameter (other that options)
    int sampleMinNumberOfParams = 0;
	
    // Define the matrix describing expected options
    NSDictionary *sampleOptionsMatrix =
	[NSDictionary dictionaryWithObjectsAndKeys:
	 CL_OPTION_OPTIONAL, @"s", //Assign with setters
	 CL_OPTION_OPTIONAL, @"x", //Constructor with xib
	 CL_OPTION_OPTIONAL_WITH_VALUE, @"c", //Class
	 CL_OPTION_OPTIONAL_WITH_VALUE, @"p", //ProjectName
	 CL_OPTION_OPTIONAL_WITH_VALUE, @"b", //Created By
	 CL_OPTION_OPTIONAL_WITH_VALUE, @"d", //Creation Date
	 CL_OPTION_OPTIONAL_WITH_VALUE, @"n", //Company Name
	 CL_OPTION_OPTIONAL_WITH_VALUE, @"i", //Inherit from class
	 CL_OPTION_OPTIONAL_WITH_VALUE, @"t", //Plist Project Definition File
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
		

    } else {
        //Display the error message
        NSLog(@"%@",commandLine.resultText);
		printHelp();
		return 0;
    }
	
	

	
	if ([commandLine.parsedCommandLine valueForKey:@"t"]) {
		ProjectDefinitionParser * pdp = [[ProjectDefinitionParser alloc]init];
		[pdp ParseProjectDefinition:[commandLine.parsedCommandLine valueForKey:@"t"]];
	}else {
		ProjectDefinitionParser * pdp = [[ProjectDefinitionParser alloc]init];
		[pdp ParseCommandLine:commandLine];
	}

	
    [pool drain];
    return 0;
}



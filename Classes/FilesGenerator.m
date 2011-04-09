//
//  FilesGenerator.m
//  objc-generator
//
//  Created by Juan Cruz Ghigliani on 04/04/11.
//  Copyright 2011 Juan Cruz Ghigliani. All rights reserved.
//

#import "FilesGenerator.h"


@implementation FilesGenerator
@synthesize variables;
@synthesize headerFile;
@synthesize bodyFile;
@synthesize withCodeContructor;
@synthesize destinationPath;

- (void)process{

	[self createHeaderFile];
	[self createBodyFile];
	NSError *error = nil; 
	[(NSString *)headerFile  writeToFile:[NSString stringWithFormat:@"%@/_%@.h",self.destinationPath,[self.variables objectForKey:@"__ViewClassName__"] ] 
							   atomically:TRUE
								 encoding:NSUTF8StringEncoding
									error:&error];
	NSLog(@"Header File Created: %@",[NSString stringWithFormat:@"%@/_%@.h",self.destinationPath,[self.variables objectForKey:@"__ViewClassName__"] ] );
	
	
	[(NSString *)bodyFile writeToFile:[NSString stringWithFormat:@"%@/_%@.m",self.destinationPath,[self.variables objectForKey:@"__ViewClassName__"] ] 
							atomically:TRUE
							  encoding:NSUTF8StringEncoding
								 error:&error];
	NSLog(@"Body File Created: %@",[NSString stringWithFormat:@"%@/_%@.m",self.destinationPath,[self.variables objectForKey:@"__ViewClassName__"] ] );
	
	NSLog(@"%@",headerFile);
	NSLog(@"%@",bodyFile);

}



- (void) createHeaderFile{
	headerFile = [[NSMutableString alloc] initWithString:
				   @"//\n"
				   @"//  ___ViewClassName__.h\n"
				   @"//  __ProjectName__\n"
				   @"//\n"
				   @"//  Created by __CreatedBy__ on __Date__.\n"
				   @"//  Copyright 2011 __MyCompanyName__. All rights reserved.\n"
				   @"//\n"
				   @"\n"
				   @"#import <UIKit/UIKit.h>\n"
				   @"\n"
				   @"@interface ___ViewClassName__ : __InheritClassName__  {\n"
				   @"	__Variables__\n"
				   @"}\n"
				   @"__Properties__\n"
				   @"\n"
				   @"@end\n"];
	
	
	
	//Property__InheritClassName__definition
	NSString * varDef = [self.variables objectForKey:@"__InheritClassName__"];
	if (!varDef) {
		[self.variables setObject:@"UIViewController" forKey:@"__InheritClassName__"];
	}
	
	
	for (NSString * key in self.variables) {
		[headerFile replaceOccurrencesOfString:key withString:[self.variables objectForKey:key] options:NSCaseInsensitiveSearch range:(NSRange){0,[headerFile length]}];		
	}
	
	
	
}
- (void) createBodyFile{
	bodyFile = [[NSMutableString alloc] initWithString:
				@"//\n"
				@"//  ___ViewClassName__.m\n"
				@"//  __ProjectName__\n"
				@"//\n"
				@"//  Created by __CreatedBy__ on __Date__.\n"
				@"//  Copyright 2011 __MyCompanyName__. All rights reserved.\n"
				@"//\n"
				@"\n"
				@"#import  \"___ViewClassName__.h\"\n"
				@"\n"
				@"@implementation ___ViewClassName__\n"
				@"\n"
				@"__Synthesize__\n"
				@"\n" ];
	if (withCodeContructor) {
		[bodyFile appendString:
		 @"__CodeInit__\n" ];
	}else {
		[bodyFile appendString:
		 @"__XibInit__\n" ];		
	}
	
	[bodyFile appendString:
			 @"\n"
			 @"- (void)dealloc {\n"
			 @"__Dealloc__\n"			 
			 @"[super dealloc];\n"
			 @"}\n"
			 @"\n"
			 @"@end\n"];
	
	for (NSString * key in self.variables) {
		[bodyFile replaceOccurrencesOfString:key withString:[self.variables objectForKey:key] options:NSCaseInsensitiveSearch range:(NSRange){0,[bodyFile length]}];		
	}
	
	
}

- (void) dealloc
{

	self.variables = nil;
	self.headerFile = nil;
	self.bodyFile = nil;
	self.destinationPath = nil;
	[super dealloc];
}



@end

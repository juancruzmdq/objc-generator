//
//  FilesGenerator.h
//  objc-generator
//
//  Created by Juan Cruz Ghigliani on 04/04/11.
//  Copyright 2011 Juan Cruz Ghigliani. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FilesGenerator : NSObject {
	NSMutableDictionary *variables;
	NSMutableString *headerFile;
	NSMutableString *bodyFile;
	BOOL withCodeContructor;
}
@property (nonatomic,retain) NSMutableDictionary *variables;
@property (nonatomic,retain) NSMutableString *headerFile;
@property (nonatomic,retain) NSMutableString *bodyFile;
@property (assign) BOOL withCodeContructor;

- (void) process;
- (void) createBodyFile;
- (void) createHeaderFile;
@end

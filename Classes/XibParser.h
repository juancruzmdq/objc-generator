//
//  XibParser.h
//  objc-generator
//
//  Created by Juan Cruz Ghigliani on 04/04/11.
//  Copyright 2011 Juan Cruz Ghigliani. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface XibParser : NSObject {
	
@private
	//input parameters
	NSString *_filename;

    //dictionary to load the result of ibtool and the result of the process
    NSMutableData *_data;
	NSMutableDictionary *_dictionary;
	
	//Auxiliar for parser information
	NSMutableDictionary *_objects;
	NSMutableDictionary *_mainStructure;
	
}

@property (nonatomic, copy) NSString *filename;
@property (nonatomic, readonly) NSDictionary *dictionary;



- (void)process;


@end

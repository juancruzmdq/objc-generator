//
//  OGInstruction.h
//  objc-generator
//
//  Created by Juan Cruz Ghigliani on 06/04/11.
//  Copyright 2011 Juan Cruz Ghigliani. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OGInstruction : NSString {
	NSString * instruction;
	BOOL localized;
}

@property(assign) BOOL localized;
@property(retain) NSString * instruction;

+(OGInstruction *)initWithString:(NSString *)_string;
+(OGInstruction *)initWithStringLocalized:(NSString *)_string;
@end

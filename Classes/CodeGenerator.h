//
//  CodeGenerator.h
//  objc-generator
//
//  Created by Juan Cruz Ghigliani on 04/04/11.
//  Copyright 2011 Juan Cruz Ghigliani. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    NibProcessorCodeStyleProperties = 1,
    NibProcessorCodeStyleSetter = 2
} NibProcessorCodeStyle;


@interface CodeGenerator : NSObject {
    NibProcessorCodeStyle _codeStyle;
	NSMutableDictionary *_codeStructure;
	NSDictionary * _fileStructure;
	NSMutableString * _constuctorCode;
	NSMutableString * _localizeCode;
	BOOL generateLocalized;
}
@property (nonatomic) NibProcessorCodeStyle codeStyle;
@property (nonatomic,retain) NSDictionary * fileStructure;
@property (nonatomic,retain) NSMutableDictionary * codeStructure;
@property (assign) BOOL generateLocalized;

- (void)process;
- (NSString *) instanceNameForObject:(NSDictionary *)obj;
- (void) generateCodeForObject:(NSDictionary *)_parsedStructure  withParent:(NSDictionary *)parent;

@end

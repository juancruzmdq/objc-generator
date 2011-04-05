//
//  CodeGenerator.h
//  objc-generator
//
//  Created by Juan Cruz Ghigliani on 04/04/11.
//  Copyright 2011 Tangelo. All rights reserved.
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
}
@property (nonatomic) NibProcessorCodeStyle codeStyle;
@property (nonatomic,retain) NSDictionary * fileStructure;
@property (nonatomic,retain) NSMutableDictionary * codeStructure;

- (void)process;
- (NSString *) instanceNameForObject:(NSDictionary *)obj;
- (void) generateCodeForObject:(NSDictionary *)_parsedStructure  withParent:(NSDictionary *)parent;

@end

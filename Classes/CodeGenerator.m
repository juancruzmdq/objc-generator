//
//  CodeGenerator.m
//  objc-generator
//
//  Created by Juan Cruz Ghigliani on 04/04/11.
//  Copyright 2011 Juan Cruz Ghigliani. All rights reserved.
//

#import "CodeGenerator.h"


@implementation CodeGenerator
@synthesize codeStyle=_codeStyle;
@synthesize fileStructure=_fileStructure;
@synthesize codeStructure=_codeStructure;
@synthesize generateLocalized;

- (id)init
{
    if (self = [super init])
    {
        self.codeStyle = NibProcessorCodeStyleProperties;
		self.codeStructure = [[[NSMutableDictionary alloc] init] autorelease];
    }
    return self;
}

- (void)process{
	// Let's print everything as source code
	[_constuctorCode release];
	_constuctorCode = [[NSMutableString alloc] init];
	
	[_localizeCode release];
	_localizeCode = [[NSMutableString alloc] init];
	
	
	[self generateCodeForObject:[self.fileStructure objectForKey:@"com.objc-generator.structure"] withParent:nil];
	NSLog(@"Creating Constructors code");
	
	//Contructor definition
	[self.codeStructure setObject:[NSString stringWithFormat:@"- (id)init{\n"
								   @"if ((self = [super init])) {\n"
								   @"%@\n"
								   @"}\n"
								   @"return self;\n"
								   @"}\n",_constuctorCode]
						   forKey:@"__CodeInit__"];	
		

	[self.codeStructure setObject:[NSString stringWithFormat:@"- (id)initWithNibName:(NSString *)nibNameOrNil\n"
		 @"bundle:(NSBundle *)nibBundleOrNil {\n"
		 @"if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {\n"
		 @"%@\n"
		 @"\n"
		 @"}\n"
	 @"return self;\n"
	 @"}\n",_localizeCode]
						   forKey:@"__XibInit__"];		
	
}

-(void)generateCodeForObject:(NSDictionary *)_parsedStructure  withParent:(NSDictionary *)parent{

    for (NSDictionary *parsedView in _parsedStructure)
    {
        id object = [[_parsedStructure objectForKey:parsedView] objectForKey:@"parsedObject"];
		//TODO: Recuperara lista de claves ordenadas
		// NSArray *orderedKeys = [object  keysSortedByValueUsingSelector:@selector(compare:)];
        for (NSString *key in object)
        {
            id value = [object objectForKey:key];
			if ([value isKindOfClass:[OGInstruction class]]) {
				value = ((OGInstruction*)value).instruction;
			}
            if ([key hasPrefix:@"__helper__"])
            {
                [_constuctorCode appendString:value];
                [_constuctorCode appendString:@"\n"];    
            }
        }
        // Constructor and frame
        id klass = ((OGInstruction*)[object objectForKey:@"class"]).instruction;
        id constructor = [object objectForKey:@"constructor"];
        id frame = [object objectForKey:@"frame"];
        NSString *instanceName = [self instanceNameForObject:[_parsedStructure objectForKey:parsedView]];
        
		//Removed line to fix issue 2
		//[_constuctorCode appendFormat:@"%@ *%@ = %@;\n", klass, instanceName, constructor];
		[_constuctorCode appendFormat:@"%@ = %@;\n", instanceName, constructor];
		
        switch (self.codeStyle)
        {
            case NibProcessorCodeStyleProperties:
                [_constuctorCode appendFormat:@"%@.frame = %@;\n", instanceName, frame];
                break;
                
            case NibProcessorCodeStyleSetter:
                [_constuctorCode appendFormat:@"[%@ setFrame:%@];\n", instanceName, frame];
                break;
				
            default:
                break;
        }
        
        // Properties
        //orderedKeys = [[object allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
        for (NSString *key in object)
        {
            id value = [object objectForKey:key];
            if (![key hasPrefix:@"__method__"] && ![key isEqualToString:@"frame"] 
                && ![key isEqualToString:@"constructor"] && ![key isEqualToString:@"class"]
                && ![key hasPrefix:@"__helper__"])
            {
                switch (self.codeStyle) 
                {
                    case NibProcessorCodeStyleProperties:
                        [_constuctorCode appendFormat:@"%@.%@ = %@;\n", instanceName, key, ((OGInstruction*)value).instruction];

							if (self.generateLocalized && ((OGInstruction*)value).localized) {
								[_localizeCode appendFormat:@"%@.%@ = %@;\n", instanceName, key, ((OGInstruction*)value).instruction];
							}
						

                        break;
                        
                    case NibProcessorCodeStyleSetter:
                        [_constuctorCode appendFormat:@"[%@ set%@:%@];\n", instanceName, [key capitalizedString], ((OGInstruction*)value).instruction];

							if (self.generateLocalized &&((OGInstruction*)value).localized) {
								[_localizeCode appendFormat:@"[%@ set%@:%@];\n", instanceName, [key capitalizedString], ((OGInstruction*)value).instruction];
							}

						
                        break;
                        
                    default:
                        break;
                }
            }
        }
        // Methods
        //orderedKeys = [object keysSortedByValueUsingSelector:@selector(caseInsensitiveCompare:)];
        for (NSString *key in object)
        {
            id value = [object objectForKey:key];

            if ([key hasPrefix:@"__method__"])
            {
                [_constuctorCode appendFormat:@"[%@ %@];\n", instanceName, ((OGInstruction*)value).instruction];

					if (self.generateLocalized &&((OGInstruction*)value).localized) {
						[_localizeCode appendFormat:@"[%@ %@];\n", instanceName, ((OGInstruction*)value).instruction];
					}

            }
        }

		if (parent) {
			[_constuctorCode appendFormat:@"[%@ addSubview:%@];\n", [self instanceNameForObject:parent], instanceName];
		}
        [_constuctorCode appendString:@"\n"];    
		
		//Variable Definition
		NSString * varDef = [self.codeStructure objectForKey:@"__Variables__"];
		if (!varDef) {
			varDef = @"";
		}
		[self.codeStructure setObject:[varDef stringByAppendingFormat:@"%@ *%@;\n",klass,instanceName] forKey:@"__Variables__"];
		
		//Property definition
		varDef = [self.codeStructure objectForKey:@"__Properties__"];
		if (!varDef) {
			varDef = @"";
		}
		[self.codeStructure setObject:[varDef stringByAppendingFormat:@"@property (nonatomic,retain) IBOutlet %@ *%@;\n",klass,instanceName] forKey:@"__Properties__"];
		
		//Syntetize definition
		varDef = [self.codeStructure objectForKey:@"__Synthesize__"];
		if (!varDef) {
			varDef = @"";
		}
		[self.codeStructure setObject:[varDef stringByAppendingFormat:@"@synthesize %@;\n",instanceName] forKey:@"__Synthesize__"];
		
		//Dealloc definition
		varDef = [self.codeStructure objectForKey:@"__Dealloc__"];
		if (!varDef) {
			varDef = @"";
		}
		[self.codeStructure setObject:[varDef stringByAppendingFormat:@"self.%@ = nil;\n",instanceName] forKey:@"__Dealloc__"];
		
		
		NSDictionary *children = [[_parsedStructure objectForKey:parsedView] objectForKey:@"childrens"];
		if (children != nil)
		{
			[self generateCodeForObject:children withParent:[_parsedStructure objectForKey:parsedView]];
		}
    }
	
	//NSLog(@"_localizeCode: %@",_localizeCode);

}



- (NSString *)instanceNameForObject:(NSDictionary *)obj
{
	
	NSString *objectId = [obj objectForKey:@"object-id"];
	NSDictionary *hierarchy = [obj objectForKey:@"hierarchy"];
	NSDictionary *object = [obj objectForKey:@"object"];
	NSString *klass = [object objectForKey:@"class"];
	
    NSString *instanceName;
	if (([hierarchy objectForKey:@"name"] != nil)&&
		(![[hierarchy objectForKey:@"name"] isEqualToString:@""])){
		instanceName = [hierarchy objectForKey:@"name"];
	}else {
		instanceName = [NSString stringWithFormat:@"%@%@",[[klass lowercaseString] substringFromIndex:2],objectId];
	}
    return instanceName;
}

- (void) dealloc
{
	[_constuctorCode release];
	[_localizeCode release];
	self.codeStructure = nil;
	self.fileStructure = nil;
	[super dealloc];
}



@end

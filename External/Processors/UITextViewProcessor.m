//
//  UITextViewProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/15/09.
//  Adrian Kosmaczewski 2009
//

#import "UITextViewProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"
#import "NSString+Nib2ObjcExtensions.h"
#import "NSDictionary+Nib2ObjcExtensions.h"

@implementation UITextViewProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UITextView";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"text"])
    {
        [output setObject:[OGInstruction initWithStringLocalized:[value quotedAsCodeString]] forKey:item];
    }
    else if ([item isEqualToString:@"textAlignment"])
    {
        [output setObject:[OGInstruction initWithString:[value textAlignmentString]] forKey:item];
    }
    else if ([item isEqualToString:@"font"])
    {
        [output setObject:[OGInstruction initWithString:[value fontString]] forKey:item];
    }
    else if ([item isEqualToString:@"textColor"])
    {
        [output setObject:[OGInstruction initWithString:[value colorString]] forKey:item];
    }
    else if ([item isEqualToString:@"editable"])
    {
        [output setObject:[OGInstruction initWithString:[value booleanString]] forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end

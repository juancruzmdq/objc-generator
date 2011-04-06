//
//  UITextFieldProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Adrian Kosmaczewski 2009
//

#import "UITextFieldProcessor.h"
#import "NSString+Nib2ObjcExtensions.h"
#import "NSNumber+Nib2ObjcExtensions.h"
#import "NSDictionary+Nib2ObjcExtensions.h"

@implementation UITextFieldProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UITextField";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"text"])
    {
        [output setObject:[OGInstruction initWithStringLocalized:[value quotedAsCodeString]] forKey:item];
    }
    else if ([item isEqualToString:@"placeholder"])
    {
        [output setObject:[OGInstruction initWithStringLocalized:[value quotedAsCodeString]] forKey:item];
    }
    else if ([item isEqualToString:@"textAlignment"])
    {
        [output setObject:[OGInstruction initWithString:[value textAlignmentString]] forKey:item];
    }
    else if ([item isEqualToString:@"textColor"])
    {
        [output setObject:[OGInstruction initWithString:[value colorString]] forKey:item];
    }
    else if ([item isEqualToString:@"font"])
    {
        [output setObject:[OGInstruction initWithString:[value fontString]] forKey:item];
    }
    else if ([item isEqualToString:@"borderStyle"])
    {
        [output setObject:[OGInstruction initWithString:[value borderStyleString]] forKey:item];
    }
    else if ([item isEqualToString:@"clearsOnBeginEditing"])
    {
        [output setObject:[OGInstruction initWithString:[value booleanString]] forKey:item];
    }
    else if ([item isEqualToString:@"adjustsFontSizeToFitWidth"])
    {
        [output setObject:[OGInstruction initWithString:[value booleanString]] forKey:item];
    }
    else if ([item isEqualToString:@"minimumFontSize"])
    {
        [output setObject:[OGInstruction initWithString:[value floatString]] forKey:item];
    }
    else if ([item isEqualToString:@"textInputTraits.enablesReturnKeyAutomatically"])
    {
        [output setObject:[OGInstruction initWithString:[value booleanString]] forKey:@"enablesReturnKeyAutomatically"];
    }
    else if ([item isEqualToString:@"textInputTraits.secureTextEntry"])
    {
        [output setObject:[OGInstruction initWithString:[value booleanString]] forKey:@"secureTextEntry"];
    }
    else if ([item isEqualToString:@"textInputTraits.keyboardAppearance"])
    {
        [output setObject:[OGInstruction initWithString:[value keyboardAppearanceString]] forKey:@"keyboardAppearance"];
    }
    else if ([item isEqualToString:@"textInputTraits.returnKeyType"])
    {
        [output setObject:[OGInstruction initWithString:[value returnKeyTypeString]] forKey:@"returnKeyType"];
    }
    else if ([item isEqualToString:@"textInputTraits.autocapitalizationType"])
    {
        [output setObject:[OGInstruction initWithString:[value autocapitalizationTypeString]] forKey:@"autocapitalizationType"];
    }
    else if ([item isEqualToString:@"textInputTraits.autocorrectionType"])
    {
        [output setObject:[OGInstruction initWithString:[value autocorrectionTypeString]] forKey:@"autocorrectionType"];
    }
    else if ([item isEqualToString:@"textInputTraits.keyboardType"])
    {
        [output setObject:[OGInstruction initWithString:[value keyboardTypeString]] forKey:@"keyboardType"];
    }
    else if ([item isEqualToString:@"clearButtonMode"])
    {
        [output setObject:[OGInstruction initWithString:[value clearButtonModeString]] forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end

//
//  ProjectDefinitionParser.h
//  objc-generator
//
//  Created by Juan Cruz Ghigliani on 08/04/11.
//  Copyright 2011 Juan Cruz Ghigliani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectDefinitionParser : NSObject {


}

-(NSDictionary *)loadProjectDefinition:(NSString *)path;
-(void)parseProjectDefinition:(NSString *)_projectDefinitionPath;
-(void)parse:(NSDictionary *)_parameters;

@end

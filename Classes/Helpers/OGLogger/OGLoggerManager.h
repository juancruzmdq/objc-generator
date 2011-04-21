//
//  OGLoggerManager.h
//  objc-generator
//
//  Created by Juan Cruz Ghigliani on 20/04/11.
//  Copyright 2011 Juan Cruz Ghigliani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OGLogger.h"

@interface OGLoggerManager : NSObject {

}

+(OGLoggerManager*)sharedInstance;
+(OGLogger*)console;

@end

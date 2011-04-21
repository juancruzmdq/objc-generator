//
//  OGLogger.h
//  objc-generator
//
//  Created by Juan Cruz Ghigliani on 19/04/11.
//  Copyright 2011 Juan Cruz Ghigliani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OGLoggerOutputConsole.h"
typedef enum  {
	OGLogLevelError		= 1, 
	OGLogLevelWarning	= 2, 
	OGLogLevelInfo		= 3,
	OGLogLevelDebug		= 4, 
} OGLogLevel;

@interface OGLogger : NSObject {
	NSString *context;
	OGLogLevel level;
	OGLoggerOutput * output;
}
@property(nonatomic,retain) NSString *context;
@property(assign) OGLogLevel level;
@property(nonatomic,retain) OGLoggerOutput * output;


-(id)init;
-(id)initInContext:(NSString *)_context;
-(id)initInContext:(NSString *)_context withLogLevel:(OGLogLevel)_logLevel;
-(id)initInContext:(NSString *)_context withLogLevel:(OGLogLevel)_logLevel andOutput:(OGLoggerOutput *)_output;

-(void)error:(NSString *)_msg;
-(void)errorWithFormat:(NSString *)format, ...;
-(void)warning:(NSString *)_msg;
-(void)warningWithFormat:(NSString *)format, ...;
-(void)info:(NSString *)_msg;
-(void)infoWithFormat:(NSString *)format, ...;
-(void)debug:(NSString *)_msg;
-(void)debugWithFormat:(NSString *)format, ...;

@end

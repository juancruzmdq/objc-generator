#include <stdio.h>
#import  <Foundation/Foundation.h>
#import "DDCommandLineInterface.h"
#import "objcGeneratorApp.h"

	
int main (int argc, char * const * argv){
	
	return DDCliAppRunWithClass([objcGeneratorApp class]);

}



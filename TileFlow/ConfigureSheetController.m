//
//  ConfigureSheetController.m
//  TileFlow
//
//  Created by Stefan Graupner on 2/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>

#import "ConfigureSheetController.h"

@implementation ConfigureSheetController

@synthesize currentSize, currentSpeed;

- (id)initWithWindowNibName:(NSString *)windowNibName owner:(id)owner
{
    self = [super initWithWindowNibName:windowNibName owner:owner];
    if (self)
    {
        ScreenSaverDefaults *defaults;
        defaults = [ScreenSaverDefaults 
                    defaultsForModuleWithName:@"com.meanderingsoul.TileFlow"];
        [self setCurrentSize:[defaults floatForKey:@"squareSize"]];
        [self setCurrentSpeed:[defaults floatForKey:@"speed"]];
    }
    return self;
}

- (IBAction)changeTileSize:(id)sender
{
    ScreenSaverDefaults *defaults;
    defaults = [ScreenSaverDefaults 
                defaultsForModuleWithName:@"com.meanderingsoul.TileFlow"];
    [defaults setFloat:[self currentSize] forKey:@"squareSize"];
}

- (IBAction)changeSpeed:(id)sender
{
    ScreenSaverDefaults *defaults;
    defaults = [ScreenSaverDefaults 
                defaultsForModuleWithName:@"com.meanderingsoul.TileFlow"];
    float speed = [self currentSpeed];
    speed -= 0.1;
    if (speed < 0) speed *= -1;
    
    [defaults setFloat:speed forKey:@"speed"];    
}

- (IBAction)okButtonClick:(id)sender
{
    [[NSApplication sharedApplication] endSheet:[self window]];
}

@end

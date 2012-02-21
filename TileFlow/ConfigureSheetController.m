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

@synthesize squareSizeSlider = _squareSizeSlider;

- (void)windowDidLoad:(id)sender
{
    [super showWindow:sender];
    ScreenSaverDefaults *defaults;
    defaults = [ScreenSaverDefaults 
                defaultsForModuleWithName:@"com.meanderingsoul.TileFlow"];
    [_squareSizeSlider setFloatValue:[defaults floatForKey:@"squareSize"]];            
}

- (IBAction)changeTileSize:(id)sender
{
    ScreenSaverDefaults *defaults;
    defaults = [ScreenSaverDefaults 
                defaultsForModuleWithName:@"com.meanderingsoul.TileFlow"];
    [defaults setFloat:[_squareSizeSlider floatValue] forKey:@"squareSize"];
}

- (IBAction)okButtonClick:(id)sender
{
    [[NSApplication sharedApplication] endSheet:[self window]];
}

@end

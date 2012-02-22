//
//  ConfigureSheetController.h
//  TileFlow
//
//  Created by Stefan Graupner on 2/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigureSheetController : NSWindowController

@property (assign) IBOutlet NSSlider* squareSizeSlider;

@property (readwrite) float currentSize;

- (IBAction)changeTileSize:(id)sender;

- (IBAction)okButtonClick:(id)sender;

@end

//
//  ConfigureSheetController.h
//  TileFlow
//
//  Created by Stefan Graupner on 2/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigureSheetController : NSWindowController

@property (readwrite) float currentSize;
@property (readwrite) float currentSpeed;

- (IBAction)changeTileSize:(id)sender;
- (IBAction)changeSpeed:(id)sender;

- (IBAction)okButtonClick:(id)sender;

@end

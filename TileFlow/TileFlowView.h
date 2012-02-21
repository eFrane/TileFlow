//
//  TileFlowView.h
//  TileFlow
//
//  Created by Stefan Graupner on 2/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>

@interface TileFlowView : ScreenSaverView
{
    int counter;
    id  configureSheet;
}

@property (readwrite) NSPoint    currentPoint;
@property (readwrite) float      squareSize;

-(void)nextPoint;

@end

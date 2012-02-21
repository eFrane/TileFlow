//
//  TileDemoView.m
//  TileFlow
//
//  Created by Stefan Graupner on 2/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>

#import "TileDemoView.h"

@implementation TileDemoView

- (id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self)
    {
        ScreenSaverDefaults *defaults;
        defaults = [ScreenSaverDefaults 
                    defaultsForModuleWithName:@"com.meanderingsoul.TileFlow"];
        
        [defaults addObserver:self 
                   forKeyPath:@"squareSize" 
                      options:NSKeyValueObservingOptionNew 
                      context:nil];
    }
    return self;
}

- (void)dealloc
{
    ScreenSaverDefaults *defaults;
    defaults = [ScreenSaverDefaults 
                defaultsForModuleWithName:@"com.meanderingsoul.TileFlow"];
    [defaults removeObserver:self forKeyPath:@"squareSize"];
    
    [super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath 
                      ofObject:(id)object 
                        change:(NSDictionary *)change
                       context:(void *)context
{
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    ScreenSaverDefaults *defaults;
    defaults = [ScreenSaverDefaults 
                defaultsForModuleWithName:@"com.meanderingsoul.TileFlow"];
    
    CGFloat x, y, squareSize;
    
    squareSize = [defaults floatForKey:@"squareSize"];
    x = ([self frame].size.width / 2) - (squareSize / 2);
    y = ([self frame].size.height / 2) - (squareSize / 2);
    
    CGRect rect = CGRectMake(x, y, squareSize, squareSize);
    
    CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
    CGContextSetRGBFillColor(context, 0.5, 1.0, 0.7, 1.0);
    CGContextFillRect(context, rect);
}

@end

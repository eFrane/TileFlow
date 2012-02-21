//
//  TileFlowView.m
//  TileFlow
//
//  Created by Stefan Graupner on 2/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TileFlowView.h"
#import "ConfigureSheetController.h"
#import "NSColor+CGConvertAdditions.h"

@implementation TileFlowView

@synthesize currentPoint = _currentPoint;
@synthesize squareSize   = _squareSize;


- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {        
        [self setAnimationTimeInterval:1/20.0];
        
        ScreenSaverDefaults *defaults;
        defaults = [ScreenSaverDefaults 
                    defaultsForModuleWithName:@"com.meanderingsoul.TileFlow"];
        
        [defaults registerDefaults:[NSDictionary 
                                    dictionaryWithObject:[NSNumber numberWithFloat:80] 
                                    forKey:@"squareSize"]];
        
        _squareSize = [defaults floatForKey:@"squareSize"];
        
        float y = frame.size.height - _squareSize;
        [self setCurrentPoint:NSMakePoint(-_squareSize, y)];
        
        srand((int)time(NULL));
        
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
    ScreenSaverDefaults *defaults;
    defaults = [ScreenSaverDefaults 
                defaultsForModuleWithName:@"com.meanderingsoul.TileFlow"];
    
    _squareSize = [defaults floatForKey:@"squareSize"];
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    [self nextPoint];
    
    CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];

    // draw tile
    CGColorRef color = CGColorCreateGenericRGB((float)rand() / RAND_MAX, 
                                               (float)rand() / RAND_MAX, 
                                               (float)rand() / RAND_MAX, 
                                               (float)rand() / RAND_MAX);
    
    CGColorRef borderColor = [[[NSColor colorWithCGColor:color] 
                                complementaryColor] CGColor];
    
    CGContextSetStrokeColorWithColor(context, borderColor);
    CGContextStrokeRect(context, CGRectMake(_currentPoint.x, 
                                            _currentPoint.y, 
                                            _squareSize, 
                                            _squareSize));
    
    CGContextSetFillColorWithColor(context, color);
    CGContextFillRect(context, CGRectMake(_currentPoint.x, 
                                          _currentPoint.y, 
                                          _squareSize, 
                                          _squareSize));    
}

-(void)nextPoint
{
    [self willChangeValueForKey:@"currentPoint"];
    /*
    if ([self bounds].size.width > _currentPoint.x)
    {
        _currentPoint.x += _squareSize;
    } else 
    {
        _currentPoint.x = 0;
        _currentPoint.y -= _squareSize;
        
        if (_currentPoint.y < 0)
        {
            _currentPoint.y = [self bounds].size.height - _squareSize;
        }
    }
    */
    
    int max_x = (int)([self frame].size.width / _squareSize) + 1;
    int max_y = (int)([self frame].size.height / _squareSize) + 1;
    
    _currentPoint.x = _squareSize * (rand() % max_x);
    _currentPoint.y = _squareSize * (rand() % max_y);
    
    [self didChangeValueForKey:@"currentPoint"];
}

- (BOOL)hasConfigureSheet
{
    return YES;
}

- (BOOL)isFlipped
{
    return YES;
}

- (NSWindow*)configureSheet
{
    if (!configureSheet)
    {
        configureSheet = [[ConfigureSheetController alloc] 
                          initWithWindowNibName:@"ConfigureSheet"];
    }
    
    return [configureSheet window];
}

@end

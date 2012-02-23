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
        ScreenSaverDefaults *defaults;
        defaults = [ScreenSaverDefaults
                    defaultsForModuleWithName:@"com.meanderingsoul.TileFlow"];

        NSMutableDictionary *initialDefaults = [[NSMutableDictionary alloc]
                                                initWithCapacity:2];
        [initialDefaults setObject:[NSNumber numberWithFloat:80]
                            forKey:@"squareSize"];
        [initialDefaults setObject:[NSNumber numberWithFloat:1/20.0]
                            forKey:@"speed"];

        [defaults registerDefaults:[NSDictionary
                                    dictionaryWithDictionary:initialDefaults]];

        _squareSize = [defaults floatForKey:@"squareSize"];
        [self setAnimationTimeInterval:[defaults floatForKey:@"speed"]];

        float y = frame.size.height - _squareSize;
        [self setCurrentPoint:NSMakePoint(-_squareSize, y)];

        srand((int)time(NULL));

        [defaults addObserver:self
                   forKeyPath:@"squareSize"
                      options:NSKeyValueObservingOptionNew
                      context:nil];

        [defaults addObserver:self
                   forKeyPath:@"speed"
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
    [defaults removeObserver:self forKeyPath:@"speed"];

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
    if ([keyPath isEqualToString:@"squareSize"])
        _squareSize = [defaults floatForKey:@"squareSize"];

    if ([keyPath isEqualToString:@"speed"])
        [self setAnimationTimeInterval:[defaults floatForKey:@"speed"]];
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

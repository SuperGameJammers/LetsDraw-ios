//
//  DrawView.h
//  StrokeManipulationWithEraser
//
//  Created by Plamen Petkov on 10/6/14.
//
//

#import <UIKit/UIKit.h>
#import "DrawView.h"

@interface DrawView_ErasingStrokeParts: UIView
@property WCMLayer* viewLayer;
@property WCMLayer* strokesLayer;
@property NSMutableArray * strokes;
@property WCMRenderingContext * willContext;
@end

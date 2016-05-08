//
//  DrawView.h
//  StrokeModelAndPersistance
//
//  Created by Plamen Petkov on 10/1/14.
//
//

#import <UIKit/UIKit.h>
#import <WILLCore/WILLCore.h>

@interface DrawView : UIView

@property WCMLayer* viewLayer;
@property NSMutableArray * strokes;
@property WCMRenderingContext * willContext;

-(void) redrawStrokes;

@end

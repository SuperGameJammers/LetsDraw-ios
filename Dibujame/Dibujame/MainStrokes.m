//
//  MainStrokes.m
//  StrokeEncodingAndDecoding
//
//  Created by Sergio Albarran on 08/05/16.
//
//

#import "MainStrokes.h"
#import "DrawView.h"
#import "DrawView_ErasingStrokeParts.h"
#import "Stroke.h"

@implementation MainStrokes
{
    DrawView * drawView;
//    DrawView_ErasingStrokeParts * eraseView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)drawRect:(CGRect)rect {
    // Do any additional setup after loading the view, typically from a nib.
    drawView = [[DrawView alloc] initWithFrame:self.frame];
//    eraseView = [[DrawView_ErasingStrokeParts alloc] initWithFrame:self.frame];
    [self addSubview:drawView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(deleteStroke:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Delete" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self addSubview:button];
    UIButton *drawB = [UIButton buttonWithType:UIButtonTypeCustom];
    [drawB addTarget:self
              action:@selector(drawStroke:)
    forControlEvents:UIControlEventTouchUpInside];
    [drawB setTitle:@"Draw" forState:UIControlStateNormal];
    [drawB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    drawB.frame = CGRectMake(80.0, 250.0, 160.0, 40.0);
    [self addSubview:drawB];
    
    [self loadStrkoes];
}

-(void)drawStroke:(id)sender
{
//    drawView = [[DrawView alloc] initWithFrame:self.frame];
//    [drawView.willContext drawLayer:eraseView.viewLayer];
//    [eraseView.willContext drawLayer:drawView.viewLayer];
//    drawView.strokes = eraseView.strokes;
//    [self loadStrkoes];
    [self addSubview:drawView];
    
    
}

-(void)deleteStroke:(id)sender
{
    drawView = [[DrawView alloc] initWithFrame:self.frame];

    
}



- (NSMutableArray*) decodeStrokesFromDocumentPath:(NSString*)path
{
    WCMDocument * doc = [[WCMDocument alloc] init];
    
    [doc loadDocumentAtPath:path];
    
    WCMDocumentSection * section = doc.sections[0];
    WCMDocumentSectionPaths * pathsElement = section.subelements[0];
    NSData * inkData = [pathsElement.content loadData];
    
    WCMInkDecoder * decoder = [[WCMInkDecoder alloc] initWithData:inkData];
    
    WCMFloatVector* strokePoints;
    unsigned int strokeStride;
    float strokeWidth;
    UIColor* strokeColor;
    float strokeStartValue;
    float strokeFinishValue;
    WCMBlendMode blendMode;
    
    NSMutableArray * strokes = [[NSMutableArray alloc] init];
    
    while([decoder decodePathToPoints:&strokePoints
                            andStride:&strokeStride
                             andWidth:&strokeWidth
                             andColor:&strokeColor
                                andTs:&strokeStartValue
                                andTf:&strokeFinishValue
                         andBlendMode:&blendMode])
    {
        Stroke * stroke = [Stroke strokeWithPoints:strokePoints
                                         andStride:strokeStride
                                          andWidth:strokeWidth
                                          andColor:strokeColor
                                             andTs:strokeStartValue
                                             andTf:strokeFinishValue
                                      andBlendMode:blendMode];
        [strokes addObject:stroke];
    }
    
    return strokes;
}

@end

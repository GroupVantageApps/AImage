#import "Coordinate.h"

@implementation Coordinate

@synthesize iPadPro_12_9;

static const CGFloat kMultiplier = 1.333f;

- (id) init {
    if (self = [super init]) {
      self.iPadPro_12_9 = [[UIScreen mainScreen] bounds].size.width == 1366.0;
    }
    return self;
}

- (CGFloat) coordinate: (CGFloat) coordinate {
  return coordinate * (iPadPro_12_9 ? kMultiplier : 1);
}

@end

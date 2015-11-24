//
//  DraggableImageView.m
//  Tinder
//
//  Created by Juan Pablo Marzetti on 11/19/15.
//  Copyright © 2015 Juan Pablo Marzetti. All rights reserved.
//

#import "DraggableImageView.h"

#define degreesToRadians( degrees ) ( ( degrees ) / 180.0 * M_PI )

@interface DraggableImageView()
@property (weak, nonatomic) IBOutlet UIImageView *draggableImage;
@property (nonatomic) CGPoint profileImageOriginalCenter;

@property (nonatomic) IBOutlet UIView *contentView;

@end

@implementation DraggableImageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void) initSubviews {
    UINib *nib = [UINib nibWithNibName:@"DraggableImageView" bundle:nil];
    [nib instantiateWithOwner:self options:nil];
    self.contentView.frame = self.bounds;
    [self addSubview:self.contentView];
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.draggableImage.image = image;
}

- (IBAction)onProfileImagePan:(UIPanGestureRecognizer *) sender {
    
    CGPoint translation = [sender translationInView:self.draggableImage];
    CGPoint location = [sender locationInView:self.draggableImage];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.profileImageOriginalCenter = self.draggableImage.center;
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        
        self.draggableImage.center = CGPointMake(self.profileImageOriginalCenter.x + translation.x, self.profileImageOriginalCenter.y);
        
        if (location.y < 152) { // left
            self.draggableImage.transform = CGAffineTransformMakeRotation(degreesToRadians(5 * translation.x/152));
        } else {
            self.draggableImage.transform = CGAffineTransformMakeRotation(degreesToRadians(-5 * translation.x/152));
        }
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        CGPoint newCenter;
        CGAffineTransform newTransform;
        CGFloat angle = 20;
        
        if (translation.x > 50) {
            newCenter = CGPointMake(self.profileImageOriginalCenter.x + 152 * 3.5, self.profileImageOriginalCenter.y);
        } else if (translation.x < -50) {
            newCenter = CGPointMake(self.profileImageOriginalCenter.x - 152 * 3.5, self.profileImageOriginalCenter.y);
        } else {
            newCenter =self.profileImageOriginalCenter;
            angle = 0;
        }
        
        if (location.y < 152) { // left
            newTransform = CGAffineTransformMakeRotation(degreesToRadians(angle * translation.x/152));
        } else {
            newTransform = CGAffineTransformMakeRotation(degreesToRadians(-angle * translation.x/152));
        }

        [UIView animateWithDuration:0.3 animations:^{
            self.draggableImage.center = newCenter;
            self.draggableImage.transform = newTransform;
        }];
    }
}



@end

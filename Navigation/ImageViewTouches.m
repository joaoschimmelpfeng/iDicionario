//
//  ImageViewTouches.m
//  Navigation
//
//  Created by João Vitor dos Santos Schimmelpfeng on 19/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "ImageViewTouches.h"

@implementation ImageViewTouches
@synthesize isEditing,root;

- (id)init
{
    self = [super init];
    if (self)
    {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(mover:)];
        
        [self addGestureRecognizer:pan];
        self.userInteractionEnabled = YES;

    }
    return self;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self setImage:image];
    [self setNeedsDisplay];
    [root dismissViewControllerAnimated:YES completion:NULL];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
 if(isEditing)
 {
     UIImagePickerController *picker = [[UIImagePickerController alloc] init];
     picker.modalPresentationStyle = UIModalPresentationCurrentContext;
     [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
     picker.delegate = self;
     UIWindow *window = [UIApplication sharedApplication].keyWindow;
     root = window.rootViewController;
     
     [root presentViewController:picker animated:YES completion:^{
         
     }];
 }
 else
 {
  self.frame = CGRectMake(self.frame.origin.x - 50, self.frame.origin.y - 50, 200, 200);
 }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
 if(!isEditing)
 {
  self.frame = CGRectMake(self.frame.origin.x + 50, self.frame.origin.y + 50, 100, 100);
 }
}

-(void) mover:(UIPanGestureRecognizer *)pan
{
 if(!isEditing)
 {
  self.frame = CGRectMake([pan locationInView:self.superview].x - 50 , [pan locationInView:self.superview].y - 50, 100, 100);
 }
}

@end

//
//  ImageViewTouches.m
//  Navigation
//
//  Created by João Vitor dos Santos Schimmelpfeng on 19/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "ImageViewTouches.h"
#import <Realm/Realm.h>
#import "persistenceObject.h"

@implementation ImageViewTouches
@synthesize isEditing,root,idVal;

- (id)initWithVal:(int)val
{
    self = [super init];
    if (self)
    {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(mover:)];
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(redimensionar:)];
        idVal = val;
        
        [self addGestureRecognizer:pan];
        [self addGestureRecognizer:pinch];
        self.userInteractionEnabled = YES;

    }
    return self;
}

-(void) redimensionar:(UIPinchGestureRecognizer *)pinch
{
 if ([pinch state] == UIGestureRecognizerStateEnded)
 {
  self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 100, 100);
  self.layer.cornerRadius = self.frame.size.height /2;
 }
 else
 {
  self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 300, 300);
  self.layer.cornerRadius = self.frame.size.height /2;
 }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self setImage:image];
    [self setNeedsDisplay];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    persistenceObject *imgSave = [[persistenceObject alloc] init];
    [imgSave setImageToSave:[NSData dataWithData:UIImagePNGRepresentation(image)]];
    [imgSave setIdVal:idVal];
    [realm beginWriteTransaction];
    [realm addObject:imgSave];
    [realm commitWriteTransaction];
    
    
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
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
 if(!isEditing)
 {
  self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 100, 100);
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

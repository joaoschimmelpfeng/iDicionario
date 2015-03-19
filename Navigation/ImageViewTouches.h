//
//  ImageViewTouches.h
//  Navigation
//
//  Created by João Vitor dos Santos Schimmelpfeng on 19/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewTouches : UIImageView <UINavigationControllerDelegate ,UIImagePickerControllerDelegate>

@property BOOL isEditing;
@property UIViewController *root;

-(void) mover:(UIPanGestureRecognizer *)pan;

@end

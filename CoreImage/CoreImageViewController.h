//
//  CoreImageViewController.h
//  CoreImage
//
//  Created by TUTU on 14-4-7.
//  Copyright (c) 2014年 TUTU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreImageViewController :UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)filter1:(id)sender;

- (IBAction)filter2:(id)sender;

- (IBAction)filter3:(id)sender;


@end

//
//  CoreImageViewController.m
//  CoreImage
//
//  Created by TUTU on 14-4-7.
//  Copyright (c) 2014年 TUTU. All rights reserved.
//

#import "CoreImageViewController.h"

@interface CoreImageViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    CIContext *context;
    CIFilter *filter;
    CIImage *inputImage;    //輸入的圖片
    CIImage *outputImage;   //輸出濾鏡效果的圖片
}

@end

@implementation CoreImageViewController
@synthesize imageView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *img = [UIImage imageNamed:@"image.jpg"];
    imageView.image = img;
    inputImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"image.jpg"]];
}

- (IBAction)filter1:(id)sender {
    
    inputImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"image.jpg"]];
    
    //2
    context = [CIContext contextWithOptions:nil];
    
    //3
    filter = [CIFilter filterWithName:@"CIBumpDistortion"];
    [filter setValue:inputImage forKey:@"inputImage"];
    [filter setValue:[CIVector vectorWithX:400 Y:300] forKey:@"inputCenter"];
    [filter setValue:[NSNumber numberWithFloat:100] forKey:@"inputRadius"];
    [filter setValue:[NSNumber numberWithFloat:3] forKey:@"inputScale"];
    //4
    outputImage = [filter outputImage];
    imageView.image = [UIImage imageWithCGImage:[context createCGImage:outputImage fromRect:outputImage.extent]];
}

- (IBAction)filter2:(id)sender {
    
    inputImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"image.jpg"]];
    
    //2
    context = [CIContext contextWithOptions:nil];
    
    //3
    filter = [CIFilter filterWithName:@"CIHueAdjust"];
    [filter setValue:inputImage forKey:@"inputImage"];
    [filter setValue:[NSNumber numberWithFloat:2.0] forKey:@"inputAngle"];
	
    //4
    outputImage = [filter outputImage];
    imageView.image = [UIImage imageWithCGImage:[context createCGImage:outputImage fromRect:outputImage.extent]];

}

- (IBAction)filter3:(id)sender {
    
    inputImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"image.jpg"]];
    
    //2
    context = [CIContext contextWithOptions:nil];
    
    filter = [CIFilter filterWithName:@"CIGloom"]; // 1
    [filter setValue:inputImage forKey:@"inputImage"];
    [filter setValue: [NSNumber numberWithFloat: 0.75]
             forKey: @"inputIntensity"]; // 3
    
    outputImage = [filter outputImage];
    imageView.image = [UIImage imageWithCGImage:[context createCGImage:outputImage fromRect:outputImage.extent]];
}

- (IBAction)takePicture:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
 }

- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)savePhoto:(id)sender {
    
    CIImage *saveToSave = [filter outputImage];
    CIContext *softwareContext = [CIContext
    contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES)} ];
    CGImageRef cgImg = [softwareContext createCGImage:saveToSave
    fromRect:[saveToSave extent]];
    ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:cgImg
    metadata:[saveToSave properties]
    completionBlock:^(NSURL *assetURL, NSError *error) {
    CGImageRelease(cgImg);
                          }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
   
    UIImage *gotImage =
    [info objectForKey:UIImagePickerControllerOriginalImage];
    inputImage = [CIImage imageWithCGImage:gotImage.CGImage];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    
}

- (void)imagePickerControllerDidCancel:
(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end


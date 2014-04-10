//
//  UIImage+Resize.h
//

#import <Foundation/Foundation.h>

@interface UIImage (resize)
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
@end
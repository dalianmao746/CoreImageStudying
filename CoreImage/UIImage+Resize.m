#import "UIImage+Resize.h"

@implementation UIImage (resize)

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
  UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  return newImage;
}

@end

//
//  UIView+TagExtensions.m
//
//  Created by Daniel Brajkovic on 2/19/12.
//

#import "UIView+TagExtensions.h"

@implementation UIView (TagExtensions)

- (UIButton *)buttonWithTag:(NSInteger)aTag
{
    UIView *aView = [self viewWithTag:aTag];
    if (aView && [aView isKindOfClass:[UIButton class]]) {
        return (UIButton *) aView;
    }
    return nil;
}

- (UIImageView *)imageViewWithTag:(NSInteger)aTag
{
    UIView *aView = [self viewWithTag:aTag];
    if (aView && [aView isKindOfClass:[UIImageView class]]) {
        return (UIImageView *) aView;
    }
    return nil;
}

- (UILabel *)labelWithTag:(NSInteger)aTag
{
    UIView *aView = [self viewWithTag:aTag];
    if (aView && [aView isKindOfClass:[UILabel class]]) {
        return (UILabel *) aView;
    }
    return nil;
}

- (UIScrollView *)scrollViewWithTag:(NSInteger)aTag
{
    UIView *aView = [self viewWithTag:aTag];
    if (aView && [aView isKindOfClass:[UIScrollView class]]) {
        return (UIScrollView *) aView;
    }
    return nil;
}

- (UITextField *)textFieldWithTag:(NSInteger)aTag
{
    UIView *aView = [self viewWithTag:aTag];
    if (aView && [aView isKindOfClass:[UITextField class]]) {
        return (UITextField*) aView;
    }
    return nil;
}

- (UITextView *)textViewWithTag:(NSInteger)aTag
{
    UIView *aView = [self viewWithTag:aTag];
    if (aView && [aView isKindOfClass:[UITextView class]]) {
        return (UITextView *) aView;
    }
    return nil;
}

@end
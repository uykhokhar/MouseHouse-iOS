//
//  UIView+TagExtensions.h
//
//  Created by Daniel Brajkovic on 2/19/12.

#import <UIKit/UIKit.h>

@interface UIView (TagExtensions)

- (UIButton *)buttonWithTag:(NSInteger)aTag;
- (UIImageView *)imageViewWithTag:(NSInteger)aTag;
- (UILabel *)labelWithTag:(NSInteger)aTag;
- (UIScrollView *)scrollViewWithTag:(NSInteger)aTag;
- (UITextField *)textFieldWithTag:(NSInteger)aTag;
- (UITextView *)textViewWithTag:(NSInteger)aTag;

@end
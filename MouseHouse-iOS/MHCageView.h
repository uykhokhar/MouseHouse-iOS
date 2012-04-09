//
//  MHCageView.h
//  MouseHouse-iOS
//
//  Created by Daniel Brajkovic on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHCageView : UIView

@property (strong, nonatomic) NSMutableDictionary *cage;
@property (weak, nonatomic) id delegate;
@property (strong, nonatomic) NSString *column;
@property (strong, nonatomic) NSString *row;

@end

@protocol MHCageViewDelegate <NSObject>

- (void)cageViewTapped:(id)sender;

@end

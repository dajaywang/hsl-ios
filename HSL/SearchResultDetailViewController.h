//
//  SearchResultDetailViewController.h
//  HSL
//
//  Created by DajieWang on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class Routing;

#import <UIKit/UIKit.h>

@interface SearchResultDetailViewController : UITableViewController

@property (strong) Routing *oneRouting;

-(UILabel *)labelForOneLegOfRouting:(NSString *)legStr withFrame:(CGRect)frame withFont:(CGFloat)fontSize;
-(UIImageView *)imageForOneLegOfRouting:(NSString *)typeStr withFrame:(CGRect)frame;
@end

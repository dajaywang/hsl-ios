//
//  SearchResultCell.m
//  HSL
//
//  Created by DajieWang on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchResultCell.h"

@implementation SearchResultCell

@synthesize totalDistance100;
@synthesize totalTime101;

@synthesize timeLable102;
@synthesize timeLable103;
@synthesize timeLable104;
@synthesize timeLable105;
@synthesize timeLable106;
@synthesize timeLable107;
@synthesize timeLable108;
@synthesize timeLable109;

@synthesize nameNumber110;
@synthesize nameNumber111;
@synthesize nameNumber112;
@synthesize nameNumber113;
@synthesize nameNumber114;
@synthesize nameNumber115;
@synthesize nameNumber116;

@synthesize image120;
@synthesize image121;
@synthesize image122;
@synthesize image123;
@synthesize image124;
@synthesize image125;
@synthesize image126;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  RssItemCell.h
//  iosc.02
//
//  Created by MrDekk on 10/08/14.
//  Copyright (c) 2014 mrdekk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RssItemCell : UITableViewCell

@property ( nonatomic, retain ) IBOutlet UIImageView* ImageView;
@property ( nonatomic, retain ) IBOutlet UILabel* Title;
@property ( nonatomic, retain ) IBOutlet UILabel* Desc;
@property ( nonatomic, retain ) IBOutlet UILabel* Date;

@end

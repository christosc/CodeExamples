//
//  AUTTextCell.m
//  AutolayoutTest
//
//  Created by Christos Chryssochoidis on 19/7/14.
//  Copyright (c) 2014 Christos Ap. Chryssochoidis. All rights reserved.
//

#import "AUTTextCell.h"

@implementation AUTTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
	if (self) {
		_customLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_customLabel.numberOfLines = 0;
		
		[self.contentView addSubview:_customLabel];
		
		[self setupConstraints];
	}
	
	return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupConstraints
{
	_customLabel.translatesAutoresizingMaskIntoConstraints = NO;
	
	NSDictionary* nameMap = @{@"label": _customLabel};
	
	NSArray* horizontalContraints = [NSLayoutConstraint
		constraintsWithVisualFormat:@"H:|-0-[label]-0-|"
		options:0
		metrics:nil
		views:nameMap];
	
	NSArray* vertivalConstraints = [NSLayoutConstraint
		constraintsWithVisualFormat:@"V:|-0-[label]-0-|"
		options:0
		metrics:nil
		views:nameMap];
	
	[self.contentView addConstraints:horizontalContraints];
	[self.contentView addConstraints:vertivalConstraints];
}

// Using this override the font size change through the device's preferences
// is made much smoother, using animation.
- (void)layoutSubviews
{
	[super layoutSubviews];
	
	[self.contentView layoutIfNeeded];
	self.customLabel.preferredMaxLayoutWidth =
		CGRectGetWidth(self.contentView.frame);
}


@end

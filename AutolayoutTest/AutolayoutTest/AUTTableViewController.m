//
//  AUTTableViewController.m
//  AutolayoutTest
//
//  Created by Christos Chryssochoidis on 19/7/14.
//  Copyright (c) 2014 Christos Ap. Chryssochoidis. All rights reserved.
//

#import "AUTTableViewController.h"
#import "AUTTextCell.h"


static NSString* const CellIdentifier = @"CellIdentifier";

@interface AUTTableViewController ()

@property (strong, nonatomic) NSArray* sourceData;
@property (strong, nonatomic) AUTTextCell* prototypeCell;

@end

@implementation AUTTableViewController


- (NSArray*)sourceData
{
	if (!_sourceData) {
		NSString* dataPath = [[NSBundle mainBundle]
			pathForResource:@"SourceData" ofType:@"plist"];
		
		_sourceData = [NSArray arrayWithContentsOfFile:dataPath];
	}
	
	return _sourceData;
}

- (AUTTextCell*)prototypeCell
{
	if (!_prototypeCell) {
		_prototypeCell = [self.tableView
			dequeueReusableCellWithIdentifier:CellIdentifier];
	}
	
	return _prototypeCell;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	[self.tableView registerClass:[AUTTextCell class]
	       forCellReuseIdentifier:CellIdentifier];
	
	// Uncomment the following line to preserve selection between presentations.
	// self.clearsSelectionOnViewWillAppear = NO;
	
	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	// self.navigationItem.rightBarButtonItem = self.editButtonItem;
	[[NSNotificationCenter defaultCenter] addObserver:self
	 	selector:@selector(didChangePreferredContentSize:)
	 	name:UIContentSizeCategoryDidChangeNotification
		object:nil];
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self
	 	name:UIContentSizeCategoryDidChangeNotification
	 	object:nil];
}


- (void)didChangePreferredContentSize:(NSNotification*)notification
{
	[self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.sourceData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
	 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView
		dequeueReusableCellWithIdentifier:CellIdentifier
				 forIndexPath:indexPath];
    
	[self configureCell:cell forRowAtIndexPath:indexPath];
	
    
	return cell;
}

- (void)configureCell:(UITableViewCell*)cell
    forRowAtIndexPath:(NSIndexPath*)ip
{
	if ([cell isKindOfClass:[AUTTextCell class]]) {
		AUTTextCell* textCell = (AUTTextCell*)cell;
		
		textCell.customLabel.text = [self.sourceData
			objectAtIndex:ip.row];
		
		textCell.customLabel.font =
			[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
	}
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView*)tableView
heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
	[self configureCell:self.prototypeCell forRowAtIndexPath:indexPath];
	
	[self.prototypeCell layoutIfNeeded];
	
	CGSize size = [self.prototypeCell.contentView
		systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
	
	return size.height + 1;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

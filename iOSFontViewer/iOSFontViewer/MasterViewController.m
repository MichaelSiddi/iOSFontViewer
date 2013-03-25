//
//  MasterViewController.m
//  iOSFontViewer
//
//  Created by Michael Siddi on 3/25/13.
//  Copyright (c) 2013 Michael Siddi. All rights reserved.
//

#import "MasterViewController.h"

#define kText @"This is a sample text."

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Available Fonts", @"Master");
    }
    return self;
}
							
- (void)dealloc
{
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

//    UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)] autorelease];
//    self.navigationItem.rightBarButtonItem = addButton;
    
    
    self.families = [NSMutableArray array];
    self.fonts = [NSMutableArray array];
    
    // List all fonts on iPhone
    NSArray *familyNames = [UIFont familyNames];
    
    familyNames = [familyNames sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *a = (NSString *)obj1;
        NSString *b = (NSString *)obj2;
        
        return [a compare:b options:NSCaseInsensitiveSearch];

    }];

    for (NSString *famName in familyNames) {
        if (famName) {
            NSArray *fontNames = [UIFont fontNamesForFamilyName:famName];

            [self.families addObject:famName];
            [self.fonts addObject:fontNames];
        }
    }
    
    [self.tableView reloadData];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.families count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.fonts objectAtIndex:section] count];
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.families objectAtIndex:section];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    NSArray *theFonts = [self.fonts objectAtIndex:indexPath.section];
    
    NSString *fontName = [theFonts objectAtIndex:indexPath.row];

    [cell.textLabel setText:kText];
    [cell.textLabel setFont:[UIFont fontWithName:fontName size:18]];
    
    [cell.detailTextLabel setFont:[UIFont fontWithName:@"Heveltica Neue" size:10]];
    cell.detailTextLabel.text = fontName;
    return cell;
}



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


@end

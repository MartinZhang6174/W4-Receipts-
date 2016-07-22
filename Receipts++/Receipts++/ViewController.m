//
//  ViewController.m
//  Receipts++
//
//  Created by Martin Zhang on 2016-07-21.
//  Copyright © 2016 Martin Zhang. All rights reserved.
//

#import "ViewController.h"
#import "ReceiptCell.h"
@import CoreData;

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchResultsController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // The number of objects that were fetched are responsible for the number of rows in section.
    return [self.fetchResultsController.fetchedObjects count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReceiptCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = @"Martin is the best.";
    cell.detailTextLabel.text = @"This man is the man of the world.";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    ReceiptCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [cell setHighlighted:NO];
}

@end

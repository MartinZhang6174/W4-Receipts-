//
//  NewReceiptViewController.m
//  Receipts++
//
//  Created by Martin Zhang on 2016-07-21.
//  Copyright © 2016 Martin Zhang. All rights reserved.
//

#import "NewReceiptViewController.h"
#import "TagPickerView.h"
#import "AppDelegate.h"
#import "Receipt.h"
#import "Tag.h"

@interface NewReceiptViewController ()
{
    NSManagedObjectContext *context;
}
@property (strong, nonatomic) IBOutlet TagPickerView *scrollPickerView;
@property (strong, nonatomic) IBOutlet UITextField *amountTextField;
@property (strong, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (strong, nonatomic) IBOutlet UITextField *noteTextField;
@property (strong, nonatomic) IBOutlet UILabel *pickerSelectionResultDisplayLabel;
@property (strong, nonatomic) NSString *selectedPickerRowTitle;
@property (strong, nonatomic) NSArray *tagCollection;

@end

@implementation NewReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tagCollection = [[NSArray alloc] initWithObjects:@"Family", @"Friends", @"Business", nil];
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    context = appDelegate.managedObjectContext;
}
//- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED {
//    
//}

- (IBAction)doneButtonPressed:(id)sender {
    if (self.amountTextField.text != nil && self.descriptionTextField.text != nil && self.noteTextField.text != nil && self.selectedPickerRowTitle != nil) {
        NSEntityDescription *tagEntityDesc = [NSEntityDescription entityForName:@"Tag" inManagedObjectContext:context];
        NSEntityDescription *receiptEntityDesc = [NSEntityDescription entityForName:@"Receipt" inManagedObjectContext:context];
        Tag *tag = [[Tag alloc] initWithEntity:tagEntityDesc insertIntoManagedObjectContext:context];
        Receipt *receipt = [[Receipt alloc] initWithEntity:receiptEntityDesc insertIntoManagedObjectContext:context];
        receipt.note = self.noteTextField.text;
        receipt.detail = self.descriptionTextField.text;
        NSNumber *amountFloatNumber = [NSNumber numberWithFloat:[self.amountTextField.text floatValue]];
        receipt.amount = amountFloatNumber;
        [receipt addTagsObject:tag];
        
        NSError *error;
        [context save:&error];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


// Setting up scrolling picker view
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.tagCollection.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.tagCollection objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSUInteger selectedRow = [self.scrollPickerView selectedRowInComponent:0];
    self.selectedPickerRowTitle = [[self.scrollPickerView delegate] pickerView:self.scrollPickerView titleForRow:selectedRow forComponent:0];
    self.pickerSelectionResultDisplayLabel.text = self.selectedPickerRowTitle;
}

@end

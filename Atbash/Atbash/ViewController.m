//
//  ViewController.m
//  Atbash
//
//  Created by Donny Davis on 5/4/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *stringTextField;
@property (weak, nonatomic) IBOutlet UILabel *outputLabel;

- (NSString *)performAtbash:(NSString *)stringToConvert;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.outputLabel.text = @"";
    [self.stringTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)performAtbash:(NSString *)stringToConvert {
    NSMutableString *newString = [[NSMutableString alloc] init];
    NSString *forward = @"abcdefghijklmnopqrstuvwxyz";
    NSString *reverse = @"zyxwvutsrqponmlkjihgfedcba";
    
    int index = (int)stringToConvert.length - 1;
    while (index >= 0) {
        [newString setString:[newString stringByAppendingString:[NSString stringWithFormat:@"%c", (char)[stringToConvert characterAtIndex:index]]]];
        index -= 1;
    }
    
    return [newString copy];
}

#pragma mark - Button Actions 

- (IBAction)atbashAction:(UIButton *)sender {
    if (![self.stringTextField.text isEqualToString:@""]) {
        self.outputLabel.text = [self performAtbash:self.stringTextField.text];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Must enter string to convert" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okButton];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - Text Field Delegates

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.outputLabel.text = @"";
}

@end

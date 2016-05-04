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
    NSCharacterSet *letterSet = [NSCharacterSet characterSetWithCharactersInString:forward];
    NSArray *wordsArray = [stringToConvert componentsSeparatedByString:@" "];
    NSRange rangeOfLetter;
    NSString *letter = @"";
    
    for (NSString *word in wordsArray) {
        int index = 0;
        while (index < word.length) {
            letter = [NSString stringWithFormat:@"%c", [word characterAtIndex:index]];
            rangeOfLetter = [forward rangeOfString:letter];
            if ([letter rangeOfCharacterFromSet:[letterSet invertedSet]].location == NSNotFound) {
                [newString setString:[newString stringByAppendingString:[NSString stringWithFormat:@"%c", (char)[reverse characterAtIndex:rangeOfLetter.location]]]];
            } else {
                [newString setString:[newString stringByAppendingString:letter]];
            }
            index += 1;
        }
        if (wordsArray.count > 1) {
            [newString setString:[newString stringByAppendingString:@" "]];
        }
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

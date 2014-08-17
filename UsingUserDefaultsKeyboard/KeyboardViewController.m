//
//  KeyboardViewController.m
//  UsingUserDefaultsKeyboard
//
//  Created by Nanba Takeo on 2014/08/17.
//  Copyright (c) 2014年 GrooveLab. All rights reserved.
//

#import "KeyboardViewController.h"

static NSString *const AppGroupId = @"group.asia.groovelab.KeyboardExtensionContaining";
static NSString *const UserDefaultsKey = @"keyborad";

@interface KeyboardViewController ()
@property (nonatomic, strong) UIButton *nextKeyboardButton;

@property (nonatomic, strong) NSDictionary *keyButtonTexts;

@end

@implementation KeyboardViewController

@synthesize keyButtonTexts;

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Perform custom UI setup here
    self.nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.nextKeyboardButton setTitle:NSLocalizedString(@"Next Keyboard", @"Title for 'Next Keyboard' button") forState:UIControlStateNormal];
    [self.nextKeyboardButton sizeToFit];
    self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.nextKeyboardButton addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.nextKeyboardButton];
    
    NSLayoutConstraint *nextKeyboardButtonLeftSideConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    NSLayoutConstraint *nextKeyboardButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    [self.view addConstraints:@[nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint]];


    //  UserDefaults
    NSUserDefaults *sharedUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:AppGroupId];
    NSArray *textArray = [sharedUserDefaults objectForKey:UserDefaultsKey];
    
    if ( textArray.count == 0 ) {
        return;
    }
    
    //  add buttons
    NSMutableDictionary *texts = [NSMutableDictionary dictionary];
    
    CGFloat x = 0.0f;
    CGFloat y = 0.0f;
    CGFloat space = 30.0f;
    
    int i = 0;
    for ( NSString *text in textArray ) {
        UIButton *keyButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [keyButton setTitle:text forState:UIControlStateNormal];
        [keyButton sizeToFit];
        CGRect frame = keyButton.frame;
        keyButton.frame = CGRectMake(frame.origin.x + x, frame.origin.y + y, frame.size.width, frame.size.height);
        x += frame.size.width + space;
        
        [texts setObject:text forKey:@(i)];
        keyButton.tag = i++;
        [keyButton addTarget:self action:@selector(keyButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:keyButton];
    }
    
    self.keyButtonTexts = texts;

}

- (void)keyButtonPressed:(UIButton*)sender {
    NSLog(@"%ld button pressed", sender.tag);

    NSString *text = [self.keyButtonTexts objectForKey:@(sender.tag)];
    if ( text ) {
        [self.textDocumentProxy insertText:text];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}

@end

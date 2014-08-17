//
//  ViewController.m
//  KeyboardExtensionContaining
//
//  Created by Nanba Takeo on 2014/08/17.
//  Copyright (c) 2014年 GrooveLab. All rights reserved.
//

#import "ViewController.h"

static NSString *const AppGroupId = @"group.asia.groovelab.KeyboardExtensionContaining";
static NSString *const UserDefaultsKey = @"keyborad";

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UITextField *textField3;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //  UserDefaults
    NSUserDefaults *sharedUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:AppGroupId];
    NSArray *texts = [sharedUserDefaults objectForKey:UserDefaultsKey];
    
    int i = 1;
    for ( NSString *text in texts ) {
        UITextField *textField = [self valueForKey:[NSString stringWithFormat:@"textField%d", i++]];
        if ( textField ) {
            textField.text = text;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Action Methods
- (IBAction)saveAction:(id)sender {
    //  UserDefaults
    NSUserDefaults *sharedUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:AppGroupId];
    
    NSMutableArray *texts = [NSMutableArray array];
    
    NSString *string1 = self.textField1.text;
    if ( string1 ) {
        [texts addObject:string1];
    }
    NSString *string2 = self.textField2.text;
    if ( string2 ) {
        [texts addObject:string2];
    }
    NSString *string3 = self.textField3.text;
    if ( string3 ) {
        [texts addObject:string3];
    }

    [sharedUserDefaults setObject:texts forKey:UserDefaultsKey];
}


@end

//
//  ViewController.m
//  GenBarCode
//
//  Created by Steve Yeom on 9/18/14.
//  Copyright (c) 2014 2nd Jobs. All rights reserved.
//

#import "ViewController.h"
#import "NKDCode128Barcode.h"
#import "UIImage-NKDBarcode.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  UIImage *templateImage = [UIImage imageNamed:@"template.png"];
  UIImageView *tview = [[UIImageView alloc] initWithImage:templateImage];
  tview.frame = CGRectMake(0, 0, 320, 576);
  [self.view addSubview:tview];
  
  [self showInput];
}

- (void)showInput {
  UIAlertView *inputNumberAlertView = [[UIAlertView alloc] initWithTitle:@"쿠폰땡처리" message:@"바코드를 만들어보자" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
  inputNumberAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
  [inputNumberAlertView show];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 1) {
    [self generateBarCodeWithNumber:[alertView textFieldAtIndex:0].text];
  }
}

- (void)generateBarCodeWithNumber:(NSString*)number {
  long long num = [number longLongValue];
  NSString *numString = [NSString stringWithFormat:@"%lld", num];
  
  if (number.length != 12 || numString.length != 12) {
    [self showInput];
    return;
  }

  NSString *range1 = [number substringWithRange:NSMakeRange(0, 4)];
  NSString *range2 = [number substringWithRange:NSMakeRange(4, 4)];
  NSString *range3 = [number substringWithRange:NSMakeRange(8, 4)];
  NSString *contentLabel = [NSString stringWithFormat:@"%@ %@ %@", range1, range2, range3];

  NKDCode128Barcode *code = [[NKDCode128Barcode alloc] initWithContent:number];
  UIImage * generatedImage = [UIImage imageFromBarcode:code]; // ..or as a less accurate UIImage
  UIImageView *view = [[UIImageView alloc] initWithImage:generatedImage];
  view.backgroundColor = [UIColor whiteColor];
  view.frame = CGRectMake(51, 410, 220, 50);
  [self.view addSubview:view];
  
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(90, 460, 220, 30)];
  label.backgroundColor = [UIColor whiteColor];
  label.text = contentLabel;
  [self.view addSubview:label];
}

@end

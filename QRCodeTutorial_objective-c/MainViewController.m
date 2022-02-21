//
//  ViewController.m
//  QRCodeTutorial_objective-c
//
//  Created by Kwon Young Jeong on 2022/02/21.
//

#import "MainViewController.h"
#import <QRCodeReaderViewController/QRCodeReaderViewController.h>
#import <QRCodeReader.h>

@interface MainViewController () <QRCodeReaderDelegate>
{
	QRCodeReaderViewController *qrCodeVC;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	// Create the reader object
	QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];

	// Instantiate the view controller
	qrCodeVC = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];

	// Set the presentation style
	qrCodeVC.modalPresentationStyle = UIModalPresentationFormSheet;

	// Define the delegate receiver
	// QR코드 인식이 성공했는지 메인뷰에서 알 수 있게 해준다.
	qrCodeVC.delegate = self;

	// Or use blocks
//	[_reader setCompletionWithBlock:^(NSString *resultAsString) {
//	  NSLog(@"%@", resultAsString);
//	}];
    
    NSURL *websiteUrl = [NSURL URLWithString:@"http://www.naver.com"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [_webView loadRequest:urlRequest];
    
    [_qrCodeBtn layer].borderColor = [UIColor blueColor].CGColor;
    [_qrCodeBtn layer].borderWidth = 3;
    [_qrCodeBtn layer].cornerRadius = 10;
    [_qrCodeBtn layer].backgroundColor = [UIColor orangeColor].CGColor;
    
    // 버튼 클릭시 qrCodeReadereLaunch 메소드 호출
    [_qrCodeBtn addTarget:self action:@selector(qrCodeReaderLaunch) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
	NSLog(@"QR코드 인식 성공!");
	
	NSURL *websiteUrl = [NSURL URLWithString:result];
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
	[_webView loadRequest:urlRequest];
	
  [self dismissViewControllerAnimated:YES completion:^{
	NSLog(@"QR코드 결과: %@", result);
  }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
	NSLog(@"QR코드 인식 취소!");
  [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)qrCodeReaderLaunch{
    NSLog(@"MainViewController - qrCodeReaderLaunch() called");
	
	[self presentViewController:qrCodeVC animated:YES completion:NULL];
}

@end

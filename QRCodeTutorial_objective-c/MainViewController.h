//
//  ViewController.h
//  QRCodeTutorial_objective-c
//
//  Created by Kwon Young Jeong on 2022/02/21.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *qrCodeBtn;

@end


//
//  LLPDFReaderViewController.m
//  iOS开发demo集锦
//
//  Created by 周尊贤 on 2017/5/12.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLPDFReaderViewController.h"
#import "ReaderViewController.h"
@interface LLPDFReaderViewController ()<ReaderViewControllerDelegate>

@end

@implementation LLPDFReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * pdfBtn = [UIButton new];
    pdfBtn.backgroundColor = [UIColor redColor];
    [pdfBtn setTitle:@"点击加载pdf阅读器" forState:UIControlStateNormal];
    [pdfBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    pdfBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:pdfBtn];
    pdfBtn.frame = CGRectMake(CGRectGetMaxX(self.view.frame) /2 -100, CGRectGetMaxY(self.view.frame) /2-35/2, 200,35);
    [pdfBtn addTarget:self action:@selector(pdfBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)pdfBtnClick {
    
    NSString *phrase = nil; // Document password (for unlocking most encrypted PDF files)
    
    NSArray *pdfs = [[NSBundle mainBundle] pathsForResourcesOfType:@"pdf" inDirectory:nil];
    
    NSString *filePath = [pdfs lastObject]; assert(filePath != nil); // Path to first PDF file
    
    ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:phrase];
    
    if (document != nil) // Must have a valid ReaderDocument object in order to proceed with things
    {
        ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
        
        readerViewController.delegate = self; // Set the ReaderViewController delegate to self
        
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
        
        [self.navigationController pushViewController:readerViewController animated:YES];
        
#else // present in a modal view controller
        
        readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        
        [self presentViewController:readerViewController animated:YES completion:NULL];
        
#endif // DEMO_VIEW_CONTROLLER_PUSH
    }
    else // Log an error so that we know that something went wrong
    {
        NSLog(@"%s [ReaderDocument withDocumentFilePath:'%@' password:'%@'] failed.", __FUNCTION__, filePath, phrase);
    }

}

-(void)dismissReaderViewController:(ReaderViewController *)viewController {
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
    
    [self.navigationController popViewControllerAnimated:YES];
    
#else // dismiss the modal view controller
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
#endif // DEMO_VIEW_CONTROLLER_PUSH

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ViewController.m
//  Test
//
//  Created by qyhc on 2017/11/13.
//  Copyright © 2017年 com.qykj. All rights reserved.
//

#import "ViewController.h"

//#import "SVProgressHUD/SVProgressHUD.h"



@interface ViewController ()

@property (nonatomic, strong) UIImageView *picImgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.picImgView = [[UIImageView alloc]init];
    self.picImgView.frame = CGRectMake(10, 100, 200, 200);
    self.picImgView.image = [UIImage imageNamed:@"photo.png"];
    
    UILongPressGestureRecognizer *gestur = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    
    gestur.minimumPressDuration = 1;
    
    [_picImgView addGestureRecognizer:gestur];
    
    _picImgView.contentMode = UIViewContentModeScaleAspectFit;
    
    _picImgView.userInteractionEnabled = YES;
    [self.view addSubview:self.picImgView];
    
}



- (void)longPressAction:(UIGestureRecognizer *)gestrue{
    
    
    if(gestrue.state == UIGestureRecognizerStateBegan){

        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"保存图片" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"取消保存图片");
        }];
        
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"确认保存图片");
            
            /*你要保存到本地相册的图片对象，当然此处更多的需求可能是长按保存，那你就写个长按收拾UILongPressGestureRecognizer手势，给手势加个触发方法不就行了嘛*/
            UIImageWriteToSavedPhotosAlbum(_picImgView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);

        }];
        
        [alertControl addAction:cancel];
        [alertControl addAction:confirm];
        
        [self presentViewController:alertControl animated:YES completion:nil];
        
    }
}


- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(id)contextInfo{
    
    NSString *message ;
    
    if(!error){
        message = [NSString stringWithFormat:@"成功保存到相册"];

    }else{
       message = [NSString stringWithFormat:@"保存失败"];
    }
    
    NSLog(@"%@",message);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end

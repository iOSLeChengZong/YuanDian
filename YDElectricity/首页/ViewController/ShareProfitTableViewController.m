//
//  ShareProfitTableViewController.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/28.
//  Copyright © 2018 yuandian. All rights reserved.
//

//原始尺寸
static CGRect oldframe;

#import "ShareProfitTableViewController.h"

@interface ShareProfitTableViewController ()

@property (weak, nonatomic) IBOutlet UIView *shareProfitView;
//截取分享图
@property(nonatomic,strong) UIImageView *shareImageView;

@end

@implementation ShareProfitTableViewController

#pragma mark -- 懒加载
-(UIImageView *)shareImageView{
    if (!_shareImageView) {
        _shareImageView = [self shotProfitScreen];
    }
    return _shareImageView;
}


#pragma mark -- 生命周期


//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = YES;
//
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NSLog(@"ShareProfitCfell:%ld",indexPath.row);
        [self scanBigImageWithImageView];
        
        //1.截图 UIImage
        //2.计算放大尺寸
        //3.显示放大图
        
    }
}

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -- 点击事件方法

- (IBAction)onBackBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)shareImage:(id)sender {
//    UIImage *shareImage = [self ShareImage];
    NSLog(@"点击了分享图片");
}


#pragma mark - 自定义方法

//指定范围截图
-(UIImageView *)shotProfitScreen{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(kScreenW, kScreenH), YES, 0);
    [[self.view layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = viewImage.CGImage;
    
    //这里可以设置想要截图的区域
    CGRect rect = [self.shareProfitView convertRect:self.shareProfitView.bounds toView:self.view];
    //这里的宽度是像素单位
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, CGRectMake(rect.origin.x * kiPhonePointmultiple, rect.origin.y * kiPhonePointmultiple, rect.size.width * kiPhonePointmultiple, rect.size.height * kiPhonePointmultiple));
    
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    
    self.shareImageView = [[UIImageView alloc] initWithFrame:self.shareProfitView.frame];
    self.shareImageView.image = sendImage;
    
    return self.shareImageView;
}

//计算放大尺寸的宽高
-(CGRect)calculateBigImageViewRectWithImageView:(UIImageView *) currentImageView{

    UIImage *image = currentImageView.image;
    CGFloat y,width,height;

    /** 已知: 要显示的宽度 mw ,未知: 要显示的高度,  提示:显示的图片跟屏幕的宽高比一致  ? 计算要显示高度求mh

     h   mh                              h * mw
     / =    ==> w * mh = h * mw  ==> mh=  /
     w   mw                                w

     */

    y = ([UIScreen mainScreen].bounds.size.height - image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width) * 0.5;
    //宽度为屏幕宽度
    width = [UIScreen mainScreen].bounds.size.width;
    //高度 根据图片宽高比设置
    height = image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width;
    return CGRectMake(0, y, width, height);
}

/**
 *  浏览大图

 */
-(void)scanBigImageWithImageView{
    
    UIImageView *currentImageview = self.shareImageView;
    //当前imageview的图片
    UIImage *image = currentImageview.image;//
    //当前视图
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //背景
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    //当前imageview的原始尺寸->将像素currentImageview.bounds由currentImageview.bounds所在视图转换到目标视图window中，返回在目标视图window中的像素值
    oldframe = [currentImageview convertRect:currentImageview.bounds toView:window];
    [backgroundView setBackgroundColor:[UIColor blackColor]];//kRGBA(107, 107, 99, 0.6)
    
    //此时视图不会显示
    [backgroundView setAlpha:0];
    
    //将所展示的imageView重新绘制在Window中
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:oldframe];
    [imageView setImage:image];
    [imageView setTag:0];
    
    [backgroundView addSubview:imageView];
    //将原始视图添加到背景视图中
    [window addSubview:backgroundView];
    
    
    //添加点击事件同样是类方法 -> 作用是再次点击回到初始大小
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImageView:)];
    [backgroundView addGestureRecognizer:tapGestureRecognizer];
    
    //动画放大所展示的ImageView
    
    [UIView animateWithDuration:0.4 animations:^{
        
        [imageView setFrame:[self calculateBigImageViewRectWithImageView:currentImageview]];
        //重要！ 将视图显示出来
        [backgroundView setAlpha:1];
    } completion:^(BOOL finished) {
        
    }];
    
}

/**
 *  恢复imageView原始尺寸
 *
 *  @param tap 点击事件
 */
-(void)hideImageView:(UITapGestureRecognizer *)tap{
    UIView *backgroundView = tap.view;
    //原始imageview
    UIImageView *imageView = [tap.view viewWithTag:0];
    //恢复
    [UIView animateWithDuration:0.4 animations:^{
        [imageView setFrame:oldframe];
        [backgroundView setAlpha:0];
    } completion:^(BOOL finished) {
        //完成后操作->将背景视图删掉
        [backgroundView removeFromSuperview];
    }];
}


//返回要分享的图片
-(UIImage *)ShareImage{
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:[self calculateBigImageViewRectWithImageView:self.shareImageView]];
    imageV.image = self.shareImageView.image;
    return imageV.image;
}



@end

//
//  Album.m
//  ModelViewController4
//
//  Created by Do Minh Hai on 12/26/15.
//  Copyright (c) 2015 Do Minh Hai. All rights reserved.
//

#import "Album.h"
#import "DataManager.h"
#import "VSModel.h"
@interface Album () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *modelLabel;

@end

@implementation Album
{
    DataManager* dataManager;
    BOOL changePage;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView.delegate= self;
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    dataManager = [DataManager getSingleton];
    self.pageControl.numberOfPages = dataManager.data.count;
    CGSize scrollViewSize = self.scrollView.bounds.size;
    self.scrollView.contentSize = CGSizeMake(scrollViewSize.width * dataManager.data.count,
                                             scrollViewSize.height);
    self.scrollView.pagingEnabled = true;
    int i = 0;
    for (VSModel* model in dataManager.data) {
        UIImageView* imageView = [[UIImageView alloc] initWithImage:model.photo];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(i * scrollViewSize.width, 0, scrollViewSize.width, scrollViewSize.height);
        [self.scrollView addSubview:imageView];
        i++;
    }
    
    [self updateLabelAt:0];

    timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoChangePage) userInfo:nil repeats:true];
    timer1 = [NSTimer scheduledTimerWithTimeInterval:0.75 target:self selector:@selector(autoChangePage) userInfo:nil repeats:false];
    //[self animation];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    self.pageControl.currentPage = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width;
    [self updateLabelAt: (int)self.pageControl.currentPage];
}
-(void)animation
{
    /*
    [UIView animateWithDuration:3 delay:3 options:YES animations:^{[self autoChangePage];} completion:^(BOOL finished){
        [self animation];
    }];
    */
    [UIView animateWithDuration:5 animations:^
    {
        if(self.pageControl.currentPage==self.pageControl.numberOfPages-1)
        {
            self.pageControl.currentPage =0 ;
            changePage = !changePage;
            self.scrollView.contentOffset = CGPointMake(self.pageControl.currentPage * self.scrollView.bounds.size.width, 0);
        }else{
            [self autoChangePage];
             }
    }];
    
}
#pragma mark - Util functions
- (void) updateLabelAt:(int) index {
   // self.pageControl.currentPage = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width;
    //int index = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width;
    VSModel* model = dataManager.data[index];
    self.modelLabel.text = [NSString stringWithFormat:@"%@\n%@", model.album_name, model.singer];
    CGSize labelSize = [self.modelLabel.text sizeWithAttributes:@{NSFontAttributeName:self.modelLabel.font}];
    self.modelLabel.frame = CGRectMake(
                                       self.modelLabel.frame.origin.x, self.modelLabel.frame.origin.y,
                                       self.modelLabel.frame.size.width,2*labelSize.height-37);
    
}
/*
- (IBAction)onPageControlChange:(UIPageControl *)sender {
    
    self.scrollView.contentOffset = CGPointMake(self.pageControl.currentPage * self.scrollView.bounds.size.width, 0);
}
*/
- (IBAction)onPageControlChange:(UIPageControl *)sender {
     self.scrollView.contentOffset = CGPointMake(self.pageControl.currentPage * self.scrollView.bounds.size.width, 0);
}
-(void) autoChangePage
{
    if(self.pageControl.currentPage==self.pageControl.numberOfPages-1) {
        self.pageControl.currentPage =0 ;
        changePage = !changePage;
        self.scrollView.contentOffset = CGPointMake(self.pageControl.currentPage * self.scrollView.bounds.size.width, 0);
    }
     
    if (self.pageControl.currentPage< self.pageControl.numberOfPages-1 && changePage==true) {
        self.pageControl.currentPage +=1;
        self.scrollView.contentOffset = CGPointMake(self.pageControl.currentPage * self.scrollView.bounds.size.width, 0);
    }else {
        changePage= !changePage;
    }
}
-(void) viewDidDisappear:(BOOL)animated
{
    [timer invalidate];
    //[self.view.layer removeAllAnimations];
}
@end
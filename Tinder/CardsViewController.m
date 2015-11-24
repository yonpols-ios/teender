//
//  ViewController.m
//  Tinder
//
//  Created by Juan Pablo Marzetti on 11/19/15.
//  Copyright © 2015 Juan Pablo Marzetti. All rights reserved.
//

#import "CardsViewController.h"
#import "DraggableImageView.h"

@interface CardsViewController ()

@property (weak, nonatomic) IBOutlet DraggableImageView *profileImage;

@end

@implementation CardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.profileImage.image = [UIImage imageNamed:@"ryan"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

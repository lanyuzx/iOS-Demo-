//
//  LLSelectMenuController.m
//  iOS开发demo集锦
//
//  Created by 周尊贤 on 2017/5/18.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLSelectMenuController.h"
#import "TYGSelectMenu.h"
@interface LLSelectMenuController ()
{
    TYGSelectMenu *menuLevel1;
    TYGSelectMenu *menuLevel2;
    TYGSelectMenu *menuLevel3;
}

@end

@implementation LLSelectMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadMenu];

}

- (void)loadMenu{
    
    menuLevel1 = [[TYGSelectMenu alloc] init];
    for (int i = 0; i < 10; i++) {
        TYGSelectMenuEntity *menu1 = [[TYGSelectMenuEntity alloc] init];
        menu1.title = [NSString stringWithFormat:@"%d",i];
        [menuLevel1 addChildSelectMenu:menu1 forParent:nil];
        
    }
    
    menuLevel2 = [[TYGSelectMenu alloc] init];
    for (int i = 0; i < 10; i++) {
        TYGSelectMenuEntity *menu1 = [[TYGSelectMenuEntity alloc] init];
        menu1.title = [NSString stringWithFormat:@"%d",i];
        [menuLevel2 addChildSelectMenu:menu1 forParent:nil];
        
        for (int j = 0; j < 15; j++) {
            TYGSelectMenuEntity *menu2 = [[TYGSelectMenuEntity alloc] init];
            menu2.title = [NSString stringWithFormat:@"%@-%d",menu1.title,j];
            [menuLevel2 addChildSelectMenu:menu2 forParent:menu1];
            
        }
    }
    
    menuLevel3 = [[TYGSelectMenu alloc] init];
    for (int i = 0; i < 10; i++) {
        TYGSelectMenuEntity *menu1 = [[TYGSelectMenuEntity alloc] init];
        menu1.title = [NSString stringWithFormat:@"%d",i];
        [menuLevel3 addChildSelectMenu:menu1 forParent:nil];
        
        for (int j = 0; j < 15; j++) {
            TYGSelectMenuEntity *menu2 = [[TYGSelectMenuEntity alloc] init];
            menu2.title = [NSString stringWithFormat:@"%@-%d",menu1.title,j];
            [menuLevel3 addChildSelectMenu:menu2 forParent:menu1];
            
            for (int x = 0; x < 20; x++) {
                TYGSelectMenuEntity *menu3 = [[TYGSelectMenuEntity alloc] init];
                menu3.title = [NSString stringWithFormat:@"%@-%d",menu2.title,x];
                [menuLevel3 addChildSelectMenu:menu3 forParent:menu2];
            }
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClick:(UIButton *)sender {
    
    
    switch (sender.tag) {
        case 0:{
            //显示并隐藏其它
            [menuLevel1 showFromView:sender];
            [menuLevel2 disMiss];
            [menuLevel3 disMiss];
            
            //block回调
            [menuLevel1 selectAtMenu:^(NSMutableArray *selectedMenuArray) {
                
                NSMutableString *title = [NSMutableString string];
                for (TYGSelectMenuEntity *tempMenu in selectedMenuArray) {
                    [title appendString:[NSString stringWithFormat:@"%ld",(long)tempMenu.id]];
                }
                
                [sender setTitle:title forState:UIControlStateNormal];
            }];
            break;
        }
        case 1:{
            //显示
            [menuLevel2 showFromView:sender];
            [menuLevel1 disMiss];
            [menuLevel3 disMiss];
            
            //block回调
            [menuLevel2 selectAtMenu:^(NSMutableArray *selectedMenuArray) {
                
                NSMutableString *title = [NSMutableString string];
                for (TYGSelectMenuEntity *tempMenu in selectedMenuArray) {
                    [title appendString:[NSString stringWithFormat:@"%ld",(long)tempMenu.id]];
                }
                
                [sender setTitle:title forState:UIControlStateNormal];
            }];
            break;
        }
        case 2:{
            //显示
            [menuLevel3 showFromView:sender];
            [menuLevel1 disMiss];
            [menuLevel2 disMiss];
            
            //block回调
            [menuLevel3 selectAtMenu:^(NSMutableArray *selectedMenuArray) {
                
                NSMutableString *title = [NSMutableString string];
                for (TYGSelectMenuEntity *tempMenu in selectedMenuArray) {
                    [title appendString:[NSString stringWithFormat:@"%ld",(long)tempMenu.id]];
                }
                
                [sender setTitle:title forState:UIControlStateNormal];
            }];
            break;
        }
        default:
            break;
    }
    
    
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

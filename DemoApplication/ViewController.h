//
//  ViewController.h
//  DemoApplication
//
//  Created by Su Pro on 1/25/18.
//  Copyright © 2018 NiNS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    UICollectionView *_collectionView;
    NSArray *dataList;
}


@end


//
//  BookModel.h
//  DemoApplication
//
//  Created by Su Pro on 1/24/18.
//  Copyright © 2018 NiNS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookModel : NSObject
@property (nonatomic) int bookIndex;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *publisher;
@property (nonatomic, strong) NSString *page;

-(instancetype) initWithData:(int )index name:(NSString *)name publisher:(NSString *)publisher page:(NSString *)page ;

@end

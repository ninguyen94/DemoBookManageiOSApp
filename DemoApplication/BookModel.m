//
//  BookModel.m
//  DemoApplication
//
//  Created by Su Pro on 1/24/18.
//  Copyright © 2018 NiNS. All rights reserved.
//

#import "BookModel.h"

@implementation BookModel

-(instancetype) initWithData:(int )index name:(NSString *)name publisher:(NSString *)publisher page:(NSString *)page {
    self = [super init];
    if (self) {
        self.bookIndex = index;
        self.name = name;
        self.publisher = publisher;
        self.page = page;
    }
    return self;
}
@end

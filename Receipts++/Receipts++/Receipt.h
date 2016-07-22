//
//  Receipt.h
//  Receipts++
//
//  Created by Martin Zhang on 2016-07-21.
//  Copyright © 2016 Martin Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Receipt : NSObject

@property (nonatomic) NSString *note;
@property (nonatomic) NSString *detail;
@property (nonatomic) NSString *tag;
@property (nonatomic) NSNumber *amount;
@property (nonatomic) NSDate *timeStamp;

@end

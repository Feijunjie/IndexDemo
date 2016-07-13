//
//  User.h
//  indexDemoTwo
//
//  Created by rhjt on 16/7/11.
//  Copyright © 2016年 junjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
-(id)init:(NSString*) _username name:(NSString*) _name;
@property (assign, readwrite, nonatomic) NSString *name;
@property (assign, readwrite, nonatomic) NSString *username;
@end

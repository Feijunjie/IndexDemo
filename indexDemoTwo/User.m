//
//  User.m
//  indexDemoTwo
//
//  Created by rhjt on 16/7/11.
//  Copyright © 2016年 junjie. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize name,username;
-(id)init:(NSString*) _username name:(NSString*) _name {
    self = [super init];
    self.username = _username;
    self.name = _name;
    
    return self;
}
@end

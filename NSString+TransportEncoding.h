//
//  NSString+TransportEncoding.h
//  ncodee
//
//  Created by Steve High on 7/5/13.
//  Copyright (c) 2013 Evilnode Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TransportEncoding)
- (NSString *) base64EncodedString;
- (NSString *) base64DecodedString;
- (NSString *) base32EncodedString;
- (NSString *) base32DecodedString;
- (NSString *) urlEncodedString;
- (NSString *) urlDecodedString;
@end

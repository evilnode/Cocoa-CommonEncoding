//
//  NSString+TransportEncoding.m
//  ncodee
//
//  Created by Steve High on 7/5/13.
//  Copyright (c) 2013 Evilnode Software. All rights reserved.
//

#import "NSString+TransportEncoding.h"
#import <Security/Security.h>

// Simple enum to identify transform mode
typedef enum {
    StringTransformOperationBase64Encode,
    StringTransformOperationBase64Decode,
    StringTransformOperationBase32Encode,
    StringTransformOperationBase32Decode
} StringTransformOperation;

//  hidden implementation to handle transform
@interface NSString (TransportEncoding_PRIVATE)
- (NSString *)transformWithFunction:(StringTransformOperation)operation;
@end
@implementation NSString (TransportEncoding_PRIVATE)
#pragma mark - Base64Encoding_PRIVATE
- (NSString *)transformWithFunction:(StringTransformOperation)operation
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    CFDataRef sourceData = (__bridge CFDataRef)data;
    SecTransformRef transformRef = NULL;
    CFErrorRef error = NULL;
    
    switch (operation) {
        case StringTransformOperationBase64Encode:
        {
            transformRef = SecEncodeTransformCreate(kSecBase64Encoding, &error);
        }
            break;
        case StringTransformOperationBase64Decode:
        {
            transformRef = SecDecodeTransformCreate(kSecBase64Encoding, &error);
        }
            break;
        case StringTransformOperationBase32Encode:
        {
            transformRef = SecEncodeTransformCreate(kSecBase32Encoding, &error);
        }
            break;
        case StringTransformOperationBase32Decode:
        {
            transformRef = SecDecodeTransformCreate(kSecBase32Encoding, &error);
        }
            break;
            
        default:
            return nil;
        break;
    }

    if (!error) {
        SecTransformSetAttribute(transformRef, kSecTransformInputAttributeName, sourceData, &error);
        if (!error) {
            CFDataRef outputRef = SecTransformExecute(transformRef, &error);
            if (!error) {
                return [[NSString alloc] initWithData:(NSData *)CFBridgingRelease(outputRef) encoding:NSUTF8StringEncoding];
            }
        }
    }
    
    CFShow(error);
    CFRelease(error);
    return nil;
}

@end

//  user-facing api
@implementation NSString (TransportEncoding)
- (NSString *) base64EncodedString
{
    return [self transformWithFunction:StringTransformOperationBase64Encode];
}

- (NSString *) base64DecodedString
{
    return [self transformWithFunction:StringTransformOperationBase64Decode];
}

- (NSString *) base32EncodedString
{
    return [self transformWithFunction:StringTransformOperationBase32Encode];
}

- (NSString *) base32DecodedString
{
    return [self transformWithFunction:StringTransformOperationBase32Decode];
}

- (NSString *) urlEncodedString
{
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *) urlDecodedString
{
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end

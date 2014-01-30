NSString-TransportEncoding
==========================

A simple transport encoding category that enables Base64, URL, and Base32 encoding/decoding.  Mac OSX only.

***Requirements***

1. Mac OSX 10.7+ (no iOS, sorry)
2. Security Framework

***Usage***
```objc

#include "NSString+TransportEncoding.h"
    ...
NSString *myString = @"This is a test";
    
//  base64 encode
NSString *b64Enc = [myString base64EncodedString];
    
//  base64 decode
NSString *b64Dec = [b64Enc base64DecodedString];
    
//  base32 encode
NSString *b32Enc = [myString base32EncodedString];
    
//  base32 decode
NSString *b32Dec = [b32Enc base32DecodedString];
    
//  url encode
NSString *urlEnc = [myString urlEncodedString];
    
//  url decode
NSString *urlDec = [urlEnc urlDecodedString];
```

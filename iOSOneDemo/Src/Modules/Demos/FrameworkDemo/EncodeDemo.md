# 编码

##  各种数据类型转换


### NSData --> NSString & NSString --> NSData

NSData -> NSString

<pre>

NSString *aString = @"1234abc";
NSData *aData = [aString dataUsingEncoding: NSUTF8StringEncoding];

</pre>

NSString -> NSData

<pre>

NSString *aString = [[NSString alloc] initWithData:aData encoding:NSUTF8StringEncoding];

</pre>

### 16进制字符串与 NSData互转

16进制string -> NSData

<pre>

- (NSData *)convertHexStrToData:(NSString *)str
{
    if (str == nil || str.length == 0) {
        return nil;
    }

    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:10];
    if (str.length % 2 == 0) {
        for (NSUInteger i = 0; i < str.length; i = i+2) {
            unichar highCh = [str characterAtIndex:i];
            unsigned short highByte = [self convertCharToInt:highCh];
            unichar lowCh = [str characterAtIndex:i+1];
            unsigned short lowByte = [self convertCharToInt:lowCh];
            Byte byte = (highByte << 4) | lowByte;
            [hexData appendBytes:&byte length:1];
        }
    } else {
        for (NSUInteger i = 0; i < str.length; i = i+2) {
            unichar highCh = 0;
            unsigned short highByte = 0;
            if (i == 0) {
                highByte = 0;
            } else {
                highCh = [str characterAtIndex:i-1];
                highByte = [self convertCharToInt:highCh];
            }
            unichar lowCh = [str characterAtIndex:i];
            unsigned short lowByte = [self convertCharToInt:lowCh];
            Byte byte = (highByte << 4) | lowByte;
            [hexData appendBytes:&byte length:1];
        }
    }
    return hexData;
}

- (unsigned short)convertCharToInt:(unichar)ch
{
    if (ch >= '0' && ch <= '9') {
        return (ch - '0');
    }
    if (ch >= 'a' && ch <= 'z') {
        return (ch - 'a') + 10;
    }
    if (ch >= 'A' && ch <= 'Z') {
        return (ch - 'A') + 10;
    }
    return 0;
}

</pre>

- 另一个更优雅的方法

<pre>

- (NSData *)convertHexStrToData:(NSString *)str {  
    if (!str || [str length] == 0) {  
        return nil;  
    }  

    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];  
    NSRange range;  
    if ([str length] % 2 == 0) {  
        range = NSMakeRange(0, 2);  
    } else {  
        range = NSMakeRange(0, 1);  
    }  
    for (NSInteger i = range.location; i < [str length]; i += 2) {  
        unsigned int anInt;  
        NSString *hexCharStr = [str substringWithRange:range];  
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];  

        [scanner scanHexInt:&anInt];  
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];  
        [hexData appendData:entity];  

        range.location += range.length;  
        range.length = 2;  
    }  

    return hexData;  
}

</pre>


NSData -> 16进制 NSString

<pre>

- (NSString *)convertDataToHexStr:(NSData *)data
{
    if (!data || data.length == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:data.length];

    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];

    if ([string characterAtIndex:0] == '0') {
        return [string substringWithRange:NSMakeRange(1, string.length-1)];
    }

    return string;
}

</pre>

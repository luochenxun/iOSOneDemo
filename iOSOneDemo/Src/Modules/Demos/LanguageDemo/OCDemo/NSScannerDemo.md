#  NSScanner



## NSScanner 是什么

NSScanner是一个类，用于在字符串中扫描指定的字符，尤其是把它们翻译/转换为数字和别的字符串。

作用有点像正则表达式，但是使用起来较正则要更简单一些，语法没那么复杂。


可以在创建NSScaner时指定一个string作为它的数据源，然后scanner会按照你的要求从头到尾地扫描这个字符串的每个字符。

比如示例1扫描一个字符串中有多少个数字

<pre>

NSString *numStr = @"a 1 b 2 c 3 d 4 e 5 f 6 o";
NSScanner * scanner = [NSScanner scannerWithString:numStr];
int numCount = 0;
NSMutableString *result = [NSMutableString stringWithCapacity:10];
while (NO == [scanner isAtEnd]) {
    if ([scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:NULL]) {
        int num;
        if ([scanner scanInt:&num]) {
            [result appendString:[NSString stringWithFormat:@"num=%d, %ld",num, scanner.scanLocation]];
            numCount ++ ;
        }
    }
}

</pre>


## NSScanner可以做什么


关键功能点：

1. 在 NSScanner 对象扫描字符串的时候，你可以通过设置属性charactersToBeSkipped忽略某些字符。






## NSScanner怎样使用

### Scanner创建

主要有如下初始化方法，其实就是给Scanner设置一个数据源。

<pre>

+ (instancetype)scannerWithString:(NSString *)aString
+ (id)localizedScannerWithString:(NSString *)aString
- (instancetype)initWithString:(NSString *)aString

</pre>



### 主要属性

<pre>

@property(readonly, copy) NSString *string
@property NSUInteger scanLocation
@property BOOL caseSensitive // 是否区分大小写，默认不区分
@property(copy) NSCharacterSet *charactersToBeSkipped
@property(retain) id locale

</pre>

- scanLocation

当前扫描的位置，这个好理解，一般是从字符串的头开始扫，扫到尾就结束了。

你可以手动调整这个位置，也可以调 *** [scanner isAtEnd] *** 判断是否扫到尾了。


### 主要方法

<pre>

- (BOOL)scanCharactersFromSet:(NSCharacterSet *)scanSet   intoString:(NSString * _Nullable *)stringValue;
- (BOOL)scanUpToCharactersFromSet:(NSCharacterSet *)stopSet    intoString:(NSString * _Nullable *)stringValue;
- (BOOL)scanString:(NSString *)string  intoString:(NSString * _Nullable *)stringValue;
- (BOOL)scanUpToString:(NSString *)stopString   intoString:(NSString * _Nullable *)stringValue;
- (BOOL)scanDecimal:(NSDecimal *)decimalValue;
- (BOOL)scanDouble:(double *)doubleValue;
- (BOOL)scanFloat:(float *)floatValue;
- (BOOL)scanHexDouble:(double *)result;
- (BOOL)scanHexFloat:(float *)result;
- (BOOL)scanHexInt:(unsigned int *)intValue;
- (BOOL)scanHexLongLong:(unsigned long long *)result;
- (BOOL)scanInt:(int *)intValue;
- (BOOL)scanInteger:(NSInteger *)value;
- (BOOL)scanUnsignedLongLong:(unsigned long long *)unsignedLongLongValue;
@property(getter=isAtEnd, readonly) BOOL atEnd;

</pre>

- scan 与 scanUpTo的区别

scan就是扫描完了指定的匹配对象才停止，scanUpTo是扫到指定的匹配对象则停止。

如："123abc" scan "123"，则是扫完123才停止，停在a这里。<br>
”1abc23“ scanUpTo "abc" ， 则是扫到a就停止了，停在a这里

- scanCharactersFromSet:intoString

扫描字符串中和NSCharacterSet字符集中匹配的字符，是按字符单个匹配的，例如，NSCharacterSet字符集为@”test123Dmo”，scanner字符串为 @” 123test12Demotest”，那么字符串中所有的字符都在字符集中，所以指针指向的地址存储的内容为”123test12Demotest”


- scanUpToCharactersFromSet:intoString：

扫描字符串直到遇到NSCharacterSet字符集的字符时停止，指针指向的地址存储的内容为遇到跳过字符集字符之前的内容


- scanString:intoString:

从当前的扫描位置开始扫描，判断扫描字符串是否从当前位置能扫描到和传入字符串相同的一串字符，如果能扫描到就返回YES,指针指向的地址存储的就是这段字符串的内容。例如scanner的string内容为123abc678,传入的字符串内容为abc，如果当前的扫描位置为0，那么扫描不到，但是如果将扫描位置设置成3，就可以扫描到了。


- scanUpToString

 扫描到指定的字符串时停下





### 示例2

<pre>

NSString *bananas = @"123.321abc137d efg/hij kl";
NSString *separatorString = @"fg";
BOOL result;

NSScanner *aScanner = [NSScanner scannerWithString:bananas];

//扫描字符串
//扫描到指定字符串时停止，返回结果为指定字符串之前的字符串
NSLog(@"扫描仪所在的位置：%lu", aScanner.scanLocation);
NSString *container;
result = [aScanner scanUpToString:separatorString intoString:&container];
NSLog(@"扫描成功：%@", result?@"YES":@"NO");
NSLog(@"扫描的返回结果：%@", container);
NSLog(@"扫描仪所在的位置：%lu", aScanner.scanLocation);

</pre>


## 示例-把16进制字符串转成NSData

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

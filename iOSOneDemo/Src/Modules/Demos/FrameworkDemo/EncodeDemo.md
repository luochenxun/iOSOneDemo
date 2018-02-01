# 编码

##  各种数据类型转换


### NSData --> NSString & NSString --> NSData


<pre><code>
- (void)initUI {
    FlexLinearLayout *box = [self addDemoBoxWithTitle:@"各数据类型转换"];

    NSString *aString = @"1234";
    [self addDescriptionOnView:box withText:[NSString stringWithFormat:@"字符串(%@)转成 NSData",aString]];

    NSData *aData = [aString dataUsingEncoding: NSUTF8StringEncoding];
    [self addDescriptionOnView:box withText:[NSString stringWithFormat:@"输出 NSData：%@",aData]];

    aString = [[NSString alloc] initWithData:aData encoding:NSUTF8StringEncoding];
    [self addDescriptionOnView:box withText:[NSString stringWithFormat:@"将NSData转回NSString：%@",aString]];



    [box adjustLayoutHeightBySubviews];
}
</code></pre>


lkjlkjasdf

<pre><code>
- (void)initUI {
FlexLinearLayout *box = [self addDemoBoxWithTitle:@"各数据类型转换"];

NSString *aString = @"1234";
[self addDescriptionOnView:box withText:[NSString stringWithFormat:@"字符串(%@)转成 NSData",aString]];

NSData *aData = [aString dataUsingEncoding: NSUTF8StringEncoding];
[self addDescriptionOnView:box withText:[NSString stringWithFormat:@"输出 NSData：%@",aData]];

aString = [[NSString alloc] initWithData:aData encoding:NSUTF8StringEncoding];
[self addDescriptionOnView:box withText:[NSString stringWithFormat:@"将NSData转回NSString：%@",aString]];



[box adjustLayoutHeightBySubviews];
}
</code></pre>


lkjlkjasdf

<pre><code>
- (void)initUI {
FlexLinearLayout *box = [self addDemoBoxWithTitle:@"各数据类型转换"];

NSString *aString = @"1234";
[self addDescriptionOnView:box withText:[NSString stringWithFormat:@"字符串(%@)转成 NSData",aString]];

NSData *aData = [aString dataUsingEncoding: NSUTF8StringEncoding];
[self addDescriptionOnView:box withText:[NSString stringWithFormat:@"输出 NSData：%@",aData]];

aString = [[NSString alloc] initWithData:aData encoding:NSUTF8StringEncoding];
[self addDescriptionOnView:box withText:[NSString stringWithFormat:@"将NSData转回NSString：%@",aString]];



[box adjustLayoutHeightBySubviews];
}
</code></pre>


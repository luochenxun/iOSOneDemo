#  KVC & KVO


## KVC


### KVC 是什么？

KVC就是键值编码 （key-value-coding)。

在 OC中，我们可以直接使用键值编码也就是KVC的方式去修改一个对象的属性：

比如，我们修改 Student对象的name这个属性（即使这个属性不是一个public接口）。

<pre>

Student *student = [[Student alloc] init];
[student setValue:@"小明" forKey:@"name"];

</pre>

如果我们甚至可以使用KVC访问对象的对象属性的属性（这里说起来比较拗口，就是我们可以一个称之为”keypath“的层级路径，去访问对象property成员的property）.


<pre>

Student *student = [[Student alloc] init];
[student setValue:@"小明" forKey:@"name"];

</pre>


当然，可以设置就可以获取，这点后面会详细介绍。


使用KVC，还可以把字典映射成对象，如：

<pre>

// 定义一个字典
NSDictionary *dict = @{
    @"name"  : @"jack",
    @"money" : @"20.7",
};

// 创建模型
Person *p = [[Person alloc] init];

// 字典转模型
[p setValuesForKeysWithDictionary:dict];

// 附一个模型转字典
[p dictionaryWithValuesForKeys:@[@"name", @"money"]];

</pre>




### KVC常用方法

1. 常用方法
2. 定义setValue:forUndefinedKey 方法接住未定义的Key，防止Crash
3. 字典映射要注意的点；


<pre>

KVC 常用的方法

(1)赋值类方法
- (void)setValue:(nullable id)value forKey:(NSString *)key;
- (void)setValue:(nullable id)value forKeyPath:(NSString *)keyPath;
- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key;
- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *, id> *)keyedValues;

(2)取值类方法
// 能取得私有成员变量的值
- (id)valueForKey:(NSString *)key;
- (id)valueForKeyPath:(NSString *)keyPath;
- (NSDictionary *)dictionaryWithValuesForKeys:(NSArray *)keys;

</pre>


- 2. 定义setValue:forUndefinedKey 方法接住未定义的Key，防止Crash

<pre>

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"Catch undefined key.");
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

</pre>

这样，再调用 [student setValue:@"小明" forKey:@"test"]; 这样的未定义的key时，也不会Crash了。


3. 字典映射要注意的点；

字典映射只适用于纯OC数据对象，如果此对象有接口的话，映射完后调用会报错。

<pre>

NSDictionary *dict = @{
                @"name"  : @"小东",
            //  @"dog" : @{ @"name" : @"小黄" },
//                         @"dog.name" : @"小黄",  // 无法映射keypath
};

映射后调用 [student2.dog printInfo] 会报错！

</pre>


## KVO


### KVO 是什么

KVO 是键值观察者（key-value-observing）。KVO提供了一种观察者的机制，通过对某个对象的某个属性添加观察者，当该属性改变，就会调用"observeValueForKeyPath:"方法，为我们提供一个“对象值改变了！”的时机进行一些操作


### KVO的使用

<pre>

KVCDemoStudent *student3 = [[KVCDemoStudent alloc] init];
[student3 addObserver:self forKeyPath:@"name"
options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
[student3 setValue:@"小明" forKey:@"name"];

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context
{
    NSLog(@"newValue----%@",change[@"new"]);
    NSLog(@"oldValue----%@",change[@"old"]);
}

</pre>



## demo

### demo1

<pre>

这里，Student与dog的Name都非public，但使用KVC仍可以访问

KVCDemoStudent *student = [[KVCDemoStudent alloc] init];
[student setValue:@"小明" forKey:@"name"];
[student setValue:@"旺财" forKeyPath:@"dog.name"];

NSDictionary *dict = @{
                       @"name"  : @"小东",
                       //  @"dog" : @{ @"name" : @"小黄" }, // 会出现上面说的非纯数据对象报错
//                         @"dog.name" : @"小黄",  // 无法映射keypath
                       };
KVCDemoStudent *student2 = [[KVCDemoStudent alloc] init];
[student2 setValuesForKeysWithDictionary:dict];

</pre>

### demo2 KVO监听

<pre>

KVCDemoStudent *student3 = [[KVCDemoStudent alloc] init];
[student3 addObserver:self forKeyPath:@"name"
options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
[student3 setValue:@"小明" forKey:@"name"];

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context
{
    NSLog(@"newValue----%@",change[@"new"]);
    NSLog(@"oldValue----%@",change[@"old"]);
}

</pre>


## 原理编

### KVC

当一个对象调用setValue:forKey: 方法时,方法内部会做以下操作:
 1.判断有没有指定key的set方法,如果有set方法,就会调用set方法,给该属性赋值
 2.如果没有set方法,判断有没有跟key值相同且带有下划线的成员属性(_key).如果有,直接给该成员属性进行赋值
 3.如果没有成员属性_key,判断有没有跟key相同名称的属性.如果有,直接给该属性进行赋值
 4.如果都没有,就会调用 valueforUndefinedKey 和setValue:forUndefinedKey:方法

 所以，上面的示例中，这样修改student的Name，也是OK的。

 <pre>

  [student setValue:@"小强" forKey:@"_name"];
 
 </pre>


##  KVO 的底层实现原理

(1)KVO 是基于 runtime 机制实现的
(2)当一个对象(假设是person对象,对应的类为 JLperson)的属性值age发生改变时,系统会自动生成一个继承自JLperson的类NSKVONotifying_JLPerson,在这个类的 setAge 方法里面调用
    [super setAge:age];
    [self willChangeValueForKey:@"age"];
    [self didChangeValueForKey:@"age"];
 三个方法,而后面两个方法内部会主动调用
 -(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context方法,在该方法中可以拿到属性改变前后的值.

# 类加载

> 类加载过程

![image](https://java-run-blog.oss-cn-zhangjiakou.aliyuncs.com/blog/0PoSNF.png)

1. 加载： 查找和导入class文件。
- 通过一个类的全限定名获取定义此类的二进制字节流
- 将这个字节流所代表的静态存储结构转化为方法区的运行时数据结构 
- 在Java堆中生成一个代表这个类的java.lang.Class对象，作为对方法区中这些数据的访问入口
2. 链接
- 验证：保证被加载类的正确性。文件格式验证，元数据验证，字节码验证，符号引用验证
- 准备：为类的静态变量分配内存，并将其初始化为默认值
- 解析：把类中的符号引用转换为直接引用
3. 初始化
对类的静态变量，静态代码块执行初始化操作


# 类装载器ClassLoader
1. Bootstrap ClassLoader 
> 负责加载$JAVA_HOME中 jre/lib/rt.jar 里所有的class或 Xbootclassoath选项指定的jar包。由C++实现，不是ClassLoader子类。
2. Extension ClassLoader
> 负责加载java平台中扩展功能的一些jar包，包括$JAVA_HOME中 jre/lib/\*.jar 或 -Djava.ext.dirs指定目录下的jar包。
3. App ClassLoader 
> 负责加载classpath中指定的jar包及 Djava.class.path 所指定目录下的类和 jar包。
4. Custom ClassLoader
> 通过java.lang.ClassLoader的子类自定义加载class，属于应用程序根据 自身需要自定义的ClassLoader，如tomcat、jboss都会根据j2ee规范自行实现ClassLoader。

![image](http://java-run-blog.oss-cn-zhangjiakou.aliyuncs.com/57e113a4e7084f0bb78d4338efa47825.png)

- 加载原则：检查某个类是否已经加载顺序是自底向上，从Custom ClassLoader到BootStrap ClassLoader逐层检查，只要某个Classloader已加载，就视为已加载此类，保证此类只所有ClassLoader加载一次。 加载的顺序:加载的顺序是自顶向下，也就是由上层来逐层尝试加载此类。
- 双亲委派机制：
1. 如果一个类加载器在接到加载类的请求时，它首先不会自己尝试去加载这个类，而是把 这个请求任务委托给父类加载器去完成，依次递归，如果父类加载器可以完成类加载任务，就成功返回;只有父类加载器无法完成此加载任务时，才自己去加载。

2. 优势:Java类随着加载它的类加载器一起具备了一种带有优先级的层次关系。比如，Java中的 Object类，它存放在rt.jar之中,无论哪一个类加载器要加载这个类，最终都是委派给处于模型 最顶端的启动类加载器进行加载，因此Object在各种类加载环境中都是同一个类。如果不采用 双亲委派模型，那么由各个类加载器自己取加载的话，那么系统中会存在多种不同的Object 类。
3. 破坏:可以继承ClassLoader类，然后重写其中的loadClass方法，其他方式大家可以自己了解拓展一下。


# 运行时数据区域
![数据区域](https://java-run-blog.oss-cn-zhangjiakou.aliyuncs.com/blog/9rZdOl.png)

## 方法区
用于存储已被虚拟机加载的类信息、常量、静态变量、即时编译器编译后的代码等数据。

## 堆
Java堆是Java虚拟机所管理内存中最大的一块，在虚拟机启动时创建，被所有线程共享。

## 虚拟机栈
虚拟机栈是一个线程执行的区域，保存着一个线程中方法的调用状态。换句话说，一个Java线程的运行 状态，由一个虚拟机栈来保存，所以虚拟机栈肯定是线程私有的，独有的，随着线程的创建而创建。

## 本地方法栈
如果当前线程执行的方法是Native类型的，这些方法就会在本地方法栈中执行。

## 程序计数器
程序计数器占用的内存空间很小，由于Java虚拟机的多线程是通过线程轮流切换，并分配处理器执行时 间的方式来实现的，在任意时刻，一个处理器只会执行一条线程中的指令。因此，为了线程切换后能够 恢复到正确的执行位置，每条线程需要有一个独立的程序计数器(线程私有)。
> 假如线程A正在执行到某个地方，突然失去了CPU的执行权，切换到线程B了，然后当线程A再获 得CPU执行权的时候，怎么能继续执行呢?这就是需要在线程中维护一个变量，记录线程执行到的位置。这就是程序计数器

# 堆
一块是非堆区，一块是堆区。

堆区分为两大块：Old区和Young区。
- Young区分为：Survivor区(S0+S1)，和 Eden区。
- Eden:S0:S1=8:1:1 S0和S1一样大，也可以叫From和To。
![image](http://java-run-blog.oss-cn-zhangjiakou.aliyuncs.com/7699730376524dad8b5b80976db5955e.png)



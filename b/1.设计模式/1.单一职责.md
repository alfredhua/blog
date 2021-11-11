---
title: 单一职责-码农阿华
keywords: 单一职责，设计模式
description: 单一职责(Simple Responsibility Pinciple，SRP)是指不要存在多于一个导致类变更 的原因
---

单一职责(Simple Responsibility Pinciple，SRP)是指不要存在多于一个导致类变更 的原因。

假设我们有一个Class负责两个职责，一旦发生需求变更，修改其中一个职责的逻辑代码，有可能会导致另一个职责的功能发生故障。这样一来，这个Class存在两个导致类变更的原因。如何解决这个问题呢?我们就要给两个职责分别用两个Class来实现，进行解耦。后期需求变更维护互不影响。

这样的设计，可以降低类的复杂度，提高类的可读性，提高系统的可维护性，降低变更引起的风险。总体来说就是一个Class/Interface/Method只负责一项职责。接下来，我们来看代码实例，还是用课程举例，我们的课程有直播课和录播课。直播课 不能快进和快退，录播可以可以任意的反复观看，功能职责不一样。还是先创建一个 Course 类:

```java
public class Course {
    public void study(String courseName){
    if("直播课".equals(courseName)){  
       System.out.println(courseName + "不能快进");
    }else{
       System.out.println(courseName + "可以反复回看");
    } }
}
```

从上面代码来看，Course 类承担了两种处理逻辑。假如，现在要对课程进行加密，那么 直播课和录播课的加密逻辑都不一样，必须要修改代码。而修改代码逻辑势必会相互影 响容易造成不可控的风险。我们对职责进行分离解耦，来看代码，分别创建两个类

```java
 public class LiveCourse {
    public void study(String courseName){
     System.out.println(courseName+"不能快进看"); 
    }
}   
public class ReplayCourse {
    public void study(String courseName){
      System.out.println(courseName+"可以反复回");
     }
}
```

业务继续发展，课程要做权限。没有付费的学员可以获取课程基本信息，已经付费的学 员可以获得视频流，即学习权限。那么对于控制课程层面上至少有两个职责。我们可以 把展示职责和管理职责分离开来，都实现同一个抽象依赖。

设计一个顶层接口,创建 ICourse 接口:

```java
public interface ICourse { //获得基本信息
    String getCourseName(); //获得视频流
    byte[] getCourseVideo();
    //学习课程
    void studyCourse(); //退款
    void refundCourse();
}
```
我们可以把这个接口拆成两个接口，创建一个接口 ICourseInfo 和 ICourseManager: ICourseInfo 接口:

```java
public interface ICourseInfo {
    String getCourseName(); 
    byte[] getCourseVideo();
}

public interface ICourseManager { 
    void studyCourse();
    void refundCourse();
}

```

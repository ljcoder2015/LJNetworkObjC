# LJNetwork-objective-c
### 关于LJNetwork
LJNetwork是我看了[iOS应用架构谈 网络层设计方案](https://casatwy.com/iosying-yong-jia-gou-tan-wang-luo-ceng-she-ji-fang-an.html)后封装的一个简化版
网络请求库，底层用的是AFNetworking。吸收了原文中的网络请求着陆点统一的思想，还有把每个请求当做对象来处理，方便对象销毁的时候取消网络请求。去掉了原文中使用
字典来提交数据给业务层的方式，还是采用json转model的那种方式。

写的比较粗糙，欢迎大家指正。

### 联系方式
email:ljcoder@163.com

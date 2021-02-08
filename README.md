# Flutter
## 1、创建flutter_module模块
### cd到根目录并创建flutter模块
### 命令输入创建 
### $flutter create -t module flutter_module

## 2、iOS项目中引入flutter
### iOS项目中先创建Podfile文件
### Podfile进行如下配置

platform:'ios','10.0'

flutter_application_path = '../flutter_module'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

target 'FlutterIOS' do
  
install_all_flutter_pods(flutter_application_path)

pod 'MJRefresh', '~> 3.5.0'



end

### 执行 pod install

### 3、Android项目中引用flutter




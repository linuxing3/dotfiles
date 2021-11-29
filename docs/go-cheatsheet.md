# Golang CHEATSHEET (中文速查表)

## Go 编译器命令

```bash
  go command [arguments] // go 命令 [参数]
  go build // 编译包和依赖包
  go clean // 移除对象和缓存文件
  go doc // 显示包的文档
  go env // 打印 go 的环境变量信息
  go bug // 报告 bug
  go fix // 更新包使用新的 api
  go fmt // 格式规范化代码
  go generate // 通过处理资源生成 go 文件
  go get // 下载并安装包及其依赖
  go install // 编译和安装包及其依赖
  go list // 列出所有包
  go run // 编译和运行 go 程序
  go test // 测试
  go tool // 运行给定的 go 工具
  go version // 显示 go 当前版本
  go vet // 发现代码中可能的错误
```

## Hello World

### 代码

```go
  // main.go
  package main // 包名

import "fmt" // 导入 fmt 包

func main() { // 主函数
fmt.Println("Hello World") // 打印输出
}
```

### 直接运行

```bash
go run main.go
echo "先编译成二进制文件再运行"
go build && ./main //
```

## 操作符

### 算数操作符

```go
  - - / % // 加 减 乘 除 取余
  & | ^ &^ // 位与 位或 位异或 位与非
  << >> // 左移 右移
  // 比较操作
  == != // 等于 不等于
  < <= // 小于 小于等于
  > > = // 大于 大于等于
  > > // 逻辑操作
  > > && || ! // 逻辑与 逻辑或 逻辑非
  > > // 其他
  > > & \* <- // 地址 指针引用 通道操作
```

## 声明

```go
a := 1 // 直接给一个未声明的变量赋值
var b int // var 变量名 数据类型 来声明
var c float64
// 注意：使用 var 声明过的变量不可再使用 := 赋值
a = 2
const d = 1 // 常量
```

## 数据类型

```go
s := "hello" // 字符

a := 1 // int

b := 1.2 // float64

c := 1 + 5i // complex128
```

### 数组

```go
arr1 := [3]int{4, 5, 6} // 手动指定长度
arr2 := [...]int{1, 2, 3} // 由 golang 自动计算长度
```

### 切片

```go
sliceInt := []int{1, 2} // 不指定长度
sliceByte := []byte("hello")
```

### 指针

```go
a := 1
point := &a // 将 a 的地址赋给 point
```

## 流程控制

```go
  // for
  i := 10
  for i > 0 {
  println(i--)
  }
  // if else
  if i == 10 {
  println("i == 10")
  } else {
  println("i != 10")
  }
  // switch
  switch i {
  case 10:
  println("i == 10")
  default:
  println("i != 10")
  }
```

## 函数

```go
 // 以 func 关键字声明
 func test() {}

f := func() {println("Lambdas function")} // 匿名函数
f()

func get() (a,b string) { // 函数多返回值
return "a", "b"
}
a, b := get()
```

## 结构体

```go
  // golang 中没有 class 只有 struct
  type People struct {
  Age int // 大写开头的变量在包外可以访问
  name string // 小写开头的变量仅可在本包内访问
  }
  p1 := People{25, "Kaven"} // 必须按照结构体内部定义的顺序
  p2 := People{name: "Kaven", age: 25} // 若不按顺序则需要指定字段

// 也可以先不赋值
p3 := new(People)
p3.Age = 25
p3.name = "Kaven"
```

- 方法
  // 方法通常是针对一个结构体来说的

```go
  type Foo struct {
  a int
  }
  // 值接收者
  func (f Foo) test() {
  f.a = 1 // 不会改变原来的值
  }
  // 指针接收者
  func (f \*Foo) test() {
  f.a = 1 // 会改变原值
  }
```

## go 协程

```go
  go func() {
  time.Sleep(10 \* time.Second)
  println("hello")
  }() // 不会阻塞代码的运行 代码会直接向下运行
  // channel 通道
  c := make(chan int)
  // 两个协程间可以通过 chan 通信
  go func() {c <- 1}() // 此时 c 会被阻塞 直到值被取走前都不可在塞入新值
  go func() {println(<-c)}()
  // 带缓存的 channel
  bc := make(chan int, 2)
  go func() {c <- 1; c <-2}() // c 中可以存储声明时所定义的缓存大小的数据，这里是 2 个
  go func() {println(<-c)}()
```

## 接口

go 的接口为鸭子类型，即只要你实现了接口中的方法就实现了该接口

```java
type Reader interface {
  Reading() // 仅需实现 Reading 方法就实现了该接口
}

type As struct {}
func (a As) Reading() {} // 实现了 Reader 接口

type Bs struct {}
func (b Bs) Reading() {} // 也实现了 Reader 接口
func (b Bs) Closing() {}
```

### 一些推荐

https://github.com/astaxie/build-web-application-with-golang // 谢大的

https://github.com/Unknwon/the-way-to-go_ZH_CN // 无闻

https://github.com/Unknwon/go-fundamental-programming // 无闻教学视频

https://golanglibs.com/

https://github.com/avelino/awesome-go

https://github.com/LeCoupa/awesome-cheatsheets

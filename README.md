# GB2260.swift 🚚 

The Swift implementation for looking up Chinese administrative divisions.

## GB/T 2260

[![GB/T 2260](https://img.shields.io/badge/GB%2FT%202260-v0.2-blue.svg)](https://github.com/cn/GB2260)
[![Build Status](https://travis-ci.org/cn/GB2260.swift.svg?branch=master)](https://travis-ci.org/cn/GB2260.swift)

The latest GB/T 2260 codes. Read the [GB2260 Specification](https://github.com/cn/GB2260/blob/v0.2/spec.md).

## Installation

### [Carthage]

[Carthage]: https://github.com/Carthage/Carthage

Add the following to your Cartfile:

```
github "cn/GB2260.swift"
```

Then run `carthage update`.

Follow the current instructions in [Carthage's README][carthage-installation]
for up to date installation instructions.

[carthage-installation]: https://github.com/Carthage/Carthage#adding-frameworks-to-an-application

## Usage

```swift
import GB2260

if let db = GB2260(),             // same to: let db = GB2260(.V201410)
   let division = db["110105"]    // Division: Optional(<GB/T 2260-201410> 110105 北京市 市辖区 朝阳区)
{

  division.name        // 朝阳区
  division.province    // Division: Optional(<GB/T 2260-201410> 110000 北京市)
  division.prefecture  // Division: Optional(<GB/T 2260-201410> 110100 北京市 市辖区)
  division.code        // 110105
  division.revision    // 201410

  division.description // 北京市 市辖区 朝阳区
}
```

### .division(of code: String) -> Division?

Returns the correspond division of `code` if there is one, returns `nil` otherwise.

```swift
GB2260()?.division(of: "110000")
// Division: Optional(<GB/T 2260-201410> 110000 北京市)
```

### [code: String] -> Division?

Same to `division(of:)`

```swift
GB2260()?["110000"]
// Division: Optional(<GB/T 2260-201410> 110000 北京市)
```

### .prefectures(of code: String) -> [Division]

Return a list of prefecture level cities in Division data structure.

```swift
GB2260()!.prefectures(of: "110000")
// [<GB/T 2260-201410> 110100 北京市 市辖区, <GB/T 2260-201410> 110200 北京市 县]
```

### .counties(of code: String) -> [Division]

Return a list of counties in Division data structure.

```swift
GB2260()!.counties(of: "110100")
/**
  [
    <GB/T 2260-201410> 110108 北京市 市辖区 海淀区
    <GB/T 2260-201410> 110117 北京市 市辖区 平谷区
    <GB/T 2260-201410> 110109 北京市 市辖区 门头沟区
    <GB/T 2260-201410> 110112 北京市 市辖区 通州区
    <GB/T 2260-201410> 110101 北京市 市辖区 东城区
    <GB/T 2260-201410> 110105 北京市 市辖区 朝阳区
    <GB/T 2260-201410> 110114 北京市 市辖区 昌平区
    <GB/T 2260-201410> 110111 北京市 市辖区 房山区
    <GB/T 2260-201410> 110115 北京市 市辖区 大兴区
    <GB/T 2260-201410> 110102 北京市 市辖区 西城区
    <GB/T 2260-201410> 110116 北京市 市辖区 怀柔区
    <GB/T 2260-201410> 110106 北京市 市辖区 丰台区
    <GB/T 2260-201410> 110107 北京市 市辖区 石景山区
    <GB/T 2260-201410> 110113 北京市 市辖区 顺义区
  ]
*/
```

### provinces: [Division]

Return a list of provinces in Division data structure.

```swift
GB2260()!.provinces
/**
  [
    <GB/T 2260-201410> 640000 宁夏回族自治区
    <GB/T 2260-201410> 230000 黑龙江省
    <GB/T 2260-201410> 440000 广东省
    <GB/T 2260-201410> 620000 甘肃省
    <GB/T 2260-201410> 500000 重庆市
    <GB/T 2260-201410> 450000 广西壮族自治区
    <GB/T 2260-201410> 460000 海南省
    <GB/T 2260-201410> 420000 湖北省
    <GB/T 2260-201410> 220000 吉林省
    <GB/T 2260-201410> 820000 澳门特别行政区
    <GB/T 2260-201410> 130000 河北省
    <GB/T 2260-201410> 110000 北京市
    <GB/T 2260-201410> 120000 天津市
    <GB/T 2260-201410> 360000 江西省
    <GB/T 2260-201410> 370000 山东省
    <GB/T 2260-201410> 630000 青海省
    <GB/T 2260-201410> 710000 台湾省
    <GB/T 2260-201410> 520000 贵州省
    <GB/T 2260-201410> 350000 福建省
    <GB/T 2260-201410> 650000 新疆维吾尔自治区
    <GB/T 2260-201410> 810000 香港特别行政区
    <GB/T 2260-201410> 410000 河南省
    <GB/T 2260-201410> 510000 四川省
    <GB/T 2260-201410> 330000 浙江省
    <GB/T 2260-201410> 540000 西藏自治区
    <GB/T 2260-201410> 430000 湖南省
    <GB/T 2260-201410> 340000 安徽省
    <GB/T 2260-201410> 150000 内蒙古自治区
    <GB/T 2260-201410> 610000 陕西省
    <GB/T 2260-201410> 530000 云南省
    <GB/T 2260-201410> 320000 江苏省
    <GB/T 2260-201410> 310000 上海市
    <GB/T 2260-201410> 140000 山西省
    <GB/T 2260-201410> 210000 辽宁省
  ]
*/
```

## License

[MIT.](LICENSE)

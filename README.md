# PSTagAlignView
![](https://img.shields.io/badge/language-Objective--C-green.svg)   ![](https://img.shields.io/cocoapods/v/PSTagAlignView.svg?style=flat)   ![](https://img.shields.io/cocoapods/l/PSTagAlignView.svg?style=flat)


* 一个自定义标签显示视图，可选择左对齐或者右对齐。
* 该自定视图会根据填充的数据以及视图的宽度自动给出完成布局之后的整体高度。

#使用方式

```ruby
//现已支持cocoaPods引入
pod 'PSTagAlignView', '~> 1.0'
```



```Objective-C
/**要显示的数据源*/
NSArray *dataArray = @[@"金城郡", @"安定郡", @"北地郡",@"陈国", @"武威郡", @"张掖郡", @"梁国", @"酒泉郡", @"敦煌郡", @"张掖属国",@"中山国", @"沛国", @"居延属国",@"陇西郡",@"汉阳郡", @"鲁国",@"武都郡"];
/** 
	按照此格式传入配置参数 
	textFont:字体
	textColor：字体颜色
	borderColor:边框颜色
	borderRadius：圆角大小
*/
NSDictionary *configDic = @{@"textFont": [UIFont systemFontOfSize:14],
                            @"textColor": [UIColor orangeColor],
                            @"borderColor": [UIColor orangeColor],
                            @"borderRadius": [NSNumber numberWithFloat:10.f]
                            };
/** 
	itemMarign为item的间距
	PSTagAlignView默认左对齐显示

*/
PSTagAlignView *tagAlignView = [PSTagAlignView tagAlignViewWithContents:dataArray itemMarign:5.0 configDict:configDic];
[self.view addSubview:tagAlignView];

__weak typeof(self) weakSelf = self;
/** 根据数据源填充之后返回整体高度，便于开发者进行更新约束 */
tagAlignView.completionBlock = ^(CGFloat height) {
    weakSelf.heightConstarint.constant = height;
};
//填充数据方法    
[tagAlignView reloadData];

```

```Objective-C
//更改数据的对其显示方式
//右对齐
self.tagAlignView.alignStyle = PSTagAlignStyleRight;
[self.tagAlignView reloadData];

```






#演示效果



![图例](http://ww1.sinaimg.cn/large/69d7eb73gy1fodqn7az0yg20af0ijqez.gif)

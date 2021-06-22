<h1 align="center">ABtutorial</h1>

<hr/>
<br/>

<div align="center">
<img width="256" height="256" src="https://abenergie.visualstudio.com/2cd1c72b-5531-41dc-8dcb-437d29801dcc/_apis/git/repositories/2a41da94-647a-4081-a5d5-d5871a66a14b/items?path=%2FABtutorial_logo.png&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=octetStream&api-version=5.0">
</div>

<br/>


# ABtutorial

ABtutorial permette la visualizzazione di mini-tutorial che spiegano specifiche funzionalità sulle app dei gruppi ABenergie e LemonPie.

## Requirements

iOS 11.0 or newer

## Installation 

ABtutorial is available through [CocoaPods](https://cocoapods.org). 
To install it, add the following line to your Podfile:

```ruby
pod 'ABtutorial', :git => 'https://abenergie.visualstudio.com/_git/ABtutorial.ios'
```

(Optional) To the top of the Podfile add this to preserve the folder structure.
```ruby
install! 'cocoapods',
:preserve_pod_file_structure => true
```

## Demo

Clone the project

```bash
git clone https://abenergie.visualstudio.com/ABtutorial.ios/_git/ABtutorial.ios
```

Go to the project directory

```bash
cd ABtutorial/Example
```

Open the example project

```bash
open ABtutorial.xcworkspace
```

Install dependencies

```bash
pod install
```

## Usage/Examples

```swift
let page = ABTOnboardPage(title: "Title",
description: "Description",
[...])

let appearance = ABTPageAppearance(titleColor: .black,
backgroundColor: .red,
[...])

let tutorial = ABTutorial(pageItems: [page],
pageAppearance: appearance)

tutorial.presentFrom(self, animated: true)
```

## Authors

- [Luigi Aiello](https://github.com/mo3bius), luigi.aiello@abenergie.it

- [Francesco Leoni](https://github.com/fraleo2406), francesco.leoni@abenergie.it

## License

ABtutorial is available under the [MIT](https://choosealicense.com/licenses/mit/) license. See the LICENSE file for more info.


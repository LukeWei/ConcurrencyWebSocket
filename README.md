# ConcurrencyWebSocket
WebSocket with [Swift Concurrency](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/)

剛好在寫 WebSocket 時想到能和 Concurrency 結合在一起，寫來試試看，記錄一下

## Installation

### Swift Package manager

```swift
dependencies: [
    .package(url: "https://github.com/LukeWei/ConcurrencyWebSocket.git", .upToNextMajor(from: "1.0.0"))
]
```
### Manually

直接複製 extension 到專案也行

## Usage

```swift
let socket = URLSession(configuration: .default).webSocketTask(with: URL(string: "wss://...")!)

for try await message in socket.stream() {
    switch msssage {
    case .string(let message):
        // do something with String
    case .data(let data):
        // do something with Data
    @unknow default:
        break
    }
}
```

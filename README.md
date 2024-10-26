# ConcurrencyWebSocket
WebSocket with Swift Concurrency

剛好在寫 WebSocket 時想到能和 Concurrency 結合在一起，寫來試試看，記錄一下

## Installation

### Swift Package manager

```swift
dependencies: [
    .package(url: "https://github.com/LukeWei/ConcurrencyWebSocket.git", .upToNextMajor(from: "1.0.0"))
]
```

## Usage

```swift
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

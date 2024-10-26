// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

typealias WebSocketStream = AsyncThrowingStream<URLSessionWebSocketTask.Message, Error>

extension URLSessionWebSocketTask {
    func stream() -> WebSocketStream {
        AsyncThrowingStream { continuation in
            Task {
                while self.state == .running || self.state == .suspended {
                    do {
                        let message = try await self.receive()
                        continuation.yield(message)
                    } catch {
                        continuation.finish(throwing: error)
                        break
                    }
                }
            }
        }
    }
}

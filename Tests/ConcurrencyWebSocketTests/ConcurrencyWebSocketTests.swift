import Testing
import Foundation
@testable import ConcurrencyWebSocket

struct ConcurrencyWebSocketTests {
    
    let sut = URLSession(configuration: .default).webSocketTask(with: URL(string: "wss://echo.websocket.org")!)
    
    init() {
        sut.resume()
    }
    
    @Test func connect() async throws {
        
        let message = "Hello, World!"
        
        try await sut.send(.string(message))
    
        var received: [String] = []
        
        Task {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            #expect(received.contains(where: { $0 == message }))
            sut.cancel()
        }
        
        // Cancelling the WebSocket always throws an NSPOSIXErrorDomain error, which should be ignored.        
        await #expect(throws: Error.self, performing: {
            for try await echo in sut.stream() {
                switch echo {
                case .string(let echo):
                    received.append(echo)
                default:
                    break
                }
            }
        })
        
    }
}

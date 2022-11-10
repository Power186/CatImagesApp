import Foundation
import Combine

/// Manages the current session from a URLSession
struct SessionManager {
    
    /// Checks for a valid response and data from a URLSession DataTaskPublisher
    /// - Parameter output: values published by Publisher
    /// - Returns: Data if valid response, otherwise bad server error
    static func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 &&
                response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}

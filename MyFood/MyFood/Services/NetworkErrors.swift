import Foundation

enum NetworkErrors: Error {
    case badURL
    case requestFailed
    case decodingFailed
    case failedSerializationBody
}

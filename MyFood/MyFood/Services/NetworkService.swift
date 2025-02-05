import Foundation

protocol NetworkServiceLogic {
    func fetchFood(by category: Categories) async throws -> FoodCards
}

final class NetworkService: NetworkServiceLogic {
        
    private let decoder = JSONDecoder()
    
    func fetchFood(by category: Categories) async throws -> FoodCards { // sporno
        guard let url = URL(string: category.url) else {
            throw NetworkErrors.badURL
        }
        
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) 
        else {
            throw NetworkErrors.requestFailed
        }
        
        do {
            return try decoder.decode(FoodCards.self, from: data)
        } catch {
            throw NetworkErrors.decodingFailed
        }
    }
}

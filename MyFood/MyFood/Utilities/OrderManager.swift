import Foundation

enum Key: String {
    case totalOrder
}

final class OrderManager {
    
    // MARK: - Singleton
    
    static let shared = OrderManager()
    private init(){}
    
    // MARK: - Public methods
    
    func saveOrder(_ order: Order) {
        var result = [String: Order]()
        
        let userDef = UserDefaults.standard
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        
        if let data = userDef.data(forKey: Key.totalOrder.rawValue),
           let totalOrder = try? decoder.decode([String: Order].self, from: data) {
            result = totalOrder
        }
        
        result[order.id] = order
        
        if let encodedData = try? encoder.encode(result) {
            userDef.set(encodedData, forKey: Key.totalOrder.rawValue)
        }
    }
    
    func getTotalOrder() -> [Order]? {
        let userDef = UserDefaults.standard
        let decoder = JSONDecoder()
        
        if let data = userDef.data(forKey: Key.totalOrder.rawValue),
           let totalOrder = try? decoder.decode([String: Order].self, from: data) {
            return totalOrder.map { $0.value }
        }

        return nil
    }
    
    func contains(_ id: String) -> Bool {
        guard let order = getTotalOrder() else { return false }
        
        return order.contains { $0.id == id }
    }
    
    func getOrder(by id: String) -> Order? {
        guard let order = getTotalOrder() else { return nil }
        let result = order.filter { $0.id == id }
        
        return result.first
    }
    
    func removeAll() {
        UserDefaults.standard.removeObject(forKey: Key.totalOrder.rawValue)
    }
    
    func remove(at id: String) {
        var updatedTotalOrder = [String: Order]()
        
        let userDef = UserDefaults.standard
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        
        if let data = userDef.data(forKey: Key.totalOrder.rawValue),
           let totalOrder = try? decoder.decode([String: Order].self, from: data) {
            updatedTotalOrder = totalOrder
        }
        
        updatedTotalOrder[id] = nil
        
        guard !updatedTotalOrder.isEmpty else {
            removeAll()
            return
        }
        
        if let encodedData = try? encoder.encode(updatedTotalOrder) {
            userDef.set(encodedData, forKey: Key.totalOrder.rawValue)
        }
    }
}

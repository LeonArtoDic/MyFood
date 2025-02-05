protocol FoodProviderLogic {
    func getFoodList(by name: Categories) async -> [FoodItem]
}

final class FoodProvider: FoodProviderLogic {
    
    // MARK: - Private properties
    
    private let networkService: NetworkService
    
    // MARK: - Initialization
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    
    // MARK: - Public methods
    
    func getFoodList(by name: Categories) async -> [FoodItem] {
        var result = [FoodCardElement]()
        
        do {
            result = try await networkService.fetchFood(by: name)
        } catch {
            print("Network error - \(error)")
        }
        
        let foodItems = result.map {
            FoodItem(title: $0.name,
                     rating: $0.rate,
                     description: $0.dsc,
                     price: $0.price,
                     imageString: $0.img,
                     id: $0.id)}
        
        return foodItems
    }
}

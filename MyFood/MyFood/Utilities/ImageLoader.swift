import UIKit

protocol ImageLoaderLogic {
    func loadImage(from urlString: String) async -> UIImage?
}

final class ImageLoader: ImageLoaderLogic {
    
    // MARK: Singleton
    
    static let shared = ImageLoader()
    
    // MARK: Private properties
    
    private let cache = NSCache<NSString, UIImage>()
    
    // MARK: Initializaton
    
    private init(){}

    
    // MARK: Public methods
    
    func loadImage(from urlString: String) async -> UIImage? {
        
        if let cachedImage = cache.object(forKey: urlString as NSString) {
            return cachedImage
        }
        
        guard let url = URL(string: urlString) else { return nil }
        
        URLSession.shared.configuration.httpMaximumConnectionsPerHost = 10
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                cache.setObject(image, forKey: urlString as NSString)
                return image
            }
        } catch {
            print("Failed to load image: \(error)")
        }
        
        return nil
    }
}

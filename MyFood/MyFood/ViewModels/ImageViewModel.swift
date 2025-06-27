import UIKit
import Combine

protocol ImageCellModelLogic {
    var imageObserver: Published<UIImage?>.Publisher { get }
    
    func fetchImage(urlString: String)
    func prepareForReuse()
}

final class ImageCellViewModel: ImageCellModelLogic {
    
    // MARK: Public properties
    
    @Published var image: UIImage?
    
    var imageObserver: Published<UIImage?>.Publisher {
        $image
    }
    
    // MARK: Private properties
    
    private var latestRequestID = UUID()
    
    
    // MARK: Public methods
    
    func fetchImage(urlString: String) {
        let requestID = UUID()
        latestRequestID = requestID
        
        Task { @MainActor in
            let image = await ImageLoader.shared.loadImage(from: urlString)
            
            if requestID == latestRequestID {
                self.image = image ?? .notFound
            }
        }
    }
    
    func prepareForReuse() {
        image = nil
        latestRequestID = UUID()
    }
}

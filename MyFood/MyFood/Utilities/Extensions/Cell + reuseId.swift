import UIKit

extension UICollectionViewCell {
    static var reuseId: String {
        Self.description()
    }
}

extension UITableViewCell {
    static var reuseId: String {
        Self.description()
    }
}

extension UITableViewHeaderFooterView {
    static var reuseId: String {
        Self.description()
    }
}

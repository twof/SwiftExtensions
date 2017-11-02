import Foundation

extension AnyKeyPath {
    
    /// Gets the key of a KeyPath as a string. Good for debugging
    var key: String? {
        let splitList = String(describing: self).split(whereSeparator: {">,.".contains($0)})
        guard splitList.count > 3 else { return nil }
        return String(splitList[2])
    }
    
    /// Gets the value of a KeyPath as a string. Good for debugging
    var value: String? {
        guard let value = (String(describing: self).split{">,.".contains($0)}.last) else { return nil }
        return String(describing: value)
    }
}

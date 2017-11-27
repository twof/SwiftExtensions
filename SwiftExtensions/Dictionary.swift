extension Dictionary where Key: Comparable, Value: Equatable {
    
    /// Returns a dictionary representing the changes between one dictionary to another with the same keys
    func difference(other: [Key: Value]) -> [Key: Value] {
        var differences = [Key: Value]()
        for (k, v) in self {
            if other[k] != v {
                differences[k] = v
            }
        }
        
        return differences
    }
    
    /// Returns a new dictionary.
    /// Returns self with changes
    func updated(with changes: [Key: Value]) -> [Key: Value] {
        var newDict = self
        for (k, v) in changes {
            newDict[k] = v
        }
        
        return newDict
    }
}

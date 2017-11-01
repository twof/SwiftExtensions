//
//  KeyPath.swift
//  SwiftExtensions
//
//  Created by New User on 11/1/17.
//  Copyright © 2017 twof. All rights reserved.
//

import Foundation

extension AnyKeyPath {
    var key: String? {
        let splitList = String(describing: self).split(whereSeparator: {">,.".contains($0)})
        guard splitList.count > 3 else { return nil }
        return String(splitList[2])
    }
    
    var value: String? {
        guard let value = (String(describing: self).split{">,.".contains($0)}.last) else { return nil }
        return String(describing: value)
    }
}

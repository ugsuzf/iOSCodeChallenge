//
//  Extensions.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//

import Foundation
import UIKit

extension Optional where Wrapped == Int {
    
    var intValue: Int {
        return self ?? 0
    }
    
    var stringValue: String {
        return String(self.intValue)
    }
}

extension UITableViewCell {
    
    static var cellIdentifier: String {
        return String(describing: Self.self)
    }
}

extension Optional where Wrapped == Double {
    
    var doubleValue: Double {
        return self ?? 0.0
    }
    
    var stringValue: String {
        return String(self.doubleValue)
    }
}

extension Optional where Wrapped == String {
    
    var stringValue: String {
        return self ?? ""
    }
    
    var intValue: Int {
        return Int(self.stringValue) ?? 0
    }
}

extension Encodable {

    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
}
extension Optional where Wrapped == Bool {
    
    var boolValue: Bool {
        return self ?? false
    }
}

protocol Instantiable: class {
    static var storyboardName: String { get }
}

extension Instantiable {
    
    static func instantiateFromStoryboard() -> Self {
        let identifier = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: Self.self))
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}


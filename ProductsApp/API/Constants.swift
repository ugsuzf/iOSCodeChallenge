//
//  Constants.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//

import Foundation

enum ServiceUrls {
    case allProducts
    case reviews(productId: String)
    
    var url: URL? {
        switch self {
        case .allProducts:
            return URL(string: "http://localhost:3001/product")
        case .reviews(let productId):
            return URL(string: "http://localhost:3002/reviews/\(productId)")
            
        }
    }
}


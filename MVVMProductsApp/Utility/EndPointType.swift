//
//  EndPointType.swift
//  MVVMProductsApp
//
//  Created by Rishabh Balani on 17/06/24.
//

import Foundation

enum HTTPMethods: String {
  case get = "GET"
  case post = "POST"
}
protocol EndPointType {
  var path: String { get }
  var baseURL: String { get }
  var url: URL? { get }
  var method: HTTPMethods { get }
}
enum EndPointsItems {
  case products
}

////https://fakestoreapi.com/products
//extension EndPointsItems: EndPointType {
//  var path: String {
//    switch self {
//    case .products:
//      return "products"
//    }
//  }
//
//  var baseURL: String {
//    return "https://fakestoreapi.com/products"
//  }
//
//  var url: URL? {
//      return URL(string: "\(baseURL) \(path) ")
//  }
//
//  var method: HTTPMethods {
//    
//  }
//
//}

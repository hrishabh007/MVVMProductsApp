//
//  ApiManager.swift
//  MVVMProductsApp
//
//  Created by Rishabh Balani on 29/05/24.
//

import Foundation

enum DataError: Error {
  case invalidURL
  case invalidResponse
  case invalidData
  case network(_ error: Error?)
}

typealias Handler<T> = (Result<T, DataError>) -> Void
//Singleton Design Pattern
class ApiManager {
  static let shared = ApiManager()
  private init() {}

  func request<T: Codable>(
    modelType: T.Type,
    type: EndPointType,
    completion: @escaping Handler<T>
  ) {
    guard let url = type.url else {
      completion(.failure(.invalidURL))
      return
    }

    var request = URLRequest(url: url)
    request.httpMethod = type.method.rawValue

    if let parameters = type.body {
      request.httpBody = try? JSONEncoder().encode(parameters)
    }
    request.allHTTPHeaderFields = type.headers
      
      //Background Task
    URLSession.shared.dataTask(with: request) {
      data, responce, error in
      guard let data, error == nil else {
        completion(.failure(.invalidData))
        return
      }
      guard let responce = responce as? HTTPURLResponse, 200...299 ~= responce.statusCode else {
        completion(.failure(.invalidResponse))
        return
      }
      // JSONDecoder () - Data ka Model (Array) mai convert karega
      do {
        let products = try JSONDecoder().decode(modelType, from: data)
        completion(.success(products))
      } catch {
        completion(.failure(.network(error)))
      }

    }.resume()
  }
  static var commonHeader: [String: String] {
    return [
      "Content-Type": "application/json"
    ]
  }

  //  func fetchProducts(completion: @escaping Handler) {
  //    guard let url = URL(string: Constants.API.productURL) else {
  //      completion(.failure(.invalidURL))
  //      return
  //    }
  //    URLSession.shared.dataTask(with: url) {
  //      data, responce, error in
  //      guard let data, error == nil else {
  //        completion(.failure(.invalidData))
  //        return
  //      }
  //      guard let responce = responce as? HTTPURLResponse, 200...299 ~= responce.statusCode else {
  //        completion(.failure(.invalidResponse))
  //        return
  //      }
  //      // JSONDecoder () - Data ka Model (Array) mai convert karega
  //      do {
  //        let products = try JSONDecoder().decode([Product].self, from: data)
  //        completion(.success(products))
  //      } catch {
  //        completion(.failure(.network(error)))
  //      }
  //
  //    }.resume()
  //  }

}

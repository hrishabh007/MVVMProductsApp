//
//  ApiManager.swift
//  MVVMProductsApp
//
//  Created by Rishabh Balani on 29/05/24.
//

import Foundation
import UIKit

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

  func request<T: Decodable>(
    modelType: T.Type,
    type: EndPointType,
    completion: @escaping Handler<T>
  ) {
      guard let url = type.url else {
      completion(.failure(.invalidURL))
      return
    }
    URLSession.shared.dataTask(with: url) {
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

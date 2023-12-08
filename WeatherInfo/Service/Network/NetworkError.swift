//
//  NetworkError.swift
//  WeatherInfo
//
//  Created by Лаборатория on 08.12.2023.
//

import Foundation

enum NetworkError: Error {

    case badUrl
    case badResponse
    case invalidDecoding
}

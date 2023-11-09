//
//  APIRequest.swift
//  Meal Search Demo
//
//  Created by NeoSOFT on 07/11/23.
//

import Foundation
import Alamofire

protocol APIRequest {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    var headers: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }
}

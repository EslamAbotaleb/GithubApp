//
//  GithubService.swift
//  GithubTask
//
//  Created by Islam Abotaleb on 1/5/21.
//

import Foundation
import Moya

enum GithubService {
    case getUsersGithubWithPagnation(since: Int, per_page: Int)
    case getRepoUserGithubByUserName(userName: String)
}

extension GithubService: TargetType {
//    https://api.github.com/users/EslamAbotaleb/repos
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .getUsersGithubWithPagnation:
            return "/users"
        case .getRepoUserGithubByUserName(let userName):
            return "users/\(userName)/repos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUsersGithubWithPagnation:
            return .get
        case .getRepoUserGithubByUserName:
            return .get
        }
    }
    var sampleData: Data {
        switch self {
        case .getUsersGithubWithPagnation:
            return Data()
        case .getRepoUserGithubByUserName:
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .getUsersGithubWithPagnation(let since,let per_page):
            return .requestParameters(
                parameters: [
                    "since": since,
                    "per_page": per_page
                ],
                encoding: URLEncoding.default)
        case .getRepoUserGithubByUserName(let userName):
            return .requestParameters(parameters:
                                        ["" : userName],
                       encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return  ["Content-Type": "application/json"]
    }
    public var validationType: ValidationType {
      return .successCodes
    }
}

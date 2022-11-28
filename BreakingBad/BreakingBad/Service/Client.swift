//
//  Client.swift
//  BreakingBad
//
//  Created by Alihan KUZUCUK on 22.11.2022.
//

import Foundation

final class Client {
    
    enum Endpoints {
        static let base = "https://www.breakingbadapi.com/api"

        case getAllCharacters
        case getCharacterQuotes(String)
        case getAllEpisodes
        case getCharacterDetail(String)
        case getEpisodeById(Int)

        var stringValue: String {
            switch self {
                case .getAllCharacters:
                    return Endpoints.base + "/characters"
                case .getCharacterQuotes(let author):
                    let authorUrlEncoded = author.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                    return Endpoints.base + "/quote?author=\(authorUrlEncoded ?? "")"
                case .getAllEpisodes:
                    return Endpoints.base + "/episodes"
                case .getCharacterDetail(let characterName):
                    let characterNameUrlEncoded = characterName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                    return Endpoints.base + "/characters?name=\(characterNameUrlEncoded ?? "")"
                case .getEpisodeById(let episodeId):
                    return Endpoints.base + "/episodes/\(episodeId)"
            }
        }

        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    @discardableResult
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()

        return task
    }
    
    class func getAllCharacters(completion: @escaping ([CharacterModel]?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getAllCharacters.url, responseType: [CharacterModel].self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    class func getCharacterQuotes(of name: String, completion: @escaping ([CharacterQuotesModel]?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getCharacterQuotes(name).url, responseType: [CharacterQuotesModel].self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    class func getAllEpisodes(completion: @escaping ([EpisodeModel]?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getAllEpisodes.url, responseType: [EpisodeModel].self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    class func getCharacterDetail(of name: String, completion: @escaping ([CharacterDetailModel]?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getCharacterDetail(name).url, responseType: [CharacterDetailModel].self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    class func getEpisodeBy(id episodeId: Int, completion: @escaping ([EpisodeModel]?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getEpisodeById(episodeId).url, responseType: [EpisodeModel].self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
}

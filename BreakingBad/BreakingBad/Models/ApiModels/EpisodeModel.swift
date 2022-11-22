//
//  EpisodeModel.swift
//  BreakingBad
//
//  Created by Alihan KUZUCUK on 22.11.2022.
//

import Foundation

struct EpisodeModel: Codable {
    let episodeId: Int
    let episodeTitle: String
    let episodeSeason: String
    let episodeAirDate: String
    let episodeCharacters: [String]
    let episodeName: String
    let episodeSeries: String

    enum CodingKeys: String, CodingKey {
        case episodeId = "episode_id"
        case episodeTitle = "title"
        case episodeSeason = "season"
        case episodeAirDate = "airDate"
        case episodeCharacters = "characters"
        case episodeName = "episode"
        case episodeSeries = "series"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        episodeId = try values.decodeIfPresent(Int.self, forKey: .episodeId) ?? -1
        episodeTitle = try values.decodeIfPresent(String.self, forKey: .episodeTitle) ?? ""
        episodeSeason = try values.decodeIfPresent(String.self, forKey: .episodeSeason) ?? ""
        episodeAirDate = try values.decodeIfPresent(String.self, forKey: .episodeAirDate) ?? ""
        episodeCharacters = try values.decodeIfPresent([String].self, forKey: .episodeCharacters) ?? []
        episodeName = try values.decodeIfPresent(String.self, forKey: .episodeName) ?? ""
        episodeSeries = try values.decodeIfPresent(String.self, forKey: .episodeSeries) ?? ""
    }
}

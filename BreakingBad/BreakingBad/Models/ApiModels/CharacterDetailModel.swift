//
//  CharacterDetailModel.swift
//  BreakingBad
//
//  Created by Alihan KUZUCUK on 23.11.2022.
//

import Foundation

struct CharacterDetailModel: Codable {
    let characterId: Int
    let characterName: String
    let characterBirthday: String
    let characterOccupation: [String]
    let characterImage: String
    let characterStatus: String
    let characterNickname: String
    let characterAppearance: [Int]
    let characterPortrayed: String
    let characterCategory: String
    let betterCallSaulAppearance: [Int]

    enum CodingKeys: String, CodingKey {
        case characterId = "char_id"
        case characterName = "name"
        case characterBirthday = "birthday"
        case characterOccupation = "occupation"
        case characterImage = "img"
        case characterStatus = "status"
        case characterNickname = "nickname"
        case characterAppearance = "appearance"
        case characterPortrayed = "portrayed"
        case characterCategory = "category"
        case betterCallSaulAppearance = "better_call_saul_appearance"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        characterId = try values.decodeIfPresent(Int.self, forKey: .characterId) ?? -1
        characterName = try values.decodeIfPresent(String.self, forKey: .characterName) ?? ""
        characterBirthday = try values.decodeIfPresent(String.self, forKey: .characterBirthday) ?? ""
        characterOccupation = try values.decodeIfPresent([String].self, forKey: .characterOccupation) ?? []
        characterImage = try values.decodeIfPresent(String.self, forKey: .characterImage) ?? ""
        characterStatus = try values.decodeIfPresent(String.self, forKey: .characterStatus) ?? ""
        characterNickname = try values.decodeIfPresent(String.self, forKey: .characterNickname) ?? ""
        characterAppearance = try values.decodeIfPresent([Int].self, forKey: .characterAppearance) ?? []
        characterPortrayed = try values.decodeIfPresent(String.self, forKey: .characterPortrayed) ?? ""
        characterCategory = try values.decodeIfPresent(String.self, forKey: .characterCategory) ?? ""
        betterCallSaulAppearance = try values.decodeIfPresent([Int].self, forKey: .betterCallSaulAppearance) ?? []
    }
}

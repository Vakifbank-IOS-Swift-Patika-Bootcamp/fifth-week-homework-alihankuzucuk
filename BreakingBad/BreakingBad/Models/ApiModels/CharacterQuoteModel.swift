//
//  CharacterQuoteModel.swift
//  BreakingBad
//
//  Created by Alihan KUZUCUK on 22.11.2022.
//

import Foundation

struct CharacterQuotesModel: Codable {
    let quoteId: Int
    let quote: String
    let author: String
    let series: String

    enum CodingKeys: String, CodingKey {
        case quoteId = "quote_id"
        case quote = "quote"
        case author = "author"
        case series = "series"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        quoteId = try values.decodeIfPresent(Int.self, forKey: .quoteId) ?? -1
        quote = try values.decodeIfPresent(String.self, forKey: .quote) ?? ""
        author = try values.decodeIfPresent(String.self, forKey: .author) ?? ""
        series = try values.decodeIfPresent(String.self, forKey: .series) ?? ""
    }
}

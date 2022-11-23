//
//  EpisodeModelUtility.swift
//  BreakingBad
//
//  Created by Alihan KUZUCUK on 23.11.2022.
//

import Foundation

final class EpisodeModelUtility {
    
    /// This method returns count of seasons according to given episode list
    /// - Parameter list: List of episodes which type of EpisodeModel
    /// - Returns: Count of season
    class func getSeasonsCount(of list: [EpisodeModel]?) -> Int {
        guard let list = list else { return 0 }
        
        var seasonCounter: Int = 0
        
        list.forEach { episode in
            if Int(episode.episodeSeason) ?? 0 > seasonCounter,
               episode.episodeSeries == "Breaking Bad" {
                seasonCounter = Int(episode.episodeSeason)!
            }
        }
        
        return seasonCounter
    }
    
    /// This method returns count of episodes in specific season
    /// - Parameters:
    ///   - list: List of episodes which type of EpisodeModel
    ///   - season: Season which requested number of episodes
    /// - Returns: Count of episodes in given season
    class func getEpisodesInSeason(of list: [EpisodeModel]?, which season: Int) -> Int {
        guard let list = list else { return 0 }
        
        var episodeCounterInSeason: Int = 0
        
        list.forEach { episode in
            if Int(episode.episodeSeason) == season,
               episode.episodeSeries == "Breaking Bad" {
                episodeCounterInSeason += 1
            }
        }
        
        return episodeCounterInSeason
    }
    
    
    /// This method returns episode which in requested season & episode
    /// - Parameters:
    ///   - list: List of episodes which type of EpisodeModel
    ///   - season: Season which requested
    ///   - episodeInSeason: Episode which requested
    /// - Returns: Episode in requested season & episode
    class func getEpisodeOf(list: [EpisodeModel]?, in season: Int, which episodeInSeason: Int) -> EpisodeModel? {
        guard let list = list else { return nil }
        
        var selectedEpisode: EpisodeModel? = nil
        
        list.forEach { episode in
            if Int(episode.episodeSeason) == season,
               Int(episode.episodeInSeason) == episodeInSeason,
               episode.episodeSeries == "Breaking Bad" {
                selectedEpisode = episode
            }
        }
        
        return selectedEpisode
    }
    
    
    /// This method returns characters of selected episode
    /// - Parameters:
    ///   - list: List of episodes which type of EpisodeModel
    ///   - season: Season which requested
    ///   - episodeInSeason: Episode which requested
    /// - Returns: String array of Character names
    class func getEpisodeCharactersOf(list: [EpisodeModel]?, in season: Int, which episodeInSeason: Int) -> [String]? {
        guard let list = list else { return nil }
        
        var selectedEpisodeCharacters: [String]? = nil
        
        list.forEach { episode in
            if Int(episode.episodeSeason) == season,
               Int(episode.episodeInSeason) == episodeInSeason,
               episode.episodeSeries == "Breaking Bad" {
                selectedEpisodeCharacters = episode.episodeCharacters
            }
        }
        
        return selectedEpisodeCharacters
    }
    
}

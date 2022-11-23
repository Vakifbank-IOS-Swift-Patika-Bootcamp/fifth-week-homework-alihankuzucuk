//
//  EpisodeModelUtility.swift
//  BreakingBad
//
//  Created by Alihan KUZUCUK on 23.11.2022.
//

import Foundation

final class EpisodeModelUtility {
    
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
    
}

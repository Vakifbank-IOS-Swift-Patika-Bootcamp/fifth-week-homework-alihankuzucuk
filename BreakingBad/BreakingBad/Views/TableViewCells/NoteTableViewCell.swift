//
//  NoteTableViewCell.swift
//  BreakingBad
//
//  Created by Alihan KUZUCUK on 28.11.2022.
//

import UIKit

final class NoteTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var lblSeasonId: UILabel!
    @IBOutlet private weak var lblEpisodeId: UILabel!
    @IBOutlet private weak var lblNote: UILabel!
    
    // MARK: - Methods
    func configureCell(note: String, episodeId: Int) {
        
        Client.getEpisodeBy(id: episodeId) { [weak self] episode, error in
            guard let self = self,
                  let episode = episode
            else {
                return
            }
            
            self.lblSeasonId.text = "Season: \(episode.first?.episodeSeason ?? "")"
            self.lblEpisodeId.text = "Episode: \(episode.first?.episodeInSeason ?? "")"
            self.lblNote.text = note
        }
        
    }
    
}

//
//  EpisodeListViewController.swift
//  BreakingBad
//
//  Created by Alihan KUZUCUK on 22.11.2022.
//

import UIKit

final class EpisodeListViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    private var episodes: [EpisodeModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Client.getAllEpisodes { [weak self] episodes, error in
            guard let self = self else { return }
            self.episodes = episodes
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}

extension EpisodeListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let episodes = episodes else { return 0 }
        return EpisodeModelUtility.getSeasonsCount(of: episodes)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let episodes = episodes else { return 0 }
        return EpisodeModelUtility.getEpisodesInSeason(of: episodes, which: section + 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = EpisodeModelUtility.getEpisodeOf(list: episodes, in: indexPath.section + 1, which: indexPath.row + 1)?.episodeTitle
        content.secondaryText = "Air Date: " + (EpisodeModelUtility.getEpisodeOf(list: episodes, in: indexPath.section + 1, which: indexPath.row + 1)?.episodeAirDate ?? "")
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Season \(section + 1)"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueShowEpisodeCharacters", sender: nil)
    }
    
}


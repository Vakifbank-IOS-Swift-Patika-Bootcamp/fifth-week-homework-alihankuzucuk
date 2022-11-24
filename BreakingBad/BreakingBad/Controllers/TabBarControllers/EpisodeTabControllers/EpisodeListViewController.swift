//
//  EpisodeListViewController.swift
//  BreakingBad
//
//  Created by Alihan KUZUCUK on 22.11.2022.
//

import UIKit

final class EpisodeListViewController: BaseViewController, EpisodeListViewControllerProtocol {

    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    // MARK: - Variables
    private var episodes: [EpisodeModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    private var selectedEpisodeCharacters: [String]?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        Client.getAllEpisodes { [weak self] episodes, error in
            guard let self = self else { return }
            self.indicator.stopAnimating()
            self.episodes = episodes
        }
    }
    
    // MARK: - Overrides
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueEpisodeCharacters" {
            guard let vcEpisodeCharacters = segue.destination as? EpisodeCharactersViewController else { return }
            vcEpisodeCharacters.delegate = self
            vcEpisodeCharacters.episodeCharacters = selectedEpisodeCharacters
        }
    }
    
    // MARK: - Methods
    func btnCloseEpisodeCharactersClicked() {
        print("Delegate Triggered")
    }

}

// MARK: - Extension: TableView
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
        var popUpEpisodeCharacters: EpisodeCharactersPopUpView!
        var selectedEpisodeCharacters = EpisodeModelUtility.getEpisodeCharactersOf(list: self.episodes, in: indexPath.section + 1, which: indexPath.row + 1)
        
        popUpEpisodeCharacters = EpisodeCharactersPopUpView(frame: self.view.frame, characterNames: selectedEpisodeCharacters)
        //self.popUpEpisodeCharacters.btnClose.addTarget(self, action: #selector(), for: .touchUpInside)
        popUpEpisodeCharacters.delegate = self
        self.view.addSubview(popUpEpisodeCharacters)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let tableViewActionShowSelectedEpisodeCharacters = UITableViewRowAction(style: .normal, title: "Episode Characters") { _, indexPath in
            self.selectedEpisodeCharacters = EpisodeModelUtility.getEpisodeCharactersOf(list: self.episodes, in: indexPath.section + 1, which: indexPath.row + 1)
            self.performSegue(withIdentifier: "segueEpisodeCharacters", sender: nil)
        }
        
        tableViewActionShowSelectedEpisodeCharacters.backgroundColor = .blue
        
        return [tableViewActionShowSelectedEpisodeCharacters]
    }
    
}


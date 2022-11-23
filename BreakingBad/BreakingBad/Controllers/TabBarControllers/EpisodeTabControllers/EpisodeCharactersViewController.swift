//
//  EpisodeCharactersViewController.swift
//  BreakingBad
//
//  Created by Alihan KUZUCUK on 23.11.2022.
//

import UIKit

final class EpisodeCharactersViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterTableViewCell")
            tableView.estimatedRowHeight = UITableView.automaticDimension
        }
    }
    
    // MARK: - Variables
    var episodeCharacters: [String]?
    
    // MARK: - Delegates
    weak var delegate: (EpisodeListViewControllerProtocol)?
    // NOTE: 'weak' variable should have optional type
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnClose.contentHorizontalAlignment = .right
        tableView.reloadData()
    }

    // MARK: - Methods
    @IBAction func btnCloseClicked(_ sender: Any) {
        delegate?.btnCloseEpisodeCharactersViewClicked()
        self.dismiss(animated: true)
    }
}

extension EpisodeCharactersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episodeCharacters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as? CharacterTableViewCell,
              let characterName = episodeCharacters?[indexPath.row]
        else {
            return UITableViewCell()
        }
        cell.configureCell(characterName: characterName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}

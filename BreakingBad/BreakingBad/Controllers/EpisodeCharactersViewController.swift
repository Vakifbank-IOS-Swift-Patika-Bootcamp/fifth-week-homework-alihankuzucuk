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
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Delegates
    weak var delegate: (EpisodeListViewControllerProtocol)?
    // NOTE: 'weak' variable should have optional type
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        btnClose.contentHorizontalAlignment = .right
    }

    // MARK: - Methods
    @IBAction func btnCloseClicked(_ sender: Any) {
        delegate?.btnCloseEpisodeCharactersViewClicked()
        self.dismiss(animated: true)
    }
}

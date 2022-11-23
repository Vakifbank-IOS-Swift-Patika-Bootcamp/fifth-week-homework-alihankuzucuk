//
//  ShowEpisodeCharactersViewController.swift
//  BreakingBad
//
//  Created by Alihan KUZUCUK on 23.11.2022.
//

import UIKit

final class ShowEpisodeCharactersViewController: BaseViewController {
    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnClose.contentHorizontalAlignment = .right
    }

    @IBAction func btnCloseClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

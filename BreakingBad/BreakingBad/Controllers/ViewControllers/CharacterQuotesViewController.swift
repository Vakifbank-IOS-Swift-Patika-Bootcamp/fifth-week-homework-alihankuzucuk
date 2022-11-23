//
//  CharacterQuotesViewController.swift
//  BreakingBad
//
//  Created by Alihan KUZUCUK on 23.11.2022.
//

import UIKit

final class CharacterQuotesViewController: BaseViewController {

    // MARK: - Variables
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    private var quotes: [CharacterQuotesModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    var character: String?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        Client.getCharacterQuotes(of: character ?? "") { [weak self] quotes, error in
            guard let self = self else { return }
            self.indicator.stopAnimating()
            self.quotes = quotes
        }
    }

}

// MARK: - Extension: TableView
extension CharacterQuotesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let quotes = quotes else { return 0 }
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = quotes?[indexPath.row].quote
        cell.contentConfiguration = content
        return cell
    }
    
}

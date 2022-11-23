//
//  CharactersCollectionViewController.swift
//  BreakingBad
//
//  Created by Alihan KUZUCUK on 22.11.2022.
//

import UIKit

final class CharactersCollectionViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var collectionViewCharacters: UICollectionView!
    
    // MARK: - Variables
    private var characters: [CharacterModel]? {
        didSet {
            collectionViewCharacters.reloadData()
        }
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewCharacters.delegate = self
        collectionViewCharacters.dataSource = self
        
        indicator.startAnimating()
        Client.getAllCharacters { [weak self] characters, error in
            guard let self = self else { return }
            self.indicator.stopAnimating()
            self.characters = characters
        }
    }

}

extension CharactersCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewCharacters.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
        cell.configure(characterName: characters?[indexPath.row].characterName ?? "")
        return cell
    }
    
}

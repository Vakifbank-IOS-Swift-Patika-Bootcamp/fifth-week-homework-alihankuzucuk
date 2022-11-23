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
    
    private var selectedCharacterName: String?

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToCharacterDetail" {
            guard let vcCharacterDetail = segue.destination as? CharacterDetailViewController else { return }
            vcCharacterDetail.detailedCharacterName = selectedCharacterName
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCharacterName = characters?[indexPath.row].characterName
        performSegue(withIdentifier: "segueToCharacterDetail", sender: nil)
    }
    
}

//
//  CharacterCollectionViewCell.swift
//  BreakingBad
//
//  Created by Alihan KUZUCUK on 23.11.2022.
//

import UIKit

final class CharacterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var lblCharacterName: UILabel!
    @IBOutlet private weak var lblCharacterBirthday: UILabel!
    @IBOutlet private weak var lblCharacterNickname: UILabel!
    @IBOutlet private weak var viewCharacterCollectionBackground: UIView!
    
    func configure(characterName: String) {
        
        Client.getCharacterDetail(of: characterName) { [weak self] characterDetail, error in
            guard let self = self,
                  let characterDetail = characterDetail
            else {
                return
            }
            
            self.lblCharacterName.text = "Name:\n" + (characterDetail.first?.characterName ?? "")
            self.lblCharacterBirthday.text = "Birthday:\n" + (characterDetail.first?.characterBirthday ?? "")
            self.lblCharacterNickname.text = "Nickname:\n" + (characterDetail.first?.characterNickname ?? "")
        }
        randomBackgroundColor()
        
    }
    
    private func randomBackgroundColor() {
        viewCharacterCollectionBackground.backgroundColor = .random()
    }
    
}

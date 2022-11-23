//
//  CharacterTableViewCell.swift
//  BreakingBad
//
//  Created by Alihan KUZUCUK on 23.11.2022.
//

import UIKit
import SDWebImage

final class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var imgVCharacter: UIImageView!
    @IBOutlet private weak var lblCharacterName: UILabel!
    @IBOutlet private weak var lblCharacterBirthday: UILabel!
    @IBOutlet private weak var lblCharacterOccupation: UILabel!
    @IBOutlet private weak var lblCharacterStatus: UILabel!
    @IBOutlet private weak var lblCharacterNickname: UILabel!
    @IBOutlet private weak var lblCharacterPortrayed: UILabel!
    
    func configureCell(characterName: String) {
        
        Client.getCharacterDetail(of: characterName) { [weak self] characterDetail, error in
            guard let self = self,
                  let characterDetail = characterDetail else { return }
            
            self.imgVCharacter.sd_setImage(with: URL(string: characterDetail.first?.characterImage ?? ""))
            self.lblCharacterName.text = "Name:\n" + (characterDetail.first?.characterName ?? "")
            self.lblCharacterBirthday.text = "Birthday:\n" + (characterDetail.first?.characterBirthday ?? "")
            self.lblCharacterOccupation.text = "Occupation:\n" + (characterDetail.first?.characterOccupation.first ?? "")
            self.lblCharacterStatus.text = "Status:\n" + (characterDetail.first?.characterStatus ?? "")
            self.lblCharacterNickname.text = "Nickname:\n" + (characterDetail.first?.characterNickname ?? "")
            self.lblCharacterPortrayed.text = "Portrayed:\n" + (characterDetail.first?.characterPortrayed ?? "")
        }
        
    }
    
}

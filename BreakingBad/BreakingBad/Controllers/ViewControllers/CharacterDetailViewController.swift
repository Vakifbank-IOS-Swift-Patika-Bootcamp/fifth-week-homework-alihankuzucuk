//
//  CharacterDetailViewController.swift
//  BreakingBad
//
//  Created by Alihan KUZUCUK on 23.11.2022.
//

import UIKit
import SDWebImage

final class CharacterDetailViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var imgVCharacter: UIImageView!
    @IBOutlet private weak var lblCharacterName: UILabel!
    @IBOutlet private weak var lblCharacterBirthdate: UILabel!
    @IBOutlet private weak var lblCharacterOccupation: UILabel!
    @IBOutlet private weak var lblCharacterStatus: UILabel!
    @IBOutlet private weak var lblCharacterNickname: UILabel!
    @IBOutlet private weak var lblCharacterPortrayed: UILabel!
    
    // MARK: - Variables
    var detailedCharacterName: String?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        Client.getCharacterDetail(of: detailedCharacterName ?? "") { [weak self] characterDetail, error in
            guard let self = self,
                  let characterDetail = characterDetail
            else {
                return
            }
            self.imgVCharacter.sd_setImage(with: URL(string: characterDetail.first?.characterImage ?? ""))
            self.lblCharacterName.text = (characterDetail.first?.characterName ?? "")
            self.lblCharacterBirthdate.text = "Birthdate: " + (characterDetail.first?.characterBirthday ?? "")
            self.lblCharacterOccupation.text = "Occupation: " + (characterDetail.first?.characterOccupation.first ?? "")
            self.lblCharacterStatus.text = "Status: " + (characterDetail.first?.characterStatus ?? "")
            self.lblCharacterNickname.text = "Nickname: " + (characterDetail.first?.characterNickname ?? "")
            self.lblCharacterPortrayed.text = "Portrayed: " + (characterDetail.first?.characterPortrayed ?? "")
        }
    }

}

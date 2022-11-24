//
//  EpisodeCharactersPopUpView.swift
//  BreakingBad
//
//  Created by Alihan KUZUCUK on 24.11.2022.
//

import UIKit

class EpisodeCharactersPopUpView: UIView {
    
    // File's Owner & Custom Class given in XIB

    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblCharacterNames: UILabel!
    @IBOutlet weak var viewPopUpBackground: UIView!
    
    weak var delegate: (EpisodeListViewControllerProtocol)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
    }
    
    convenience init(frame: CGRect, characterNames: [String]?) {
        self.init(frame: frame)
        lblCharacterNames.text = ""
        if let characterNames = characterNames {
            characterNames.forEach({ characterName in
                lblCharacterNames.text! += (characterName) + "\n"
            })
        }
    }
    
    func setupXib(frame: CGRect) {
        let view = loadXib()
        view.frame = frame
        btnClose.backgroundColor = .random()
        btnClose.layer.cornerRadius = 15
        backgroundColor = UIColor(red: 0.300706, green: 0.983725, blue: 0.559038, alpha: 0.3)
        viewPopUpBackground.backgroundColor = UIColor(red: 0.300706, green: 0.983725, blue: 0.559038, alpha: 1)
        addSubview(view)
    }
    
    func loadXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "EpisodeCharactersPopUpView", bundle: bundle)
        
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        
        return view!
    }
    
    @IBAction func btnCloseClicked(_ sender: Any) {
        delegate?.btnCloseEpisodeCharactersClicked()
        self.removeFromSuperview()
    }
}

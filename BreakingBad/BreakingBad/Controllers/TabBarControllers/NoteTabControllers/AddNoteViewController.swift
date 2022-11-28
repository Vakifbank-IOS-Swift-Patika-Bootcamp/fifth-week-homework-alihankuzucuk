//
//  AddNoteViewController.swift
//  BreakingBad
//
//  Created by Alihan KUZUCUK on 28.11.2022.
//

import UIKit

final class AddNoteViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var pickerViewSeasons: UIPickerView!
    @IBOutlet private weak var pickerViewEpisodes: UIPickerView!
    @IBOutlet private weak var txtNote: UITextField!
    @IBOutlet private weak var btnSaveNote: UIButton!
    
    // MARK: - Variables
    private var episodes: [EpisodeModel]? {
        didSet {
            pickerViewSeasons.dataSource = self
            pickerViewSeasons.delegate = self
            pickerViewEpisodes.dataSource = self
            pickerViewEpisodes.delegate = self
        }
    }
    
    private var selectedPickerViewSeason: Int = 0
    private var selectedPickerViewEpisode: Int = 0
    
    var editNote : (Bool, Note?) = (false, nil)

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Client.getAllEpisodes { [weak self] episodes, error in
            guard let self = self else { return }
            self.episodes = episodes
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if editNote.0 == true {
            Client.getEpisodeBy(id: Int(editNote.1?.episodeId ?? 0)) { [weak self] episode, error in
                guard let self = self else { return }
                
                let selectSeasonIndex = (Int(episode?.first?.episodeSeason ?? "") ?? 0) - 1
                let selectEpisodeIndex = (Int(episode?.first?.episodeInSeason ?? "") ?? 0) - 1
                
                self.pickerViewSeasons.selectRow(selectSeasonIndex, inComponent: 0, animated: true)
                self.selectedPickerViewSeason = selectSeasonIndex + 1
                self.pickerViewEpisodes.reloadAllComponents()
                
                self.pickerViewEpisodes.selectRow(selectEpisodeIndex, inComponent: 0, animated: true)
                self.selectedPickerViewEpisode = selectEpisodeIndex + 1
                
                self.txtNote.text = String(self.editNote.1?.note ?? "")
            }
            btnSaveNote.setTitle("Edit Note", for: .normal)
        } else {
            btnSaveNote.setTitle("Save Note", for: .normal)
        }
    }
    
    // MARK: - Actions
    @IBAction func btnSaveNoteClicked(_ sender: Any) {
        if selectedPickerViewSeason > 0,
           selectedPickerViewEpisode > 0,
           let note = txtNote.text {
            let episodeId = EpisodeModelUtility.getEpisodeOf(list: episodes, in: selectedPickerViewSeason, which: selectedPickerViewEpisode)?.episodeId ?? 0
            
            if editNote.0 == false {
                CoreDataManager.shared.saveNote(noteText: note, episode: episodeId)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadNoteList"), object: nil)
                self.dismiss(animated: true)
            } else {
                guard case editNote.1 = editNote.1 else { return }
                CoreDataManager.shared.updateNoteBy(id: (editNote.1?.noteId)!, newEpisodeId: episodeId, newNote: note)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadNoteList"), object: nil)
                self.dismiss(animated: true)
            }
        }
        else {
            showAlertView(title: "Error", message: "Please first select season & episode") {
                
            }
        }
    }
}

// MARK: - Extension: PickerView
extension AddNoteViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerViewSeasons {
            return EpisodeModelUtility.getSeasonsCount(of: self.episodes)
        } else if pickerView == pickerViewEpisodes {
            return EpisodeModelUtility.getEpisodesInSeason(of: self.episodes, which: pickerViewSeasons.selectedRow(inComponent: 0) + 1)
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerViewSeasons {
            return "Season \(row + 1)"
        } else if pickerView == pickerViewEpisodes {
            let episodeTitle = String(EpisodeModelUtility.getEpisodeOf(list: episodes, in: selectedPickerViewSeason, which: row + 1)?.episodeTitle ?? "Please first select season")
            return "\(row + 1) : \(episodeTitle)"
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerViewSeasons {
            selectedPickerViewSeason = row + 1
            pickerViewEpisodes.reloadAllComponents()
        } else if pickerView == pickerViewEpisodes {
            selectedPickerViewEpisode = row + 1
        }
    }
}

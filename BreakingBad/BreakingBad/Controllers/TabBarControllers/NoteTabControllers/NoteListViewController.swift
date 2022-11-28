//
//  NoteListViewController.swift
//  BreakingBad
//
//  Created by Alihan KUZUCUK on 28.11.2022.
//

import UIKit

final class NoteListViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Variables
    private var noteList: [Note]? {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: "NoteTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteTableViewCell")
            tableView.estimatedRowHeight = UITableView.automaticDimension
        }
    }
    
    // MARK: - Floating Button
    private let floatingButton: UIButton = {
        let button = UIButton(
            frame: CGRect(x: 0,
                          y: 0,
                          width: 60,
                          height: 60))
        button.backgroundColor = .green
        
        let floatingButtonImage = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(floatingButtonImage, for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        
        // button.layer.masksToBounds = true // If you active this line, button will clip shadow
        button.layer.cornerRadius = 60 / 2
        
        return button
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        
        self.noteList = CoreDataManager.shared.getNotes()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x: view.frame.size.width - 60 - 30,
                                      y: view.frame.size.height - 60 - 100,
                                      width: 60,
                                      height: 60)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadNewNote), name: NSNotification.Name(rawValue: "reloadNoteList"), object: nil)
    }
    
    // MARK: - Methods
    private func configureViews() {
        view.addSubview(floatingButton)
        floatingButton.addTarget(self, action: #selector(didFloatingButtonClicked), for: .touchUpInside)
    }
    
    @objc private func didFloatingButtonClicked() {
        guard let addNoteViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: AddNoteViewController.self)) as? AddNoteViewController else { return }
        // It needs to give StoryboardId to the AddNoteViewController
        addNoteViewController.modalPresentationStyle = .pageSheet
        present(addNoteViewController, animated: true)
    }
    
    @objc private func reloadNewNote() {
        self.noteList = CoreDataManager.shared.getNotes()
        tableView.reloadData()
    }

}

// MARK: - Extension: TableView
extension NoteListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noteList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as? NoteTableViewCell,
              let noteText = noteList?[indexPath.row].note,
              let episodeId = noteList?[indexPath.row].episodeId
        else {
            return UITableViewCell()
        }
        cell.configureCell(note: noteText, episodeId: Int(episodeId))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let tableViewActionDeleteNote = UITableViewRowAction(style: .destructive, title: "Delete Note") { [weak self] _, indexPath in
            guard let self = self else { return }
            CoreDataManager.shared.deleteNoteBy(id: (self.noteList?[indexPath.row].noteId)!)
            self.noteList?.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        tableViewActionDeleteNote.backgroundColor = .red
        
        return [tableViewActionDeleteNote]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let editNoteViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(
                    withIdentifier: String(describing: AddNoteViewController.self)) as? AddNoteViewController
        else { return }
        // It needs to give StoryboardId to the AddNoteViewController
        editNoteViewController.editNote = (true, self.noteList?[indexPath.row])
        editNoteViewController.modalPresentationStyle = .pageSheet
        present(editNoteViewController, animated: true)
    }
}

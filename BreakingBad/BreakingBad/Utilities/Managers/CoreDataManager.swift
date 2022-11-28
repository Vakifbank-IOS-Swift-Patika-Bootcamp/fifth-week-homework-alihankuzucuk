//
//  CoreDataManager.swift
//  BreakingBad
//
//  Created by Alihan KUZUCUK on 28.11.2022.
//

import UIKit
import CoreData

enum BreakingBadCoreDataKeys: String {
    case noteId
    case note
    case episodeId
}

final class CoreDataManager {
    static let shared = CoreDataManager()
    private let managedContext: NSManagedObjectContext!
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    @discardableResult
    func saveNote(noteText: String, episode episodeId: Int) -> Note? {
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        note.setValue(UUID(), forKey: BreakingBadCoreDataKeys.noteId.rawValue)
        note.setValue(noteText, forKeyPath: BreakingBadCoreDataKeys.note.rawValue)
        note.setValue(episodeId, forKey: BreakingBadCoreDataKeys.episodeId.rawValue)
        
        do {
            try managedContext.save()
            return note as? Note
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    func getNotes() -> [Note] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
        do {
            let notes = try managedContext.fetch(fetchRequest)
            return notes as! [Note]
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return []
    }
    
    func deleteNoteBy(id noteId: UUID) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "noteId = %@", noteId.uuidString)
        
        fetchRequest.returnsObjectsAsFaults = false // It provides speed when reading large data
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                managedContext.delete(result)

                do  {
                    try managedContext.save()
                } catch {
                    print("Could not save. \(error)")
                }
                break
            }
        } catch {
            print("Could not delete. \(error)")
        }
    }
    
    func getNoteBy(id noteId: UUID) -> Note? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "noteId = %@", noteId.uuidString)
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                return result as? Note
            }
        } catch {
            print("Could not delete. \(error)")
        }
        
        return nil
    }
    
    func updateNoteBy(id noteId: UUID, newEpisodeId: Int, newNote: String) {
        var note = getNoteBy(id: noteId)
        guard let note = note else { return }
        note.episodeId = Int32(newEpisodeId)
        note.note = String(newNote)
        
        do {
            try managedContext.save()
        }
        catch {
            print("Could not update. \(error)")
        }
    }
}

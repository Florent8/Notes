//
//  Notes.swift
//  Notes
//
//  Created by  on 12/12/2017.
//  Copyright © 2017 amacabr2. All rights reserved.
//

import Foundation
import MapKit

class Notes: NSObject, NSCoding {
    
    private var notes: [Note]
    
    struct Keys {
        static let notes = "notes"
    }
    
    init(_ notes: [Note]) {
        self.notes = notes
    }
    
    override init() {
        notes = [
            Note(title: "note1", content: "note1", createdAt: Date(), location: CLLocationCoordinate2D(latitude: 47.617274, longitude: 6.910793)),
            Note(title: "note2", content: "note2", createdAt: Date(), location: CLLocationCoordinate2D(latitude: 47.718488, longitude: 6.7997704))
        ]
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(aDecoder.decodeObject(forKey: Keys.notes) as! [Note])
    }
    
    func getNote(_ index: Int) -> Note {
        return notes[index]
    }
    
    func getNotes() -> [Note] {
        return notes
    }
    
    func addNote(_ note: Note) {
        addNote(note, at: size())
    }
    
    func addNote(_ note: Note, at index: Int) {
        notes.insert(note, at: index)
    }
    
    func deleteNote(_ index: Int) -> Note {
        return notes.remove(at: index)
    }
    
    func updateNote(_ note: Note, at index: Int) {
        notes[index] = note
    }
    
    func size() -> Int {
        return notes.count
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(notes, forKey: Keys.notes)
    }
}

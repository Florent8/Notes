//
//  Note.swift
//  Notes
//
//  Created by  on 28/11/2017.
//  Copyright © 2017 amacabr2. All rights reserved.
//

import Foundation
import MapKit

class Note {
    
    private let title: String
    private let content: String
    private let createdAt: Date
    private var updatedAt: Date?
    private var location: CLLocationCoordinate2D
    
    init(title: String, content: String, createdAt: Date, updatedAt: Date?, location: CLLocationCoordinate2D) {
        self.title = title
        self.content = content
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.location = location
    }
    
    convenience init(title: String, content: String, createdAt: Date, location: CLLocationCoordinate2D) {
        self.init(title: title, content: content, createdAt: createdAt, updatedAt: nil, location: location)
    }
    
    private func dateToString(date: Date) -> String {
        let formater = DateFormatter()
        formater.dateFormat = "dd/MM/yyyy HH:mm:ss"
        return formater.string(from: date)
    }
    
    func getTitle() -> String {
        return title
    }
    
    func getContent() -> String {
        return content
    }
    
    func getCreatedAt() -> Date {
        return createdAt
    }
    
    func getLocation() -> CLLocationCoordinate2D {
        return location
    }
    
    func getCreatedAtToString() -> String {
        return dateToString(date: createdAt)
    }
    
    func getUpdatedAtToString() -> String? {
        if let updatedAt = updatedAt {
            return dateToString(date: updatedAt)
        }
        return nil
    }
}

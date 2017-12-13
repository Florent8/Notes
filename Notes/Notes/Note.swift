//
//  Note.swift
//  Notes
//
//  Created by  on 28/11/2017.
//  Copyright © 2017 amacabr2. All rights reserved.
//

import Foundation
import MapKit

class Note: NSObject, NSCoding {
    
    private let title: String
    private let content: String
    private let createdAt: Date
    private var updatedAt: Date?
    private var location: CLLocationCoordinate2D
    
    struct Keys {
        static let title = "title"
        static let content = "content"
        static let createdAt = "createdAt"
        static let updatedAt = "updatedAt"
        static let latitude = "latitude"
        static let longitude = "longitude"
    }
    
    init(title: String, content: String, createdAt: Date, updatedAt: Date?, location: CLLocationCoordinate2D) {
        self.title = title
        self.content = content
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.location = location
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(
            title: aDecoder.decodeObject(forKey: Keys.title) as! String,
            content: aDecoder.decodeObject(forKey: Keys.content) as! String,
            createdAt: aDecoder.decodeObject(forKey: Keys.createdAt) as! Date,
            updatedAt: aDecoder.decodeObject(forKey: Keys.updatedAt) as? Date,
            location: CLLocationCoordinate2D(
                latitude: aDecoder.decodeDouble(forKey: Keys.latitude),
                longitude: aDecoder.decodeDouble(forKey: Keys.longitude)
            )
        )
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: Keys.title)
        aCoder.encode(content, forKey: Keys.content)
        aCoder.encode(createdAt, forKey: Keys.createdAt)
        aCoder.encode(updatedAt, forKey: Keys.updatedAt)
        aCoder.encode(location.latitude, forKey: Keys.latitude)
        aCoder.encode(location.longitude, forKey: Keys.longitude)
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

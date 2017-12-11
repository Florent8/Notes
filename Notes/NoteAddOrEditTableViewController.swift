//
//  NoteAddOrEditTableViewController.swift
//  Notes
//
//  Created by  on 28/11/2017.
//  Copyright © 2017 amacabr2. All rights reserved.
//

import UIKit
import MapKit

class NoteAddOrEditTableViewController: UITableViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    private var note: Note?
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var noteTextField: UITextField!
    @IBOutlet private weak var saveButton: UIBarButtonItem!
    @IBOutlet private weak var mapView: MKMapView!
    private let locationManager = CLLocationManager()
    
    func setNote(note: Note) {
        self.note = note
    }
    
    func getNote() -> Note? {
        return note
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if let note = note {
            titleTextField.text = note.getTitle()
            noteTextField.text = note.getContent()
            centerMapInLocation(note.getLocation())
            setSaveButtonEnabled()
        } else {
            centerMapInLocation(CLLocationCoordinate2D())
        }
    
        noteTextField.borderStyle = UITextBorderStyle.roundedRect
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    private func setSaveButtonEnabled() {
        saveButton.isEnabled = titleTextField.text != "" && noteTextField.text != ""
    }
    
    private func centerMapInLocation(_ location: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        mapView.setRegion(MKCoordinateRegion(center: location, span: MKCoordinateSpanMake(0.5, 0.5)), animated: true)
    }
    
    @IBAction func titleDidChanged(_ sender: UITextField) {
        setSaveButtonEnabled()
    }
    
    @IBAction func noteDidChanged(_ sender: UITextField) {
        setSaveButtonEnabled()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last?.coordinate {
            centerMapInLocation(lastLocation)
        }
        locationManager.stopUpdatingLocation()
    }
    
    @IBAction func updateLocation(_ sender: UIButton) {
        print(CLLocationManager.authorizationStatus())
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.notDetermined {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "save" {
            var createdAt = Date()
            var updatedAt: Date? = nil
            if let note = note {
                createdAt = note.getCreatedAt()
                updatedAt = Date()
            }
            note = Note(title: titleTextField.text!, content: noteTextField.text!, createdAt: createdAt, updatedAt: updatedAt, location: CLLocationCoordinate2D())
        }
    }
}

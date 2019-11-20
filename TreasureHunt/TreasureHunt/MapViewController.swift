//
//  MapViewController.swift
//  TreasureHunt
//
//  Created by Kobe McKee on 11/20/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    let apiController = APIController()
    var currentRoom: Room? {
        didSet {
            DispatchQueue.main.async {
                self.roomIdLabel.text = "Room \(self.currentRoom!.id)"
                self.coordinatesLabel.text = self.currentRoom!.coordinates
                self.descriptionLabel.text = self.currentRoom!.description
                self.messagesTextView.text += "\n \(String(describing: self.currentRoom!.messages))"
            }
        }
    }
    
    
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var roomIdLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var coordinatesLabel: UILabel!
    @IBOutlet weak var messagesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    
    
    

    @IBAction func initializePlayer(_ sender: Any) {
        apiController.initPlayer { (room, error) in
            if let error = error {
                print(error)
            }
            
            if let room = room {
                print(room)
                self.currentRoom = room
            }
        }
    }
    
    @IBAction func take(_ sender: Any) {
    }
    
    
    
    @IBAction func drop(_ sender: Any) {
    }
    
    
    @IBAction func sell(_ sender: Any) {
    }
    
    @IBAction func getStatus(_ sender: Any) {
        apiController.getStatus { (status, error) in
            if let error = error {
                print(error)
            }
            
            if let status = status {
                print(status)
                DispatchQueue.main.async {
                    self.messagesTextView.text += "\n \(String(describing: status.messages))"
                }
            }
        }
    }
    
    
    @IBAction func examine(_ sender: Any) {
    }
    
    
    @IBAction func wear(_ sender: Any) {
    }
    
    @IBAction func undress(_ sender: Any) {
    }
    

    
    @IBAction func moveNorth(_ sender: Any) {
        apiController.move(direction: "n") { (room, error) in
            if let error = error {
                print(error)
            }
            
            if let room = room {
                print(room)
                self.currentRoom = room
            }
        }
    }
    
    
    @IBAction func moveEast(_ sender: Any) {
        apiController.move(direction: "n") { (room, error) in
            if let error = error {
                print(error)
            }
            
            if let room = room {
                print(room)
                self.currentRoom = room
            }
        }
    }
    
    
    @IBAction func moveSouth(_ sender: Any) {
        apiController.move(direction: "n") { (room, error) in
            if let error = error {
                print(error)
            }
            
            if let room = room {
                print(room)
                self.currentRoom = room
            }
        }
    }
    
    @IBAction func moveWest(_ sender: Any) {
        apiController.move(direction: "n") { (room, error) in
            if let error = error {
                print(error)
            }
            
            if let room = room {
                print(room)
                self.currentRoom = room
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

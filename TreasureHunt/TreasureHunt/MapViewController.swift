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
    var currentRoom: Room?
    
    
    @IBOutlet weak var moveNorthButton: UIButton!
    @IBOutlet weak var moveEastButton: UIButton!
    @IBOutlet weak var moveSouthButton: UIButton!
    @IBOutlet weak var moveWestButton: UIButton!
    
    
    
    @IBOutlet weak var roomTitleLabel: UILabel!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var roomIdLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var coordinatesLabel: UILabel!
    @IBOutlet weak var messagesTextView: UITextView!
    @IBOutlet weak var exitsLabel: UILabel!
    
    @IBOutlet weak var smartMoveSwitch: UISwitch!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        apiController.initPlayer { (room, error) in
            if let error = error {
                print(error)
            }
            
            if let room = room {
                print(room)
                self.currentRoom = room
                DispatchQueue.main.async {
                    self.updateRoom()
                }
            }
        }
        
        apiController.changeName(newName: "Kobe")
        
    }
    
    func updateRoom() {
        if let id = currentRoom?.id,
            let coordinates = currentRoom?.coordinates,
            let description = currentRoom?.description,
            let exits = currentRoom?.exits {
            
            roomIdLabel.text = "Room \(id)"
            coordinatesLabel.text = coordinates
            descriptionLabel.text = description
            exitsLabel.text = exits.joined(separator: ", ").uppercased()
            
            if let title = currentRoom?.title {
                roomTitleLabel.text = title
            }
            
            
            if !exits.contains("n") {
                moveNorthButton.isEnabled = false
            } else {
                moveNorthButton.isEnabled = true
            }
            if !exits.contains("e") {
                moveEastButton.isEnabled = false
            } else {
                moveEastButton.isEnabled = true
            }
            if !exits.contains("s") {
                moveSouthButton.isEnabled = false
            } else {
                moveSouthButton.isEnabled = true
            }
            if !exits.contains("w") {
                moveWestButton.isEnabled = false
            } else {
                moveWestButton.isEnabled = true
            }
            
        }

        if let messages = currentRoom!.messages {
            if messages != [] {
                messagesTextView.text += "\n \(messages))"
            }
        }

        if let errors = currentRoom!.errors {
            if errors != [] {
                let alert = UIAlertController(title: "Errors", message: errors.joined(separator: "\n"), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                self.present(alert, animated: true)
            }
        }
        
        if let items = currentRoom!.items {
            if items != [] {
                let alert = UIAlertController(title: "Items Found", message: items.joined(separator: "\n"), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }
        }
        
    
        
    }

    @IBAction func pray(_ sender: Any) {
        
        apiController.pray { (room, error) in
            if let error = error {
                print(error)
            }
            
            if let room = room {
                DispatchQueue.main.async {
                    self.currentRoom = room
                    self.updateRoom()
                }
            }
        }
        
    }
    
    
    


    
    @IBAction func take(_ sender: Any) {
        var itemName = ""
        let alert = UIAlertController(title: "Take an item", message: "Enter the name of the item you're taking", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        let textField = alert.textFields?[0]
        alert.addAction(UIAlertAction(title: "Take Item", style: .default, handler: { (action) in
            itemName = textField?.text ?? ""
            self.apiController.takeTreasure(nameOfTreasure: itemName) { (room, error) in
                if let error = error {
                    print(error)
                }
                
                if let room = room {
                    DispatchQueue.main.async {
                        self.currentRoom = room
                        self.updateRoom()
                    }
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    
    
    @IBAction func drop(_ sender: Any) {
        var itemName = ""
        let alert = UIAlertController(title: "Drop an item", message: "Enter the name of the item you're dropping", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        let textField = alert.textFields?[0]
        alert.addAction(UIAlertAction(title: "Drop Item", style: .default, handler: { (action) in
            itemName = textField?.text ?? ""
            self.apiController.dropTreasure(nameOfTreasure: itemName) { (room, error) in
                if let error = error {
                    print(error)
                }
                
                if let room = room {
                    DispatchQueue.main.async {
                        self.currentRoom = room
                        self.updateRoom()
                    }
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    
    @IBAction func sell(_ sender: Any) {
        
        var itemName = ""
        let alert = UIAlertController(title: "Sell an item", message: "Enter the name of the item you're selling", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        let textField = alert.textFields?[0]
        alert.addAction(UIAlertAction(title: "Sell Item", style: .default, handler: { (action) in
            itemName = textField?.text ?? ""
            self.apiController.sell(nameOfTreasure: itemName)
            self.confirmSale(itemName: itemName)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    
    
    func confirmSale(itemName: String) {
        
        let confirmAlert = UIAlertController(title: "Confirm Sale", message: "Are you sure you want to sell \(itemName)", preferredStyle: .alert)
        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        confirmAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) in
            self.apiController.confirmSale(nameOfTreasure: itemName) { (room, error) in
                if let error = error {
                    print(error)
                }
                if let room = room {
                    DispatchQueue.main.async {
                        self.currentRoom = room
                        self.updateRoom()
                    }
                }
            }
        }))
        
        self.present(confirmAlert, animated: true)
        
    }
    
    @IBAction func getStatus(_ sender: Any) {
        apiController.getStatus { (status, error) in
            if let error = error {
                print(error)
            }
            
            if let status = status {
                print(status)
                DispatchQueue.main.async {
                    if let errors = status.errors {
                        if errors != [] {
                            let alert = UIAlertController(title: "Errors", message: errors.joined(separator: "\n"), preferredStyle: .alert)
                            if let cooldown = status.cooldown {
                                alert.message?.append(contentsOf: "\n Cooldown: \(cooldown)")
                            }
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            
                            self.present(alert, animated: true)
                        }
                    }
                    
                    if let messages = status.messages {
                        if messages != [] {
                            self.messagesTextView.text += "\n \(String(describing: status.messages))"
                        }
                    }
                    
                    
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
    

    // MARK: - Movement
    
    @IBAction func moveNorth(_ sender: Any) {
        if smartMoveSwitch.isOn {
            var roomId: String = ""
            let alert = UIAlertController(title: "Smart Move", message: "What is the next room's ID?", preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            let textField = alert.textFields?[0]
            textField?.keyboardType = .numberPad
            alert.addAction(UIAlertAction(title: "Move North", style: .default, handler: { (action) in
                roomId = textField?.text ?? ""
                self.apiController.smartMove(direction: "n", nextRoomId: roomId) { (room, error) in
                    if let error = error {
                        print(error)
                    }
                    if let room = room {
                        DispatchQueue.main.async {
                            self.currentRoom = room
                            self.updateRoom()
                        }
                    }
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        } else {
            
            apiController.move(direction: "n") { (room, error) in
                if let error = error {
                    print(error)
                }
                
                if let room = room {
                    print(room)
                    self.currentRoom = room
                    DispatchQueue.main.sync {
                        self.updateRoom()
                    }
                }
            }
            
        }
        
    }
    
    
    @IBAction func moveEast(_ sender: Any) {
        if smartMoveSwitch.isOn {
            var roomId: String = ""
            let alert = UIAlertController(title: "Smart Move", message: "What is the next room's ID?", preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            let textField = alert.textFields?[0]
            textField?.keyboardType = .numberPad
            alert.addAction(UIAlertAction(title: "Move East", style: .default, handler: { (action) in
                roomId = textField?.text ?? ""
                self.apiController.smartMove(direction: "e", nextRoomId: roomId) { (room, error) in
                    if let error = error {
                        print(error)
                    }
                    if let room = room {
                        DispatchQueue.main.async {
                            self.currentRoom = room
                            self.updateRoom()
                        }
                    }
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        } else {
            
            apiController.move(direction: "e") { (room, error) in
                if let error = error {
                    print(error)
                }
                
                if let room = room {
                    print(room)
                    self.currentRoom = room
                    DispatchQueue.main.sync {
                        self.updateRoom()
                    }
                }
            }
        }
    }
    
    
    @IBAction func moveSouth(_ sender: Any) {
        if smartMoveSwitch.isOn {
            var roomId: String = ""
            let alert = UIAlertController(title: "Smart Move", message: "What is the next room's ID?", preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            let textField = alert.textFields?[0]
            textField?.keyboardType = .numberPad
            alert.addAction(UIAlertAction(title: "Move South", style: .default, handler: { (action) in
                roomId = textField?.text ?? ""
                self.apiController.smartMove(direction: "s", nextRoomId: roomId) { (room, error) in
                    if let error = error {
                        print(error)
                    }
                    if let room = room {
                        DispatchQueue.main.async {
                            self.currentRoom = room
                            self.updateRoom()
                        }
                    }
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        } else {
            
            apiController.move(direction: "s") { (room, error) in
                if let error = error {
                    print(error)
                }
                
                if let room = room {
                    print(room)
                    self.currentRoom = room
                    DispatchQueue.main.sync {
                        self.updateRoom()
                    }
                }
            }
        }
    }
    
    @IBAction func moveWest(_ sender: Any) {
        if smartMoveSwitch.isOn {
            var roomId: String = ""
            let alert = UIAlertController(title: "Smart Move", message: "What is the next room's ID?", preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            let textField = alert.textFields?[0]
            textField?.keyboardType = .numberPad
            alert.addAction(UIAlertAction(title: "Move West", style: .default, handler: { (action) in
                roomId = textField?.text ?? ""
                self.apiController.smartMove(direction: "w", nextRoomId: roomId) { (room, error) in
                    if let error = error {
                        print(error)
                    }
                    if let room = room {
                        DispatchQueue.main.async {
                            self.currentRoom = room
                            self.updateRoom()
                        }
                    }
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        } else {
            apiController.move(direction: "w") { (room, error) in
                if let error = error {
                    print(error)
                }
                
                if let room = room {
                    print(room)
                    self.currentRoom = room
                    DispatchQueue.main.sync {
                        self.updateRoom()
                    }
                }
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

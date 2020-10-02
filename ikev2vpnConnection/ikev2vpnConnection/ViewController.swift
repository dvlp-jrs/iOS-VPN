//
//  ViewController.swift
//  ikev2vpnConnection
//
//  Created by jrs on 21/05/19.
//  Copyright © 2019 jyoti ranjan swain. All rights reserved.
//

import UIKit
import NetworkExtension

var ip : String = ""
var pass : String = ""
var certi : String = ""
var connectOnDemand : Bool = false
var user : String = ""

class ViewController: UIViewController {
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var connectOn: UISwitch!
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var text3: UITextField!
    @IBOutlet weak var text4: UITextField!
    
    
    //Assigning vpn class
     let vpnInstance = Vpn()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         vpnInstance.vpnDelegate = self
        
        if connectOn.isOn {
            connectOnDemand = true
        } else {
            connectOnDemand = false
        }
    }
    
    //Will act as connect/Disconnect
    @IBAction func connectTrig(_ sender: Any) {
        view.endEditing(true)
        vpnInstance.connectVPN()
    }
    
    //Updating connection status
    var status: Status? {
        didSet {
            connectButton.setTitle(status?.description, for: .normal)
//            statusLabel.text = status?.description
//            if status == Status.connecting {
//                statusLabel.text = "Connecting"
//            } else if status == Status.disconnecting {
//                statusLabel.text = "Disconnecting"
//            } else if status == Status.connected {
//                statusLabel.text = "Connected"
//            } else if status == Status.disconnected {
//                statusLabel.text = "Disconnected"
//            } else if status == Status.errorConnecting {
//                statusLabel.text = "Error connecting"
//            }
        }
    }
        
    @objc private func checkNEStatus(status: NEVPNStatus) {
        switch status {
        case .invalid:
        self.status = Status.errorConnecting
        case .disconnected:
        self.status = Status.disconnected
        case .connecting:
        self.status = Status.connecting
        case .connected:
        self.status = Status.connected
        case .reasserting:
        print("NEVPNConnection: Reasserting")
        case .disconnecting:
        self.status = Status.disconnecting
        default:
            print("Unexpected Error")
            }
        }
 
    @IBAction func ipAddress(_ sender: Any) {
        ip = text1.text!
    }
    
    @IBAction func username(_ sender: Any) {
        user = text2.text!
    }
    
    @IBAction func password(_ sender: Any) {
        pass = text3.text!
    }
    
    @IBAction func certificate(_ sender: Any) {
        certi = text4.text!
    }
    
    @IBAction func cod(_ sender: Any) {
      connectOnDemand = !connectOnDemand
    }
    
    
}


    
    

extension ViewController: VpnDelegate {
    func setStatus(status: Status) {
        self.status = status
    }
    func checkNES(status: NEVPNStatus){
        self.checkNEStatus(status: status)
    }
}


//
//  PopupRoomFormViewController.swift
//  chirpAttendanceAdmin
//
//  Created by Garima Bothra on 15/10/19.
//  Copyright © 2019 Garima Bothra. All rights reserved.
//

import UIKit
import Firebase
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

class PopupRoomFormViewController: UIViewController {

    @IBOutlet weak var roomName: UITextField!
    @IBOutlet weak var ClassTime: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func createRoomButtonPressed(_ sender: Any) {
        let myOptionalString = roomName.text;
        guard let myString = myOptionalString, !myString.isEmpty else {
            print("String is nil or empty.")
            return // or break, continue, throw
        }
        guard let myStr = ClassTime.text, !myStr.isEmpty else {
            print("String is nil or empty.")
            return // or break, continue, throw
        }
        print(myString)
        print(myStr)
        var post1Ref = refer.child("Admin").child(adminName).child("rooms").childByAutoId()
        
        
        var postId = post1Ref.key
        print(postId)
        let substr = postId?.prefix(5)
        
        
        
        func MD5(string: String) -> Data {
            let length = Int(CC_MD5_DIGEST_LENGTH)
            let messageData = string.data(using:.utf8)!
            var digestData = Data(count: length)
            
            _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
                messageData.withUnsafeBytes { messageBytes -> UInt8 in
                    if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                        let messageLength = CC_LONG(messageData.count)
                        CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                    }
                    return 0
                }
            }
            return digestData
        }
        
        
        let md5Data = MD5(string: String(substr!))
        let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
        print("md5Hex: \(md5Hex)")
        let hashed = md5Hex.prefix(5)
        //        let ref = Database.database().reference().child("Admin").child("rooms").child("").queryEqual(toValue: "569fe")
        //       print(ref)
        
        // refer.child("Admin").child(adminName).child("rooms").observe(.value) { (snapshot) in
        //    print("\((snapshot.value as? NSDictionary)!)")
        //
        // }
        //        ref.observeSingleEvent(of: .value, with: { snapshot in
        //            if(snapshot.exists()){
        //            print(snapshot)
        //            }
        //        })
        //        refer.child("Admin").child(adminName).child("rooms").observeSingleEvent(of: .value, with: { (snapshot) in
        //
        //        })
        post1Ref.setValue(hashed)
        print(hashed)
        
        let timestart = NSDate().timeIntervalSince1970
        print(Int(timestart))
        print(Int(myStr))
        let timeEnd = Int(timestart)+(60*Int(myStr)! ?? 0)
        print(timeEnd)
        refer.child("rooms").child(String(hashed)).child("endingUnixTime").setValue(String(timeEnd));
        refer.child("rooms").child(String(hashed)).child("startingUnixTime").setValue(String(Int(timestart)));
        refer.child("rooms").child(String(hashed)).child("roomName").setValue(myString);
        refer.child("rooms").child(String(hashed)).child("hashedKey").setValue(String(hashed));
         dismiss(animated: true, completion: nil)
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

//
//  ChatVC.swift
//  Clerkie Project
//
//  Created by Jing on 2017/11/11.
//  Copyright © 2017年 Jing. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import CoreData
import AVKit
import MobileCoreServices
import Photos

class ChatVC: JSQMessagesViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var friendImg = #imageLiteral(resourceName: "ic_account_circle")
    
    var friendId = ""
    
    var friendName = ""
    
    var userImg = UIImage()
    
    var datasource : [JSQMessage] = []
    
//    var currChat = Chat.init(entity: NSEntityDescription.entity(forEntityName: "Chat", in: AppDelegate.persistentContainer.viewContext)!, insertInto: AppDelegate.persistentContainer.viewContext)
    
    var container = AppDelegate.persistentContainer
    
    var autoReply = ["How r u?", "I'm good.", "Okay.", "Cool.", "Thank you!"]
    
    let picker = UIImagePickerController()
    
    /// Lazy computed property for painting outgoing messages blue
    lazy var outgoingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }()
    
    /// Lazy computed property for painting incoming messages gray
    lazy var incomingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        senderId = UserDefaults.standard.string(forKey: "currID")
        senderDisplayName = UserDefaults.standard.string(forKey: "currScreenName")
        getUserImage()
        getDataSource()
    }
    
    func getDataSource() {
        let context = container.viewContext
//        context.perform {
//
//        }
        if let chat = try? Chat.findOrCreateChat(matching: self.senderId, with: self.friendId, in: context) {
            //                self.currChat = chat
            try? context.save()
            if chat.message != nil && chat.message!.count > 0 {
                let messages = chat.message as! Set<Message>
                for message in messages {
                    if let newMsg = JSQMessage(senderId: message.senderId, senderDisplayName: message.name, date: message.date, text: message.text) {
                        self.datasource.append(newMsg)
                    }
                }
                self.datasource.sort(by: { (msg1, msg2) -> Bool in
                    return msg1.date.timeIntervalSince1970 < msg2.date.timeIntervalSince1970
                })
                self.finishReceivingMessage()
            }
        }
        print("datasource = \(self.datasource)")
    }

    func getUserImage() {
        if let url = UserDefaults.standard.object(forKey: "currImageUrl") as! String! {
            URLSession.shared.dataTask(with: NSURL(string: url)! as URL, completionHandler: {(data, response, error) -> Void in
                print("img url = \(url)")
                self.userImg = UIImage(data: data!)!
            }).resume()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        collectionView.estima
//        collectionView.collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.topContentAdditionalInset = 0
        print("get image = \(friendImg)")
        self.tabBarController?.tabBar.isHidden = true
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        self.collectionView.collectionViewLayout.springinessEnabled = true
//    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return datasource[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        return datasource[indexPath.item].senderId == senderId ? outgoingBubble : incomingBubble
    }
    

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        if datasource[indexPath.item].senderId == senderId {
            return JSQMessagesAvatarImageFactory.avatarImage(with: userImg, diameter: 30)
        } else {
            return JSQMessagesAvatarImageFactory.avatarImage(with: friendImg, diameter: 30)
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        return datasource[indexPath.item].senderId == senderId ? nil : NSAttributedString(string: datasource[indexPath.item].senderDisplayName)
    }
    
    // this function helps to play the video in chat window
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAt indexPath: IndexPath!)
    {
        
        let msg = datasource[indexPath.item];
        
        if msg.isMediaMessage
        {
            if let mediaItem = msg.media as? JSQVideoMediaItem  {
                
                let player = AVPlayer(url: mediaItem.fileURL);
                let playerController = AVPlayerViewController();
                playerController.player = player;
                self.present(playerController, animated: true, completion: nil)
            }
            
        }
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat
    {
        // Return the height of the bubble top label
        return datasource[indexPath.item].senderId == senderId ? 0 : 15
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let context = container.viewContext
        let newMsg = Message(context: context)
        newMsg.senderId = senderId
        newMsg.name = senderDisplayName
        newMsg.text = text
        newMsg.date = Date()
//        newMsg.chat = self.currChat
//        try? context.save()
        let rand = random()
        let newReply = Message(context: context)
        newReply.senderId = self.friendId
        newReply.name = friendName
        newReply.text = autoReply[rand]
        newReply.date = Date() + 5
        if let chat = try? Chat.findOrCreateChat(matching: self.senderId, with: self.friendId, in: context) {
            newMsg.chat = chat
            newReply.chat = chat
        }
        try? context.save()
        print("Reload data")
        print("is on Main = \(Thread.isMainThread)")
        datasource.append(JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: newMsg.date, text: text))
//        collectionView.reloadData()
        datasource.append(JSQMessage(senderId: friendId, senderDisplayName: friendName, date: newReply.date, text: newReply.text))
        collectionView.reloadData()
//        collectionView.layoutSubviews()
        finishSendingMessage()
    }
    
    private func random() -> Int {
        let range = Range(0...4)
        let cnt = UInt32(range.upperBound - range.lowerBound)
        return Int(arc4random_uniform(cnt)) + range.lowerBound
    }
    
    // FOR SENDING IMGAES MESSAGE
    
    override func didPressAccessoryButton(_ sender: UIButton!)
    {
        
        let alert = UIAlertController(title: "Media Messages", message: "Please Select A Media", preferredStyle: .actionSheet);
        
        let cancle = UIAlertAction(title: "Cancle", style: .cancel, handler: nil);
        
        let photos = UIAlertAction(title: "Photos", style: .default, handler: {(alert: UIAlertAction) in
            if PHPhotoLibrary.authorizationStatus() == .authorized {
                self.chooseMedia(type: kUTTypeImage);
            } else {
                self.showAlert("Please open access to photo library in Settings for this app!")
            }
            
            
        })
        
        
        let videos = UIAlertAction(title: "Videos", style: .default, handler: {(alert: UIAlertAction) in
            if PHPhotoLibrary.authorizationStatus() == .authorized {
                self.chooseMedia(type: kUTTypeMovie);
            } else {
                self.showAlert("Please open access to media library in Settings for this app!")
            }
            
        })
        
        alert.addAction(photos);
        alert.addAction(videos);
        alert.addAction(cancle);
        present(alert, animated: true, completion: nil);
        
    }
    
    //END SENDING BUTTON FUNCTIONS
    
    
    // PICKER VIEW FUNCTION
    
    
    private func chooseMedia(type: CFString)
    {
        picker.delegate = self
        picker.mediaTypes = [type as String]   // helps to undestand which type of media file is
        
        present(picker, animated: true, completion: nil);
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        
        if let pic = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            let img = JSQPhotoMediaItem(image: pic);
            datasource.append(JSQMessage(senderId:senderId, displayName: senderDisplayName, media: img));
            
        }
            
        else if let vidurl = info[UIImagePickerControllerMediaURL] as? URL
        {
            let video = JSQVideoMediaItem(fileURL: vidurl, isReadyToPlay: true);
            datasource.append(JSQMessage(senderId:senderId, displayName: senderDisplayName, media: video));
        }
        
        self.dismiss(animated:  true, completion: nil);
        collectionView.reloadData();
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title:"", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

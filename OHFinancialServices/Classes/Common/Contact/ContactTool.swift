//
//  ContactTool.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/5/21.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit
import ContactsUI
class ContactTool: NSObject {
    var currentViewController : UIViewController?
    private lazy var contUI : CNContactPickerViewController = {
        let contUI = CNContactPickerViewController()
        contUI.delegate = self
        return contUI
    }()
    
    private lazy var contactArray : [[String : Any]] = Array()
    private lazy var contactDict : [String : Any] = Dictionary()
    
}

extension ContactTool {
    /// 获取所有通讯录信息
    func getAllContacts(finishedContacts:@escaping (_ conts : [[String:Any]]) -> ()) {
        CNContactStore().requestAccess(for: .contacts) {[weak self](isRight, error) in
            if isRight {
                self?.loadContactsData(finishedContacts: {(contacts) in
                   finishedContacts(contacts)
                })
            }
        }
    }
    
    //获取单个通讯录信息
    func getContectMessage(finishedContect:@escaping (_ name:String,_ phone:String)->()) {
        let vc = ContactViewController()
        CNContactStore().requestAccess(for: .contacts) {[weak self](isRight, error) in
            if isRight {
                self?.loadContactsData(finishedContacts: {(contacts) in
                    vc.contactArray = contacts
                })
            }
        }
        vc.getBlock{dict in
            finishedContect("\(dict["name"]!)", "\(dict["phone"]!)")
        }
        self.currentViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func loadContactsData(finishedContacts:(_ conts : [[String:Any]]) -> ()) {
        let store = CNContactStore()
        contactArray.removeAll()
        let keys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactNicknameKey,CNContactOrganizationNameKey, CNContactJobTitleKey,CNContactDepartmentNameKey, CNContactNoteKey, CNContactPhoneNumbersKey,CNContactEmailAddressesKey, CNContactPostalAddressesKey,CNContactDatesKey, CNContactInstantMessageAddressesKey]
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        do {
            try store.enumerateContacts(with: request, usingBlock: { [weak self](contact, stop) in
                self?.contactDict["name"] = "\(contact.familyName)" + "\(contact.givenName)"
                for phone in contact.phoneNumbers {
                    
                    self?.contactDict["phone"] = "\(phone.value.stringValue)"
                }
                self?.contactArray.append(self!.contactDict)
            })
            finishedContacts(contactArray)
        } catch  {
            print("error")
        }
    }
    
}

extension ContactTool:CNContactPickerDelegate,CNContactViewControllerDelegate {
    internal func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        for cont in contacts {
            contactDict["name"] = "\(cont.familyName)" + "\(cont.givenName)"
            for phone in cont.phoneNumbers {
                contactDict["phone"] = phone.value.stringValue
            }
            
        }
    }
    
    internal func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        
    }
}

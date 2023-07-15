//
//  HomeViewModel.swift
//  PrecticalTask
//
//  Created by Abhay Pansora on 15/07/23.
//

import Foundation
import UIKit

class HomeViewModel {
    
    //#MARK: - Variables
    fileprivate weak var theController:HomeVC!
    init(theController:HomeVC) {
        self.theController = theController
    }
}

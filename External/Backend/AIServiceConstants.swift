//
//  AIServiceConstants.swift
//  Swift3CodeStructure
//
//  Created by Abhay Pansora on 24/06/2023.
//  Copyright © 2023 Abhay Pansora. All rights reserved.
//

import Foundation

//MARK:- BASE URL
let URL_BASE                            = "https://fakestoreapi.com/products" //Configuration.baseURL+"/api/"
let API_TIME_OUT_INTERVAL = 15

// API


//MARK:- FULL URL
func getFullUrl(_ urlEndPoint : String) -> String {
    return URL_BASE + urlEndPoint
}



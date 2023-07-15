//
//  AIServiceManager.swift
//  Swift3CodeStucture
//
//  Created by Abhay Pansora on 11/24/16.
//  Copyright © 2016 agilepc-100. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import UIKit
import Foundation

class AIServiceManager: NSObject {
    
    static let sharedManager : AIServiceManager = {
        let instance = AIServiceManager()
        return instance
    }()
    
    // MARK: - ERROR HANDLING
    
    func handleError(_ errorToHandle : NSError, statusCode: Int){
        print(errorToHandle.code)
        if statusCode == 429 {
            displayAlertWithMessage("You exceeded your requests limit")
        }else if(errorToHandle.domain == CUSTOM_ERROR_DOMAIN)    {
            displayAlertWithMessage("Something went wrong, please try again later.")
        }else if(errorToHandle.code == -1009){
            displayAlertWithMessage("Please check your connection again, or connect to Wi-Fi")
        }else if(statusCode == 401){
            displayAlertWithTitle(APP_NAME, andMessage: "Something went wrong. Please log in again", buttons: ["Ok"], completion: { (index) in
                //appDelegate.sessionOut()
            })
        } else{
            if(errorToHandle.code == -999){
                return
            }
            if errorToHandle.localizedDescription == "URLSessionTask failed with error: Abgebrochen"{
                return
            }
            displayAlertWithMessage(errorToHandle.localizedDescription)//("errorCode: \(errorToHandle.code): \(errorToHandle.localizedDescription)")
        }
    }
    
    // MARK: - ************* COMMON API METHOD **************
    
    // GET
    func callGetApi(_ url : String , completionHandler : @escaping (AFDataResponse<Any>) -> ())
    {
        if IS_INTERNET_AVAILABLE()
        {
            //SHOW_CUSTOM_LOADER()
            let url = URL(string: url)!
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.get.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            //request.setValue(AIUser.sharedManager.token, forHTTPHeaderField: "access-token")
            AF.request(request).responseJSON(completionHandler: completionHandler)
        }else{
            SHOW_INTERNET_ALERT()
        }
    }
    
    func callGetApiWithHeader(_ url : String , completionHandler : @escaping (AFDataResponse<Any>) -> ()){
        if IS_INTERNET_AVAILABLE(){
            //SHOW_CUSTOM_LOADER()
            let headers: HTTPHeaders = [
                "Authorization": "Bearer g",
                "Content-Type" : "application/json"
            ]
            print("*******************************")
            print("URL: " , url)
            print("Headers: " , headers)
            print("*******************************")
            AF.request(url, method:.get, parameters: nil, headers: headers).responseJSON(completionHandler: completionHandler)
        }else{
            SHOW_INTERNET_ALERT()
        }
    }
    func callGetApiWithHeaderParameter(_ url : String ,params : [String : AnyObject]?, completionHandler : @escaping (AFDataResponse<Any>) -> ()){
        if IS_INTERNET_AVAILABLE(){
            //SHOW_CUSTOM_LOADER()
            let headers: HTTPHeaders = [
                "Authorization": "Bearer bvn",
                "Content-Type" : "application/json"
            ]
            print("*******************************")
            print("params: " , params!)
            print("URL: " , url)
            print("Headers: " , headers)
            print("*******************************")
            let url = URL(string: url)!
            /*var request = URLRequest(url: url)
             request.httpMethod = HTTPMethod.get.rawValue
             request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
             request.setValue("gzip", forHTTPHeaderField: "Accept-Encoding")
             request.addValue("Bearer " + AIUser.sharedManager.token, forHTTPHeaderField: "Authorization")
             let jsonData: Data? = try? JSONSerialization.data(withJSONObject: params, options: [])
             let jsonString: String = String(data: jsonData!, encoding: String.Encoding.utf8)!
             let jsonPassData = jsonString.data(using: .utf8, allowLossyConversion: false)!
             request.httpBody = jsonPassData
             //AF.request(request).responseJSON(completionHandler: completionHandler)*/
            AF.request(url, method:.get, parameters: params!, headers: headers).responseJSON(completionHandler: completionHandler)
        }else{
            SHOW_INTERNET_ALERT()
        }
    }
    
    
    func  callPostApiWithHeader(_ url : String, params : [String : AnyObject]?, completionHandler :@escaping (AFDataResponse<Any>) -> ()){
        if IS_INTERNET_AVAILABLE()
        {
            let urlString = url
            let url = URL(string: urlString)!
            let jsonData: Data? = try? JSONSerialization.data(withJSONObject: params!, options: [])
            let jsonString: String = String(data: jsonData!, encoding: String.Encoding.utf8)!
            print(url)
            let jsonPassData = jsonString.data(using: .utf8, allowLossyConversion: false)!
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("gzip", forHTTPHeaderField: "Accept-Encoding")
            //request.setValue(AIUser.sharedManager.token, forHTTPHeaderField: "access-token")
            request.addValue("Bearer " + "gh", forHTTPHeaderField: "Authorization")
            request.httpBody = jsonPassData
            print("*******************************")
            print("URL: " , url)
            //print("token: " , AIUser.sharedManager.token)
            print("params: " , params as Any)
            print("*******************************")
            AF.request(request).responseJSON(completionHandler: completionHandler)
        } else {
            SHOW_INTERNET_ALERT()
        }
    }
    func  callMultiPartPostApiWithHeader(_ url : String,params : [String : AnyObject]?,images: [UIImage],imagesName: [String], completionHandler :@escaping (AFDataResponse<Any>) -> ()){
        if IS_INTERNET_AVAILABLE()
        {
            let headers: HTTPHeaders = [
                "Content-type": "multipart/form-data",
                "Authorization": "Bearer bgdg"
            ]
            print("*******************************")
            print("URL: " , URL_BASE)
            //print("token: " , AIUser.sharedManager.token)
            print("headers: " , headers)
            print("*******************************")
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key,value) in params! {
                    multipartFormData.append(((value as AnyObject).data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false))!, withName: key)
                }
                for (i,img) in images.enumerated() {
                    let imgData = img.jpegData(compressionQuality: 0.25)
                    multipartFormData.append(imgData!, withName: imagesName[i], fileName: "\(UIDevice.current.identifierForVendor!.uuidString)\(i).png", mimeType: "image/png")
                }
                
            },to: url, method: .post , headers: headers).responseJSON(completionHandler: completionHandler)
        } else {
            SHOW_INTERNET_ALERT()
        }
    }
    //Above API calling methods just for Viewing purpose to add only
    
    // MARK: - ************* ProductList API **************
    func callGetProducts(isLoadFistTen:Bool,totalGetProductCount:Int, completetion : @escaping (_ isSuccess:Bool,_ arr:[ProductModel],_ strMessage:String) -> Void){
        
        guard let url = URL(string: URL_BASE) else {
            print("URl is not valid")
            completetion(false,[ProductModel](),"URl is not valid")
            return
        }
        if IS_INTERNET_AVAILABLE()
        {
            AF.request(url).responseJSON { (response) in
                
                guard response.error == nil else {
                    print("Error: \(response.error!.localizedDescription)")
                    completetion(false,[ProductModel](),"\(response.error!.localizedDescription)")
                    return
                }
                guard let jsonData = response.data else {
                    print("Invalid data")
                    completetion(false,[ProductModel](),"Invalid data")
                    return
                }
                
                if let products = Mapper<ProductModel>().mapArray(JSONString: String(data: jsonData, encoding: .utf8) ?? "") {
                    var getProducts = [ProductModel]()
                    if isLoadFistTen{
                        getProducts = Array(products.prefix(10)) // Load first 10 products
                        completetion(true,getProducts,"Product get sucessfully")
                    }else{
                        if products.count > totalGetProductCount{
                            let endIndex = totalGetProductCount + 10
                            getProducts = Array(products.prefix(endIndex)) // Append the additional products to the existing array
                            completetion(true,getProducts,"Product get sucessfully")
                        }else{
                            completetion(true,getProducts,"All Product get sucessfully")
                        }
                    }
                }
            }
        }else{
            completetion(false,[ProductModel](),"No internet connection")
            SHOW_INTERNET_ALERT()
        }
        
    }
    
}


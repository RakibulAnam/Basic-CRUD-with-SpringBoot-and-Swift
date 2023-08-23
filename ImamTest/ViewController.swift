//
//  ViewController.swift
//  ImamTest
//
//  Created by Jotno on 8/22/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    var subjects : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //testPerform()
        //postStudent()
        //putStudent()
        deleteStudent()
    }
    
    
    
    func deleteStudent(){
        
        guard let url = URL(string: "http://localhost:9191/delete/2")else{
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error{
                
                print("Got Error \(error.localizedDescription)")
                return
            }
                if let data = data {
                    do {
                        let jsonResponseArray = try JSONSerialization.jsonObject(with: data, options: [])
                        print(jsonResponseArray)
                    } catch {
                        print("JSON ERROR : \(error.localizedDescription)")
                    }
                }
        }.resume()
        
        
    }
    
    
    func putStudent(){
        
        guard let url = URL(string: "http://localhost:9191/update/2") else{
            
            print("Invalid URL")
            
            return}
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jSONData = StudentModel(firstName: "Mohit", lastName: "Anam", email: "1@3.com", password: "123", dob: "1999-11-05", board: "dhaka", contact: "016", address: "Narayanganj",
                                    ssc: [Subject(subject: "Mathematics", gpa: "A+"), Subject(subject: "Physics", gpa: "A+")],
                                    hsc: [Subject(subject: "Chemistry 1st Paper", gpa: "A+"), Subject(subject: "Higher Math 1st Paper", gpa: "A+")]
        )
        
        let encoder = JSONEncoder()
        
        if let encodedData = try? encoder.encode(jSONData){
            
            print(String(data: encodedData, encoding: .utf8)!)
            request.httpBody = encodedData
            
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let error = error {
                                print("ErrorBro: \(error.localizedDescription)")
                                return
                            }
                
                if let data = data {
                             do {
                                 // Parse the response data if needed
                                 let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                                 print(jsonResponse)
                             } catch {
                                 print("JSON Error: \(error.localizedDescription)")
                             }
                }
                
            }.resume()
            
        }
        
    }
    
    func postStudent() {
        
        guard let url = URL(string: "http://localhost:9191/addStudent") else{
            
            print("Invalid URL")
            
            return}
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jSONData = StudentModel(firstName: "MOhit", lastName: "Anam", email: "1@3.com", password: "123", dob: "1999-11-05", board: "dhaka", contact: "016", address: "Narayanganj",
                                    ssc: [Subject(subject: "Mathematics", gpa: "A+"), Subject(subject: "Physics", gpa: "A+")],
                                    hsc: [Subject(subject: "Chemistry 1st Paper", gpa: "A+"), Subject(subject: "Higher Math 1st Paper", gpa: "A+")]
        )
        
        let encoder = JSONEncoder()
        
        if let encodedData = try? encoder.encode(jSONData){
            
            print(String(data: encodedData, encoding: .utf8)!)
            request.httpBody = encodedData
            
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let error = error {
                                print("ErrorBro: \(error.localizedDescription)")
                                return
                            }
                
                if let data = data {
                             do {
                                 // Parse the response data if needed
                                 let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                                 print(jsonResponse)
                             } catch {
                                 print("JSON Error: \(error.localizedDescription)")
                             }
                }
                
            }.resume()
            
        }
        
        
    }
    

    
    
    
    
    
    
    func testPerform(){
        
        
        if let url = URL(string: "http://localhost:9191/SSCSubjects"){
            
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                
                if let safeData = data{
                    
                    //print(response)
                    let dataString = String(data: safeData, encoding: .utf8)
                    
                    let decoder = JSONDecoder()
                    
                    do{
                        
                        self.subjects = try decoder.decode([String].self, from: safeData)
                        print(self.subjects)
                    }catch{
                        print(error)
                    }
                    
                    }
                    
                    
                        
                }
                
            print(subjects)
            
            task.resume()
            }
            
            
        }
        
        
        
        
        
        
    }
    
    



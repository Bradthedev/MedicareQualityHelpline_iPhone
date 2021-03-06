//
//  AppDelegate.swift
//  Medicare Quality Helpline
//
//  Created by Brad Collins on 1/16/18.
//  Copyright © 2018 livanta. All rights reserved.
//

import UIKit
import CoreData
import GRDB

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //user defaults stuff
        let defaults = UserDefaults.standard
        
        let isOnInitComplete = defaults.object(forKey: "OnInitComplete") as? Bool ?? nil
        
        if(isOnInitComplete != true){
            //add db stuff here
            var sqliteFileURLs:String;
            if let sqliteFileURL = Bundle.main.url(forResource: "Livanta", withExtension: "sqlite") {
                
                do{
                    let dbQueue = try DatabaseQueue(path: sqliteFileURL.absoluteString)
                    
                    
                } catch  {
                    print(error);
                }
            }
            
           
            
        }
        
        //db stuff
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "HospitalLocations", in: context)
        let newHospital = NSManagedObject(entity: entity!, insertInto: context)
        
        newHospital.setValue("Livanta", forKey: "hospital_name")
        newHospital.setValue("Maryland", forKey: "hospital_state")
        newHospital.setValue(39.051599499999995, forKey: "hospital_lat")
        newHospital.setValue(-76.49555090000001, forKey: "hospital_lng")
        
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
        return true
    }
    
    struct Hospital {
        var hospitalName:String;
        var hospitalState:String;
        var hospitalLat:Double;
        var hospitalLng:Double;
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Medicare_Quality_Helpline")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    

}


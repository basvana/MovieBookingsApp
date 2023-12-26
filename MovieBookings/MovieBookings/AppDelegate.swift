//
//  AppDelegate.swift
//  MovieBookings
//
//  Created by danish on 21/12/23.
//
import Foundation
import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
  /*  lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "MovieBookings", withExtension: "Movie")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()*/
    
   lazy var persistentContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "MovieBookingsApp")
       container.loadPersistentStores(completionHandler: { (storeDescription, error) in
           if let error = error as NSError?{
               fatalError("Unsolved error \(error), \(error.userInfo)")
           }
       })
       return container
       }()


/*  lazy var managedObjectContext: NSManagedObjectContext? = {
      // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
      let coordinator = self.persistentContainer
      if coordinator == nil {
          return nil??
      }
      var managedObjectContext = NSManagedObjectContext()
      managedObjectContext.persistentContainer = coordinator
      return managedObjectContext
  }()*/

  // MARK: - Core Data Saving support

  func saveContext () {
       let context = persistentContainer.viewContext
          //var error: NSError? = nil
          if context.hasChanges {
              do {
                  try context.save()
              }
              catch {
                 let nserror = error as NSError
                  fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                 
              }
          }
      }
  }
        






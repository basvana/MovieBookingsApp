//
//  MovieTableView.swift
//  MovieBookings
//  Created by danish on 22/12/23.

import Foundation
import UIKit
import CoreData


var movieList = [Movie]()

class MovieTableView: UITableViewController
{
  //  var movieList = [Movie]()
    var fLoad = true
    
    override func viewDidLoad() {
        if(fLoad)
        {
            fLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
                        do{
                            let results:NSArray = try context.fetch(request) as NSArray
                            for result in results
                            {
                                let movie = result as! Movie
                                movieList.append(movie)
                            }
                        }
                        catch
                        {
                            print("Fetch Failed")
                        }

        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "movieCellID", for : indexPath) as! MovieCell
        
        let thisMovie: Movie!
        thisMovie = movieList[indexPath.row]
        
        movieCell.titleLabel.text = thisMovie.title
        movieCell.castLabel.text = thisMovie.cast
        
        
        return movieCell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        return movieList.count
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editMovie", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editMovie")
        {
            let indexPath = tableView.indexPathForSelectedRow!
            
            let movieDetail = segue.destination as? ViewController
            
            let selectedNote : Movie!
            selectedNote = movieList[indexPath.row]
            movieDetail!.selectedNote = selectedNote
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
   override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            return .delete
        }
    //swipe right to delete data
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
            if editingStyle == .delete{
                tableView.beginUpdates()
                movieList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .right)
                tableView.endUpdates()
            }
        }
}


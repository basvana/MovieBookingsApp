//
//  ViewController.swift
//  MovieBookings
//
//  Created by danish on 21/12/23.//

import UIKit
import CoreData

class ViewController: UIViewController {
  
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var Login: UIButton!
    
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var castTV: UITextView!
    
    var selectedNote: Movie? = nil
    
    var _fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    
    var managedObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(selectedNote != nil)
        {
            titleTF.text = selectedNote?.title
            castTV.text = selectedNote?.cast
        }
        
    }
    
   
 /*   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let context: NSManagedObjectContext = self.fetchedResultsController.managedObjectContext
        context.delete(movieList[indexPath.row])
        movieList.remove(at: index.row)
    }*/

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    
    // Override to support conditional rearranging of the table view.
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        // Return NO if you do not want the item to be re-orderable.
        return false
    }

    
    
  /*  @IBAction func loginbutton(_ sender: UIButton) {
        let username = userName.text ?? ""
        let Password = password.text ?? ""
        
        let validUsername = "user"
        let validPassword = "password"
        
        if username == validUsername && Password == validPassword{
            //Successful Login
            showAlert(title:"Success", message: "Login Successful")
            //
            //performSegue(withIdentifier: "MovieTableView", sender: nil)
            navigateToMovieTableView()
        }
        else{
            showAlert(title: "Error", message: "Invalid details")
        }
        
        
    }
    private func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
               let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
               alert.addAction(okAction)
               present(alert, animated: true, completion: nil)
    }
    private func navigateToMovieTableView() {
        let tableView = MovieTableView()
        navigationController?.pushViewController(tableView, animated: true)
    }
   */
    
    @IBAction func saveAction(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        if(selectedNote == nil)
        {
            let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context)
            let newMovie = Movie(entity: entity!, insertInto: context)
            newMovie.id = Int32(movieList.count as NSNumber)
            newMovie.title = titleTF.text
            newMovie.cast = castTV.text
            do{
                try context.save()
                movieList.append(newMovie)
                navigationController?.popViewController(animated: true)
            }
            catch{
                print("context save error")
            }
        }
        else
        {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
            do{
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let movie = result as! Movie
                    if(movie == selectedNote)
                    {
                        movie.title = titleTF.text
                        movie.cast = castTV.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                        
                    }
                }
            }
            catch
            {
                print("Fetch Failed")
            }
        }
    }
}
   



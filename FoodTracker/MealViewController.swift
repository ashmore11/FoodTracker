//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Scott Ashmore on 03/02/2016.
//  Copyright © 2016 Scott Ashmore. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate,
  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
  // MARK: Properties
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var ratingControl: RatingControl!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  /*
  This value is either passed by `MealTableViewController` in `prepareForSegue(_:sender:)`
  or constructed as part of adding a new meal.
  */
  var meal: Meal?

  override func viewDidLoad() {
  
    super.viewDidLoad()
      
    // Handle the text field’s user input through delegate callbacks.
    nameTextField.delegate = self
    
    // Set up views if editing an existing meal
    if let meal = meal {
      
      navigationItem.title = meal.name
      nameTextField.text = meal.name
      photoImageView.image = meal.photo
      ratingControl.rating = meal.rating
      
    }
    
    // Enable the save button only if the textfield has a valid Meal name
    checkValidMealName()
  
  }
  
  // MARK: UITextFieldDelegate
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    
    textField.resignFirstResponder()
    
    return true
    
  }
  
  func textFieldDidBeginEditing(textField: UITextField) {
    
    // Disable the save button while editing
    saveButton.enabled = false
    
  }
  
  func checkValidMealName() {
    
    // Disable the save button if the text field is empty
    let text = nameTextField.text ?? ""
    
    saveButton.enabled = !text.isEmpty
    
  }
  
  func textFieldDidEndEditing(textField: UITextField) {
    
    checkValidMealName()
    
    navigationItem.title = textField.text
    
  }
  
  // MARK: UIImagePickerControllerDelegate
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    
    dismissViewControllerAnimated(true, completion: nil)
    
  }
  
  func imagePickerController(picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    
    let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
      
    photoImageView.image = selectedImage
      
    dismissViewControllerAnimated(true, completion: nil)
      
  }
  
  // MARK: Navigation
  @IBAction func cancel(sender: UIBarButtonItem) {
    
    // Depending on the style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
    let isPresentingInAddMealMode = presentingViewController is UINavigationController
    
    if isPresentingInAddMealMode {
    
      dismissViewControllerAnimated(true, completion: nil)
      
    }
    else {
      
      navigationController!.popViewControllerAnimated(true)
      
    }
    
  }
  
  // This method lets you configure a view controller before it's presented.
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if saveButton === sender {
      
      let name = nameTextField.text ?? ""
      let photo = photoImageView.image
      let rating = ratingControl.rating
      
      // Set the meal to be passed to MealTableViewController after the unwind segue.
      meal = Meal(name: name, photo: photo, rating: rating)
    
    }
  
  }
  
  // MARK: Actions
  
  @IBAction func setLabelText(sender: UITextField) {
    
    print(nameTextField.text)
    
  }

  @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
    
    nameTextField.resignFirstResponder()
    
    let imagePickerController = UIImagePickerController()
    
    imagePickerController.sourceType = .PhotoLibrary
    
    imagePickerController.delegate = self
    
    presentViewController(imagePickerController, animated: true, completion: nil)
    
  }

}


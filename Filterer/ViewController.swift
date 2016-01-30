//
//  ViewController.swift
//  Filterer
//
//  Created by Arman Kussainov on 1/23/16.
//  Copyright © 2016 Arman Kussainov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var filteredImage: UIImage?
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var bottomMenu: UIView!
    @IBOutlet var thirdMenu: UIView!
    @IBOutlet var editMenu: UIView!
    
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var compareButton: UIButton!
    @IBOutlet var editButton: UIButton!
    
    @IBOutlet var slider: UISlider!
    
    var originalImage: UIImage?
    
    var colourId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)

        editMenu.translatesAutoresizingMaskIntoConstraints = false
        editMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        
        originalImage = imageView.image
        
    }
    
    @IBAction func imageTouched(sender: UITapGestureRecognizer) {
        if colourId != 0 {
            if imageView.image == originalImage {
                imageView.image = filteredImage
            } else {
                imageView.image = originalImage
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onEdit(sender: UIButton) {
        if sender.selected {
            hideEditMenu()
            editButton.enabled = false
        } else {
            hideSecondaryMenu()
            filterButton.selected = false
            showEditMenu()
            editButton.enabled = true
        }
    }
    
    @IBAction func onCompare(sender: UIButton) {
        if compareButton.selected {
            imageView.image = filteredImage
            compareButton.selected = false
        } else {
            imageView.image = originalImage
            compareButton.selected = true
        }
    }
    
    @IBAction func onShare(sender: UIButton) {
        let activityController = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    
    }
    
    @IBAction func onNewPhoto(sender: UIButton) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
            self.showCamera()
        }))

        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        
        self.presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        
        self.presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        }
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onFilter(sender: UIButton) {
        if sender.selected {
            hideSecondaryMenu()
            sender.selected = false
            compareButton.enabled = false
            editButton.enabled = false
            colourId = 0
        } else {
            showSecondaryMenu()
            sender.selected = true
        }
    }
    
    func showSecondaryMenu() {
        view.addSubview(secondaryMenu)
    
        let bottomContstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomContstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.2) {
            self.secondaryMenu.alpha = 1.0
        }
    }

    func hideSecondaryMenu() {
        UIView.animateWithDuration(0.2, animations: {
            self.secondaryMenu.alpha = 0
            }) { (completed) -> Void in
                if completed == true {
                    self.secondaryMenu.removeFromSuperview()
                }
        }
    }
    
    func showEditMenu() {
        view.addSubview(editMenu)
        
        let bottomContstraint = editMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = editMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = editMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        
        let heightConstraint = editMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomContstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.editMenu.alpha = 0
        UIView.animateWithDuration(0.2) {
            self.editMenu.alpha = 1.0
        }
    }
    
    func hideEditMenu() {
        UIView.animateWithDuration(0.2, animations: {
            self.editMenu.alpha = 0
            }) { (completed) -> Void in
                if completed == true {
                    self.editMenu.removeFromSuperview()
                }
        }
    }

    @IBAction func sliderChanged(sender: UISlider) {
        self.filterColour(Int(sender.value), typeId: colourId)
    }
    
    @IBAction func onRedFilter(sender: UIButton) {
        self.filterColour(107, typeId: 1)
        colourId = 1
        compareButton.enabled = true
        editButton.enabled = true
    }
    
    @IBAction func onGreenFilter(sender: UIButton) {
        self.filterColour(108, typeId: 2)
        colourId = 2
        compareButton.enabled = true
        editButton.enabled = true
    }
    
    @IBAction func onBlueFilter(sender: UIButton) {
        self.filterColour(110, typeId: 3)
        colourId = 3
        compareButton.enabled = true
        editButton.enabled = true
    }
    
    @IBAction func onYellowFilter(sender: AnyObject) {
        self.filterColour(107, typeId: 4)
        colourId = 4
        compareButton.enabled = true
        editButton.enabled = true
    }
    
    @IBAction func onPurpleFilter(sender: AnyObject) {
        self.filterColour(107, typeId: 5)
        colourId = 5
        compareButton.enabled = true
        editButton.enabled = true
    }
    
    func filterColour(avg: Int, typeId: Int) {
        let image = imageView.image!
        
        let rgbaImage = RGBAImage(image: image)!
        
        let avgColour = avg
        
        if (typeId == 1) {
            for y in 0..<rgbaImage.height {
                for x in 0..<rgbaImage.width {
                    let index = y * rgbaImage.width + x
                    var pixel = rgbaImage.pixels[index]
                    let colourDelta = Int(pixel.red) - avgColour
                    var modifier = 1 + 4 * (Double(y) / Double(rgbaImage.height))
                    if (Int(pixel.red) < avgColour) {
                        modifier = 1
                    }
                    
                    pixel.red = UInt8(max(min(235, Int(round(Double(avgColour) + modifier * Double(colourDelta)))), 8))
                    rgbaImage.pixels[index] = pixel
                }
            }
        } else if (typeId == 2) {
            for y in 0..<rgbaImage.height {
                for x in 0..<rgbaImage.width {
                    let index = y * rgbaImage.width + x
                    var pixel = rgbaImage.pixels[index]
                    let colourDelta = Int(pixel.green) - avgColour
                    var modifier = 1 + 4 * (Double(y) / Double(rgbaImage.height))
                    if (Int(pixel.green) < avgColour) {
                        modifier = 1
                    }
                    
                    pixel.green = UInt8(max(min(235, Int(round(Double(avgColour) + modifier * Double(colourDelta)))), 8))
                    rgbaImage.pixels[index] = pixel
                }
            }
        } else if (typeId == 3) {
            for y in 0..<rgbaImage.height {
                for x in 0..<rgbaImage.width {
                    let index = y * rgbaImage.width + x
                    var pixel = rgbaImage.pixels[index]
                    let colourDelta = Int(pixel.blue) - avgColour
                    var modifier = 1 + 4 * (Double(y) / Double(rgbaImage.height))
                    if (Int(pixel.blue) < avgColour) {
                        modifier = 1
                    }
                    
                    pixel.blue = UInt8(max(min(255, Int(round(Double(avgColour) + modifier * Double(colourDelta)))), 8))
                    rgbaImage.pixels[index] = pixel
                }
            }
        } else if (typeId == 4) {
            for y in 0..<rgbaImage.height {
                for x in 0..<rgbaImage.width {
                    let index = y * rgbaImage.width + x
                    var pixel = rgbaImage.pixels[index]
                    let colourDelta = Int(pixel.yellow) - avgColour
                    var modifier = 1 + 4 * (Double(y) / Double(rgbaImage.height))
                    if (Int(pixel.yellow) < avgColour) {
                        modifier = 1
                    }
                    
                    pixel.yellow = UInt8(max(min(255, Int(round(Double(avgColour) + modifier * Double(colourDelta)))), 8))
                    rgbaImage.pixels[index] = pixel
                }
            }
        } else if (typeId == 5) {
            for y in 0..<rgbaImage.height {
                for x in 0..<rgbaImage.width {
                    let index = y * rgbaImage.width + x
                    var pixel = rgbaImage.pixels[index]
                    let colourDelta = Int(pixel.purple) - avgColour
                    var modifier = 1 + 4 * (Double(y) / Double(rgbaImage.height))
                    if (Int(pixel.purple) < avgColour) {
                        modifier = 1
                    }
                    
                    pixel.purple = UInt8(max(min(255, Int(round(Double(avgColour) + modifier * Double(colourDelta)))), 8))
                    rgbaImage.pixels[index] = pixel
                }
            }
        }
        
        filteredImage = rgbaImage.toUIImage()
        imageView.image = filteredImage
    }
    
}




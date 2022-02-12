//
//  DetailViewController.swift
//  NoteSimple
//
//  Created by Songjeongpyeong on 2022/02/11.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet weak var AboutBarButton: UIButton!
    
   
 
    let aboutButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(buttonPressed(_:)))
    
    let lockOffButton = UIBarButtonItem(image: UIImage(systemName: "lock.open"), style: .plain, target: self, action: #selector(buttonPressed(_:)))
    
    let lockOnButton = UIBarButtonItem(image: UIImage(systemName: "lock"), style: .plain, target: self, action: #selector(buttonPressed(_:)))

   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItems = [aboutButton, lockOffButton]
       
        
    }
    
    
    
    override func setEditing (_ editing:Bool, animated:Bool)
    {
       super.setEditing(editing,animated:animated)
        if(self.isEditing)
       {
            self.editButtonItem.title = "저장"
       }else
       {
     //   self.editButtonItem.title = "저장"
       }
     }
    @objc private func buttonPressed(_ sender: Any) {
        
    }
}

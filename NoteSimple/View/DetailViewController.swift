//
//  DetailViewController.swift
//  NoteSimple
//
//  Created by Songjeongpyeong on 2022/02/11.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet weak var textview_detail: UITextView!
    @IBOutlet weak var AboutBarButton: UIButton!
    
    var Sqllite = SqliteClass()
    var detailviewmodel = DetailViewMdoel()
    
   lazy var aboutButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(buttonPressed(_:)))
   lazy var  lockOffButton = UIBarButtonItem(image: UIImage(systemName: "lock.open"), style: .plain, target: self, action: #selector(lockButton(_:)))
   lazy var  lockOnButton = UIBarButtonItem(image: UIImage(systemName: "lock"), style: .plain, target: self, action: #selector(buttonPressed(_:)))

   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItems = [aboutButton, lockOffButton]
      
    }
    
    

    
    
    @objc private func buttonPressed(_ sender: Any) {
        
        
       
        
        detailviewmodel.insertDetailViewModel(Content: textview_detail.text , Password: "")
       
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc private func lockButton(_ sender: Any) {
        
     
      
        self.navigationController?.popViewController(animated: true)
    }
    

    
    
  
    
    
    
}

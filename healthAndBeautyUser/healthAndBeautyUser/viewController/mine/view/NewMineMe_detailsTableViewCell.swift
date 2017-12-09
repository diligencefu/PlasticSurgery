//
//  NewMineMe_detailsTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/13.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineMe_detailsTableViewCell: UITableViewCell {

    @IBOutlet weak var titles: UILabel!
    @IBOutlet weak var details: UILabel!
    
    private var _model : String?
    var model : String? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    private func didSetModel(_ model: String) {
        
       
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

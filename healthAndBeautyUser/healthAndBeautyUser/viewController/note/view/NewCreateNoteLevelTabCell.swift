

import UIKit

class NewCreateNoteLevelTabCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var slider: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if isIce {
            slider.isOn = true
        }else {
            slider.isOn = false
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

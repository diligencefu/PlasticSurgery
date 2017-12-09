/*
 *This file is HJImageBrowser package of all the documents.
 *HJ<471941655@qq.com>
 *
 *Please ask Wang Mu wood file content copyright and license.
 *file that was distributed with this source code.
 */

import UIKit
/*
 *获取高清和缩略图图片代理
 *Get Gao Qinghe thumbnail images agent
 */
protocol HJImageBrowserDelegate : NSObjectProtocol {
    
    ///  获取缩略图图片 && Getting thumbnail images
    ///  - parameter indexRow: 当前是第几个cell && The current is which a cell
    ///  - returns: 获取的缩略图图片 && Getting thumbnail images
    func getTheThumbnailImage(_ indexRow: Int) ->UIImage
}

class HJImageBrowser:
                                UIView,
                                UICollectionViewDelegate,
                                UICollectionViewDataSource,
                                UICollectionViewDelegateFlowLayout{
    
    /// 获取高清和缩略图图片代理 && Get Gao Qinghe thumbnail images agent
    var delegates :HJImageBrowserDelegate?
    
    /// 承载view  父视图view && Bearing the view parent view view
    var bottomView:UIView!
    
    /// 是否让走预加载图片 && If let go preload picture
    var isShow: Bool!
    
    /* 如果没有缩略图则显示这张图片 && If there is no thumbnail drawings show the picture
     如果这张图片也没有则什么也不显示 && If they aren't in the picture is what also don't show
     */
    var defaultImage: UIImage!
    
    /// 当前显示的是第几张图片 && How many pictures of the currently displayed
    var indexImage: Int!
    
    /// 高清图片数组 && High-resolution image array
    var arrayImage: [String]!
    
    /// 图片展示View && Pictures show the View
    var collectionView:UICollectionView!
    
    /// 图片个数显示 && The number of picture
    var imageNumberLabel: UILabel!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        creatUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}


extension HJImageBrowser{
    
    func  creatUI(){
        
        self.backgroundColor = viewTheBackgroundColor
        
        isShow = false
        creatCollectionView()
    }
    
    func  creatCollectionView(){
        
        let fowLayout = UICollectionViewFlowLayout.init()
        
        fowLayout.minimumLineSpacing = 0;
        
        fowLayout.scrollDirection = .horizontal
        
        fowLayout.itemSize = CGSize(width: ScreenWidth + imageInterval,
                                        height: ScreenHeight)
        
        collectionView = UICollectionView.init(frame: CGRect(x: 0,
            y: 0,
            width: ScreenWidth + imageInterval,
            height: ScreenHeight),
                                               collectionViewLayout: fowLayout)
        
        collectionView.allowsMultipleSelection = true
        
        collectionView.register(HJCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView.isPagingEnabled = true
        
        collectionView.delegate = self
        
        collectionView.dataSource = self
        
        collectionView.alpha = 0
        
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.backgroundColor = viewTheBackgroundColor
        
        imageNumberLabel = UILabel.init(frame: CGRect(x: 0, y: ScreenHeight - 30, width: ScreenWidth, height: 20))
        
        imageNumberLabel.backgroundColor = UIColor.clear
        
        imageNumberLabel.textColor = UIColor.white
        
        imageNumberLabel.textAlignment = .center
        
        imageNumberLabel.alpha = 0
        
        self.addSubview(collectionView)
        
        self.addSubview(imageNumberLabel)
    }
    
    override func layoutSubviews(){
        
        super.layoutSubviews()
        
        imageNumberLabel.text = String.init(self.indexImage+1) + "/" + "\(self.arrayImage.count)"
        
        if (isShow == false) {
            
            if (self.indexImage == nil) {
                
                let altShow = UIAlertView.init(title: nil,
                                               message: "请设置imageInterval属性",
                                               delegate: nil,
                                               cancelButtonTitle: "确定")
                altShow.show()
                
                self.removeFromSuperview()
                
                return
                
            }
            
            self.collectionView.contentOffset = CGPoint(x: (self.frame.size.width + imageInterval) *  CGFloat(self.indexImage), y: 0)
            
            isShow = true
            
            let  tempView = UIImageView.init()
            
            var ima = UIImage.init()
            
            self.addSubview(tempView)
            
            if ((self.delegates?.getTheThumbnailImage(self.indexImage)) != nil) {
                
                ima = (self.delegates?.getTheThumbnailImage(self.indexImage))!
                
                
            }else{
                
                if (self.defaultImage != nil) {
                    
                    ima = self.defaultImage!
                    
                }else{
                    
                    ima = defaultImage
                }
            }
            
            tempView.image = ima
            
            var ve = UIView()
            
            if self.bottomView == nil {
                
                let altShow = UIAlertView.init(title: nil,
                                               message: "请设置bottomView属性",
                                               delegate: nil,
                                               cancelButtonTitle: "确定")
                
                altShow.show()
                
                self.removeFromSuperview()
                
                return
                
            }
            
            
            if self.bottomView.isKind(of: UICollectionView.classForCoder()) {
                
                let view = self.bottomView as! UICollectionView
                
                let path = IndexPath.init(row: self.indexImage, section: 0)
                
                ve = view.cellForItem(at: path)!
                
            }else{
                
                ve = self.bottomView.subviews[indexImage]
            }
            
            let rect = self.bottomView.convert(ve.frame, to: self)
            
            tempView.frame = rect
            
            self.collectionView.isHidden = true
            
            self.collectionView.alpha = 1
            
            let heightS = (ima.size.height)/(ima.size.width)*ScreenWidth
            
            let widthS = (ima.size.width)/(ima.size.height)*heightS
            
            UIView.animate(withDuration: animationTime, animations: {
                
                tempView.frame = CGRect(x: 0, y: 0, width: widthS, height: heightS)
                
                if heightS < ScreenHeight {
                    
                    tempView.center = self.center
                    
                }
                
            }, completion: { (callBack) in
                
                tempView.removeFromSuperview()
                
                self.collectionView.isHidden = false
                
            }) 
        }
    }
    
    internal func show(){
        
        let window = UIApplication.shared.keyWindow
        
        self.frame = (window?.bounds)!
        
        window?.addSubview(self)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! HJCell
        
        cell.bottomView = self.bottomView
        
        
        if ((self.delegates?.getTheThumbnailImage(indexPath.row)) != nil) {
            
            cell.setImageWithURL(arrayImage[indexPath.row],
                                 placeholderImage:
                (self.delegates?.getTheThumbnailImage(indexPath.row))!,
                                 defaultImage:self.defaultImage)
            
        }else{
            
            if (self.defaultImage == nil) {
                
                self.defaultImage = UIImage.init()
            }
            
            cell.setImageWithURL(arrayImage[indexPath.row],
                                 placeholderImage:self.defaultImage,
                                 defaultImage:self.defaultImage)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayImage.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let firstIndexPath = self.collectionView.indexPathsForVisibleItems.first
        
        indexImage = firstIndexPath?.row
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let path = self.collectionView.indexPathForItem(at: self.collectionView.contentOffset)
        let number = path?.row
        
        if number != nil {
            imageNumberLabel.text = "\(number!+1)" + "/" + "\(self.arrayImage.count)"

        }else{
            return
        }
        
        UIView.animate(withDuration: 3, animations: {
            
            self.imageNumberLabel.alpha = 0
            
        }) 
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.imageNumberLabel.alpha = 1
            
        }) 
        
    }
    
}


@objc(HJCell)
class HJCell:
    UICollectionViewCell,
    UIScrollViewDelegate,
UIActionSheetDelegate{
    
    static let cellId = "HJCell"
    
    var BigImage: UIImageView!
    
    var BottomScroll: UIScrollView!
    
    var bottomView:UIView!
    
    var cireView: cireview!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        creatUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatUI(){
        
        self.cireView = cireview.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        self.cireView.value  = 0
        
        self.cireView.maximumValue = 1
        
        self.cireView.isUserInteractionEnabled = false
        
        self.cireView.center = CGPoint(x: ScreenWidth/2, y: ScreenHeight/2)
        
        BottomScroll = UIScrollView.init(frame: CGRect(x: 0,
            y: 0,
            width: ScreenWidth,
            height: ScreenHeight))
        
        BottomScroll.delegate = self
        
        BottomScroll.maximumZoomScale = 2.5;
        
        BottomScroll.minimumZoomScale = 1.0;
        
        BottomScroll.backgroundColor = viewTheBackgroundColor
        
        BigImage = UIImageView.init()
        
        BigImage.isUserInteractionEnabled = true
        
        BottomScroll.addSubview(BigImage)
        
        self.addSubview(BottomScroll)
        
        let singleTap = UITapGestureRecognizer.init(target: self,
                                                    action: #selector(self.oneTouch(_:)))
        
        let doubleTap = UITapGestureRecognizer.init(target: self,
                                                    action: #selector(self.twoTouch(_:)))
        
        let longpressGesutre = UILongPressGestureRecognizer(target: self,
                                                            action: #selector(self.handleLongpressGesture(_:)))
        
        doubleTap.numberOfTapsRequired = 2
        
        singleTap.require(toFail: doubleTap)
        
        doubleTap.require(toFail: longpressGesutre)
        
        BottomScroll.addGestureRecognizer(singleTap)
        
        BottomScroll.addGestureRecognizer(doubleTap)
        
        BottomScroll.addGestureRecognizer(longpressGesutre)
        
        self.cireView.isHidden = true
        
        self.addSubview(cireView)
        
    }
    
    func setUpTheValue(_ value:CGFloat){
        
        self.cireView.value =  value
        
    }
    
    internal func setImageWithURL(_ url:String, placeholderImage:UIImage, defaultImage:UIImage){
        
        self.setBigImageTheSizeOfThe(placeholderImage, defaultImage:defaultImage)
        
        self.cireView.isHidden = false
        
        
        BigImage.kf.setImage(with: URL.init(string: url),
                             placeholder: defaultImage,
                             options: [.cacheMemoryOnly],
                             progressBlock: { (receivedSize, expectedSize) in
            
            let showProgress = Float(receivedSize)/Float(expectedSize)
            
            self.setUpTheValue(CGFloat.init(showProgress))
            
        }) { (image, error, cacheType, imageURL) in
            
            self.cireView.isHidden = true
            
            if image == nil {
                
                self.setBigImageTheSizeOfThe(placeholderImage, defaultImage:defaultImage)
                
                return
            }
            self.setBigImageTheSizeOfThe(image!, defaultImage:defaultImage)
        }
    }
    
    func setBigImageTheSizeOfThe(_ bImage:UIImage, defaultImage:UIImage){
        
        self.BottomScroll.contentOffset = CGPoint.zero
        
        self.BottomScroll.contentSize = CGSize.zero
        
        self.BottomScroll.contentInset = UIEdgeInsets.zero
        
        self.BottomScroll.zoomScale = 1
        
        var heightS = (bImage.size.height)/(bImage.size.width)*self.BottomScroll.frame.size.width
        
        var widthS = (bImage.size.width)/(bImage.size.height)*heightS
        
        if heightS.isNaN || widthS.isNaN {
            
            let image = defaultImage
            
            heightS = (image.size.height)/(image.size.width)*self.BottomScroll.frame.size.width
            
            widthS = (image.size.width)/(image.size.height)*heightS
            
            if heightS.isNaN || widthS.isNaN {
                
                let imageI = defaultImage
                
                heightS = (imageI.size.height)/(imageI.size.width)*self.BottomScroll.frame.size.width
                
                widthS = (imageI.size.width)/(imageI.size.height)*heightS
                
                self.BigImage.image = imageI
                
            }else{
                
                heightS = (image.size.height)/(image.size.width)*self.BottomScroll.frame.size.width
                
                widthS = (image.size.width)/(image.size.height)*heightS
                
                self.BigImage.image = image
            }
            
        }
        
        self.BigImage.frame = CGRect(x: 0, y: 0, width: widthS, height: heightS)
        
        if heightS > ScreenHeight {
            
            self.BottomScroll.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
            
            self.BottomScroll.contentSize = CGSize(width: widthS, height: heightS)
            
        }else{
            
            self.BottomScroll.contentInset = UIEdgeInsetsMake((self.BottomScroll.frame.size.height - heightS)/2, 0, 0, 0)
            
        }
    }
    
    func oneTouch(_ sender: UITapGestureRecognizer){
        
        let  tempView = UIImageView.init()
        tempView.contentMode = .scaleAspectFill
        let imaV = sender.view?.subviews[0] as! UIImageView
        
        let ima = imaV.image
        
        tempView.image = ima
        
        self.superview?.superview?.addSubview(tempView)
        
        let ve:UIView!
        
        if self.bottomView.isKind(of: UICollectionView.classForCoder()) {
            
            let view = self.bottomView as! UICollectionView
            
            let path = IndexPath.init(row: self.indexPath().row, section: 0)
            
            ve = view.cellForItem(at: path)
            
        }else{
            
            ve = self.bottomView.subviews[self.indexPath().row]
            
        }
        
        if ve == nil {
            
            UIView.animate(withDuration: animationTime, animations: {
                
                self.superCollectionView().alpha = 0
                
                self.superview?.superview?.alpha = 0
                
            }, completion: { (callBack) in
                
                self.superview?.superview?.removeFromSuperview()
                
            }) 
            
            return
        }
        
        let rect = self.bottomView.convert(ve.frame, to: self)
        
        let poin = self.bottomView.convert(ve.center, to: self)
        
        let heightS = (ima?.size.height)!/(ima?.size.width)!*ScreenWidth
        
        let widthS = (ima?.size.width)!/(ima?.size.height)!*heightS
        
        tempView.frame = CGRect(x: 0, y: 0, width: widthS, height: heightS)
        
        if ima?.size.height < ScreenHeight {
            
            tempView.center = (self.superview?.superview?.center)!
            
        }
        
        self.superCollectionView().alpha = 0.5
        
        self.superview?.superview?.backgroundColor = UIColor.clear
        
        UIView.animate(withDuration: animationTime, animations: {
            
            self.superCollectionView().alpha = 0
            
            tempView.center = poin
            
            tempView.bounds = rect
            
        }, completion: { (callBack) in
            
            self.superview?.superview?.removeFromSuperview()
            
        }) 
    }
    
    func twoTouch(_ sender: UITapGestureRecognizer){
        
        let touchPoint = sender.location(in: sender.view)
        
        let scroll =  sender.view as! UIScrollView
        
        let imageView = scroll.subviews[0]
        
        let zs = scroll.zoomScale
        
        UIView.animate(withDuration: 0.5, animations: {
            
            scroll.zoomScale = (zs == 1.0) ? 2.0 : 0.0
            
        }) 
        
        UIView.animate(withDuration: 0.5, animations: {
            
            if scroll.zoomScale==2.0{
                
                let rectHeight = (self.frame.size.height)/scroll.zoomScale
                
                let rectWidth = self.frame.size.width/scroll.zoomScale
                
                let rectX = touchPoint.x-rectWidth/2.0
                
                let rectY = touchPoint.y-rectHeight/2.0
                
                let zoomRect = CGRect(x: rectX, y: rectY, width: rectWidth, height: rectHeight)
                
                scroll.zoom(to: zoomRect, animated: false)
                
                if imageView.frame.size.height > ScreenHeight {
                    
                    self.BottomScroll.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
                }else{
                    
                    self.BottomScroll.contentInset = UIEdgeInsetsMake((self.BottomScroll.frame.size.height - (imageView.frame.size.height))/2, 0, 0, 0)
                }
            }else{
                
                if imageView.frame.size.height > ScreenHeight {
                    
                    self.BottomScroll.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
                }else{
                    
                    self.BottomScroll.contentInset = UIEdgeInsetsMake((self.BottomScroll.frame.size.height - (imageView.frame.size.height))/2, 0, 0, 0)
                }
            }
        }) 
    }
    
    func handleLongpressGesture(_ sender : UILongPressGestureRecognizer){
        
        if (sender.state == .began) {
            
            let saveImageAlt = UIActionSheet.init(title: "保存图片到本地", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: "保存")
            
            saveImageAlt.show(in: self)
        }
    }
    
    func actionSheet(_ actionSheet: UIActionSheet, willDismissWithButtonIndex buttonIndex: Int){
        
        if buttonIndex == 0 {
            
            UIImageWriteToSavedPhotosAlbum(self.BigImage.image!,
                                           self,
                                           #selector(HJCell.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        
        if error != nil {
            
            let altShow =  UIAlertView.init(title: nil,
                                            message: "图片保存失败/n\(String(describing: error?.description))",
                                            delegate: nil,
                                            cancelButtonTitle: "确定")
            
            altShow.show()
            return
        }
//        setToast(str: "图片保存成功")
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return scrollView.subviews[0]
        
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
    
        let image = scrollView.subviews[0]
        
        if image.frame.size.height > ScreenHeight {
            
            UIView.animate(withDuration: 0.2, animations: {
                
                self.BottomScroll.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
                
            })
            
        }else{
            
            UIView.animate(withDuration: 0.2, animations: {
                
                self.BottomScroll.contentInset = UIEdgeInsetsMake((self.BottomScroll.frame.size.height - image.frame.size.height)/2, 0, 0, 0)
                
            })
        }
    }
    
    func indexPath() ->IndexPath{
        
        let collectionView = self.superCollectionView
        
        let indexPath = collectionView().indexPath(for: self)
        
        return indexPath!;
        
    }
    
    func superCollectionView() ->UICollectionView{
        
        return self.findSuperViewWithClass(UICollectionView.classForCoder()) as! UICollectionView
        
    }
    
    func findSuperViewWithClass(_ superViewClass:AnyClass) ->UIView{
        
        var superView = self.superview
        
        var foundSuperView:UIView?
        
        while (superView != nil && foundSuperView == nil) {
            
            if ((superView?.isKind(of: superViewClass)) != nil) {
                
                foundSuperView = superView
                
            }else{
                
                superView = superView!.superview;
                
            }
            
        }
        
        return foundSuperView!
    }
    
}

/// 进度框 && The progress of the box
class cireview: UIView{
    
    var value: CGFloat = 0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var maximumValue: CGFloat = 0 {
        didSet { self.setNeedsDisplay() }
    }
    
    var contentLabel: UILabel!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.isOpaque = false
        
        self.backgroundColor = progressViewBackColor
        
        contentLabel = UILabel.init(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        
        contentLabel.textAlignment = .center
        
        contentLabel.textColor = progressColor
        
        contentLabel.adjustsFontSizeToFitWidth = true
        
        contentLabel.text = "0.0%"
        
        self.addSubview(contentLabel)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let lineWidth: CGFloat = 5.0
//        
//        let radius = rect.width / 2.0 - lineWidth
//
//        let centerX = rect.midX
//
//        let centerY = rect.midY
//
//        let startAngle = CGFloat(-90 * M_PI / 180)
//
//        let endAngle = CGFloat(((self.value / self.maximumValue) * 360 - 90) ) * CGFloat(M_PI) / 180
        
        let context = UIGraphicsGetCurrentContext()
        
        context!.setStrokeColor(progressArticleColor)
        
        context!.setLineWidth(lineWidth)
        
//        CGContextAddArc(context!, centerX, centerY, radius, startAngle, endAngle, 0)
        
        context!.strokePath()
        
        context!.setStrokeColor(progressBackColor)
        
//        CGContextAddArc(context!, centerX, centerY, radius, startAngle, endAngle, 1)
        
        context!.strokePath()
        
        let content = Int(self.value * 100)
        
        self.contentLabel.text = String.init(content) + "%"

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


/// Tools 工具类 && The Tools Tools
import Foundation
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


/////屏幕高度 && The screen height
//let ScreenHeight = UIScreen.main.bounds.size.height
//
/////屏幕宽度 && The width of the screen
//let ScreenWidth = UIScreen.main.bounds.size.width

///图片与图片之间的间隔 && The interval between images and pictures
let imageInterval = CGFloat(20)

///视图的背景颜色 && The background color of the view
let viewTheBackgroundColor = UIColor.black

/// 动画时间 && Animation time
let animationTime = 0.35

///  进度条字体颜色 The progress bar font color
let progressColor = UIColor.black

///  进度条 条的背景颜色 && The background color of the article the progress bar
let progressBackColor =  UIColor.darkGray.cgColor

///  进度条 条的颜色 && The progress bar of the color
let progressArticleColor =  UIColor.white.cgColor

/// 进度条View背景色 && The progress bar View the background color
let progressViewBackColor = UIColor.clear

/// 默认背景图片颜色获取和设置 && The default color to get and set background image
func getColorImageWithColor() ->(UIImage){
    
    let color = UIColor.brown
    
    let rect = CGRect(x: 0, y: 0, width: ScreenWidth, height: 200)
    
    UIGraphicsBeginImageContext(rect.size);
    
    let context = UIGraphicsGetCurrentContext();
    
    context!.setFillColor(color.cgColor);
    
    context!.fill(rect);
    
    let img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img!;
    
}

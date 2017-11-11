/*
 * Copyright (c) 2014-2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

// A delay function
// A delay function
func delay(_ seconds: Double, completion: @escaping ()->Void) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(Int(seconds * 1000.0))) {
        completion()
    }
}

class ViewController: UIViewController {

  // MARK: IB outlets

  @IBOutlet var loginButton: UIButton!
  @IBOutlet var heading: UILabel!
  @IBOutlet var username: UITextField!
  @IBOutlet var password: UITextField!

  @IBOutlet var cloud1: UIImageView!
  @IBOutlet var cloud2: UIImageView!
  @IBOutlet var cloud3: UIImageView!
  @IBOutlet var cloud4: UIImageView!

  // MARK: further UI

  let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
  let status = UIImageView(image: UIImage(named: "banner"))
  let label = UILabel()
  let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]

  var statusPosition = CGPoint.zero

  // MARK: view controller methods

  override func viewDidLoad() {
    super.viewDidLoad()

    //set up the UI
    loginButton.layer.cornerRadius = 8.0
    loginButton.layer.masksToBounds = true

    spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
    spinner.startAnimating()
    spinner.alpha = 0.0
    loginButton.addSubview(spinner)

    status.isHidden = true
    status.center = loginButton.center
    view.addSubview(status)

    label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
    label.font = UIFont(name: "HelveticaNeue", size: 18.0)
    label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
    label.textAlignment = .center
    status.addSubview(label)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    heading.center.x -= view.bounds.width
    username.center.x -= view.bounds.width
    password.center.x -= view.bounds.width
    
    // heading
    UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseInOut], animations: {
        self.heading.center.x += self.view.bounds.width
    }, completion: nil)
    
    // username
    UIView.animate(withDuration: 1, delay: 0.5, options: [.curveEaseInOut], animations: {
        self.username.center.x += self.view.bounds.width
    }, completion: nil)
    
    // password
    UIView.animate(withDuration: 1, delay: 0.7, options: [], animations: {
        self.password.center.x += self.view.bounds.width
    }, completion: nil)
    
    // Login
    loginButton.center.y += 30.0
    loginButton.alpha = 0
    
    // Clouds
    cloud1.alpha = 0
    self.cloud1.center.x -= self.view.bounds.width + self.cloud1.bounds.width
    cloud2.alpha = 0
    self.cloud2.center.x -= self.view.bounds.width + self.cloud2.bounds.width
    cloud3.alpha = 0
    self.cloud3.center.x -= self.view.bounds.width + self.cloud3.bounds.width
    cloud4.alpha = 0
    self.cloud4.center.x -= self.view.bounds.width + self.cloud4.bounds.width
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    // Animate clouds
    UIView.animate(withDuration: 2, delay: 0.7, options: [], animations: {
        self.cloud1.alpha = 1.0
    }, completion: nil)
    
    UIView.animate(withDuration: 2, delay: 0.9, options: [], animations: {
        self.cloud2.alpha = 1.0
    }, completion: nil)
    
    UIView.animate(withDuration: 2, delay: 1.1, options: [], animations: {
        self.cloud3.alpha = 1.0
    }, completion: nil)
    
    UIView.animate(withDuration: 2, delay: 1.3, options: [], animations: {
        self.cloud4.alpha = 1.0
    }, completion: nil)
    
    UIView.animate(withDuration: 15, delay: 1, options: [.repeat], animations: {
        self.cloud1.center.x += (self.view.bounds.width + self.cloud1.bounds.width) * 2
    }, completion: nil)
    
    UIView.animate(withDuration: 15, delay: 6, options: [.repeat], animations: {
        self.cloud2.center.x += (self.view.bounds.width + self.cloud2.bounds.width) * 2
    }, completion: nil)
    
    UIView.animate(withDuration: 15, delay: 8, options: [.repeat], animations: {
        self.cloud3.center.x += (self.view.bounds.width + self.cloud3.bounds.width) * 2
    }, completion: nil)
    
    UIView.animate(withDuration: 15, delay: 3, options: [.repeat], animations: {
        self.cloud4.center.x += (self.view.bounds.width + self.cloud4.bounds.width) * 2
    }, completion: nil)
    
    // Animate login button
    UIView.animate(withDuration: 2.0, delay: 2.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
        self.loginButton.center.y -= 30.0
        self.loginButton.alpha = 1.0
    }, completion: nil)
  }

  // MARK: further methods

  @IBAction func login() {
    UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
        self.loginButton.bounds.size.width += 80.0
    }, completion: nil)
    
    UIView.animate(withDuration: 0.30, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
        self.loginButton.center.y += 60
        self.loginButton.backgroundColor = UIColor(displayP3Red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
        
    }, completion: nil)
    
    self.spinner.center = CGPoint(x: 40, y: self.loginButton.frame.height/2)
    self.spinner.alpha = 1
    
    view.endEditing(true)
  }

  // MARK: UITextFieldDelegate

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let nextField = (textField === username) ? password : username
    nextField?.becomeFirstResponder()
    return true
  }

}

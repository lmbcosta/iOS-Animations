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
        
        // Save banner innitial position
        statusPosition = status.center
  }

  override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        heading.center.x -= view.bounds.width
        username.center.x -= view.bounds.width
        password.center.x -= view.bounds.width
    
        // heading
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseInOut], animations: {
            self.heading.center.x += self.view.bounds.width
        }, completion: nil)
    
        // username
        UIView.animate(withDuration: 2, delay: 0.5, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: [.curveEaseInOut], animations: {
            self.username.center.x += self.view.bounds.width
        }, completion: nil)
    
        // password
        UIView.animate(withDuration: 2, delay: 0.7, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: [.curveEaseInOut], animations: {
            self.password.center.x += self.view.bounds.width
        }, completion: nil)
    
        // Login
        loginButton.center.y += 30.0
        loginButton.alpha = 0
    
        // Clouds
        cloud1.alpha = 0
        cloud2.alpha = 0
        cloud3.alpha = 0
        cloud4.alpha = 0
      }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Animate clouds
        UIView.animate(withDuration: 2, delay: 0.7, options: [], animations: {
            self.cloud1.alpha = 1.0
        }, completion: nil)
        animateClouds(imageView: cloud1)
        
        UIView.animate(withDuration: 2, delay: 0.9, options: [], animations: {
            self.cloud2.alpha = 1.0
        }, completion: nil)
        animateClouds(imageView: cloud2)
        
        UIView.animate(withDuration: 2, delay: 1.1, options: [], animations: {
            self.cloud3.alpha = 1.0
        }, completion: nil)
        animateClouds(imageView: cloud3)
        
        UIView.animate(withDuration: 2, delay: 1.3, options: [], animations: {
            self.cloud4.alpha = 1.0
        }, completion: nil)
        animateClouds(imageView: cloud4)
        
        // Animate login button
        UIView.animate(withDuration: 1.5, delay: 2.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.loginButton.center.y -= 30.0
            self.loginButton.alpha = 1.0
        }, completion: nil)
  }

    // MARK: IB Actions

    @IBAction func login() {
        view.endEditing(true)
        
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginButton.bounds.size.width += 80.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.30, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginButton.center.y += 60
            self.loginButton.backgroundColor = UIColor(displayP3Red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
            
        }, completion: {_ in
            self.showMessage(index: 0)
        })
        
        self.spinner.center = CGPoint(x: 40, y: self.loginButton.frame.height/2)
        self.spinner.alpha = 1
        
    }

      // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextField = (textField === username) ? password : username
        nextField?.becomeFirstResponder()
        return true
    }
    
    // MARK: Util Functions
    
    // Function to show messages in status label
    func showMessage(index: Int) {
        label.text = messages[index]
        // Animate status label
        UIView.transition(with: status, duration: 0.5, options: [.curveEaseOut, .transitionCurlDown], animations: {
            self.status.isHidden = false
        }) { _ in
            // Make a delay of 2 seconds
            delay(2.0, completion: {
                if index < self.messages.count - 1 {
                    self.removeMessage(index: index)
                } else {
                    // reset form
                    self.resetForm()
                }
            })
        }
    }
    
    // Function to emove messages from status label
    func removeMessage(index: Int) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            self.status.center.x += self.view.frame.width
        }) { _ in
            self.status.isHidden = true
            self.status.center = self.statusPosition
            // Call next message
            self.showMessage(index: index + 1)
        }
    }
    
    func resetForm() {
        // Status bar
        UIView.transition(with: status, duration: 0.2, options: [.transitionCurlUp, .curveEaseIn], animations: {
            self.status.isHidden = true
            self.status.center = self.statusPosition
        }, completion: nil)
        
        UIView.animate(withDuration: 0.10, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.0, options: [], animations: {
            self.spinner.alpha = 0.0
            self.spinner.center = CGPoint(x: -20.0, y: 16.0)
        }, completion: nil)
        
        UIView.animate(withDuration: 0.4) {
            self.loginButton.center.y -= 60
            self.loginButton.backgroundColor = UIColor(displayP3Red: 0.63, green: 0.84, blue: 0.35, alpha: 1)
            self.loginButton.bounds.size.width -= 80.0
        }
    }
    
    // Animate clouds
    func animateClouds(imageView: UIImageView) {
        
        let cloudSpeed = view.frame.width / 30
        let cloudDistance = view.frame.width - imageView.frame.origin.x
        let duration = cloudDistance / cloudSpeed
        
        
        
        UIView.animate(withDuration: TimeInterval(duration), delay: 0.0, options: [], animations: {
            imageView.center.x += cloudDistance
        }) { _ in
            imageView.alpha = 0.0
            imageView.frame.origin.x = self.view.frame.origin.x
            UIView.animate(withDuration: 2, delay: 0.7, options: [], animations: {
                imageView.alpha = 1
            }, completion: nil)
            self.animateClouds(imageView: imageView)
        }
        
    }
}









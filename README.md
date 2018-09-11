# PhotoZnapp
Pinterest UI with pure Swift

#1.	What is PhotoZnapp

PhotoZnapp is a gallery viewer application.  Application consumes Unsplash’s public api. For more info please visit https://www.unsplash.com

PhotoZnapp written with these tools:

-	Swift 4.1
-	xCode 9.4 

#1.1 How to run project? 

-	Clone https://github.com/behrank/PhotoZnapp.git from github. 
-	Open PhotoZnapp.workspace with xCode 9.4
-	Click to run button. 
-	No need to run “pod install” command on terminal. 
-	Login process accepts any valid email address and minimum 6-character length password. Registration not required.

#2.	Features

These are the main features of PhotoZnapp:
-	Login with email and password
-	Photo gallery
-	Pinterest like display and navigation layout
-	Search on either users and photos

#3.	Technical Overview

Application uses Swift extensions and several UI’s written by me. You may find more info about application below.

#3.1 Architecture
PhotoZnapp written with Clean Swift architecture ( https://clean-swift.com/ ) instead of Apple’s MVC. 

#3.2 Network
PhotoZnapp’s network layer built with Moya and Alamofire. PhotoZnapp uses Decodable protocol to decoding API responses into struct models in order to consume API.

#3.3 Cache
PhotoZnapp uses NSCache for caching images to improve user experience and reducing Wi-Fi/mobile data usage.

#3.4 UI
PhotoZnapp layout similar with Pinterest iOS application. Uses almost same scaling and navigation animation without any 3rd party library.

PhotoZnapp also uses Lottie framework for loading animation. Lottie is an iOS, Android, and React Native library that renders After Effects animations in real time, allowing apps to use animations as easily as they use static images. Lottie is an Airbnb product. Available for free via CocoaPods.


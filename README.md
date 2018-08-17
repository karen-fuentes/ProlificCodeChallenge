# Swag Committee Challenge 
Created an app that uses prolific server to create, edit, share, checkout, and delete books from app.  

### Features
 
- User can see all books from library 
- User can edit books as they please
- User can add book to library
- Delete one book or all books from library
- Share book to Twitter or Facebook 
 
### Architecture 

Throughout this application I tried to stick to the MVC model. As I've progressed through my iOS career I have learned the importance in separation of responsibilities and to make objects less dependent from one another and polymorphic. I am still trying to perfect this craft, but I  tried to implement this as much I could throughout my project.
 
#### Avoiding Massive View Controller  

One of the issues with MVC is separating view and controller. Especially in iOS where the viewController can make this a bit convoluted. I  decided in my project to make separate views for the view controller. The views in this case will be responsible for the location of labels, buttons,  etc. and their attributes. The ViewController will be in charge of how these UI objects get their information and interact with another. One beauty of this was that I was able to use the some views more than once for different view controllers. Making my views a bit polymorphic. 

#### API Client and API Request Manager 

Another way I tried to make the code reusable is separating the api client and request manager. If we were to extend the project and make different objects or use more API’s the API request manager becomes reusable for all these cases. The bookAPIClient does all the work of creating, editing, and deleting books. While the APIRequestManager preforms the data task. 


## Demos: 

#### Add Book 
<img src="https://github.com/karen-fuentes/ProlificCodeChallenge/blob/master/images/addingBook.gif" />

#### Checkout Book 
<img src="https://github.com/karen-fuentes/ProlificCodeChallenge/blob/master/images/checkOutDemo.gif" />

#### Edit Book 
<img src="https://github.com/karen-fuentes/ProlificCodeChallenge/blob/master/images/editBook.gif" />

#### Delete One Book  
<img src="https://github.com/karen-fuentes/ProlificCodeChallenge/blob/master/images/deleteOneBook.gif" />

#### Delete All Books  
<img src="https://github.com/karen-fuentes/ProlificCodeChallenge/blob/master/images/deleteAll.gif" />

#### Share Book
<img src="https://github.com/karen-fuentes/ProlificCodeChallenge/blob/master/images/shareBookToTwitter.gif" />

#### Posted on Twitter Feed
<img src="https://github.com/karen-fuentes/ProlificCodeChallenge/blob/master/images/sharedToTwitter.jpg" width="320" />
 

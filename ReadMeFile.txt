Login page: 
1.layout - user name and About Us
2.where email and password fields with validation of mail formate and password length.
3.invalid email or password
4.user not exist.

About Us Page
1.layout - user name and Login
2.Introduction
3.Features
4.Usage
5.Contact
6.Version-2
7.Unit Testing button 

Unit Testing Page
1.layout - user name, about us and Login
2.page wise image in grid 
3.on click on image than image view is open and next and previous image button .

User detail page :(without permission)
1.layout - user name and logout
2.Fields are first name,last name,city and department(view mode)
3.Edited fields are  first name,last name,city
4.save button to save data .
5.Product list which is assign to the user.(not editable.)

User detail page :(with permission)
1.layout - product management, User management, user name and logout
2.Fields are first name,last name,city and department(view mode)
3.Edited fields are  first name,last name,city and department
4.All Fields are required.
5.save button to save data .
6.Product list which is assign to the user.
7.Delete Product from user detail page.
8.Add product  from user detail page.
9. While adding product,Select product category and than refresh brand which is available.
10.Add product and refresh product list .
11.Add new user -Fields are first name ,last name ,Email and password
12.All Fields are required and validation of mail format and min max length for first name ,last name,password 
13.If user is already added than get alert thatUser is already exist.where check email and password.

User List page 
1.layout - product management,user name and logout
2.Add user button
3.search filter
4.List of Users where column are 
>UserCode (linkable) to click on usercode than user redirect on user detail page. ,
>First Name,
 >Last name , 
>City ,
>Department , 
>Action where delete user feature .
5.Delete user :
> If user assigned any product than user can not deleted and pop up product list.
> if user does not assigned any product than use be can deleted.
6.pagination : total record, pagesize,previous page , next page and page no.

Product List page 
1.layout - user management,user name and logout
2.Add Product button
3.search filter
4.List of Product where column are 
>Product Code
>Brand Name,
 >Available Quantity 
>Used Quantity ,
>Total Quantity , 
>Action where delete and edit product .
5.Delete Product :
> If Product assigned any user than product can not deleted and pop up user list.
> if product does not assigned any user than Product can be deleted.
6.Edit Product :
>Update Product quantity .
>If user chnage Product Quantity and product quantity is less than used quantity than get alert that "Quantity should not be less than used Quantity"
7.pagination : total record, pagesize,previous page , next page and page no.
8.Product Category button
9.Product Brand Button

Product Detail Page (PopUp)

1. Add new  product from product list page 
>Product already exist
2. Edit Product from Product List page
3. Assign product from user detail page.
>Product already assinged
>Product category already assigned


Product Category
>PopUp-Get list of Active Product Category

Product Brand
>Pop-up-Get list of Active Product Brand


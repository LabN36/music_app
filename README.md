
App Flow
[Done] Invoke above API in the Flutter Application.
[Done] Fetch all Top-20 songs and store them on Database.
[Done] Display all Top-20 songs in a List from the database
[Done] On cell item, display
    a. Album image
    b. Title of the song
    c. Artist name (optional)
    d. Add to Cart – Should add the song to the cart
    e. Listen Icon – Should play the song [-] (Optional)
[WIP] On clicking a record, it should navigate to another screen which will show all details of Song.
[-] Play the song on the detail screen (Optional)


Cart management:
[Done] When any item added to cart, that should be runtime, and the user should be able to see the counter increase on the card icon on the action bar (Top right corner)
[Done] Clicking on cart, will open another screen where all cart items should load, and the user should be able to increase or decrease quantity from there.
[NA] No need to display PRICE
[Done] Clicking on Checkout display a dialog box which summarize all the items
[Done] On the dialog, clicking on DONE will clear my cart and will bring back to the home screen where I can see all 20 songs
[Done] On the dialog, clicking on CANCEL will dismiss the dialog

Notes:
[Done] API should call one time when app run for the first time, rest every time it should fetch data from the database.
[Done] Use Proper Application Architecture and a suitable coding design pattern


[Done] Better UI/UX
[Done] Proper use of state management 
[Done] Better code with [-] documentation
[-] Media player notification (Android) with Play and Pause button
[-] Proper test cases

Other Possible Optimization
1. Image loading could be optimized further based on the load
2. Uniform Theming & Typography
3. Navigation & Routing could've been improved
4. Localization can be used
5. Effective Error Handling
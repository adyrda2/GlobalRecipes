### Summary: Include screen shots or a video of your app highlighting its features
<p float="left">
  <img src="https://github.com/user-attachments/assets/aacf526e-372e-43b7-91cf-26ad1e7b1d07" width="200" height="400" />
  <img src="https://github.com/user-attachments/assets/f8fa942d-ea55-4a00-9da8-f6809cca6489" width="200" height="400" />
  <img src="https://github.com/user-attachments/assets/a470f7da-9d70-4aa6-9fc2-6dbf384ae03d" width="200" height="400" />
</p>
 Images saving to caches directory:
 <img src="https://github.com/user-attachments/assets/65c717c7-d618-45ce-894c-98f0518f1e67"/>


### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

My priorities were to ensure the core functionality was working and to write the code in a way that was maintainable, testable, and using the latest practices. I chose to use MVVM for this project, and opted for protocols and dependency injection to make unit testing easier.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I split the requirements up into several tasks and allocated a couple hours to each of them. I budgeted more time for caching as I had a couple ideas I wanted to try.

Examples of tasks:
  - Writing out the networking code and unit testing
  - Displaying the data on the screen as well as the different states (empty and malformed data)
  - Caching and unit testing

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

I considered caching the images using SwiftData as a way of caching solely to disk, and while I was able to get a proof of concept working, it seemed like it would be adding a lot of overhead. I decided to utilize NSCache for caching the images in memory and also stored them to disk using the file manager.

### Weakest Part of the Project: What do you think is the weakest part of your project?

Due to timing, the UI and error handling throughout could have been enhanced. Also, in the CachedImageManager load function, there is a lot going on, and I would consider using some helper functions to break it down and make it easier to follow.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.README

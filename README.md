# HoleFilling
### An macOS Command Line Tool
This tool contains a small image processing library that fills holes in images. That is my approach to the task that you can find in the HoleFillingTask.pdf file. 


## Input requirements
- Original and Hole mask images. Both of them have to be with the same width and height
- Hole mask image expected to be a black and white image with one hole in it, where non-black color represents the hole. Find more details about the rest of the parameters in the HoleFillingQuestion.pdf file, as well as additional questions 
 
## Answers on questions

### Question #1

>If there are m boundary pixels and n pixels inside the hole, what’s the complexity of the algorithm that fills the hole, assuming that the hole and boundary were already found? Try to also express the complexity only in terms of n. 

### Answer 
Time complexity - O(N*M)  
If we are trying to express the complexity in terms of amount pixels inside (N), the form of the hole is playing a big role.
#### For square
N * M = N * 4*N^0.5 = 4N^1.5  
Time complexity - O(N^1.5)
#### For line (worst case)
N * M = N * (2N+2) = 2*N^2 + 2*N   
Time complexity - O(N^2)

### Question #2
>Describe an algorithm that approximates the result in O(n) to a high degree of accuracy. As a bonus, implement the suggested algorithm in your library in addition to the algorithm described above. 
### Answer 
To achieve O(N) time complexity, we need to spend constant time for each pixel in the hole body. For that matter, we will use pairs with neighbor pixels (exclude unfilled hole pixels).    

We should use spiral traversal to get relevant result.  

| 1 | 2 | 3 |  
| 8 | 9 | 4 |  
| 7| 6 | 5 |  

This algorithm implemented in project: holeFiller.fillHoleApproximate(holeInformation:)

### Author: Eugene Gordenstein

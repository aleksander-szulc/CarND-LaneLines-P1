# **Finding Lane Lines on the Road** 

## Writeup

---

**Finding Lane Lines on the Road**

The goals / steps of this project are the following:

* Make a pipeline that finds lane lines on the road
* Reflect on your work in a written report


[//]: # (Image References)

[image1]: ./writeup_images/a_solidWhiteCurve.jpg "Mask"
[image2]: ./writeup_images/b_solidWhiteCurve.jpg "Color filter"
[image3]: ./writeup_images/c_solidWhiteCurve.jpg "Edges"
[image4]: ./writeup_images/d_solidWhiteCurve.jpg "Lines"
[image5]: ./writeup_images/solidWhiteCurve.jpg "Result"

---

### Reflection


### 1. Description

The pipeline consists of 5 steps. In order to test each step separately and quickly identify issues, after each step there is an image with a partial result saved to a file in `test_images_output`.

All the parameters were adjusted manually using the partial results.

#### Step 1 - Region of interest

I pick a region of interest by applying a mask on a picture. The mask is a trapezoid that leaves the line with a small margin on each side.
In order to avoid hardcoding the image size, so that the program can process different images, the trapezoid corners are calculated by taking 
proportions of the image width and height.

![Mask][image1]

#### Step 2 - Color filtering

Next there is a color selection applied, I tried to narrow down the colors as much as possible, leaving only white and yellow.

![Color filter][image2]

#### Step 3 - Canny edge detection

Next I apply Canny edge detection. In order to do that the image is converted to grayscale and gaussian blur is applied.

![Edges][image3]

#### Step 4 - Hough transform

Next there is Hought transform, which detects lines out of edges.

![Lines][image4]

#### Step 5 - Drawing lines

Last step is drawing lines. I convert the lines provided by Hough transform from `(x1, y1, x2, y2)` representation into `y = mx+b`, where `m` is the tangens of the angle, also knows as the slope, telling us what is the angle
of the line, `b`  is the intersection of the line with `x` axis.

At this point there are many noises - lines that are not the road lines, but fluorescence elements on the road. Those false lines are close to horizontal, that's why I filter them out by 
ignoring all the lines, which angle is between -20 and 20 degrees.

Then I group the lines into right and left lines, based on the negative and positive value of the slope.

I calculate the average left and right line, by calculating the average `m` and `b`.

Last part is to draw the lines. For this I'm taking the average lines and I extrapolate them from the minimum `y` to the maximum `y` of each of them.

![Result][image5]


### 2. Potential shortcomings

The main problem of this solution is color selection. This is the first element that is not working properly with any other images than those provided as examples.
RGB value of a pixel depends on many aspects like light conditions, shadows, reflections, type of camera. The same white light in one conditions can have totaly different RGB
values in different conditions. This is also evident when running the challenge.mp4, as soon as the car drives through bright road area the detected lines go nuts.

Another problem are the elements on the road that are not lines, but have the same colors. Filtering them by angle does not always work and they have a significant impact
on the final calculated line when they are very close to the car.

The last shortcoming that I discovered is that this solution is prepared only for perfectly straight road lines. In the solidYellowLeft.mp4 video we can see a moment when there
is a slight left turn, at this moment the algorithm looses its accuracy and the line starts to jump, giving an unpredictible result.


### 3. Possible improvements

The key improvement would be to resign from color selection and try to solve the problem in a more flexible way.

Another potential improvement would be to better filter out fluorescent elements, checking for example their standard deviation of the angle and distance from line.

%%new this only i have to do it
% 
% <<FILENAME.PNG>>
% 
a = imaqhwinfo;
b = arduino('COM7');
%[camera_name, camera_id, format] = getCameraInfo(a);


% Capture the video frames using the videoinput function
% You have to replace the resolution & your installed adaptor name.
%vid = videoinput(camera_name, camera_id, format);
vid = videoinput('winvideo', 2, 'YUY2_352x288');

% Set the properties of the video object
set(vid, 'FramesPerTrigger', Inf);
set(vid, 'ReturnedColorspace', 'rgb');
vid.FrameGrabInterval = 5;

%start the video aquisition here
start(vid)

% Set a loop that stop after 100 frames of aquisition
while(vid.FramesAcquired<=50000)
    
    % Get the snapshot of the current frame
    data = getsnapshot(vid);
    
    % Now to track red objects in real time
    % we have to subtract the red component 
    % from the grayscale image to extract the red components in the image.
    diff_im = imsubtract(data(:,:,1), rgb2gray(data));
    %Use a median filter to filter out noise
    diff_im = medfilt2(diff_im, [3 3]);
    % Convert the resulting grayscale image into a binary image.
    diff_im = im2bw(diff_im,0.1);
    
    % Remove all those pixels less than 300px
    diff_im = bwareaopen(diff_im,300);
    
    % Label all the connected components in the image.
    bw = bwlabel(diff_im, 8);
    
    % Here we do the image blob analysis.
    % We get a set of properties for each labeled region.
    stats = regionprops(logical(bw), 'BoundingBox', 'Centroid');
    %%
    % 
    % <<FILENAME.PNG>>
    % 
    
    % Display the image
    imshow(data)
    
    hold on
    
    %This is a loop to bound the red objects in a rectangular box.
    for object = 1:length(stats)
        bb = stats(object).BoundingBox;
        bc = stats(object).Centroid;
        rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
        plot(bc(1),bc(2), '-m+')
        a=text(bc(1)+15,bc(2), strcat('X: ', num2str(round(bc(1))), '    Y: ', num2str(round(bc(2)))));
        set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
   
           
   if (20>=(round(bc(1))))&&((round(bc(1)))>=0)
      writePWMDutyCycle (b, 10, .05);

elseif(40>=(round(bc(1))))&&((round(bc(1)))>=20)
         writePWMDutyCycle (b, 10, .10);

 
elseif(60>=(round(bc(1))))&&((round(bc(1)))>=40)
         writePWMDutyCycle (b, 10, .15);
 
   
elseif(80>=(round(bc(1))))&&((round(bc(1)))>=60)
         writePWMDutyCycle (b, 10, .20);
  
     
elseif(100>=(round(bc(1))))&&((round(bc(1)))>=80)
         writePWMDutyCycle (b, 10, .25);
   
 elseif(120>=(round(bc(1))))&&((round(bc(1)))>=100)
    writePWMDutyCycle (b, 10, .30);
 elseif(140>=(round(bc(1))))&&((round(bc(1)))>=120)
    writePWMDutyCycle (b, 10, .35);
   

 elseif(160>=(round(bc(1))))&&((round(bc(1)))>=140)
    writePWMDutyCycle (b, 10, .40);
     elseif(180>=(round(bc(1))))&&((round(bc(1)))>=160)
    writePWMDutyCycle (b, 10, .45);
     elseif(190>=(round(bc(1))))&&((round(bc(1)))>=180)
    writePWMDutyCycle (b, 10, .50);
     elseif(200>=(round(bc(1))))&&((round(bc(1)))>=190)
    writePWMDutyCycle (b, 10, .55);
         elseif(210>=(round(bc(1))))&&((round(bc(1)))>=200)
    writePWMDutyCycle (b, 10, .60);
         elseif(220>=(round(bc(1))))&&((round(bc(1)))>=210)
    writePWMDutyCycle (b, 10, .65);
         elseif(240>=(round(bc(1))))&&((round(bc(1)))>=220)
    writePWMDutyCycle (b, 10, .70);
         elseif(250>=(round(bc(1))))&&((round(bc(1)))>=240)
    writePWMDutyCycle (b, 10, .75);
         elseif(260>=(round(bc(1))))&&((round(bc(1)))>=250)
    writePWMDutyCycle (b, 10, .80);
         elseif(270>=(round(bc(1))))&&((round(bc(1)))>=260)
    writePWMDutyCycle (b, 10, .82);
         elseif(280>=(round(bc(1))))&&((round(bc(1)))>=270)
    writePWMDutyCycle (b, 10, .86);
         elseif(300>=(round(bc(1))))&&((round(bc(1)))>=280)
    writePWMDutyCycle (b, 10, .88);
         elseif(320>=(round(bc(1))))&&((round(bc(1)))>=300)
    writePWMDutyCycle (b, 10, .90);
         elseif(350>=(round(bc(1))))&&((round(bc(1)))>=320)
    writePWMDutyCycle (b, 10, .91);
         elseif(370>=(round(bc(1))))&&((round(bc(1)))>=350)
    writePWMDutyCycle (b, 10, .93);
         elseif(400>=(round(bc(1))))&&((round(bc(1)))>=370)
    writePWMDutyCycle (b, 10, .95);
    
end
    end
hold off
end
     
% Both the loops end here.

% Stop the video aquisition.
stop(vid);

% Flush all the image data stored in the memory buffer.
flushdata(vid);

% Clear all variables
clear all
sprintf('%s','That was all about Image tracking, Guess that was pretty easy :) ')

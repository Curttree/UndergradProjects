%Curtis Tremblay
%CISC 472- Assignment 3
%April 13, 2015
function[]=display_landmarks(volume,origin,landmark,value)
%display_landmarks as defined in Assignment 3 description
%   volume:3d matrix containing the voxel information for a image dataset
%   origin:3x1 vector containing the origin of the image dataset (in mm)
%   landmark:3x1 vector containing x,y,z information of landmark (in mm)
%   value:voxel value in which landmark will be marked.

%Find landmark point

%account for matlab indexing
origin=[origin(2);origin(1);origin(3)];
landmark=[landmark(2);landmark(1);landmark(3)];


dist=[1;1;1]-origin;
out=floor(landmark+dist);
for x=out(1,1)-1:out(1,1)+1
    volume(x,out(2,1),out(3,1))=value;
end
for y=out(2,1)-1:out(2,1)+1
    volume(out(1,1),y,out(3,1))=value;
end
for z=out(3,1)-1:out(3,1)+1
    volume(out(1,1),out(2,1),z)=value;
end
slice=volume(:,:,out(3,1));
firstslice=zeros(size(volume,3),190);
for counter=1:190
    for counter2=1:size(volume,3)
        firstslice(counter2,counter)=volume(out(1,1),counter,counter2);
    end
end
secondslice=zeros(190,size(volume,3));
for counter=1:190
    for counter2=1:size(volume,3)
        secondslice(counter,counter2)=volume(counter,out(2,1),counter2);
    end
end
figure
subplot(2,2,1);
imshow(firstslice,[min(min(firstslice)),max(max(firstslice))]);
title('Frontal Plane')
subplot(2,2,2);
imshow(secondslice,[min(min(secondslice)),max(max(secondslice))]);
title('Saggital Plane')
subplot(2,2,3);
imshow(slice,[min(min(slice)),max(max(slice))]);
title('Axial Plane')
end


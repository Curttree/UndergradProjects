%Curtis Tremblay
%CISC 472- Assignment 3
%April 13, 2015
function [] = segmentation_visualization( volume,origin,segmentation_file )
%Task 4: Visualization of segmentation
    fileID = fopen(segmentation_file);
    maximum=max(max(max(volume)))+1;
    maxz=0;
    while ~feof(fileID)
         line= fgets(fileID);
         A= sscanf(line,'%f,%f,%f,%f');
         actual=[A(1,1);A(2,1);A(3,1)]-origin+[1;1;1];
         if(round(actual(3,1))>=maxz)
             maxz=round(actual(3,1));
         end
         volume(round(actual(2,1)),round(actual(1,1)),round(actual(3,1)))=maximum;
    end
    out=zeros(size(volume,1),size(volume,2),size(volume,3));
    for x=1:size(volume,1)
        for y=1:size(volume,2)
            for z=1:size(volume,3)
                if volume(x,y,z)==maximum
                    out(x,y,z)=1;
                else
                    out(x,y,z)=0;
                end
            end
        end
    end
firstslice=volume(:,:,maxz-60);
secondslice=volume(:,:,maxz-50);
thirdslice=volume(:,:,maxz-40);
fourthslice=volume(:,:,maxz-30);
fifthslice=volume(:,:,maxz-20);
figure
imshow(firstslice,[min(min(firstslice)),max(max(firstslice))]);
figure
imshow(secondslice,[min(min(secondslice)),max(max(secondslice))]);
figure
imshow(thirdslice,[min(min(thirdslice)),max(max(thirdslice))]);
figure
imshow(fourthslice,[min(min(fourthslice)),max(max(fourthslice))]);
figure
imshow(fifthslice,[min(min(fifthslice)),max(max(fifthslice))]);
fclose('all');

end


%Curtis Tremblay
%CISC 472- Assignment 3
%April 13, 2015
function [out] = binary_voxel(volume,origin,segmentation_file)
%Task 5ii: Create a binary voxel
    fileID = fopen(segmentation_file);
    maximum=max(max(max(volume)))+1;
    while ~feof(fileID)
         line= fgets(fileID);
         A= sscanf(line,'%f,%f,%f,%f');
         actual=[A(1,1);A(2,1);A(3,1)]-origin+[1;1;1];
         volume(floor(actual(2,1)),floor(actual(1,1)),floor(actual(3,1)))=maximum;
    end
    out=zeros(size(volume,1),size(volume,2),154);
    for x=1:size(volume,1)
        for y=1:size(volume,2)
            for z=1:154
                if volume(x,y,z)==maximum
                    out(x,y,z)=1;
                else
                    out(x,y,z)=0;
                end
            end
        end
    end
end


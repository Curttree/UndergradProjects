%Curtis Tremblay
%CISC 472- Assignment 3
%April 13, 2015
function [ ] = create_cartilage( mri,cartilage,origin)
%Task 5 iii: Create voxel volume containing cartilage info
cartilagemask=zeros(sum(sum(sum(cartilage))),4);
count=1;
for x=1:size(cartilage,1)
    for y=1:size(cartilage,2)
        for z=1:size(cartilage,3)
            if cartilage(y,x,z)==1
                %Transfer back to proper coordinate system
                cartilagemask(count,1:3)=[x,y,z]-[1,1,1]+origin';
                cartilagemask(count,4)=mri(y,x,z);
                count=count+1;
            end
        end
    end
end
dlmwrite('Cartilage_inMRI_mask.txt',cartilagemask,',');
end


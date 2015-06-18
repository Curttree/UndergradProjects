%Curtis Tremblay
%CISC 472- Assignment 3
%April 13, 2015
function [ ] = taskFive(  )
%Task 5: Determine Cartilage Volume
    [q,rotation,translation]=horns([-26.14317,-93.6106,-643.297;
        60.6069,-112.42,-650.373;
        9.08479,-133.96,-638.603;
        42.0235,-75.6846,-656.996;
        -6.67128,-71.681,-649.853],[-34.5029,56.4774,-59.9131;
        52.4359,38.6747,-67.2723;
        1.56049,17.2319,-52.8177;
        33.0425,74.4548,-76.3488;
        -15.5747,78.1617,-68.5479]);
    fileID = fopen('CT_mask.txt');
    count=0;
    actualvals=zeros(288076,4);
    while ~feof(fileID)
         count=count+1;
         line= fgets(fileID);
         A= sscanf(line,'%f,%f,%f,%f');
         actualvals(count,1:3)=A(1:3)';
         actualvals(count,4)=A(4,1);
    end
    Bone_In_MRI_mask=zeros(count,4);
    for x=1:count
       Bone_In_MRI_mask(x,1:3)= actualvals(x,1:3)*rotation'+translation';
       Bone_In_MRI_mask(x,4)=actualvals(x,4);
    end
    dlmwrite('Bone_In_MRI_mask.txt',Bone_In_MRI_mask,',');
    disp('Done')

end


%Curtis Tremblay
%CISC 472- Assignment 3
%April 13, 2015
function [ volume_CT ] = taskSix( volume_CT )
%Task 6 of Assignment 3 :CT of the Future
%   Follows guidelines as defined in assignment description.

%Create Mask
[q,rotation,translation,rms]=horns([-34.5029,56.4774,-59.9131;
        52.4359,38.6747,-67.2723;
        1.56049,17.2319,-52.8177;
        33.0425,74.4548,-76.3488;
        -15.5747,78.1617,-68.5479],[-26.14317,-93.6106,-643.297;
        60.6069,-112.42,-650.373;
        9.08479,-133.96,-638.603;
        42.0235,-75.6846,-656.996;
        -6.67128,-71.681,-649.853])
    fileID = fopen('Cartilage_inMRI_mask.txt');
    count=0;
    actualvals=zeros(288076,4);
    while ~feof(fileID)
         count=count+1;
         line= fgets(fileID);
         A= sscanf(line,'%f,%f,%f,%f');
         actualvals(count,1:3)=A(1:3)';
         actualvals(count,4)=A(4,1);
    end
    Cartilage_inCT_mask=zeros(count,4);
    for x=1:count
       Cartilage_inCT_mask(x,1:3)= actualvals(x,1:3)*rotation'+translation';
       Cartilage_inCT_mask(x,4)=actualvals(x,4);
    end
    dlmwrite('Cartilage_inCT_mask.txt',Cartilage_inCT_mask,',');
    
    %Verify
    segmentation_visualization(volume_CT,[-83.3998;-209.4639;-803.00],'Cartilage_inCT_mask.txt')

    %Create new Voxel Volume
    for x=1:size(Cartilage_inCT_mask,1)
        coord=floor([Cartilage_inCT_mask(x,2),Cartilage_inCT_mask(x,1),Cartilage_inCT_mask(x,3)]+[1,1,1]-[-209.4639,-83.3998,-803.00])
        volume_CT(coord(1,1),coord(1,2),coord(1,3))=2000;
    end
    
    
    %Save Voxel Volume
    for x=1:299
        filename=strcat(sprintf('Future_CT_Bin/knee_ct_new_%d.bin',x-1));
        fileID = fopen(filename,'w');
        fwrite(fileID,volume_CT(:,:,x),'int16');
    end
    fclose('all');
    
    
    volume_CT_new=read_data('Future_CT_Bin/knee_ct_new_',299,'int16');

    %Display slices
    firstslice=volume_CT_new(:,:,140);
    secondslice=volume_CT_new(:,:,150);
    thirdslice=volume_CT_new(:,:,160);
    figure
    subplot(2,2,1)
    imshow(firstslice,[min(min(firstslice)),max(max(firstslice))]);
    subplot(2,2,2)
    imshow(secondslice,[min(min(secondslice)),max(max(secondslice))]);
    subplot(2,2,3)
    imshow(thirdslice,[min(min(thirdslice)),max(max(thirdslice))]);
    
    firstslice=zeros(190,299);
    secondslice=zeros(190,299);
    thirdslice=zeros(190,299);
    for counter=1:190
        for counter2=1:299
          firstslice(counter,counter2)=volume_CT_new(90,counter,counter2);
          secondslice(counter,counter2)=volume_CT_new(100,counter,counter2);
          thirdslice(counter,counter2)=volume_CT_new(110,counter,counter2);
        end
    end
    figure
    subplot(2,2,1)
    imshow(firstslice,[min(min(firstslice)),max(max(firstslice))]);
    subplot(2,2,2)
    imshow(secondslice,[min(min(secondslice)),max(max(secondslice))]);
    subplot(2,2,3)
    imshow(thirdslice,[min(min(thirdslice)),max(max(thirdslice))]);
    
    firstslice=zeros(190,299);
    secondslice=zeros(190,299);
    thirdslice=zeros(190,299);
    for counter=1:190
        for counter2=1:299
          firstslice(counter,counter2)=volume_CT_new(counter,110,counter2);
          secondslice(counter,counter2)=volume_CT_new(counter,120,counter2);
          thirdslice(counter,counter2)=volume_CT_new(counter,130,counter2);
        end
    end
    figure
    subplot(2,2,1)
    imshow(firstslice,[min(min(firstslice)),max(max(firstslice))]);
    subplot(2,2,2)
    imshow(secondslice,[min(min(secondslice)),max(max(secondslice))]);
    subplot(2,2,3)
    imshow(thirdslice,[min(min(thirdslice)),max(max(thirdslice))]);
    disp('Done')
end


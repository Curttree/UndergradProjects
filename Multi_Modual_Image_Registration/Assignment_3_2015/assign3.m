%Curtis Tremblay
%CISC 472- Assignment 3
%February 26, 2015

%Initialize
clear all
close all
clc
%%
%Task One
volume_CT=read_data('CT_Bin/knee_ct_',299,'int16');

firstslice=zeros(190,299);
for counter=1:190
    for counter2=1:299
        firstslice(counter,counter2)=volume_CT(115,counter,counter2);
    end
end
secondslice=volume_CT(:,:,50);
thirdslice=volume_CT(:,:,115);
figure
imshow(firstslice,[min(min(firstslice)),max(max(firstslice))]);
figure
imshow(secondslice,[min(min(secondslice)),max(max(secondslice))]);
figure
imshow(thirdslice,[min(min(thirdslice)),max(max(thirdslice))]);

volume_MRI=read_data('MRI_Bin/knee_mri_',154,'uint16');

firstslice=zeros(190,154);
for counter=1:190
    for counter2=1:154
        firstslice(counter,counter2)=volume_MRI(115,counter,counter2);
    end
end
secondslice=volume_MRI(:,:,50);
thirdslice=volume_MRI(:,:,115);
figure
imshow(firstslice,[min(min(firstslice)),max(max(firstslice))]);
figure
imshow(secondslice,[min(min(secondslice)),max(max(secondslice))]);
figure
imshow(thirdslice,[min(min(thirdslice)),max(max(thirdslice))]);
%%
%Task Two CT
display_landmarks(volume_CT,[-83.3998;-209.4639;-803.00],[-26.14317;-93.6106;-643.297],3000);
display_landmarks(volume_CT,[-83.3998;-209.4639;-803.00],[9.08479;-133.96;-638.603],3000);
display_landmarks(volume_CT,[-83.3998;-209.4639;-803.00],[60.6069;-112.42;-650.373],3000);
display_landmarks(volume_CT,[-83.3998;-209.4639;-803.00],[42.0235;-75.6846;-656.996],3000);
display_landmarks(volume_CT,[-83.3998;-209.4639;-803.00],[-6.67128;-71.681;-649.853],3000);

%%
%Task Two MRI
display_landmarks(volume_MRI,[-89.7749329;-48.4298096;-167.5021362],[-34.5029;56.4774;-59.9131],4000);
display_landmarks(volume_MRI,[-89.7749329;-48.4298096;-167.5021362],[52.4359;38.6747;-67.2723],4000);
display_landmarks(volume_MRI,[-89.7749329;-48.4298096;-167.5021362],[1.56049;17.2319;-52.8177],4000);
display_landmarks(volume_MRI,[-89.7749329;-48.4298096;-167.5021362],[33.0425;74.4548;-76.3488],4000);
display_landmarks(volume_MRI,[-89.7749329;-48.4298096;-167.5021362],[-15.5747;78.1617;-68.5479],4000);

%%
%Task Three i
[q1,r1,t1,rms]=horns([1,1,0;0,0,0],[1,0,0;0,1,0])
%% Task Three ii
[q,rotation,translation,rms]=horns([-26.14317,-93.6106,-643.297;
        60.6069,-112.42,-650.373;
        9.08479,-133.96,-638.603;
        42.0235,-75.6846,-656.996;
        -6.67128,-71.681,-649.853],[-34.5029,56.4774,-59.9131;
        52.4359,38.6747,-67.2723;
        1.56049,17.2319,-52.8177;
        33.0425,74.4548,-76.3488;
        -15.5747,78.1617,-68.5479])

new_point=rotation*[-26.14317,-93.6106,-643.297]'+translation;
display_landmarks(volume_MRI,[-89.7749329;-48.4298096;-167.5021362],new_point,2000);
%% Task Three iii
[q2,rotation2,translation2,rms2]=horns([-34.5029,56.4774,-59.9131;
        52.4359,38.6747,-67.2723;
        1.56049,17.2319,-52.8177;
        33.0425,74.4548,-76.3488;
        -15.5747,78.1617,-68.5479],[-26.14317,-93.6106,-643.297;
        60.6069,-112.42,-650.373;
        9.08479,-133.96,-638.603;
        42.0235,-75.6846,-656.996;
        -6.67128,-71.681,-649.853])

new_point2=rotation2*[-34.5029,56.4774,-59.9131]'+translation2;
display_landmarks(volume_CT,[-83.3998;-209.4639;-803.00],new_point2,5000);
%%
%Task Four ii
segmentation_visualization(volume_CT,[-83.3998;-209.4639;-803.00],'CT_mask.txt')
%%
%Task Four iii
segmentation_visualization(volume_MRI,[-89.7749329;-48.4298096;-167.5021362],'MRI_mask.txt')
%%
%Task Five
taskFive();
%%
segmentation_visualization(volume_MRI,[-89.7749329;-48.4298096;-167.5021362],'Bone_In_MRI_mask.txt')
%%
binaryBone=binary_voxel(volume_MRI,[-89.7749329;-48.4298096;-167.5021362],'Bone_In_MRI_mask.txt');
binaryMRI=binary_voxel(volume_MRI,[-89.7749329;-48.4298096;-167.5021362],'MRI_mask.txt');
cartilage=binaryMRI-binaryBone;
create_cartilage(volume_MRI,cartilage,[-89.7749329;-48.4298096;-167.5021362]);
%%
segmentation_visualization(volume_MRI,[-89.7749329;-48.4298096;-167.5021362],'Cartilage_inMRI_mask.txt')
%%
%Task Six
newCT=taskSix(volume_CT);
%%
%Task Six DICOM
taskSixDicom(newCT);
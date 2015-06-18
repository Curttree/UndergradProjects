%Curtis Tremblay
%CISC 472- Assignment 3
%April 13, 2015
function [ volume ] = read_data( prefix,nr,type )
%read_data as defined in Assignment 3 Task 1
%   volume:3d matrix containing the voxel information for an image dataset
%   prefix:common prefix for all images in the dataset
%   nr: number of slices in image dataset
%   type: pixel type of dataset
volume = zeros(190,190,nr);
for counter=0:nr-1
    filename=strcat(prefix,sprintf('%d.bin',counter));
    fileID = fopen(filename);
    volume(:,:,counter+1) = fread(fileID,[190,190],type);
end
fclose('all');
end


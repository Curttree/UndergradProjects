%Curtis Tremblay
%CISC 472- Assignment 3
%April 13, 2015
function [  ] = taskSixDicom( newCT )
%TASK 6: Part 4
for counter=0:298
    if counter<10
        filename=strcat(sprintf('CT_Dicom/CT_Knee_000%d.dcm',counter));
    elseif counter<100
        filename=strcat(sprintf('CT_Dicom/CT_Knee_00%d.dcm',counter));
    else
        filename=strcat(sprintf('CT_Dicom/CT_Knee_0%d.dcm',counter));
    end
    slice = dicomread(filename);
    slicecopy=slice;
    slicecopy = uint16(newCT(:,:,counter+1));
    if counter<10
        newfilename=strcat(sprintf('CT_new_Dicom/CT_Knee_new_000%d.dcm',counter));
    elseif counter<100
        newfilename=strcat(sprintf('CT_new_Dicom/CT_Knee_new_00%d.dcm',counter));
    else
        newfilename=strcat(sprintf('CT_new_Dicom/CT_Knee_new_0%d.dcm',counter));
    end
    dicomwrite(slicecopy,newfilename);
end

end


%Curtis Tremblay
%CISC 472- Assignment 3
%April 13, 2015
function [q,rotation,translation,rms ] = horns( P,X )
%TASK 3: Multi-modal Registration using a Pair-Point Algorithm

%STEP1: compute centre of mass
    u_p=zeros(1,3);
    u_x=zeros(1,3);
    for m=1:size(P,1)
        u_p=u_p+[P(m,1),P(m,2),P(m,3)];
    end
    u_p=u_p/size(P,1);
    for n=1:size(X,1)
        u_x=u_x+[X(n,1),X(n,2),X(n,3)];
    end
    u_x=u_x/size(X,1);
    
%STEP2: Center
    Phat=zeros(size(P,1),size(P,2));
    Xhat=zeros(size(P,1),size(P,2));
    for m=1:size(P,1)
      Phat(m,1)=P(m,1)-u_p(1);
      Phat(m,2)=P(m,2)-u_p(2);
      Phat(m,3)=P(m,3)-u_p(3);
    end
    for n=1:size(X,1)
     Xhat(n,1)=X(n,1)-u_x(1);
     Xhat(n,2)=X(n,2)-u_x(2);
     Xhat(n,3)=X(n,3)-u_x(3);
    end
    
%STEP3: Cross-Variance Matrix
    crossCov = Phat'*Xhat;
%STEP4: Anti-Symmetric Matrix
    anti=crossCov-crossCov';
    col=[anti(2,3);anti(3,1);anti(1,2)];
%STEP5: SYMMETRIC MATRIX
    final=crossCov+crossCov'-trace(crossCov)*[1,0,0;0,1,0;0,0,1];
    Quat=[trace(crossCov),col(1),col(2),col(3);col(1),final(1,1),final(1,2),final(1,3);col(2),final(2,1),final(2,2),final(2,3);col(3),final(3,1),final(3,2),final(3,3)];
    [V D]=eig(Quat);
    q = V(:,4);
    q0=q(1);
    q1=q(2);
    q2=q(3);
    q3=q(4);
%Calculate Rotation
    rotation=[q0.^2+q1.^2-q2.^2-q3.^2,2*(q1*q2-q0*q3),2*(q1*q3+q0*q2);
        2*(q1*q2+q0*q3),q0.^2+q2.^2-q1.^2-q3.^2,2*(q2*q3-q0*q1);
        2*(q1*q3-q0*q2),2*(q2*q3+q0*q1),q0.^2+q3.^2-q1.^2-q2.^2];
%Calculate Translation 
    translation = u_x' - rotation*u_p';
%Calculate Root Mean Square Error
     rms =0;
    for i=1:size(P,1)
        d = ((X(i,:))' - (rotation*(P(i,:))' + translation));
        rms = rms + norm(d).^2;
    end 
    rms=sqrt(rms/size(P,1));
end


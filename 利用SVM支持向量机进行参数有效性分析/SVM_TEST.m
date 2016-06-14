clc;
clear all;

load reAD_classification_test.mat;

%X=X(:,1:12);%1-12����ֻ�����ȥ���м���
%X=X(:,13:48);%13-48����ֻ��DTI����ȥ���м���
%X=X(:,49:104);%49-104����ֻ��GMM����ȥ���м���
%X=X(:,1:48);%1-12����ֻ�������DTIȥ���м���
%X=X(:,13:104);%49-104����ֻ��GMM����ȥ���м���
for num=1:10
    for i=1:10
        
        SVMModel = fitcsvm(X,Y,'CrossVal','on','ClassNames',{'NC','AD'},'Standardize',true);
        
        classLoss(i,1:10)=kfoldLoss(SVMModel,'mode','individual');
    end
    
    for j=1:10
        classLoss(11,j)=mean(classLoss(1:10,j));
    end
    total(1,num)=1-mean(classLoss(11,j));
end
% %vol
% load AD_classsification_testvol;
%
% for i=1:10
%
% SVMModel = fitcsvm(X,Y,'CrossVal','on','ClassNames',{'NC','AD'},'Standardize',true);
%
% classLossvol(i,1:10)=kfoldLoss(SVMModel,'mode','individual');
% end
%
% for i=1:10
% classLossvol(11,i)=mean(classLossvol(1:10,i));
% end
% %fa
% load AD_classsification_testfa;
%
% for i=1:10
%
% SVMModel = fitcsvm(X,Y,'CrossVal','on','ClassNames',{'NC','AD'},'Standardize',true);
%
% classLossfa(i,1:10)=kfoldLoss(SVMModel,'mode','individual');
% end
%
% for i=1:10
% classLossfa(11,i)=mean(classLossfa(1:10,i));
% end
% %adc
% load AD_classsification_testadc;
%
% for i=1:10
%
% SVMModel = fitcsvm(X,Y,'CrossVal','on','ClassNames',{'NC','AD'},'Standardize',true);
%
% classLossadc(i,1:10)=kfoldLoss(SVMModel,'mode','individual');
% end
%
% for i=1:10
% classLossadc(11,i)=mean(classLossadc(1:10,i));
% end
% %rd
% load AD_classsification_testrd;
%
% for i=1:10
%
% SVMModel = fitcsvm(X,Y,'CrossVal','on','ClassNames',{'NC','AD'},'Standardize',true);
%
% classLossrd(i,1:10)=kfoldLoss(SVMModel,'mode','individual');
% end
%
% for i=1:10
% classLossrd(11,i)=mean(classLossrd(1:10,i));
% end
% %mk
% load AD_classsification_testmk;
%
% for i=1:10
%
% SVMModel = fitcsvm(X,Y,'CrossVal','on','ClassNames',{'NC','AD'},'Standardize',true);
%
% classLossmk(i,1:10)=kfoldLoss(SVMModel,'mode','individual');
% end
%
% for i=1:10
% classLossmk(11,i)=mean(classLossmk(1:10,i));
% end
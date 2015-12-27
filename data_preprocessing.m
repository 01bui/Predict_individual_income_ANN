% workclass={'Private', 'Self-emp-not-inc', 'Self-emp-inc', 'Federal-gov', 'Local-gov', 'State-gov', 'Without-pay', 'Never-worked'}; 
% education={'Bachelors', 'Some-college', '11th', 'HS-grad', 'Prof-school', 'Assoc-acdm', 'Assoc-voc', '9th, 7th-8th', '12th', 'Masters', '1st-4th', '10th', 'Doctorate', '5th-6th', 'Preschool'}; 
% marital_status={'Married-civ-spouse', 'Divorced', 'Never-married', 'Separated', 'Widowed', 'Married-spouse-absent', 'Married-AF-spouse'}; 
% occupation={'Tech-support', 'Craft-repair', 'Other-service', 'Sales', 'Exec-managerial', 'Prof-specialty', 'Handlers-cleaners', 'Machine-op-inspct', 'Adm-clerical', 'Farming-fishing', 'Transport-moving', 'Priv-house-serv', 'Protective-serv', 'Armed-Forces'}; 
% relationship={'Wife', 'Own-child', 'Husband', 'Not-in-family', 'Other-relative', 'Unmarried'}; 
% race={'White', 'Asian-Pac-Islander', 'Amer-Indian-Eskimo', 'Other, Black'}; 
% sex={'Female', 'Male'}; 
% native_country={ 'United-States', 'Cambodia', 'England', 'Puerto-Rico', 'Canada', 'Germany', 'Outlying-US(Guam-USVI-etc)', 'India', 'Japan', 'Greece', 'South', 'China', 'Cuba', 'Iran', 'Honduras', 'Philippines', 'Italy', 'Poland', 'Jamaica', 'Vietnam', 'Mexico', 'Portugal', 'Ireland', 'France', 'Dominican-Republic', 'Laos', 'Ecuador', 'Taiwan', 'Haiti', 'Columbia', 'Hungary', 'Guatemala', 'Nicaragua', 'Scotland', 'Thailand', 'Yugoslavia', 'El-Salvador', 'Trinadad&Tobago', 'Peru', 'Hong', 'Holand-Netherlands'}; 
% income={'<=50K','>50K'}; 
%data={age,workclass,fnlwgt,education,education_num,marital_status,occupation,relationship,race,sex,capital_gain,capital_loss,hours_per_week,native_country,income}; 

clear all;
clc;

%load train data from adult.data. 
disp('load train data...'); 
fid=fopen('adult.data','r'); 
rawdata=textscan(fid,'%f%s%f%s%f%s%s%s%s%s%f%f%f%s%s','delimiter',','); 
fclose(fid); 

disp('preprocessing data...'); 
%get age column
disp('get age data...'); 
age = rawdata{1,1};
minage = min(age);
maxage = max(age);
for i = 1:1:size(age,1)
    age(i) = (age(i) - minage)/(maxage - minage);
end

%get workclass column
disp('get workclass data...'); 
workclass = [];
tempdata = rawdata{1,2};
var = unique(tempdata);
for i = 1:1:size(tempdata,1)
    if strcmp(tempdata(i), var(1)) == 1
        workclass = [workclass; 0 0 0 0];
    elseif strcmp(tempdata(i), var(2)) == 1 
        workclass = [workclass; 0 0 0 1];
    elseif strcmp(tempdata(i), var(3)) == 1
        workclass = [workclass; 0 0 1 0];    
    elseif strcmp(tempdata(i), var(4)) == 1
        workclass = [workclass; 0 0 1 1];    
    elseif strcmp(tempdata(i), var(5)) == 1
        workclass = [workclass; 0 1 0 0];
    elseif strcmp(tempdata(i), var(6)) == 1
        workclass = [workclass; 0 1 0 1];    
    elseif strcmp(tempdata(i), var(7)) == 1
        workclass = [workclass; 0 1 1 0];     
    elseif strcmp(tempdata(i), var(8)) == 1
        workclass = [workclass; 0 1 1 1];
    elseif strcmp(tempdata(i), var(9)) == 1
        workclass = [workclass; 1 0 0 0];
    end
end

%get fnlwgt column
disp('get fnlwgt data...'); 
fnlwgt = rawdata{1,3};
minfnlwgt = min(fnlwgt);
maxfnlwgt = max(fnlwgt);
for i = 1:1:size(fnlwgt,1)
    fnlwgt(i) = (fnlwgt(i) - minfnlwgt)/(maxfnlwgt - minfnlwgt);
end

%get education column
disp('get education data...'); 
education = [];
tempdata = rawdata{1,4};
var = unique(tempdata);
for i = 1:1:size(tempdata,1)
    if strcmp(tempdata(i), var(1)) == 1
        education = [education; 0 0 0 0];
    elseif strcmp(tempdata(i), var(2)) == 1 
        education = [education; 0 0 0 1];
    elseif strcmp(tempdata(i), var(3)) == 1
        education = [education; 0 0 1 0];    
    elseif strcmp(tempdata(i), var(4)) == 1
        education = [education; 0 0 1 1];    
    elseif strcmp(tempdata(i), var(5)) == 1
        education = [education; 0 1 0 0];
    elseif strcmp(tempdata(i), var(6)) == 1
        education = [education; 0 1 0 1];    
    elseif strcmp(tempdata(i), var(7)) == 1
        education = [education; 0 1 1 0];     
    elseif strcmp(tempdata(i), var(8)) == 1
        education = [education; 0 1 1 1];
    elseif strcmp(tempdata(i), var(9)) == 1
        education = [education; 1 0 0 0];
    elseif strcmp(tempdata(i), var(10)) == 1
        education = [education; 1 0 0 1];
    elseif strcmp(tempdata(i), var(11)) == 1
        education = [education; 1 0 1 0];
    elseif strcmp(tempdata(i), var(12)) == 1
        education = [education; 1 0 1 1];
    elseif strcmp(tempdata(i), var(13)) == 1
        education = [education; 1 1 0 0];        
    elseif strcmp(tempdata(i), var(14)) == 1
        education = [education; 1 1 0 1];     
    elseif strcmp(tempdata(i), var(15)) == 1
        education = [education; 1 1 1 0];  
    elseif strcmp(tempdata(i), var(16)) == 1
        education = [education; 1 1 1 1];          
    end
end

%get education-num column
disp('get education-num data...'); 
educationnum = rawdata{1,5};
mineducationnum = min(educationnum);
maxeducationnum = max(educationnum);
for i = 1:1:size(educationnum,1)
    educationnum(i) = (educationnum(i) - mineducationnum)/(maxeducationnum - mineducationnum);
end

%get marital_status column
disp('get marital_status data...'); 
marital = [];
tempdata = rawdata{1,6};
var = unique(tempdata);
for i = 1:1:size(tempdata,1)
    if strcmp(tempdata(i), var(1)) == 1
        marital = [marital; 0 0 0];
    elseif strcmp(tempdata(i), var(2)) == 1 
        marital = [marital; 0 0 1];
    elseif strcmp(tempdata(i), var(3)) == 1
        marital = [marital; 0 1 0];    
    elseif strcmp(tempdata(i), var(4)) == 1
        marital = [marital; 0 1 1];    
    elseif strcmp(tempdata(i), var(5)) == 1
        marital = [marital; 1 0 0];
    elseif strcmp(tempdata(i), var(6)) == 1
        marital = [marital; 1 0 1];    
    elseif strcmp(tempdata(i), var(7)) == 1
        marital = [marital; 1 1 0];     
    end
end

%get occupation column
disp('get occupation data...'); 
occupation = [];
tempdata = rawdata{1,7};
var = unique(tempdata);
for i = 1:1:size(tempdata,1)
    if strcmp(tempdata(i), var(1)) == 1
        occupation = [occupation; 0 0 0 0];
    elseif strcmp(tempdata(i), var(2)) == 1 
        occupation = [occupation; 0 0 0 1];
    elseif strcmp(tempdata(i), var(3)) == 1
        occupation = [occupation; 0 0 1 0];    
    elseif strcmp(tempdata(i), var(4)) == 1
        occupation = [occupation; 0 0 1 1];    
    elseif strcmp(tempdata(i), var(5)) == 1
        occupation = [occupation; 0 1 0 0];
    elseif strcmp(tempdata(i), var(6)) == 1
        occupation = [occupation; 0 1 0 1];    
    elseif strcmp(tempdata(i), var(7)) == 1
        occupation = [occupation; 0 1 1 0];     
    elseif strcmp(tempdata(i), var(8)) == 1
        occupation = [occupation; 0 1 1 1];
    elseif strcmp(tempdata(i), var(9)) == 1
        occupation = [occupation; 1 0 0 0];
    elseif strcmp(tempdata(i), var(10)) == 1
        occupation = [occupation; 1 0 0 1];
    elseif strcmp(tempdata(i), var(11)) == 1
        occupation = [occupation; 1 0 1 0];
    elseif strcmp(tempdata(i), var(12)) == 1
        occupation = [occupation; 1 0 1 1];
    elseif strcmp(tempdata(i), var(13)) == 1
        occupation = [occupation; 1 1 0 0];        
    elseif strcmp(tempdata(i), var(14)) == 1
        occupation = [occupation; 1 1 0 1];     
    elseif strcmp(tempdata(i), var(15)) == 1
        occupation = [occupation; 1 1 1 0];         
    end
end

%get relationship column
disp('get relationship data...'); 
relationship = [];
tempdata = rawdata{1,8};
var = unique(tempdata);
for i = 1:1:size(tempdata,1)
    if strcmp(tempdata(i), var(1)) == 1
        relationship = [relationship; 0 0 0];
    elseif strcmp(tempdata(i), var(2)) == 1 
        relationship = [relationship; 0 0 1];
    elseif strcmp(tempdata(i), var(3)) == 1
        relationship = [relationship; 0 1 0];    
    elseif strcmp(tempdata(i), var(4)) == 1
        relationship = [relationship; 0 1 1];    
    elseif strcmp(tempdata(i), var(5)) == 1
        relationship = [relationship; 1 0 0];
    elseif strcmp(tempdata(i), var(6)) == 1
        relationship = [relationship; 1 0 1];    
    end
end

%get race column
disp('get race data...'); 
race = [];
tempdata = rawdata{1,9};
var = unique(tempdata);
for i = 1:1:size(tempdata,1)
    if strcmp(tempdata(i), var(1)) == 1
        race = [race; 0 0 0];
    elseif strcmp(tempdata(i), var(2)) == 1 
        race = [race; 0 0 1];
    elseif strcmp(tempdata(i), var(3)) == 1
        race = [race; 0 1 0];    
    elseif strcmp(tempdata(i), var(4)) == 1
        race = [race; 0 1 1];    
    elseif strcmp(tempdata(i), var(5)) == 1
        race = [race; 1 0 0];
    end
end

%get sex column
disp('get sex data...'); 
sex = [];
tempdata = rawdata{1,10};
var = unique(tempdata);
for i = 1:1:size(tempdata,1)
    if strcmp(tempdata(i), var(1)) == 1
        sex = [sex; 0];
    elseif strcmp(tempdata(i), var(2)) == 1 
        sex = [sex; 1];   
    end
end

%get capital-gain column
disp('get capital-gain data...'); 
cgain = rawdata{1,11};
mincgain = min(cgain);
maxcgain = max(cgain);
for i = 1:1:size(cgain,1)
    cgain(i) = (cgain(i) - mincgain)/(maxcgain - mincgain);
end

%get capital-loss column
disp('get capital-loss data...'); 
closs = rawdata{1,12};
mincloss = min(closs);
maxcloss = max(closs);
for i = 1:1:size(closs,1)
    closs(i) = (closs(i) - mincloss)/(maxcloss - mincloss);
end

%get hours-per-week column
disp('get hours-per-week data...'); 
hpw = rawdata{1,13};
minhpw = min(hpw);
maxhpw = max(hpw);
for i = 1:1:size(hpw,1)
    hpw(i) = (hpw(i) - minhpw)/(maxhpw - minhpw);
end

%get native_country column
disp('get native_country data...'); 
country = [];
tempdata = rawdata{1,14};
var = unique(tempdata);
for i = 1:1:size(tempdata,1)
    if strcmp(tempdata(i), var(1)) == 1
        country = [country;0 0 0 0 0 0];
    elseif strcmp(tempdata(i), var(2)) == 1 
        country = [country;0 0 0 0 0 1];
    elseif strcmp(tempdata(i), var(3)) == 1
        country = [country;0 0 0 0 1 0];    
    elseif strcmp(tempdata(i), var(4)) == 1
        country = [country;0 0 0 0 1 1];    
    elseif strcmp(tempdata(i), var(5)) == 1
        country = [country;0 0 0 1 0 0];
    elseif strcmp(tempdata(i), var(6)) == 1
        country = [country;0 0 0 1 0 1];    
    elseif strcmp(tempdata(i), var(7)) == 1
        country = [country;0 0 0 1 1 0];     
    elseif strcmp(tempdata(i), var(8)) == 1
        country = [country;0 0 0 1 1 1];
    elseif strcmp(tempdata(i), var(9)) == 1
        country = [country;0 0 1 0 0 0];
    elseif strcmp(tempdata(i), var(10)) == 1
        country = [country;0 0 1 0 0 1];
    elseif strcmp(tempdata(i), var(11)) == 1
        country = [country;0 0 1 0 1 0];
    elseif strcmp(tempdata(i), var(12)) == 1
        country = [country;0 0 1 0 1 1];
    elseif strcmp(tempdata(i), var(13)) == 1
        country = [country;0 0 1 1 0 0];        
    elseif strcmp(tempdata(i), var(14)) == 1
        country = [country;0 0 1 1 0 1];     
    elseif strcmp(tempdata(i), var(15)) == 1
        country = [country;0 0 1 1 1 0];  
    elseif strcmp(tempdata(i), var(16)) == 1
        country = [country;0 0 1 1 1 1];   
    elseif strcmp(tempdata(i), var(17)) == 1
        country = [country;0 1 0 0 0 0];
    elseif strcmp(tempdata(i), var(18)) == 1 
        country = [country;0 1 0 0 0 1];
    elseif strcmp(tempdata(i), var(19)) == 1
        country = [country;0 1 0 0 1 0];    
    elseif strcmp(tempdata(i), var(20)) == 1
        country = [country;0 1 0 0 1 1];    
    elseif strcmp(tempdata(i), var(21)) == 1
        country = [country;0 1 0 1 0 0];
    elseif strcmp(tempdata(i), var(22)) == 1
        country = [country;0 1 0 1 0 1];    
    elseif strcmp(tempdata(i), var(23)) == 1
        country = [country;0 1 0 1 1 0];     
    elseif strcmp(tempdata(i), var(24)) == 1
        country = [country;0 1 0 1 1 1];
    elseif strcmp(tempdata(i), var(25)) == 1
        country = [country;0 1 1 0 0 0];
    elseif strcmp(tempdata(i), var(26)) == 1
        country = [country;0 1 1 0 0 1];
    elseif strcmp(tempdata(i), var(27)) == 1
        country = [country;0 1 1 0 1 0];
    elseif strcmp(tempdata(i), var(28)) == 1
        country = [country;0 1 1 0 1 1];
    elseif strcmp(tempdata(i), var(13)) == 1
        country = [country;0 1 1 1 0 0];        
    elseif strcmp(tempdata(i), var(29)) == 1
        country = [country;0 1 1 1 0 1];     
    elseif strcmp(tempdata(i), var(30)) == 1
        country = [country;0 1 1 1 1 0];  
    elseif strcmp(tempdata(i), var(31)) == 1
        country = [country;0 1 1 1 1 1];   
    elseif strcmp(tempdata(i), var(32)) == 1
        country = [country;1 0 0 0 0 0];
    elseif strcmp(tempdata(i), var(33)) == 1 
        country = [country;1 0 0 0 0 1];
    elseif strcmp(tempdata(i), var(34)) == 1
        country = [country;1 0 0 0 1 0];    
    elseif strcmp(tempdata(i), var(35)) == 1
        country = [country;1 0 0 0 1 1];    
    elseif strcmp(tempdata(i), var(36)) == 1
        country = [country;1 0 0 1 0 0];
    elseif strcmp(tempdata(i), var(37)) == 1
        country = [country;1 0 0 1 0 1];    
    elseif strcmp(tempdata(i), var(38)) == 1
        country = [country;1 0 0 1 1 0];     
    elseif strcmp(tempdata(i), var(39)) == 1
        country = [country;1 0 0 1 1 1];
    elseif strcmp(tempdata(i), var(40)) == 1
        country = [country;1 0 1 0 0 0];
    elseif strcmp(tempdata(i), var(41)) == 1
        country = [country;1 0 1 0 0 1];
    elseif strcmp(tempdata(i), var(42)) == 1
        country = [country;1 0 1 0 1 0];
    end
end

%get income column
disp('get income data...'); 
income = [];
class = [];
tempdata = rawdata{1,15};
var = unique(tempdata);
for i = 1:1:size(tempdata,1)
    if strcmp(tempdata(i), var(1)) == 1
        income = [income;0 1];
        class = [class; 1];
    elseif strcmp(tempdata(i), var(2)) == 1 
        income = [income;1 0];      
        class = [class; 2];
    end
end



disp('finish getting data...'); 

%get total data
totaldata = [age workclass fnlwgt education educationnum marital occupation ...
    relationship race sex cgain closs hpw country income class];

save totaldata.mat totaldata
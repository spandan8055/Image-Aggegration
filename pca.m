run('C:\Users\spandan\Documents\MATLAB\VLFEATROOT\toolbox\vl_setup.m');

path = 'C:\Users\spandan\Documents\MATLAB\101_ObjectCategories';
cal101=dir(path);
for k=1:101
    name{k} = cal101(k+3).name; 
end

% let us do this 8 classes of objects
data = [3 33 34 61 85 91]; 
n= 20; 
show101Images(path, name, data);
Z=length(data);


for k=1:Z
    for j=1:n
        image=imread(sprintf('%s/%s/image_%04d.jpg',path,name{data(k)},j));
         [h, w, dim]=size(image);
         if dim==1
            [f,d] = vl_sift(single((image)));
            [f_d,d_d]= vl_dsift(single(image));
            sift{j,k}=vl_sift(single((image)));
            dsift{j,k}=vl_dsift(single((image)));
        else
            [f,d] = vl_sift(single(rgb2gray(image)));
            [f_d,d_d]= vl_dsift(single(rgb2gray(image)));
            sift{j,k}=vl_sift(single(rgb2gray(image)));
            dsift{j,k}=vl_dsift(single(rgb2gray(image)));
        
         end
    end
end
[n_sift, kd_sift]=size(gd_sift_cdvs);
siftfeatures=gd_sift_cdvs(1:50000, 1:128);
offs = randperm(n_sift); 
offs =offs(1:50000);
% PCA
[A1, s1, lat1]=princomp(double(gd_sift_cdvs(offs,:)));
PCA=princomp(double(gd_sift_cdvs(offs,:)));
figure(41); hold on; grid on;
stem(lat1, '.'); title('pca');
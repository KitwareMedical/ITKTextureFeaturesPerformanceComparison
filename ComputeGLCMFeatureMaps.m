clear all;
close all;

nbOfIterrations = 10

time = zeros(nbOfIterrations,1);

for a = 1 : nbOfIterrations
    tic

    inIm = imread('image2048.jpg');
    offsets = [0 1; -1 1; -1 0; -1 -1];

    neightborhood = 4;

    [X,Y] = size(inIm);

    Contrast = zeros(X,Y);
    Correlation = zeros(X,Y);
    Energy = zeros(X,Y);
    Homogeneity = zeros(X,Y);

    for i = neightborhood + 1 : X - neightborhood

        for j = neightborhood + 1 : Y - neightborhood

            intIm = inIm( (i - neightborhood):(i + neightborhood), (j - neightborhood) : (j + neightborhood));
            glcm = graycomatrix(intIm, 'Offset', offsets, 'NumLevels', 10, 'GrayLimits', []);
            stats = graycoprops(glcm);
            Contrast(i,j) = mean(stats.Contrast);
            Correlation(i,j) = mean(stats.Correlation);
            Energy(i,j) = mean(stats.Energy);
            Homogeneity(i,j) = mean(stats.Homogeneity);

        end

    end


    imwrite(Contrast,'Contrast.jpg');
    imwrite(Correlation,'Correlation.jpg');
    imwrite(Energy,'Energy.jpg');
    imwrite(Homogeneity,'Homogeneity.jpg');

    
    time(a) = toc;
    
end

time
mean = mean(time)
standardDeviation = std(time)

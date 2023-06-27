function collectSensorData() 
  clear;

  collectionTime = 10;
  dataLabel = 'classA';
  filenameData = "";

    if isempty(filenameData)
        filenameData = 'dataThesis';
    end

    %% data arrays
    labels = {};
    accelerations = [];
    euclideanNormValues = [];

    d1=load(strcat("classA", ".mat"));
    [accelerations1, imfs1, normalizedImfs1, hilbertSpectrum1, normalizedHilbertSpectrum1, labels1] = deal(d1.accelerations, d1.imfs, d1.normalizedImfs, d1.hilbertSpectrum,d1.normalizedHilbertSpectrum, d1.labels);


    for count = 1:size(accelerations1, 1)
        accelReadingsX = accelerations1(count, 1);
        accelReadingsY = accelerations1(count, 2);
        accelReadingsZ = accelerations1(count, 3);
        accelReadings = [accelReadingsX, accelReadingsY, accelReadingsZ]

%         disp(accelReadings);
%         fprintf(accelReadingsX + " " + accelReadingsY + " " + accelReadingsZ);

        euclideanNormValue = sqrt(accelReadingsX^2 + accelReadingsY^2 + accelReadingsZ^2);

        %% push to array
        accelerations = [accelerations; accelReadings];
        euclideanNormValues = [euclideanNormValues; euclideanNormValue];
  
    end

   [imf,residual,info]  = emd(euclideanNormValues, 'Interpolation','pchip','Display',1);


  minArr = [];
  maxArr = [];
  meanArr = [];
  standardDeviationArr = [];
  rootMeanSquareArr = [];

  for count1 = 1:size(imf, 2)
    min = 1000; 
    max = 0;
    mean = 0;
    standardDeviation = 0;
    rootMeanSquare = 0;
    tempArr = [];

    imfSize = size(imf, 1);

    for count2 = 1:imfSize
        tempVal = imf(count2, count1);
        mean = mean + tempVal;
        tempArr = [tempArr; tempVal]
    end

    tempArr = sort(tempArr);
    min = tempArr(1);
    max = tempArr(imfSize);
    mean = mean / imfSize;
    standardDeviation = std(tempArr);
    rootMeanSquare = rms(tempArr);

    minArr = [minArr; min];
    maxArr = [maxArr; max];
    meanArr = [meanArr; mean];
    standardDeviationArr = [standardDeviationArr; standardDeviation];
    rootMeanSquareArr = [rootMeanSquareArr; rootMeanSquare];
  end

  fprintf("min:\n");
  disp(minArr);
  fprintf("max:\n");
  disp(maxArr);
  fprintf("Mean:\n");
  disp(meanArr);
  fprintf("Standard Deviation:\n");
  disp(standardDeviationArr);
  fprintf("Root Mean Square:\n");
  disp(rootMeanSquareArr);
end
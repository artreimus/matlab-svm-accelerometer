function collectSensorData() 
    clear;
    
    %% setup raspberry pi   
    % 169.254.61.19 / 192.168.100.83 / check ip address
    % check for username and password (pi and pi12345 in this case)  
    mypi= raspi('169.254.61.19', 'pi', 'pi12345');
    enableI2C(mypi);
    
    %% scan for I2C Address
    % mypi.AvailableI2CBuses
    % disp(scanI2CBus(mypi,'i2c-0'));
    % disp(scanI2CBus(mypi,'i2c-1'));
    
    %% program configuration
    prompt = "How many MINUTES do you want to COLLECT the data: ";
    collectionTime = input(prompt);
    collectionTime = collectionTime * 60;
    
    prompt = "What is the LABEL of the data: ";
    dataLabel = input(prompt, "s");
    
    prompt = "What is the FILENAME for the DATA (blank = dataThesis): ";
    filenameData = input(prompt, "s");
    
    if isempty(filenameData)
      filenameData = 'dataThesis';
    end
    
    if isempty(collectionTime) || isempty(dataLabel)
      ME = MException('MyComponent:emptyVariable', 'Please provide all required fields');
      throw(ME)
    end

    %% sensor
    accelSensor = adxl345(mypi, Bus="i2c-1");

    %% data arrays
    labels = {};
    accelerations = [];
    euclideanNormValues = [];

    for count = 1:collectionTime
        %% read data from sensor
        accelReadings = readAcceleration(accelSensor);
        fprintf("Sensor Readings: ");
        disp(accelReadings);

        accelReadingsX = accelReadings(1, 1);
        accelReadingsY = accelReadings(1, 2);
        accelReadingsZ = accelReadings(1, 3);

        euclideanNormValue = sqrt(accelReadingsX^2 + accelReadingsY^2 + accelReadingsZ^2);

        %% push to array
        accelerations = [accelerations; accelReadings];
        euclideanNormValues = [euclideanNormValues; euclideanNormValue];

        %% delay in seconds
        pause(1);
    end

  %% emd
  [imf,residual,info]  = emd(euclideanNormValues, 'Interpolation','pchip','Display',1);

  %% hilbert transform     
  hilbertVal = hilbert(imf);
  imaginaryVal = imag(hilbertVal);
  realVal = real(hilbertVal);
  absVal = abs(hilbertVal);

%   disp("Imaginary");
%   disp(size(imaginaryVal));  
%   disp("Real");
%   disp(size(realVal));
%   disp("absVal");
%   disp(size(absVal));
  
%   figure();
%   plot(realVal);
%   plot(imaginaryVal);
%   plot(absVal);
%   grid();

  %% instantenous amplitude and phase
  magnitudeVal = abs(hilbertVal);
  phaseVal = angle(hilbertVal);

%   disp("Magnitude");
%   disp(size(magnitudeVal));
%   disp("Phase");
%   disp(size(phaseVal));

  %% features from instanteneous magnitude and phase
  fMinArr = [];
  fMaxArr = [];
  fMeanArr = [];
  fStandardDeviationArr = [];
  fRootMeanSquareArr = [];

  aMinArr = [];
  aMaxArr = [];
  aMeanArr = [];
  aStandardDeviationArr = [];
  aRootMeanSquareArr = [];

  minArr = [];
  maxArr = [];
  meanArr = [];
  standardDeviationArr = [];
  rootMeanSquareArr = [];

  %% extract features 
  for count1 = 1:size(imf, 2)
    fMean = 0;
    fTempArr = [];

    aMean = 0;
    aTempArr = [];

    mean = 0;
    tempArr = [];

    imfSize = size(imf, 1);

    for count2 = 1:imfSize
        fTempVal = phaseVal(count2, count1);
        fMean = fMean + fTempVal;
        fTempArr = [fTempArr; fTempVal]

        aTempVal = magnitudeVal(count2, count1);
        aMean = aMean + aTempVal;
        aTempArr = [aTempArr; aTempVal]

        tempVal = imf(count2, count1);
        mean = mean + tempVal;
        tempArr = [tempArr; tempVal]
    end

    fTempArr = sort(fTempArr);
    fMin = fTempArr(1);
    fMax = fTempArr(imfSize);
    fMean = fMean / imfSize;
    fStandardDeviation = std(fTempArr);
    fRootMeanSquare = rms(fTempArr);

    aTempArr = sort(aTempArr);
    aMin = aTempArr(1);
    aMax = aTempArr(imfSize);
    aMean = aMean / imfSize;
    aStandardDeviation = std(aTempArr);
    aRootMeanSquare = rms(aTempArr);

    tempArr = sort(tempArr);
    min = tempArr(1);
    max = tempArr(imfSize);
    mean = mean / imfSize;
    standardDeviation = std(tempArr);
    rootMeanSquare = rms(tempArr);

    fMinArr = [fMinArr, fMin];
    fMaxArr = [fMaxArr, fMax];
    fMeanArr = [fMeanArr, fMean];
    fStandardDeviationArr = [fStandardDeviationArr, fStandardDeviation];
    fRootMeanSquareArr = [fRootMeanSquareArr, fRootMeanSquare];

    aMinArr = [aMinArr, aMin];
    aMaxArr = [aMaxArr, aMax];
    aMeanArr = [aMeanArr, aMean];
    aStandardDeviationArr = [aStandardDeviationArr, aStandardDeviation];
    aRootMeanSquareArr = [aRootMeanSquareArr, aRootMeanSquare];

    minArr = [minArr, min];
    maxArr = [maxArr, max];
    meanArr = [meanArr, mean];
    standardDeviationArr = [standardDeviationArr, standardDeviation];
    rootMeanSquareArr = [rootMeanSquareArr, rootMeanSquare];
  end

    %% separate the features to single variables
    fMin1 = fMinArr(1,1);
    fMin2 = fMinArr(1,2);
    fMin3 = fMinArr(1,3);
    fMin4 = fMinArr(1,4);
    fMin5 = fMinArr(1,5);
    fMin6 = fMinArr(1,6);

    fMax1 = fMaxArr(1,1);
    fMax2 = fMaxArr(1,2);
    fMax3 = fMaxArr(1,3);
    fMax4 = fMaxArr(1,4);
    fMax5 = fMaxArr(1,5);
    fMax6 = fMaxArr(1,6);

    fMean1 = fMeanArr(1,1);
    fMean2 = fMeanArr(1,2);
    fMean3 = fMeanArr(1,3);
    fMean4 = fMeanArr(1,4);
    fMean5 = fMeanArr(1,5);
    fMean6 = fMeanArr(1,6);

    fStd1 = fStandardDeviationArr(1,1);
    fStd2 = fStandardDeviationArr(1,2);
    fStd3 = fStandardDeviationArr(1,3);
    fStd4 = fStandardDeviationArr(1,4);
    fStd5 = fStandardDeviationArr(1,5);
    fStd6 = fStandardDeviationArr(1,6);

    fMse1 = fRootMeanSquareArr(1,1);
    fMse2 = fRootMeanSquareArr(1,2);
    fMse3 = fRootMeanSquareArr(1,3);
    fMse4 = fRootMeanSquareArr(1,4);
    fMse5 = fRootMeanSquareArr(1,5);
    fMse6 = fRootMeanSquareArr(1,6);

    aMin1 = aMinArr(1,1);
    aMin2 = aMinArr(1,2);
    aMin3 = aMinArr(1,3);
    aMin4 = aMinArr(1,4);
    aMin5 = aMinArr(1,5);
    aMin6 = aMinArr(1,6);

    aMax1 = aMaxArr(1,1);
    aMax2 = aMaxArr(1,2);
    aMax3 = aMaxArr(1,3);
    aMax4 = aMaxArr(1,4);
    aMax5 = aMaxArr(1,5);
    aMax6 = aMaxArr(1,6);

    aMean1 = aMeanArr(1,1);
    aMean2 = aMeanArr(1,2);
    aMean3 = aMeanArr(1,3);
    aMean4 = aMeanArr(1,4);
    aMean5 = aMeanArr(1,5);
    aMean6 = aMeanArr(1,6);

    aStd1 = aStandardDeviationArr(1,1);
    aStd2 = aStandardDeviationArr(1,2);
    aStd3 = aStandardDeviationArr(1,3);
    aStd4 = aStandardDeviationArr(1,4);
    aStd5 = aStandardDeviationArr(1,5);
    aStd6 = aStandardDeviationArr(1,6);

    aMse1 = aRootMeanSquareArr(1,1);
    aMse2 = aRootMeanSquareArr(1,2);
    aMse3 = aRootMeanSquareArr(1,3);
    aMse4 = aRootMeanSquareArr(1,4);
    aMse5 = aRootMeanSquareArr(1,5);
    aMse6 = aRootMeanSquareArr(1,6);

%   fprintf("Fmin:\n");
%   disp(fMinArr);
%   fprintf("Fmax:\n");
%   disp(fMaxArr);
%   fprintf("FMean:\n");
%   disp(fMeanArr);
%   fprintf("FStd:\n");
%   disp(fStandardDeviationArr);
%   fprintf("Fmse:\n");
%   disp(fRootMeanSquareArr);
% 
%   fprintf("Amin:\n");
%   disp(aMinArr);
%   fprintf("Amax:\n");
%   disp(aMaxArr);
%   fprintf("AMean:\n");
%   disp(aMeanArr);
%   fprintf("AStd:\n");
%   disp(aStandardDeviationArr);
%   fprintf("Amse:\n");
%   disp(aRootMeanSquareArr);
% 
%   fprintf("min:\n");
%   disp(minArr);
%   fprintf("max:\n");
%   disp(maxArr);
%   fprintf("Mean:\n");
%   disp(meanArr);
%   fprintf("Standard Deviation:\n");
%   disp(standardDeviationArr);
%   fprintf("Root Mean Square:\n");
%   disp(rootMeanSquareArr);

  %% input label for dataset
  labels = [labels, dataLabel] 

  %% save data as .mat
  finalFileName = strcat(filenameData, ".mat");
  save(finalFileName, "labels", "accelerations","euclideanNormValues","imf", "hilbertVal", "imaginaryVal", ...
      "realVal", "absVal", "magnitudeVal", "phaseVal", "fMinArr", "fMaxArr", "fMeanArr", "fStandardDeviationArr", "fRootMeanSquareArr", ...
      "aMinArr", "aMaxArr", "aMeanArr", "aStandardDeviationArr", "aRootMeanSquareArr", "minArr", "maxArr", "meanArr", ...
      "standardDeviationArr", "rootMeanSquareArr", "fMin1", "fMin2", "fMin3", "fMin4", "fMin5", "fMin6", "fMax1", "fMax2", ...
      "fMax3", "fMax4", "fMax5", "fMax6", "fMean1", "fMean2", "fMean3", "fMean4", "fMean5", "fMean6", "fStd1", "fStd2", "fStd3", ...
      "fStd4", "fStd5", "fStd6", "fMse1", "fMse2", "fMse3", "fMse4", "fMse5", "fMse6", "aMin1", "aMin2", "aMin3", "aMin4", "aMin5", ...
      "aMin6", "aMax1", "aMax2", "aMax3", "aMax4", "aMax5", "aMax6", "aMean1", "aMean2", "aMean3", "aMean4", "aMean5", "aMean6", ...
      "aStd1", "aStd2", "aStd3", "aStd4", "aStd5", "aStd6", "aMse1", "aMse2", "aMse3", "aMse4", "aMse5", "aMse6");

  %% save data as .xlsx
  data=load(finalFileName);
  f=fieldnames(data);
  for k=1:size(f,1)
      xlswrite(strcat(filenameData, ".xlsx"),data.(f{k}),f{k})
  end
end
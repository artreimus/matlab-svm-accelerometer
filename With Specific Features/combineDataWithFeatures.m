function combineData
    %% project configuration
    fprintf("PLEASE MAKE SURE THE DATA HAS THE FOLLOWING FIELDS: \nlabels, accelerations , euclideanNormValues , imf,  hilbertVal,  imaginaryVal, realVal, absVal,  magnitudeVal,  phaseVal,  fMinArr,  fMaxArr,  fMeanArr,  fStandardDeviationArr,  fRootMeanSquareArr,  aMinArr,  aMaxArr,  aMeanArr,  aStandardDeviationArr,  aRootMeanSquareArr,  minArr,  maxArr,  meanArr,  standardDeviationArr,  rootMeanSquareArr, fMin1,fMin2,fMin3,fMin4,fMin5,fMin6,fMax1,fMax2,fMax3,fMax4,fMax5,fMax6,fMean1,fMean2,fMean3,fMean4,fMean5,fMean6,fStd1,fStd2,fStd3,fStd4,fStd5,fStd6,fMse1,fMse2,fMse3,fMse4,fMse5,fMse6,aMin1,aMin2,aMin3,aMin4,aMin5,aMin6,aMax1,aMax2,aMax3,aMax4,aMax5,aMax6,aMean1,aMean2,aMean3,aMean4,aMean5,aMean6,aStd1,aStd2,aStd3,aStd4,aStd5,aStd6,aMse1,aMse2,aMse3,aMse4,aMse5,aMse6\n");
    
    prompt = "What is the FILENAME for DATA 1: ";
    filenameData1 = input(prompt, "s");

    prompt = "What is the FILENAME for DATA 2: ";
    filenameData2 = input(prompt, "s");

    prompt = "What is the FILENAME for the COMBINED DATA (blank = combinedData): ";
    finalFileName = input(prompt, "s");

    if isempty(finalFileName)
        finalFileName = "combinedData"
    end

    if isempty(filenameData1) || isempty(filenameData2)
            ME = MException('MyComponent:emptyVariable', 'Please provide all required fields');
        throw(ME)
    end
    
    %% load data 1
    d1=load(strcat(filenameData1, ".mat"));
    [labels, accelerations , euclideanNormValues , imf,  hilbertVal,  imaginaryVal, realVal, absVal,  magnitudeVal,  phaseVal,  fMinArr,  fMaxArr,  fMeanArr,  fStandardDeviationArr,  fRootMeanSquareArr,  aMinArr,  aMaxArr,  aMeanArr,  aStandardDeviationArr,  aRootMeanSquareArr,  minArr,  maxArr,  meanArr,  standardDeviationArr,  rootMeanSquareArr, fMin1,fMin2,fMin3,fMin4,fMin5,fMin6,fMax1,fMax2,fMax3,fMax4,fMax5,fMax6,fMean1,fMean2,fMean3,fMean4,fMean5,fMean6,fStd1,fStd2,fStd3,fStd4,fStd5,fStd6,fMse1,fMse2,fMse3,fMse4,fMse5,fMse6,aMin1,aMin2,aMin3,aMin4,aMin5,aMin6,aMax1,aMax2,aMax3,aMax4,aMax5,aMax6,aMean1,aMean2,aMean3,aMean4,aMean5,aMean6,aStd1,aStd2,aStd3,aStd4,aStd5,aStd6,aMse1,aMse2,aMse3,aMse4,aMse5,aMse6] = deal(d1.labels, d1.accelerations, d1.euclideanNormValues , d1.imf,  d1.hilbertVal,  d1.imaginaryVal, d1.realVal, d1.absVal,  d1.magnitudeVal, d1.phaseVal,  d1.fMinArr,  d1.fMaxArr,  d1.fMeanArr,  d1.fStandardDeviationArr,  d1.fRootMeanSquareArr,  d1.aMinArr,  d1.aMaxArr,  d1.aMeanArr,  d1.aStandardDeviationArr,  d1.aRootMeanSquareArr,  d1.minArr,  d1.maxArr, d1.meanArr,  d1.standardDeviationArr,  d1.rootMeanSquareArr, d1.fMin1, d1.fMin2, d1.fMin3, d1.fMin4, d1.fMin5, d1.fMin6, d1.fMax1, d1.fMax2, d1.fMax3, d1.fMax4, d1.fMax5, d1.fMax6, d1.fMean1, d1.fMean2, d1.fMean3, d1.fMean4, d1.fMean5, d1.fMean6, d1.fStd1, d1.fStd2, d1.fStd3, d1.fStd4, d1.fStd5, d1.fStd6, d1.fMse1, d1.fMse2, d1.fMse3, d1.fMse4, d1.fMse5, d1.fMse6, d1.aMin1, d1.aMin2, d1.aMin3, d1.aMin4, d1.aMin5, d1.aMin6, d1.aMax1, d1.aMax2, d1.aMax3, d1.aMax4, d1.aMax5, d1.aMax6, d1.aMean1, d1.aMean2, d1.aMean3, d1.aMean4, d1.aMean5, d1.aMean6, d1.aStd1, d1.aStd2, d1.aStd3, d1.aStd4, d1.aStd5, d1.aStd6, d1.aMse1, d1.aMse2, d1.aMse3, d1.aMse4, d1.aMse5, d1.aMse6);

    %% load data 2
    d2=load(strcat(filenameData2, ".mat"))
    [labels2, accelerations2, euclideanNormValues2 , imf2,  hilbertVal2,  imaginaryVal2, realVal2, absVal2,  magnitudeVal2,  phaseVal2,  fMinArr2,  fMaxArr2,  fMeanArr2,  fStandardDeviationArr2,  fRootMeanSquareArr2,  aMinArr2,  aMaxArr2,  aMeanArr2,  aStandardDeviationArr2,  aRootMeanSquareArr2,  minArr2,  maxArr2,  meanArr2,  standardDeviationArr2,  rootMeanSquareArr2, fMin1Two, fMin2Two, fMin3Two, fMin4Two, fMin5Two, fMin6Two, fMax1Two, fMax2Two, fMax3Two, fMax4Two, fMax5Two, fMax6Two, fMean1Two, fMean2Two, fMean3Two, fMean4Two, fMean5Two, fMean6Two, fStd1Two, fStd2Two, fStd3Two, fStd4Two, fStd5Two, fStd6Two, fMse1Two, fMse2Two, fMse3Two, fMse4Two, fMse5Two, fMse6Two, aMin1Two, aMin2Two, aMin3Two, aMin4Two, aMin5Two, aMin6Two, aMax1Two, aMax2Two, aMax3Two, aMax4Two, aMax5Two, aMax6Two, aMean1Two, aMean2Two, aMean3Two, aMean4Two, aMean5Two, aMean6Two, aStd1Two, aStd2Two, aStd3Two, aStd4Two, aStd5Two, aStd6Two, aMse1Two, aMse2Two, aMse3Two, aMse4Two, aMse5Two, aMse6Two] = deal(d2.labels, d2.accelerations, d2.euclideanNormValues , d2.imf,  d2.hilbertVal,  d2.imaginaryVal, d2.realVal, d2.absVal,  d2.magnitudeVal, d2.phaseVal,  d2.fMinArr,  d2.fMaxArr,  d2.fMeanArr,  d2.fStandardDeviationArr,  d2.fRootMeanSquareArr,  d2.aMinArr,  d2.aMaxArr,  d2.aMeanArr,  d2.aStandardDeviationArr,  d2.aRootMeanSquareArr,  d2.minArr,  d2.maxArr, d2.meanArr,  d2.standardDeviationArr,  d2.rootMeanSquareArr, d2.fMin1, d2.fMin2, d2.fMin3, d2.fMin4, d2.fMin5, d2.fMin6, d2.fMax1, d2.fMax2, d2.fMax3, d2.fMax4, d2.fMax5, d2.fMax6, d2.fMean1, d2.fMean2, d2.fMean3, d2.fMean4, d2.fMean5, d2.fMean6, d2.fStd1, d2.fStd2, d2.fStd3, d2.fStd4, d2.fStd5, d2.fStd6, d2.fMse1, d2.fMse2, d2.fMse3, d2.fMse4, d2.fMse5, d2.fMse6, d2.aMin1, d2.aMin2, d2.aMin3, d2.aMin4, d2.aMin5, d2.aMin6, d2.aMax1, d2.aMax2, d2.aMax3, d2.aMax4, d2.aMax5, d2.aMax6, d2.aMean1, d2.aMean2, d2.aMean3, d2.aMean4, d2.aMean5, d2.aMean6, d2.aStd1, d2.aStd2, d2.aStd3, d2.aStd4, d2.aStd5, d2.aStd6, d2.aMse1, d2.aMse2, d2.aMse3, d2.aMse4, d2.aMse5, d2.aMse6);

    %% combine the data
    labels = [labels; labels2];
    accelerations = [accelerations; accelerations2];
    euclideanNormValues = [euclideanNormValues; euclideanNormValues2];
    imf = [imf; imf2];
    hilbertVal = [hilbertVal; hilbertVal2];
    imaginaryVal = [imaginaryVal; imaginaryVal2];
    realVal = [realVal; realVal2];
    absVal = [absVal; absVal2];
    magnitudeVal = [magnitudeVal; magnitudeVal2];
    phaseVal = [phaseVal; phaseVal2];
    fMinArr = [fMinArr; fMinArr2];
    fMaxArr = [fMaxArr; fMaxArr2];
    fMeanArr = [fMeanArr; fMeanArr2];
    fStandardDeviationArr = [fStandardDeviationArr; fStandardDeviationArr2];
    fRootMeanSquareArr = [fRootMeanSquareArr; fRootMeanSquareArr2];
    aMinArr = [aMinArr; aMinArr2];
    aMaxArr = [aMaxArr; aMaxArr2];
    aMeanArr = [aMeanArr; aMeanArr2];
    aStandardDeviationArr = [aStandardDeviationArr; aStandardDeviationArr2];
    aRootMeanSquareArr = [aRootMeanSquareArr; aRootMeanSquareArr2];
    minArr = [minArr; minArr2];
    maxArr = [maxArr; maxArr2];
    meanArr = [meanArr; meanArr2];
    standardDeviationArr = [standardDeviationArr; standardDeviationArr2];
    rootMeanSquareArr = [rootMeanSquareArr; rootMeanSquareArr2];

    fMin1 = [fMin1; fMin1Two];
    fMin2 = [fMin2; fMin2Two];
    fMin3 = [fMin3; fMin3Two];
    fMin4 = [fMin4; fMin4Two];
    fMin5 = [fMin5; fMin5Two];
    fMin6 = [fMin6; fMin6Two];
   
    fMax1 = [fMax1; fMax1Two];
    fMax2 = [fMax2; fMax2Two];
    fMax3 = [fMax3; fMax3Two];
    fMax4 = [fMax4; fMax4Two];
    fMax5 = [fMax5; fMax5Two];
    fMax6 = [fMax6; fMax6Two];
     
    fMean1 = [fMean1; fMean1Two];
    fMean2 = [fMean2; fMean2Two];
    fMean3 = [fMean3; fMean3Two];
    fMean4 = [fMean4; fMean4Two];
    fMean5 = [fMean5; fMean5Two];
    fMean6 = [fMean6; fMean6Two];
    
    fStd1 = [fStd1; fStd1Two];
    fStd2 = [fStd2; fStd2Two];
    fStd3 = [fStd3; fStd3Two];
    fStd4 = [fStd4; fStd4Two];    
    fStd5 = [fStd5; fStd5Two];
    fStd6 = [fStd6; fStd6Two];
    
    fMse1 = [fMse1; fMse1Two];
    fMse2 = [fMse2; fMse2Two];
    fMse3 = [fMse3; fMse3Two];
    fMse4 = [fMse4; fMse4Two];
    fMse5 = [fMse5; fMse5Two];
    fMse6 = [fMse6; fMse6Two];
    
    aMin1 = [aMin1; aMin1Two];
    aMin2 = [aMin2; aMin2Two];
    aMin3 = [aMin3; aMin3Two];
    aMin4 = [aMin4; aMin4Two];
    aMin5 = [aMin5; aMin5Two];
    aMin6 = [aMin6; aMin6Two];
    
    aMax1 = [aMax1; aMax1Two];
    aMax2 = [aMax2; aMax2Two];
    aMax3 = [aMax3; aMax3Two];
    aMax4 = [aMax4; aMax4Two];
    aMax5 = [aMax5; aMax5Two];
    aMax6 = [aMax6; aMax6Two];
    
    aMean1 = [aMean1; aMean1Two];
    aMean2 = [aMean2; aMean2Two];
    aMean3 = [aMean3; aMean3Two];
    aMean4 = [aMean4; aMean4Two];
    aMean5 = [aMean5; aMean5Two];
    aMean6 = [aMean6; aMean6Two];
    
    aStd1 = [aStd1; aStd1Two];
    aStd2 = [aStd2; aStd2Two];
    aStd3 = [aStd3; aStd3Two];
    aStd4 = [aStd4; aStd4Two];
    aStd5 = [aStd5; aStd5Two];
    aStd6 = [aStd6; aStd6Two];
    
    aMse1 = [aMse1; aMse1Two];
    aMse2 = [aMse2; aMse2Two];
    aMse3 = [aMse3; aMse3Two];
    aMse4 = [aMse4; aMse4Two];
    aMse5 = [aMse5; aMse5Two];
    aMse6 = [aMse6; aMse6Two];

    %% save data as .mat
    finalFileName = strcat(finalFileName, ".mat");
    save(finalFileName, "labels", "accelerations","euclideanNormValues","imf", "hilbertVal", "imaginaryVal", "realVal", ...
        "absVal", "magnitudeVal", "phaseVal", "fMinArr", "fMaxArr", "fMeanArr", "fStandardDeviationArr", "fRootMeanSquareArr", ...
        "aMinArr", "aMaxArr", "aMeanArr", "aStandardDeviationArr",  "aRootMeanSquareArr", "minArr", "maxArr", "meanArr", ...
        "standardDeviationArr", "rootMeanSquareArr", "fMin1", "fMin2", "fMin3", "fMin4", "fMin5", "fMin6", "fMax1", "fMax2", ...
        "fMax3", "fMax4", "fMax5", "fMax6", "fMean1", "fMean2", "fMean3", "fMean4", "fMean5", "fMean6", "fStd1", "fStd2", "fStd3", ...
        "fStd4", "fStd5", "fStd6", "fMse1", "fMse2", "fMse3", "fMse4", "fMse5", "fMse6", "aMin1", "aMin2", "aMin3", "aMin4", ...
        "aMin5", "aMin6", "aMax1", "aMax2", "aMax3", "aMax4", "aMax5", "aMax6", "aMean1", "aMean2", "aMean3", "aMean4", ...
        "aMean5", "aMean6", "aStd1", "aStd2", "aStd3", "aStd4", "aStd5", "aStd6", "aMse1", "aMse2", "aMse3", "aMse4", ...
        "aMse5", "aMse6");
    
    %% save data as .xlsx
    data=load(finalFileName);
    f=fieldnames(data);
    for k=1:size(f,1)
        xlswrite(strcat(finalFileName, ".xlsx"),data.(f{k}),f{k})
    end
end

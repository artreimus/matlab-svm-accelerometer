function predictSVM
    %% project configuration 
    fprintf("PLEASE MAKE SURE THAT THE EXPORTED MODELS HAVE THE FOLLOWING NAMES: svmModelStatus, svmModelClass\n");
    prompt = "What is the FILENAME for that contains the EXPORTED MODELS: ";
    filenameModel = input(prompt, "s");


    prompt = "What is the FILENAME for the LOGGED DATA: ";
    filenameLogging = input(prompt, "s");

    if isempty(filenameLogging) || isempty(filenameModel) 
         ME = MException('MyComponent:emptyVariable', 'Please provide all required fields');
        throw(ME);
    end

    %% filenames when debugging
%     filenameModel = "svmModels";
%     filenameLogging = "loggedData";

    %% load SVM models 
    models=load(strcat(filenameModel, ".mat"));
    [svmModelStatus] = deal(models.svmModelStatus);
    [svmModelClass] = deal(models.svmModelClass);

    %% load raspberry pi
    mypi= raspi('169.254.61.19', 'pi', 'pi12345');
    enableI2C(mypi);

    %% load sensor
    accelSensor = adxl345(mypi, Bus="i2c-1");

    allData = [];

    %% predict using SVM models
    while true
        %% collect data using sensor
        accelReadings = readAcceleration(accelSensor);
        fprintf("Sensor Reading: ");
        disp(accelReadings);
        pause(0.5);

        %% emd
        [imf] = emd(accelReadings);

        if isempty(imf) 
            disp("Please fix sensor orientation");
            continue;
        end

        fprintf("EMD: ");
        disp(imf);

        %% hht
        hilbertSpectrum = hht(imf);
        
        %% clean data
        hilbertSpectrum = full(hilbertSpectrum);
        sz = size(hilbertSpectrum)

        normalizedHilbertSpectrum = [];
        singleHht = [];
        varCounter = 0;

        %% check rows
        for count1 = 1:sz(1)
            %% check cols
            for count2 = 1:sz(2)
                val = hilbertSpectrum(count1, count2);
                if(val ~= 0)
                    singleHht = [singleHht; val];
                    varCounter = varCounter + 1;
                    if(varCounter == 3)
                        varCounter = 0;
                        normalizedHilbertSpectrum = [singleHht(1), singleHht(2), singleHht(3)];
                        singleHht = [];
                    end
                end
            end
        end
        
        fprintf("HHT: ");
        disp(normalizedHilbertSpectrum);

        %% predict using SVM
        svmStatus = svmModelStatus.ClassificationSVM;
        svmClass = svmModelClass.ClassificationSVM;

        [labels, score] = predict(svmStatus, normalizedHilbertSpectrum);
        statusLabel = labels;
        [labels, score] = predict(svmClass, normalizedHilbertSpectrum);
        classLabel = labels;
        disp(statusLabel);
        disp(classLabel);
        pause(0.5);
     
        allData = [allData; [accelReadings(1), accelReadings(2), accelReadings(3), statusLabel, classLabel]];
        xlswrite(strcat(filenameLogging, ".xlsx"), allData);
    end

end
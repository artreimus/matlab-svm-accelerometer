function collectSensorData() 
    clear;
    % 169.254.61.19 / 192.168.100.83
    mypi= raspi('169.254.61.19', 'pi', 'pi12345');
    enableI2C(mypi);

    %% scan for I2C Address
    % mypi.AvailableI2CBuses
    % disp(scanI2CBus(mypi,'i2c-0'));
    % disp(scanI2CBus(mypi,'i2c-1'));

    %% program configuration
    prompt = "How many SECONDS do you want to COLLECT the data: ";
    collectionTime = input(prompt);

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

    %% data arrays
    accelSensor = adxl345(mypi, Bus="i2c-1");
    labels = {};
    accelerations = [];
    imfs = [];
    normalizedImfs = [];
    

    for count = 1:collectionTime
        %% read data from sensor
        accelReadings = readAcceleration(accelSensor);
        fprintf("Sensor Readings: ");
        disp(accelReadings);

        %% emd
        [imf] = emd(accelReadings);

        if isempty(imf) 
            ME = MException('MyComponent:emptyVariable', "Please fix sensor orientation");
            throw(ME);
        end
        
        %% clean emf data
        normalizedImf = [imf(1), imf(2), imf(3)];
        fprintf("IMF: ");
        disp(normalizedImf);

        %% push to array
        accelerations = [accelerations; accelReadings];
        imfs = [imfs; imf];
        normalizedImfs = [normalizedImfs; normalizedImf];

        %% delay in seconds
        pause(1);   
    end
   

    %% hht
    hilbertSpectrum = hht(imfs);

    %% uncomment to show hht plot
    % hht(imfs);

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
                    normalizedHilbertSpectrum = [normalizedHilbertSpectrum; [singleHht(1), singleHht(2), singleHht(3)]];
                    labels = [labels; dataLabel];
                    singleHht = [];
                end
            end
        end
    end
    

    %% save data as .mat
    finalFileName = strcat(filenameData, ".mat");
    save(finalFileName,"accelerations","imfs","normalizedImfs","hilbertSpectrum", "normalizedHilbertSpectrum", "labels");
    
    %% save data as .xlsx
    data=load(finalFileName);
    f=fieldnames(data);
    for k=1:size(f,1)
        xlswrite(strcat(filenameData, ".xlsx"),data.(f{k}),f{k})
    end
end
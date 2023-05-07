function renameLabel
    %% project configuration
    fprintf("PLEASE MAKE SURE THE DATA HAS THE FOLLOWING FIELDS: \nacceleration, imfs, normalizedImfs, hilbertSpectrum, normalizedHilbertSpectrum, labels\n")

    prompt = "What is the FILENAME of the DATASET you want to RENAME the LABEL: ";
    filenameData = input(prompt, "s");

    prompt = "What is the NEW LABEL: ";
    newLabel = input(prompt, "s");

    if isempty(filenameData)
        ME = MException('MyComponent:emptyVariable', 'Please provide all required fields');
                throw(ME)
    end
    
    %% load data 
    d1=load(strcat(filenameData, ".mat"));
    [accelerations, imfs, normalizedImfs, hilbertSpectrum, normalizedHilbertSpectrum, labels] = deal(d1.accelerations, d1.imfs, d1.normalizedImfs, d1.hilbertSpectrum,d1.normalizedHilbertSpectrum, d1.labels);

    %% rename the data
    sz = size(labels);
    newLabels = {};
    
    
    for count1 = 1:sz(1)
        newLabels = [newLabels; newLabel];
    end

    labels = newLabels;

    %% save data
    finalFileName = strcat(filenameData, "Renamed", ".mat");
    save(finalFileName,"accelerations","imfs","normalizedImfs","hilbertSpectrum", "normalizedHilbertSpectrum", "labels");
    

    %% save data as .xlsx
    data=load(finalFileName);
    f=fieldnames(data);
    for k=1:size(f,1)
        xlswrite(strcat(finalFileName, ".xlsx"),data.(f{k}),f{k})
    end

    disp(strcat("Label successfully renamed. The new file name is ", filenameData, "Renamed.mat"));
end

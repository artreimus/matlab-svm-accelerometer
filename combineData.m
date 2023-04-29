function combineData
    %% project configuration
    fprintf("PLEASE MAKE SURE THE DATA HAS THE FOLLOWING FIELDS: \nacceleration, imfs, normalizedImfs, hilbertSpectrum, normalizedHilbertSpectrum, labels\n")

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
    [accelerations1, imfs1, normalizedImfs1, hilbertSpectrum1, normalizedHilbertSpectrum1, labels1] = deal(d1.accelerations, d1.imfs, d1.normalizedImfs, d1.hilbertSpectrum,d1.normalizedHilbertSpectrum, d1.labels);

    %% load data 2
    d2=load(strcat(filenameData2, ".mat"))
    [accelerations2, imfs2, normalizedImfs2, hilbertSpectrum2, normalizedHilbertSpectrum2, labels2] = deal(d2.accelerations, d2.imfs, d2.normalizedImfs, d2.hilbertSpectrum,d2.normalizedHilbertSpectrum, d2.labels);

    %% combine the data
    accelerations = [accelerations1; accelerations2];
    imfs = [imfs1; imfs2];
    normalizedImfs = [normalizedImfs1; normalizedImfs2];
    hilbertSpectrum = [hilbertSpectrum1; hilbertSpectrum2];
    normalizedHilbertSpectrum = [normalizedHilbertSpectrum1; normalizedHilbertSpectrum2];
    labels = [labels1; labels2];

    finalFileName = strcat(finalFileName, ".mat");
    save(finalFileName,"accelerations","imfs","normalizedImfs","hilbertSpectrum", "normalizedHilbertSpectrum", "labels");
    

    %% save data as .xlsx
    data=load(finalFileName);
    f=fieldnames(data);
    for k=1:size(f,1)
        xlswrite(strcat(finalFileName, ".xlsx"),data.(f{k}),f{k})
    end
end

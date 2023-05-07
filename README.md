<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
</head>
<body>
  <header>
    <h1>Predictive Motor Maintenance using ADXL Sensor and SVM Models</h1>
  </header>

  <main>
    <h2>Purpose</h2>
    <p>Do Predictive Motor Maintenance. Collect Sensor data using ADXL Sensor. Train SVM Model using Data Collected in MATLAB. After training, use SVM to predict the CLASS (Class 1, 2, 3, etc) and the Status of the motor (whether it's broken or not broken).</p>
    <h2>Methodology</h2>
    <h3>TRAINING</h3>
    <ol>
      <li>Setup the Raspberry Pi and the ADXL Sensor in MATLAB.</li>
      <li>Collect Sensor Data using ADXL Sensor for the Class.</li>
      <li>Use EMD.</li>
      <li>Use Hilbert Huang Transform.</li>
      <li>Save Dataset.</li>
      <li>Train SVM Model using MATLAB's Classification Leaner Tools.</li>
    </ol>
    <h3>TESTING</h3>
    <ol>
      <li>Setup the Raspberry Pi and the ADXL Sensor in MATLAB.</li>
      <li>Collect Sensor Data using ADXL Sensor for the Class and Status of the Motor.</li>
      <li>The Prediction will be printed in the MATLAB terminal.</li>
    </ol>
     <h2>How to Use</h2>
  <ol>
    <li>Setup the Raspberry Pi and the ADXL Sensor in MATLAB.</li>
    <li>Run <code>collectSensorData.m</code> - Collect data of the different Class and Status of the motor using script. The collected data are also saved in Excel format for the user's analyzing purposes.</li>
    <li>Run <code>combineData.m</code> - Combine related data (Classes and Status)</li>
    <li>(OPTIONAL) Run <code>renameLabel.m</code> to change the label of a dataset.</li>
    <li>Train model for predicting Class of Motor. By using the following terminal commands:
      <ol type="a">
        <li>load data set using: <code>load data_name</code></li>
        <li>Convert array to table using (Note: the normalizedHilbertSpectrum is the data stored of the result of the hilbert spectrum transform): <code>trainingData = array2table(normalizedHilbertSpectrum)</code></li>
        <li>Group together the hilbert spectrum data and the and label using the following: <code>trainingData.Group = labels</code></li>
      </ol>
    </li>
    <li>Use the Classification Learner tool to train the SVM. Refer to reference for the tool's step-by-step guide</li>
    <li>After training, export the model and save model using command (Please do not change file name of data. If you want to change the file name, change the data use in the predictSVM script): <code>save("svmModelClass.mat", "svmModelClass")</code>.</li>
    <li>Training model for classifying the Status of motor (refer to step 5 for the steps).</li>
    <li>After training, export the model and save model using command (Please do not change file name of data. If you want to change the file name, change the data use in the predictSVM script): <code>save("svmModelStatus.mat", "svmModelStatus")</code>.</li>
    <li>Combine the data models using by using the following terminal commands:
      <ol type="a">
        <li>load svm for classifying status: <code>load svmModelStatus</code></li>
        <li>load svm for clasifying class: <code>load svmModelClass</code></li>
        <li>combine models into one dataset: <code>save("svmModels.mat", "svmModelStatus", "svmModelClass")</code></li>
      </ol>
    </li>
    <li>Run <code>predictSVM</code> script to collect data using ADXL sensor and predict the Class and Status of the Motor using the trained SVM models. The collected data are also saved in Excel format for the user's analyzing purposes.</li>
  </ol>

  <h2>References</h2>
  <ul>
    <li><a href="https://pimylifeup.com/raspberry-pi-accelerometer-adxl345/">Raspberry Pi Accelerometer using the ADXL345</a></li>
    <li><a href="https://www.mathworks.com/help/supportpkg/raspberrypiio/index.html?s_tid=CRUX_lftnav">MATLAB Support Package for Raspberry Pi Hardware</a></li>
    <li><a href="https://www.mathworks.com/help/signal/ref/emd.html">EMD</a></li>
    <li><a href="https://www.mathworks.com/help/signal/ref/hht.html">Hilbert Huang Transform</a></li>
    <li><a href="https://www.mathworks.com/help/stats/train-support-vector-machines-in-classification-learner-app.html">Train Support Vector Models in MATLAB's Classification Leaner Tool</li>
  </ul>
</main>
</body>
</html>

function stand = standardization(Mat)
    nRow = size(Mat,1);
    MatMean = repmat(mean(Mat),nRow,1);
    MatStd = repmat(std(Mat),nRow,1);
    stand = (Mat - MatMean)./(MatStd);
return
    
First of all I just checked if the file and directory exists or not. If it does, then I just set it to be the working dir() and if it doesn't then it download through the dataset through url, unzips it and set it to be the working dir().
Then I just read the files(X_test and X_train) into testdata and traindata. The columns names of both the data frames are set to the labels.
I row binded the (traindata, testdata) into data and (train_labels, test_labels) dataframes into levels.
Subsetted the columns which contains the means.
Column binded the data and level data frames.
I tranformed the level column into factor set the levels to be activity names using activity_labels data.
Inputted the test&train subjects data into subjects data frame.
Column binded this subject dataframe to data and splitted it based on subject and activity and stored into use data frame.
Applied lapply function to find colMeans.
Wrote my final ans into the csv file.

Getting and Cleaning Data Project

The attached R script run_analysis.R performs the following steps

1.download X train and X test data 

2.bind X test and X train data by rows

3.download features data 

4.replace column names in xdata with features data from previous step 

5.reduce columns to include only ones with mean or std

6.download subject train and subject test data

7.bind subtrain and subtest data by rows

8.add column named Subject to xdata with data with subject created above 

9.download y train and ytest data

10.bind ytrain and ytest by rows 

11.add column named V1 to xdata with activity data created above

12.download activity labels data 

13.left join column to xdata with actlab created above

14.select colunmns in desired order ommiting coulnmn V1

15.change column 2 name to Activity

16.create tidy data that averages data by Subject then Activity 

17.write tidy.txt file

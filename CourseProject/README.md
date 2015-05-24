The analysis was carried out as follows
For both the test and training sets
  1. Read the data set containing the measurements
  2. Name the columns using the information from features.txt
  3. Find the columns corresponding to mean and std by searching for mean() or std() using grep
  4. Filter down to columns for mean and std
  5. Remove brackets for cleaner names
  6. Read activities for y values
  7. Use factors to changle activities to be more descriptive
  8. Read subjects for readings
  9. Using cbind, Merging the readings, activities, and subjects to create complete training/test dataset.

After both sets were read the complete data set was created using rbind

Finally, the data was summarized  using the dplyr summarize_each function, grouping on subject and activity


rankall <- function(outcome, num = "best") {
	## Read outcome data
	## Check that state and outcome are valid
	## For each state, find the hospital of the given rank
	## Return a data frame with the hospital names and the
	## (abbreviated) state name

	# Read in outcome data
	outcomes <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

	# Unique vector of valid states
	valid_states <- sort(unique(outcomes[ , "State"]))

	# Valid outcomes and their corresponding columns
	valid_outcomes_and_columns <- c("heart attack" = 11,
									"heart failure" = 17,
									"pneumonia" = 23)

	# Check that input outcome is valid
	if (! (outcome %in% names(valid_outcomes_and_columns))) stop("invalid outcome")

	# Convert the outcome columns to numeric
	for (column in valid_outcomes_and_columns) {
		outcomes[ , column] <- as.numeric(outcomes[ , column])
	} 

	# Column corresponding to hospital name
	hospital_name_column <- 2

	# Remove NA outcomes, then order by states, then by outcome column, then by hospital name
	outcome_column <- valid_outcomes_and_columns[outcome]
	outcomes <- outcomes[!is.na(outcomes[ , outcome_column]) , ]
	outcomes <- outcomes[order(outcomes[ , "State"],
							   outcomes[ , outcome_column],
							   outcomes[ , hospital_name_column]) , ]

	# Then, for each state, add a row to the output dataframe that has the
	# hospital name (which may be NA) of the input rank ("num"). Input rank can be
	# "best", "worst", or an integer rank (which may be out of bounds).
	# Ties are won by the hospital that comes first alphabetically (except for "worst").

	output_frame <- data.frame("hospital"=character(), "state"=character())
	for (state in valid_states) {
		outcomes_for_state <- outcomes[outcomes[ , "State"] == state , ]
		num_rows_for_state <- nrow(outcomes_for_state)
		if (num_rows_for_state == 0) {
			hospital_name <- NA
		} else if (num == "best") {
			hospital_name <- outcomes_for_state[1, hospital_name_column]
		} else if (num == "worst") {
			hospital_name <- outcomes_for_state[num_rows_for_state, hospital_name_column]
		} else if (num > num_rows_for_state) {
			hospital_name <- NA
		} else {
			hospital_name <- outcomes_for_state[num, hospital_name_column]
		}
		new_row <- data.frame("hospital"=hospital_name, "state"=state)
		output_frame <- rbind(output_frame, new_row)
	}

	# names(output_frame) <- c("hospital", "state")
	output_frame
}
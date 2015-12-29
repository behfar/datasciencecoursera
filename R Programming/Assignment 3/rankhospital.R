rankhospital <- function(state, outcome, num = "best") {
	## Read outcome data
	## Check that state and outcome are valid
	## Return hospital name in that state with the given rank
	## 30-day death rate

	# Read in outcome data
	outcomes <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

	# Unique vector of valid states
	valid_states <- sort(unique(outcomes[ , "State"]))

	# Check that input state is valid
	if (! (state %in% outcomes[,"State"])) stop("invalid state")

	# Valid outcomes and their corresponding columns
	valid_outcomes_and_columns <- c("heart attack" = 11,
									"heart failure" = 17,
									"pneumonia" = 23)

	# Check that input outcome is valid
	if (! (outcome %in% names(valid_outcomes_and_columns))) stop("invalid outcome")

	# Convert the valid outcome columns to numeric
	for (column in valid_outcomes_and_columns) {
		outcomes[ , column] <- as.numeric(outcomes[ , column])
	} 

	# Column corresponding to hospital name
	hospital_name_column <- 2

	# Return the hospital name with the requested ranking in the column corresponding
	# to the input outcome (which is the 30 day mortality rate). Input rank ("num")
	# can be "best", "worst", or an integer rank (which may be out of bounds).
	# Ties are won by the hospital that comes first alphabetically (except for "worst").

	# Only keep the outcomes for the input state
	outcomes_for_state <- outcomes[outcomes[ , "State"] == state , ]

	# Order by the input outcome (1st level) and by hospital name (2nd level), and remove NAs
	outcome_column <- valid_outcomes_and_columns[outcome]
	order_by_outcome_then_hospital_name <- order(outcomes_for_state[ , outcome_column],
												 outcomes_for_state[ , hospital_name_column])
	outcomes_for_state <- outcomes_for_state[order_by_outcome_then_hospital_name , ]
	outcomes_for_state <- outcomes_for_state[!is.na(outcomes_for_state[ , outcome_column]) , ]

	# Output the hospital name with the requested ranking
	num_rows <- nrow(outcomes_for_state)
	if (num == "best") {
		output_row <- 1
	} else if (num == "worst") {
		output_row <- num_rows
	} else if (num > num_rows) {
		return(NA)
	} else {
		output_row <- num
	}
	outcomes_for_state[output_row , hospital_name_column]

}
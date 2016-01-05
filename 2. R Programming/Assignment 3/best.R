best <- function(state, outcome) {
	## Read outcome data
	## Check that state and outcome are valid
	## Return hospital name in that state with lowest 30-day death rate

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

	# Return the hospital name with the lowest value in the column corresponding
	# to the input outcome (which is the 30 day mortality rate).
	# Ties are won by the hospital that comes first alphabetically

	# Only keep the outcomes for the input state
	outcomes_for_state <- outcomes[outcomes[ , "State"] == state , ]

	# Order by the input outcome (1st level) and by hospital name (2nd level)
	outcome_column <- valid_outcomes_and_columns[outcome]
	order_by_outcome_then_hospital_name <- order(outcomes_for_state[ , outcome_column],
												 outcomes_for_state[ , hospital_name_column])
	outcomes_for_state <- outcomes_for_state[order_by_outcome_then_hospital_name , ]

	# Output the first hospital name
	outcomes_for_state[1 , hospital_name_column]

}


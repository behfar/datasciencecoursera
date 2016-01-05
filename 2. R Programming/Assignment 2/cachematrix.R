## R Programming, Assignment 2

## Input:  a matrix x
## Output: a list of functions (set, get, setsolve, getsolve) representing a cache matrix.
##         set(new_matrix):       sets the value of the cache matrix to new_matrix
##         get():                 returns the value of the cache matrix (defaults is matrix)
##         setsolve(new_inverse): sets the value of the inverse to new_inverse
##         getsolve():            returns the value of the cached inverse (defaults is NULL)
makeCacheMatrix <- function(matrix = matrix()) {

	# force the evaluation of the formal arg 'matrix' so we don't run into lazy eval problems, such
	# as in the 2nd for-loop of testCacheMatrix() below (this is was BIG pain to debug!)
	force(matrix)

	# default the cache inverse to NULL
	cache_inverse <- NULL

	# set the value of matrix in parent closure to new_matrix, and clear cache_inverse to NULL
	set <- function(new_matrix) {
		matrix <<- new_matrix
		cache_inverse <<- NULL
	}

	# return the value of matrix
	get <- function() matrix

	# set the value of cache_inverse in parent closure to new_inverse
	setsolve <- function(new_inverse) cache_inverse <<- new_inverse

	# return the value of cache_inverse
	getsolve <- function() cache_inverse

	# return a list of the setter and getter functions as the cache matrix
	list(set = set, get = get, setsolve = setsolve, getsolve = getsolve)

}

## Input:  a cache matrix, plus any optional parameters to pass on to the R 'solve' function
## Output: returns the value of the inverse of x, either by looking up the cache value of the
##         inverse (if it is not NULL), or else by calculating the inverse fresh and caching
##         it for future reference
cacheSolve <- function(cache_matrix, ...) {

    # if the cache inverse of cache_matrix is not NULL, return that
    inverse <- cache_matrix$getsolve()
    if (!is.null(inverse)) {
    	return(inverse)
    }

    # else calculate the inverse of cache_matrix, set it as cache inverse for future, and return it
    inverse <- solve(cache_matrix$get(), ...)
    cache_matrix$setsolve(inverse)
    inverse

}

## Helper functions to aid in testing

## Create num_tests many random matrices and assign them to cache matrices
## Then do three runs through them and compute their inverses using the cache matrices, and compare
## the running times. Also, check that the inverses are computed correctly.
testCacheMatrix <- function(dim = 10, num_tests = 100) {

	## Setup

	# Create an array to hold num_tests random matrices of size dim x dim
	# Also create a parallel array to hold their inverses
	random_matrices <- array(NA, dim = c(dim, dim, num_tests))
	random_matrices_inverses <- array(NA, dim = c(dim, dim, num_tests))

	# Populate the arrays with random matrices and their inverses
	for (k in 1:num_tests) {
		random_matrices[,,k] <- generateRandomMatrix(dim)
		random_matrices_inverses[,,k] <- solve(random_matrices[,,k])
	}

	# Create a vector of num_tests cache matrices initialized using num_test random matrices
	cache_matrices <- list()
	for (k in 1:num_tests) {
		cache_matrices <- c(cache_matrices, list(makeCacheMatrix(random_matrices[,,k])))
	}

	## Testing

	# Define a funtion that calls cacheSolve() once through all num_tests cache matrices
	run_through_cache_inverses <- function() {
		for (k in 1:num_tests) {
			cacheSolve(cache_matrices[[k]])
		}
	}

	# Now run this function three times and benchmark time it each round. The first round
	# should be slower because the inverses are being computed for the first time and cached.
	# The 2nd and 3rd times should be faster and of approximately equal speed.
	message("microbenchmark test: started")
	library("microbenchmark")
	for (i in 1:3) {
		results <- microbenchmark(run_through_cache_inverses(), times=1L)
		cat("Run ", i, "\n")
		print(results)
	}
	message("microbenchmark test: finished")

	# Finally, also make sure that the cache inverses are actually correct
	message("inverse correctness test: started")
	for (k in 1:num_tests) {
		if (!identical(cacheSolve(cache_matrices[[k]]), random_matrices_inverses[,,k])) {
			message(cat("test number", k, "failed"))
		} 
	}
	message("inverse correctness test: finished")

}

## Generate a random dim x dim matrix with values between min and max
## Note: a random matrix is invertible with probability 1
generateRandomMatrix <- function(dim = 3, min = -1, max = 1) {

	# generate dim x dim uniformly random numbers between min and max to fill the matrix
	random_data <- runif(dim * dim, min, max)

	# generate a square matrix based on the random data, and return it
	matrix <- matrix(random_data, nrow = dim, ncol = dim)

}
